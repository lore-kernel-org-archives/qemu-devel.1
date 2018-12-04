Received: from eggs.gnu.org ([2001:4830:134:3::10]:51170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gUANd-0005Wc-IA
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 08:04:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gUANc-0006Vg-3D
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 08:04:49 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:37322)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gUANa-0006NL-Sv
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 08:04:47 -0500
Received: by mail-oi1-x241.google.com with SMTP id y23so14171081oia.4
	for <qemu-devel@nongnu.org>; Tue, 04 Dec 2018 05:04:46 -0800 (PST)
MIME-Version: 1.0
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-28-clg@kaod.org>
	<20181129040917.GF14697@umbus.fritz.box>
	<CAFEAcA8=xJCoTmXmygpK2yVdq5Viqi-dQoiTJrML=goutzKujQ@mail.gmail.com>
	<f92e8c2c-3384-ba88-3d85-0c168441b052@kaod.org>
In-Reply-To: <f92e8c2c-3384-ba88-3d85-0c168441b052@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Dec 2018 13:04:34 +0000
Message-ID: <CAFEAcA_3Qy1R8uOT_QayXfUneQT0_rL3J3Rv_uTG0DDFSCyRvQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 27/36] sysbus: add a sysbus_mmio_unmap()
 helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Tue, 4 Dec 2018 at 12:33, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> A completely new interrupt controller was introduced on the POWER9
> processor and it uses MMIO regions for interrupt management. These
> regions are backed by simple MRs in QEMU, when using TCG, and backed
> by ram_device_ptr MRs under KVM.
>
> Difficulties arise with the fact that POWER9 pseries guests need
> to support the old mode (XICS, no MMIOs) and the new mode XIVE.
> The interrupt mode is negotiated at boot between the hypervisor
> and the guest and a reset is generated to take into account
> the changes. Which means that, at reset, we may need to disconnect
> from a KVM IC device and reconnect to another.

This is a painful API for QEMU to implement, incidentally,
because we don't have any concept really of a warm reset. In
theory reset should get you back to exactly the same state
as if you'd just started QEMU. You can probably bodge something
together, though.

> When switching from XICS to XIVE mode :
>
>   if kvm
>     - destroy KVM XICS device
>     - create KVM XIVE device
>     - get fd, mmap, init ram_device_ptr MRs
>     - map mmio
>   - enable MMIOs
>
> When switching from XIVE to XICS  :
>
>   - disable MMIOs
>   if kvm
>     - delete MRs
>     - munmap
>     - destroy KVM XIVE device
>     - create KVM XICS device

This seems basically OK, I think.

thanks
-- PMM
