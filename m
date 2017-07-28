Received: from eggs.gnu.org ([2001:4830:134:3::10]:46962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1daxwN-0003fx-0a
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 01:36:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1daxwJ-0002KZ-N3
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 01:35:59 -0400
Received: from 9.mo5.mail-out.ovh.net ([178.32.96.204]:58627)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1daxwJ-0002CH-Gj
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 01:35:55 -0400
Received: from player695.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id A37BB116D88
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 07:35:47 +0200 (CEST)
References: <150100547373.27487.3154210751350595400.stgit@bahia>
	<07a10650-f216-99ea-fb48-286887279bf1@linux.vnet.ibm.com>
	<20170727183926.246b5beb@bahia.lan>
	<20bc63c9-0649-5b82-5042-61e7313cf833@ozlabs.ru>
	<20170728034042.GD3098@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <cd9ef0ba-c329-bac2-6b94-a8397d7b45cc@kaod.org>
Date: Fri, 28 Jul 2017 07:35:34 +0200
MIME-Version: 1.0
In-Reply-To: <20170728034042.GD3098@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [for-2.11 PATCH 00/26] spapr: add
 support for PHB hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Greg Kurz <groug@kaod.org>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>

On 07/28/2017 05:40 AM, David Gibson wrote:
> On Fri, Jul 28, 2017 at 01:27:05PM +1000, Alexey Kardashevskiy wrote:
>> On 28/07/17 02:39, Greg Kurz wrote:
>>> On Wed, 26 Jul 2017 17:31:17 -0300
>>> Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com> wrote:
>>>
>>>> I've tested the patch set using Greg's Github branch. It worked fine=
 in=20
>>>> my tests
>>>> using a Fedora 26 and an Ubuntu 17.04 guests. I have two observation=
s
>>>> though:
>>>>
>>>> 1 - This is not related to this patch set per se because it is=20
>>>> reproducible on master, but
>>>> I think it is interfering with this new feature.  There is a=20
>>>> warning/error message in
>>>> the kernel right after SLOF that goes:
>>>>
>>>> (...)
>>>>   -> smp_release_cpus() =20
>>>> spinning_secondaries =3D 0
>>>>   <- smp_release_cpus()
>>>> Linux ppc64le
>>>> #1 SMP Mon Jul 1[    0.030450] pci 0000:00:02.0: of_irq_parse_pci:=20
>>>> failed with rc=3D-22
>>>> [    0.030552] pci 0000:00:0f.0: of_irq_parse_pci: failed with rc=3D=
-22
>>>> [  OK  ] Started Security Auditing Service.
>>>> (...)
>>>>
>>>
>>> This is a regression in QEMU master introduced by this commit:
>>>
>>> commit b87680427e8a3ff682f66514e99a8344e7437247
>>> Author: C=E9dric Le Goater <clg@kaod.org>
>>> Date:   Wed Jul 5 19:13:15 2017 +0200
>>>
>>>     spapr: populate device tree depending on XIVE_EXPLOIT option
>>>    =20
>>>     When XIVE is supported, the device tree should be populated
>>>     accordingly and the XIVE memory regions mapped to activate MMIOs.
>>>    =20
>>>     Depending on the design we choose, we could also allocate differe=
nt
>>>     ICS and ICP objects, or switch between objects. This needs to be
>>>     discussed.
>>>    =20
>>>     Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>>>     Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>>>
>>> It is very similar to the issue that motivated the new KVMPPC_H_UPDAT=
E_PHANDLE
>>> hcall (see patch 24 and 26 in this series):
>>>
>>> - QEMU creates an "interrupt-controller" node with a phandle property
>>>   with the value 0x1111
>>> - QEMU passes the FDT to SLOF
>>> - SLOF converts all references to the phandle to an SLOF internal val=
ue
>>>
>>> =3D> from now on (ie, until the next machine reset), the guest only k=
nows
>>>    the OF phandle.
>>>
>>> - during CAS, if we go XICS, we send back an updated FDT with the
>>>   phandle of the "interrupt-controller" node reverted to 0x1111
>>>
>>> =3D> the guest complains because all cold-plugged devices nodes refer
>>>    to the OF phandle, not 0x1111
>>>
>>> A solution is to use the value set by KVMPPC_H_UPDATE_PHANDLE during =
CAS
>>> instead of 0x1111. I could verify it makes the guest warning disappea=
r.
>>>
>>> I'll send a dedicated patchset to fix this in 2.10.
>>
>>
>> The SLOF I pushed for 2.10 does not have it though. And the rest of XI=
VE is
>> not targeted for 2.10 anyway. So imho the solution is reverting "spapr=
:
>> populate device tree depending on XIVE_EXPLOIT option" for 2.10.
>=20
> I agree, I've applied the revert to ppc-for-2.10 now.

Sure.=20

Greg, have you found a solution to get around this problem or do we need
to populate the device tree with the interrupt controller node for SLOF ?=
=20

Thanks,

C. =20
