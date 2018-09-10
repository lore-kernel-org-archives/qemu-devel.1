Received: from eggs.gnu.org ([2001:4830:134:3::10]:59361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fzNpe-0003yz-T7
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 11:10:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fzNpa-00081L-Mj
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 11:10:30 -0400
References: <20180908141528.71260-1-jaywang0.tw@gmail.com>
	<CAFEAcA-AX9V+OGMGf+JD9dnFEiSfStuSrmEGGuhFhNQjTyrJcw@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <427e8ad2-c96a-fce8-b49e-c490c15d9ecd@redhat.com>
Date: Mon, 10 Sep 2018 10:10:24 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-AX9V+OGMGf+JD9dnFEiSfStuSrmEGGuhFhNQjTyrJcw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Peter Maydell <peter.maydell@linaro.org>, Yan-Jie Wang <jaywang0.tw@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>

On 9/8/18 10:34 AM, Peter Maydell wrote:
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

I hope no one else has it, because it is wrong, and should be fixed in 
MacOS to comply with the POSIX recommendation:

http://austingroupbugs.net/view.php?id=415#c862

The commit message ought to call out this link, when stating that the 
patch is a workaround for a buggy syscall.

> (2) is there a way to determine which flavour of SEEK_DATA we
> have as a configure-time test rather than having to hardcode
> an OS-specific #ifdef ?

Rather than hard-coding an OS-specific #ifdef, if we really are stuck 
working around MacOS braindead departure from implementation 
compatibility, then here's what Bruno recommended on the gnulib list:

https://lists.gnu.org/archive/html/bug-gnulib/2018-09/msg00058.html
> 
> How about one of these approaches?
> 
> (a) Put some knowledge about the extent boundaries into the code.
>     I.e. round offset down to the previous extend boundary before the
>     two lseek calls?

Except that I know of no clean way to learn what the actual extent 
boundary of a random offset is going to be.

> 
> (b) Evaluate both
>         d = lseek (fd, SEEK_DATA, offset);
>         h = lseek (fd, SEEK_HOLE, offset);
>     and since you don't know anything about the range from offset
>     to min(d,h)-1, assume it's data.
>     Then, if d < h, you have a data block, or if h < d, you have a hole.
> 

Our code currently optimizes by trying to use only one instead of two 
lseek() calls where possible, but this workaround seems like the most 
viable of any solution without even more syscalls.

> (c) for (int i = 1; i <= 16; i++)
>       {
>         unsigned long o = max (offset - (1 << i), 0);
>         d = lseek (fd, SEEK_DATA, o);
>         h = lseek (fd, SEEK_HOLE, o);
>         if (d < offset || h < offset)
>           break;
>       }

That may work to accomplish the semantics of proposal 1), but it is an 
awful lot of syscalls, and once you've made two, you don't really need 
to make more than two.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
