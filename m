Received: from eggs.gnu.org ([2001:4830:134:3::10]:53743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ecAE5-0001Pk-2h
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 08:27:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ecAE1-0002GA-0L
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 08:27:29 -0500
Received: from 12.mo3.mail-out.ovh.net ([188.165.41.191]:43751)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ecAE0-00028d-Qg
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 08:27:24 -0500
Received: from player158.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id C72211867C1
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 14:27:15 +0100 (CET)
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
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <988ba765-5f0b-26eb-569a-2118eb533bf9@kaod.org>
Date: Thu, 18 Jan 2018 14:27:09 +0100
MIME-Version: 1.0
In-Reply-To: <1516224472.31850.193.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>

On 01/17/2018 10:27 PM, Benjamin Herrenschmidt wrote:
> On Wed, 2018-01-17 at 15:39 +0100, C=C3=A9dric Le Goater wrote:
>> Migration is a problem. We will need both backend QEMU objects to be=20
>> available anyhow if we want to migrate. So we are back to the current=20
>> solution creating both QEMU objects but we can try to defer some of th=
e=20
>> KVM inits and create the KVM device on demand at CAS time.
>=20
> Do we have a way to migrate a piece of info from the machine *first*
> that indicate what type of XICS/XIVE to instanciate ?

The source and the target machines should have the same realized=20
objects. I think this is the simplest solution to keep the migration=20
framework maintainable.=20


I don't think it is a problem to call a xics_fini() routine to=20
destroy the XICS KVM device if a new interrupt mode was negotiated
in CAS. We would then call a xive_init() routing to create the new=20
XIVE KVM device.

When done, the question boils down to disconnect and reconnect the=20
vcpus to the KVM device. The QEMU CPU ->intc pointer should be=20
updated also but that's a QEMU level problem. Already done.
=20
In the QEMU "icp-kvm" object, the connection to the KVM device=20
is currently forced in the realize routine but we can add some=20
handlers to manage the link. Similar handlers would do the same=20
in the QEMU "nvt-kvm" object when XIVE is on.


If we think this is a possible way to address the problem, I can=20
check the above thinking on a XICS KVM machine and force the=20
init/fini sequence in the CAS negotiation process. I will need=20
a KVM ioctl to destroy a device and maybe a KVM VCPU ioctl to=20
disable a capability.=20

Cheers,

C.=20
