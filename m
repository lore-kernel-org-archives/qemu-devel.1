Received: from eggs.gnu.org ([2001:4830:134:3::10]:53547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cvePk-00089m-B9
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 02:27:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cvePf-0001FL-8t
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 02:27:32 -0400
Received: from 8.mo177.mail-out.ovh.net ([46.105.61.98]:38062)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cvePf-0001EY-2c
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 02:27:27 -0400
Received: from player688.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 18F0A4A17E
	for <qemu-devel@nongnu.org>; Wed,  5 Apr 2017 08:27:23 +0200 (CEST)
References: <1491205565-12831-1-git-send-email-clg@kaod.org>
	<20170405055115.GC13614@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <590d0aa7-6d77-d6eb-c93e-75f2e8e9a506@kaod.org>
Date: Wed, 5 Apr 2017 08:27:15 +0200
MIME-Version: 1.0
In-Reply-To: <20170405055115.GC13614@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 0/9] ppc/pnv: interrupt controller
 (POWER8)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 04/05/2017 07:51 AM, David Gibson wrote:
> On Mon, Apr 03, 2017 at 09:45:56AM +0200, C=E9dric Le Goater wrote:
>> Hello,
>>
>> Here is a series adding support for the interrupt controller as found
>> on a POWER8 system. POWER9 uses a different interrupt controller
>> called XIVE, still to be worked on.
>>
>> The initial patches are more cleanups of the XICS layer which move the
>> IRQ 'server' number mapping under the machine handlers.
>>
>> A new PnvICPState object based on MMIOs, which is specific to PowerNV,
>> is introduced in XICS. These ICP objects are created for each thread
>> of a core and linked to the associated PowerPCCPU object.
>>
>> Finally, to make use of the XICS layer, the PowerNV machine is
>> extended with a QOM XICSFabric interface and with a global memory
>> region acting as the Interrupt Management area.
>>
>>
>> To test, grab a kernel and a rootfs image here :
>>
>>   https://openpower.xyz/job/openpower-op-build/distro=3Dubuntu,target=3D=
palmetto/lastSuccessfulBuild/artifact/images/zImage.epapr
>>   https://openpower.xyz/job/openpower-op-build/distro=3Dubuntu,target=3D=
palmetto/lastSuccessfulBuild/artifact/images/rootfs.cpio.xz
>>
>> The full patchset is available here :
>>
>>    https://github.com/legoater/qemu/commits/powernv-ipmi-2.9
>>
>> Thanks,
>=20
> I've applied the series to my ppc-for-2.10 branch.  A couple of things
> to think about for follow up cleanups:
>=20
> 1) The spapr->nr_servers field has very little remaining use; can you
>    go a bit further and remove it entirely?

yes. I have a patch for it already, reshuffling the xics_system_init
routine again to make it look a little better :=20

	https://github.com/legoater/qemu/commit/94e90b4b660d521ad4806a5496dd89f3=
51995810
=20
> 2) At the moment you're creating (and realizing) the ICP objects=20

yes. This is because the number of ICPState objects depends=20
on 'nr_threads' which is only known at realize time.

We could also define an array of icps in the core:

	PnvICPState icps[MAX_THREADS]

initialize them in an init routine and only realize a subset=20
depending on 'nr_threads'.=20

This is possible because the size of TYPE_PNV_ICP and TYPE_ICP
are the same.=20

But, the current method is safer I think.=20

> just  before you realize the core objects.=20

yes. this is to not complete the core realization if the ICP=20
creation fails. Else the core would be fully realized before=20
the ICP, which feels incorrect as the ICP is an attribute=20
of the core now.=20

> I'm not entirely sure if
> creating new objects at realize time is QOMishly correct.  Maybe do
> some more enquiries to see if it is or not, and if not update.

Yes.

Thanks,

C.=20
  =20
