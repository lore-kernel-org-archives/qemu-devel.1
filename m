Received: from eggs.gnu.org ([209.51.188.92]:50787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gt9Ps-0002QW-BJ
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 06:06:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gt9Pr-0000t8-5d
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 06:06:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58892)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gt9Pq-0000qq-DI
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 06:06:22 -0500
Date: Mon, 11 Feb 2019 10:58:44 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190211105844.GN27585@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <CAFEAcA88+A2oCkQnxKDEdpmfCZSmPzWMBg01wDDV68bMZoY5Jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA88+A2oCkQnxKDEdpmfCZSmPzWMBg01wDDV68bMZoY5Jg@mail.gmail.com>
Subject: Re: [Qemu-devel] should we try to stop using variable length arrays?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Thu, Feb 07, 2019 at 07:30:59PM +0000, Peter Maydell wrote:
> Currently QEMU has 9 uses of variable length arrays
> (found using -Wvla):
> 
> hw/block/dataplane/virtio-blk.c:62:25: warning: variable length array
> used [-Wvla]
>     unsigned long bitmap[BITS_TO_LONGS(nvqs)];
>                         ^
> hw/i386/multiboot.c:364:18: warning: variable length array used [-Wvla]
>     char kcmdline[strlen(kernel_filename) + strlen(kernel_cmdline) + 2];
>                  ^
> hw/i386/xen/xen-hvm.c:618:25: warning: variable length array used [-Wvla]
>     unsigned long bitmap[DIV_ROUND_UP(npages, width)];
>                         ^
> hw/intc/xics.c:604:18: warning: variable length array used [-Wvla]
>     uint8_t flags[ics->nr_irqs];
>                  ^
> hw/net/fsl_etsec/rings.c:383:18: warning: variable length array used [-Wvla]
>     uint8_t  padd[etsec->rx_padding];
>                  ^
> hw/ppc/pnv.c:130:26: warning: variable length array used [-Wvla]
>     uint32_t servers_prop[smt_threads];
>                          ^
> hw/ppc/spapr.c:162:26: warning: variable length array used [-Wvla]
>     uint32_t servers_prop[smt_threads];
>                          ^
> hw/ppc/spapr.c:163:27: warning: variable length array used [-Wvla]
>     uint32_t gservers_prop[smt_threads * 2];
>                           ^
> linux-user/syscall.c:3478:23: warning: variable length array used [-Wvla]
>     struct sembuf sops[nsops];
>                       ^
> 
> Should we be looking to get rid of these and turn on the -Wvla
> warning? I know the Linux kernel has recently decided to do this
> (some rationale at the start of https://lwn.net/Articles/749064/).
> Now that doesn't necessarily apply to us as a userspace program,
> but on the other hand if any of these were allowing the guest to
> determine the size of an on-stack array that would not be great.
> (The linux-user one is bogus in that way, though not a security issue
> as the guest code there has full control anyway.)
> 
> Opinions? I admit that to some extent this is just my sense of
> tidiness thinking that if we only have a handful of uses of
> something we should squash that down to zero :-)

I think we've got few enough uses of VLA that we would be justified in
removing them so that we can compile time prevent use of the potentially
dangerous feature, even if the current uses are safe.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
