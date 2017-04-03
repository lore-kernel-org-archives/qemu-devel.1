Received: from eggs.gnu.org ([2001:4830:134:3::10]:40685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cv7yt-0001HH-Fj
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 15:49:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cv7ys-0005f3-F4
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 15:49:39 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:34193)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cv7ys-0005eb-7K
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 15:49:38 -0400
Received: by mail-wr0-x233.google.com with SMTP id t20so5486948wra.1
	for <qemu-devel@nongnu.org>; Mon, 03 Apr 2017 12:49:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170401004624.30886-4-ehabkost@redhat.com>
References: <20170401004624.30886-1-ehabkost@redhat.com>
	<20170401004624.30886-4-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Apr 2017 20:49:16 +0100
Message-ID: <CAFEAcA_uRHZR0N-=h=eWsDKjZpN4csua1j++wLVfZbsNVpaH5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [RFC 03/19] sysbus: Set user_creatable=false by
 default on TYPE_SYS_BUS_DEVICE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laszlo Ersek <lersek@redhat.com>, Alexander Graf <agraf@suse.de>, Marcel Apfelbaum <marcel@redhat.com>, Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, "Michael S. Tsirkin" <mst@redhat.com>, Scott Wood <scottwood@freescale.com>, Jason Wang <jasowang@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Gerd Hoffmann <kraxel@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Qemu-block <qemu-block@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Beniamino Galvani <b.galvani@gmail.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, "Gabriel L . Somlo" <somlo@cmu.edu>, Igor Mammedov <imammedo@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>, qemu-arm <qemu-arm@nongnu.org>, Shannon Zhao <zhaoshenglong@huawei.com>

On 1 April 2017 at 01:46, Eduardo Habkost <ehabkost@redhat.com> wrote:
> commit 33cd52b5d7b9adfd009e95f07e6c64dd88ae2a31 unset
> cannot_instantiate_with_device_add_yet in TYPE_SYSBUS, making
> all kinds of untested devices available to -device and
> device_add.
>
> The problem with that is: setting has_dynamic_sysbus on a
> machine-type lets it accept all the 288 sysbus device types we
> have in QEMU, and most of them were never meant to be used with
> -device. That's a lot of untested code.
>
> Fortunately today we have just a few has_dynamic_sysbus=1
> machines: virt, pc-q35-*, ppce500, and spapr.
>
> virt, ppce500, and spapr have extra checks to ensure just a few
> device types can be instantiated:
>
> * virt supports only TYPE_VFIO_CALXEDA_XGMAC, TYPE_VFIO_AMD_XGBE.
> * ppce500 supports only TYPE_ETSEC_COMMON.
> * spapr supports only TYPE_SPAPR_PCI_HOST_BRIDGE.
>
> q35 has no code to block unsupported sysbus devices, however, and
> accepts all device types. Fortunately, only the following 20
> device types are compiled into the qemu-system-x86_64 and
> qemu-system-i386 binaries:
>
> * allwinner-ahci
> * amd-iommu
> * cfi.pflash01
> * esp
> * fw_cfg_io
> * fw_cfg_mem
> * generic-sdhci
> * hpet
> * intel-iommu
> * ioapic
> * isabus-bridge
> * kvmclock
> * kvm-ioapic
> * kvmvapic
> * SUNW,fdtwo
> * sysbus-ahci
> * sysbus-fdc
> * sysbus-ohci
> * unimplemented-device
> * virtio-mmio
>
> Instead of requiring each machine-type with has_dynamic_sysbus=1
> to implement its own mechanism to block unsupported devices, we
> can use the user_creatable flag to ensure we won't let the user
> plug anything that will never work.

How does this work? Which devices can be dynamically
plugged is machine dependent. You can't dynamically-plug
an intel-iommu on the ARM virt board, and you can't
dynamically-plug the vfio-calxeda-xgmac on the spapr
board, and so on. So I don't see how we can just have
a flag on the device itself that controls whether
it can be dynamically plugged.

So I'm definitely coming around to the opinion that
it's just a bug in the q35 board that it doesn't have
any device whitelisting, and we should fix that.

thanks
-- PMM
