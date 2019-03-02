Received: from eggs.gnu.org ([209.51.188.92]:44877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1h01wo-0002D1-5Y
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 05:32:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1h01is-0006cS-5i
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 05:18:27 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34483)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1h01im-0005N2-AQ
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 05:18:25 -0500
Received: by mail-wr1-f66.google.com with SMTP id f14so422973wrg.1
	for <qemu-devel@nongnu.org>; Sat, 02 Mar 2019 02:18:02 -0800 (PST)
Date: Sat, 2 Mar 2019 11:17:58 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190302101758.g37atuvjk4qg4cn4@steredhat>
References: <1549390526-24246-1-git-send-email-pbonzini@redhat.com>
	<1549390526-24246-14-git-send-email-pbonzini@redhat.com>
	<87sgw6k02i.fsf@zen.linaroharston>
	<20190301171343.dyuqan3ok6gzuotw@steredhat>
	<87o96ujx63.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o96ujx63.fsf@zen.linaroharston>
Subject: Re: [Qemu-devel] [PULL 13/76] pvh: Add x86/HVM direct boot ABI
 header file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org

On Fri, Mar 01, 2019 at 05:56:36PM +0000, Alex Bennée wrote:
> 
> Stefano Garzarella <sgarzare@redhat.com> writes:
> 
> > On Fri, Mar 01, 2019 at 04:53:57PM +0000, Alex Bennée wrote:
> >>
> >> Paolo Bonzini <pbonzini@redhat.com> writes:
> >>
> >> > From: Liam Merwick <Liam.Merwick@oracle.com>
> >> >
> >> > The x86/HVM direct boot ABI permits Qemu to be able to boot directly
> >> > into the uncompressed Linux kernel binary with minimal firmware involvement.
> >> >
> >> > 	https://xenbits.xen.org/docs/unstable/misc/pvh.html
> >> >
> >> > This commit adds the header file that defines the start_info struct
> >> > that needs to be populated in order to use this ABI.
> >> >
> >> > The canonical version of start_info.h is in the Xen codebase.
> >> > (like QEMU, the Linux kernel uses a copy as well).
> >> >
> >> > Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
> >> > Reviewed-by: Konrad Rzeszutek Wilk <Konrad.Wilk@oracle.com>
> >> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> >>
> >> This has changed behaviour of a boot. Previously:
> >>
> >>   qemu-system-i386 -serial mon:stdio -nographic -device \
> >>      isa-debugcon,chardev=serial0 -kernel ./tests/hello
> >>
> >
> > Hi Alex,
> > is your image in multiboot format?
> 
> AFAICT yes, I'm not super familiar with x86 so I'm mostly cribbing from:
> 
>   https://github.com/doug65536/qemu-bmibug
> 
> > I sent a patch few weeks ago that fix the loading of multiboot images:
> > https://www.mail-archive.com/qemu-devel@nongnu.org/msg596424.html
> 
> That certainly fixes things. Although I'm wondering if it's worth making
> my test image PVH compatible anyway (if it's easy to do) as all I really
> want to do is exercise the softmmu code. It might be simpler to use
> paravirtualised serial ports rather than banging an IO port, IDK?

I don't have a lot of experience too, but I don't think there are a lot
of differences in terms of how to use ports.

Multiboot and PVH change the way how to jump to your image.
Both provide a structure where your image can found the e820 memory map and
PVH provides also the RSDP (ACPI) pointer.

Maybe create a PVH image should be simpler because you only need to put in the
ELF note the entry point of your ELF image. Then, EBX will contain the address
of start_info structure (where you can find the e820 mmap).

You can take a look of this file in Linux: arch/x86/platform/pvh/head.S

I hope this can help :)

Cheers,
Stefano
