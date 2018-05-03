Received: from eggs.gnu.org ([2001:4830:134:3::10]:54634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fEFRG-0004fO-Ep
	for qemu-devel@nongnu.org; Thu, 03 May 2018 10:42:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fEFRD-0004To-70
	for qemu-devel@nongnu.org; Thu, 03 May 2018 10:42:30 -0400
Received: from 15.mo1.mail-out.ovh.net ([188.165.38.232]:33030)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fEFRD-0004T3-19
	for qemu-devel@nongnu.org; Thu, 03 May 2018 10:42:27 -0400
Received: from player714.ha.ovh.net (unknown [10.109.122.78])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 7567AF3462
	for <qemu-devel@nongnu.org>; Thu,  3 May 2018 16:42:25 +0200 (CEST)
References: <20180419124331.3915-1-clg@kaod.org>
	<20180419124331.3915-7-clg@kaod.org>
	<20180426071129.GJ8800@umbus.fritz.box>
	<dafe2911-9755-2007-5723-686de5aeceb8@kaod.org>
	<20180503054341.GT13229@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <039bc762-0ce1-c09e-20f0-69bf890e68be@kaod.org>
Date: Thu, 3 May 2018 16:42:21 +0200
MIME-Version: 1.0
In-Reply-To: <20180503054341.GT13229@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 06/35] spapr/xive: introduce a XIVE
 interrupt presenter model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On 05/03/2018 07:43 AM, David Gibson wrote:
> On Wed, May 02, 2018 at 09:39:44AM +0200, C=E9dric Le Goater wrote:
>>>> =20
>>>> +static XiveNVT *spapr_xive_get_nvt(XiveFabric *xf, uint32_t server)
>>>> +{
>>>> +    PowerPCCPU *cpu =3D spapr_find_cpu(server);
>>>> +
>>>> +    return cpu ? XIVE_NVT(cpu->intc) : NULL;
>>>> +}
>>>
>>> So this is a bit of a tangent, but I've been thinking of implementing
>>> a scheme where there's an opaque pointer in the cpu structure for the
>>> use of the machine.  I'm planning for that to replace the intc pointe=
r
>>> (which isn't really used directly by the cpu). That would allow us to
>>> have spapr put a structure there and have both xics and xive pointers
>>> which could be useful later on.
>>
>> Here is a quick try of the idea. Tested on pnv and spapr machines.
>> I lacked inspiration on the name so I called the object
>> {Machine}Link.
>=20
> This is a bit overkill compared to what I had in mind.  I don't think
> the thing we're pointing to has to be a fully realized QOM object.=20

Yes, it is quite a bit of code for a simple struct.

> I was just going to replace the Object * with a void *, that it's up to
> the machine to interpret.

So the machine would just g_malloc0 a custom struct for each CPU, filling
it out depending on the configuration/needs ?=20
=20
> I'm also wondering about restricting this idea to vhyp platforms. =20

OK.=20

> The idea is that for physical-esque machines the cpu really does (or
> should) know how things are connected to it. =20

yes. P9 does not have a XICS interrupt controller on PowerNV.

> It's the abstraction of
> the paravirt platform that makes it fuzzy.  In which case I'd see it
> as the "opaque" pointer that goes along with the vhyp function
> pointers.

I will take a look for the intc pointer as xive needs an extra one.

C.
