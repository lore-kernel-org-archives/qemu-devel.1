Received: from eggs.gnu.org ([2001:4830:134:3::10]:43884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jaywang0.tw@gmail.com>) id 1fzY0T-0000Vu-Nq
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 22:02:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jaywang0.tw@gmail.com>) id 1fzY05-00052t-O8
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 22:01:58 -0400
From: =?UTF-8?B?546L5b2l5YKR?= <jaywang0.tw@gmail.com>
References: <20180908141528.71260-1-jaywang0.tw@gmail.com>
	<CAFEAcA-AX9V+OGMGf+JD9dnFEiSfStuSrmEGGuhFhNQjTyrJcw@mail.gmail.com>
Message-ID: <ca366a38-d19b-3a48-fa45-292c7bc3126c@gmail.com>
Date: Tue, 11 Sep 2018 10:01:50 +0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-AX9V+OGMGf+JD9dnFEiSfStuSrmEGGuhFhNQjTyrJcw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] block/file-posix: fix the wrong result of
 find_allocation() in macOS.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>

This is the program I used to check the behavior of SEEK_DATA and SEEK_HOLE.

#define _FILE_OFFSET_BITS 64
#define _LARGEFILE64_SOURCE 1
#include <sys/types.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <stdint.h>
#include <fcntl.h>
#include <errno.h>
#include <stdio.h>

/*
 * This function is suitable for macOS and Solaris' lseek behavior,
 * since start is always set to the beginning of a data region or a hole.
 * Please see the logics in main()
 */
static int find_allocation(int fd, off_t start, off_t *data, off_t*hole)
{
    off_t offs;

    offs = lseek(fd, start, SEEK_DATA);

    if (offs < 0) {
        return -errno;
    }

    if (offs < start) {
        return -EIO;
    }

    if (offs > start) {
        /* D2: start is at the beginning of hole */
        *hole = start;
        *data = offs;
        return 0;
    }

    /* D1: start is at beginning of data region */
    offs = lseek(fd, start, SEEK_HOLE);
    
    if (offs < 0) {
        return -errno;
    }

    if (offs < start) {
        return -EIO;
    }

    if (offs > start) {
        *data = start;
        *hole = offs;
        return 0;
    }

    return -EIO;
}

int main(int argc, const char* argv[])
{
    off_t first_data = -1, trailing_hole = -1;
    off_t cursor = 0;

    if (argc != 2) {
        fprintf(stderr, "Usage: %s path\n", argv[0]);
        return 1;
    }

    int fd = open(argv[1], O_RDONLY);
    if (fd < 0) {
        perror("Cannot open the file");
        return 1;
    }

    off_t filesize = lseek(fd, 0, SEEK_END);
    if (filesize < 0) {
        perror("Cannot get the file size");
        return 1;
    }

    if (filesize < 2) {
        fprintf(stderr, "Filesize is too small.\n");
        return 1;
    }

    printf ("Filesize: %lld\n", (long long)filesize);

    while(cursor < filesize) {
        off_t data, hole;
        int res;

        /* cursor is always at the beginning of a data region or a hole */
        res = find_allocation(fd, cursor, &data, &hole);
        
        if (res < 0 && res != -ENXIO) {
            fprintf(stderr, "The filesystem or platform being checked does not support SEEK_DATA or SEEK_HOLE.\n");
            perror("");
            return 1;
        }

        if (res == -ENXIO) {
            /* we are at the trailing hole */
            trailing_hole = cursor;
            break;
        }

        if (data == cursor && (hole - data) > 1) {
            /* the length of the data region must be greater than 1. */
            if (first_data == -1) {
                first_data = cursor;
            }
        }

        if (data == cursor) {
            cursor = hole;
        } else {
            cursor = data;
        }
    }

    if (first_data >= 0) {
        printf("Checking for SEEK_DATA by using the data region at %lld... ", (long long)first_data);
        /* first_data plus 1 makes the offset in the middle of a data region */
        errno = 0;
        off_t offs = lseek(fd, first_data + 1, SEEK_DATA);

        if (offs < 0 && errno != ENXIO) {
            printf("Error\n");
            perror(" Msg");
        } else if (errno == ENXIO || offs > first_data + 1) {
            /* offs is set to the next data region. This is macOS's behavior */
            printf("macOS\n");
        } else if (offs == first_data + 1) {
            printf("Linux\n");
        } else {
            printf("Unknown behavior\n");
        }
    } else {
        fprintf(stderr, "There is no data region which is suitable to be checked.\n");
    }

    if (trailing_hole >= 0) {
        printf("Checking for SEEK_HOLE by using the trailing hole at %lld... ", (long long)trailing_hole);
        off_t offs = lseek(fd, trailing_hole, SEEK_HOLE);

        if (offs < 0) {
            printf("Error\n");
            perror(" Msg");
        } else if (offs == filesize) {
            /* offs is set to EOF. This is Solaris' behavior */
            printf("Solaris\n");
        } else if (offs == trailing_hole) {
            printf("Linux\n");
        } else {
            printf("Unknown behavior\n");
        }
    } else {
        fprintf(stderr, "There is no trailing hole which is suitable to be checked.\n");
    }

    return 0;
}



Peter Maydell - 2018/9/8 11:34 PM:
> On 8 September 2018 at 15:15, Yan-Jie Wang <jaywang0.tw@gmail.com> wrote:
>> In macOS, lseek with SEEK_DATA behaves differently.
>> It seeks to the next data region even though offset is in the middle of
>> a data region. In addition, there may be many data regions without any
>> hole among them, like this: |---Data---|---Data---|
>>
>> Because of this, qemu-img convert with raw images as input may create
>> corrupted images in macOS especially for large files, and qemu-img
>> map may also report wrong things. This patch fixes this undesired
>> behaviors.
> 
> Hi. I have two general questions here:
> (1) is this behaviour of SEEK_DATA specific to macOS, or do the
> other BSDs (FreeBSD, OpenBSD, NetBSD) also have it ?
I have installed FreeBSD in Virtualbox and checked the behavior of lseek in FreeBSD.
The behavior of SEEK_DATA is the same as the one in Linux.

> (2) is there a way to determine which flavour of SEEK_DATA we
> have as a configure-time test rather than having to hardcode
> an OS-specific #ifdef ?
macOS can be installed on HFS+ or APFS filesystem. Only APFS supports SEEK_DATA and SEEK_HOLE.

If we try to build qemu on HFS+ filesystem, it is not possible to detect the behavior
of SEEK_DATA and SEEK_HOLE on configure-time.  lseek with SEEK_DATA or SEEK_HOLE returns
errors when the file being checked is on HFS+ filesystem. (I have checked it by formatting
my USB thumb drive to HFS+ filesystem and running the program provided at the top of this email on the file located at the HFS+ filesystem on my thumb drive.)

> 
> thanks
> -- PMM
> 
