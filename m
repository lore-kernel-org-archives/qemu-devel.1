Received: from eggs.gnu.org ([2001:4830:134:3::10]:53734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1ecHQd-0008Tn-AI
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 16:08:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1ecHQY-0003kj-Bl
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 16:08:55 -0500
Message-ID: <1516309705.31850.227.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 19 Jan 2018 08:08:25 +1100
In-Reply-To: <988ba765-5f0b-26eb-569a-2118eb533bf9@kaod.org>
References: <20171209084338.29395-1-clg@kaod.org>
	<20171209084338.29395-3-clg@kaod.org>
	<20171220050947.GC5981@umbus.fritz.box>
	<1513815126.2743.34.camel@kernel.crashing.org>
	<6768575f-27e0-1277-3e7e-56ec44298e6a@kaod.org>
	<1513896817.2743.63.camel@kernel.crashing.org>
	<683d0912-ad48-927c-8235-5358417be44c@kaod.org>
	<1516187433.31850.189.camel@kernel.crashing.org>
	<2226ed5e-f666-8060-2edd-998d2f5107ed@kaod.org>
	<1516224472.31850.193.camel@kernel.crashing.org>
	<988ba765-5f0b-26eb-569a-2118eb533bf9@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 02/19] spapr: introduce a skeleton for
 the XIVE interrupt controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>

On Thu, 2018-01-18 at 14:27 +0100, C=C3=A9dric Le Goater wrote:
> The source and the target machines should have the same realized=20
> objects. I think this is the simplest solution to keep the migration=20
> framework maintainable.=20

Yeah well, it all boils down to qemu migration being completely brain
dead in relying on an external entity to create the same machine rather
than carrying the configuration in the migration stream... ugh.

> I don't think it is a problem to call a xics_fini() routine to=20
> destroy the XICS KVM device if a new interrupt mode was negotiated
> in CAS. We would then call a xive_init() routing to create the new=20
> XIVE KVM device.
>=20
> When done, the question boils down to disconnect and reconnect the=20
> vcpus to the KVM device. The QEMU CPU ->intc pointer should be=20
> updated also but that's a QEMU level problem. Already done.

The problem is more the in-kernel hooks.
=20
> In the QEMU "icp-kvm" object, the connection to the KVM device=20
> is currently forced in the realize routine but we can add some=20
> handlers to manage the link. Similar handlers would do the same=20
> in the QEMU "nvt-kvm" object when XIVE is on.
>=20
>=20
> If we think this is a possible way to address the problem, I can=20
> check the above thinking on a XICS KVM machine and force the=20
> init/fini sequence in the CAS negotiation process. I will need=20
> a KVM ioctl to destroy a device and maybe a KVM VCPU ioctl to=20
> disable a capability.=20
