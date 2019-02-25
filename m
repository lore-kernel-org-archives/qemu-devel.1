Received: from eggs.gnu.org ([209.51.188.92]:40306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gyIBk-0006gp-Je
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:29:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gyIBd-0005SP-Cv
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:29:00 -0500
References: <1551095970-14645-1-git-send-email-thuth@redhat.com>
	<20190225140935.GE6320@linux.fritz.box>
	<CAFEAcA9bbZKeM=-P7mh90-QH35Kn_oR-D0yTUbteKg8JEV+Tgw@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8b979054-595e-e697-beb1-d45f1537c64d@redhat.com>
Date: Mon, 25 Feb 2019 16:28:43 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9bbZKeM=-P7mh90-QH35Kn_oR-D0yTUbteKg8JEV+Tgw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] block/nvme: Remove QEMU_PACKED from
 naturally aligned NVMeRegs struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Fam Zheng <fam@euphon.net>, Qemu-block <qemu-block@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Max Reitz <mreitz@redhat.com>, Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>

On 25/02/2019 15.30, Peter Maydell wrote:
> On Mon, 25 Feb 2019 at 14:09, Kevin Wolf <kwolf@redhat.com> wrote:
>> Though I'm not sure why a compiler should warn if packed and non-packed
>> result in the exact same layout anyway...
> 
> Packed implies "and any time you see a pointer to this struct
> it might not be aligned". Non-packed implies "you can assume
> that the base of the struct is aligned".

Right. FWIW, consider this small program:

#include <stdio.h>
#include <stdint.h>

typedef struct {
    uint64_t a;
    uint64_t b;
    uint64_t c;
    uint64_t d;
} __attribute__((packed)) s1_t;

struct {
    char x;
    s1_t s1;
} s2;

int main()
{
    printf("address of s2.s1.d = %p\n", &s2.s1.d);
    return 0;
}

Though all members of s1_t look like they are naturally aligned, I get
an odd pointer for one of its members in this case.

So passing along that pointer to other functions will certainly cause
crashes on architectures like Sparc, thus the compiler warning is indeed
justified here.

 Thomas
