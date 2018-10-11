Received: from eggs.gnu.org ([2001:4830:134:3::10]:54440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gAVez-0004mZ-8s
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 03:45:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gAVev-000604-7t
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 03:45:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56306)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gAVet-0005oM-L6
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 03:45:24 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B894C31524D6
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 07:45:22 +0000 (UTC)
Date: Thu, 11 Oct 2018 09:45:21 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181011074521.bsnmm4tj7znecw2k@sirius.home.kraxel.org>
References: <20181008185013.19371-1-mreitz@redhat.com>
	<20181010101025.kck5epmrqurpbeg6@sirius.home.kraxel.org>
	<0d07e9f7-1924-0e0f-94da-25d25b10e748@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d07e9f7-1924-0e0f-94da-25d25b10e748@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] sdl2: Support all virtio-gpu formats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org

On Wed, Oct 10, 2018 at 07:35:06PM +0200, Max Reitz wrote:
> On 10.10.18 12:10, Gerd Hoffmann wrote:
> > On Mon, Oct 08, 2018 at 08:50:13PM +0200, Max Reitz wrote:
> >> There are some 2D resource formats that can be used through virtio-gpu,
> > 
> > Ahem, not really.  XRGB is the only one which works in practice, and
> > virtio-gpu kms driver will stop advertising anything else soon (patches
> > should land upstream with the next merge window).
> 
> OK, if virtio-gpu didn't support anything else, that'd be a fix, too.
> But it sounds like you're talking about the Linux driver, I'm not.
> 
> This is not about Linux applications being able to abuse the Linux
> driver to crash the VM, this is about malicious drivers (not necessarily
> Linux drivers).
> 
> >> Add these formats in the switch converting pixman to SDL format
> >> constants so a guest cannot crash the VM by triggering the
> >> g_assert_not_reached() with an unsupported format.
> > 
> > Do you have a reproducer for that?
> 
> I have attached two RISC-V kernels, one (kernel-rgbx) setting
> VIRTIO_GPU_FORMAT_R8G8B8X8_UNORM, the other (kernel-bgra) setting
> VIRTIO_GPU_FORMAT_B8G8R8A8_UNORM.  Both crash qemu:
> 
> $ $QEMU/build/riscv64-softmmu/qemu-system-riscv64 -kernel kernel-rgbx \
>     -serial stdio -M virt -device virtio-gpu-device
> [platform-virt] Virt platform detected
> [virtio-gpu] Found device @0x10008000
> [virtio-gpu] Scanout 0: 0x0:1024x768
> **
> ERROR:$QEMU/ui/sdl2-2d.c:114:sdl2_2d_switch: code should not be reached
> [1]    7151 abort (core dumped)

Ok, I see.  If sdl2 can support those formats it makes sense to support
them, but they must be added to both sdl2_2d_check_format() and
sdl2_2d_switch() then.

> > There is sdl2_2d_check_format() which reports the supported formats.
> > If we hit sdl2_2d_switch() with a format not whitelisted by
> > sdl2_2d_check_format() we have a bug somewhere in qemu ...
> 
> I suppose the other solution would be for virtio_gpu_set_scanout() to
> check whether the resource's format can actually be used for that
> display.

Yes, that must be added (independent from the sdl2 patch).

> Or in virtio_gpu_resource_create_2d(), I don't know whether
> it's possible to use resources in other formats at all.

Not directly, they must be converted (using pixman) then.

cheers,
  Gerd
