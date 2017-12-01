Received: from eggs.gnu.org ([2001:4830:134:3::10]:47197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eKoBF-0005yF-Jv
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:28:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eKoBC-0005Af-FB
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:28:49 -0500
Received: from 9.mo3.mail-out.ovh.net ([87.98.184.141]:53437)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eKoBC-00059o-9V
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:28:46 -0500
Received: from player771.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 8814F17782F
	for <qemu-devel@nongnu.org>; Fri,  1 Dec 2017 09:10:29 +0100 (CET)
References: <20171123132955.1261-1-clg@kaod.org>
	<20171123132955.1261-18-clg@kaod.org>
	<20171130055542.GG3023@umbus.fritz.box>
	<2cee93ff-060a-aa04-852c-d3585dba0c7f@kaod.org>
	<20171201041423.GF30161@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <8d2e92cc-a305-d9d4-b28c-873acd76ee6a@kaod.org>
Date: Fri, 1 Dec 2017 09:10:24 +0100
MIME-Version: 1.0
In-Reply-To: <20171201041423.GF30161@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 17/25] spapr: add a sPAPRXive object to the
 machine
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

On 12/01/2017 05:14 AM, David Gibson wrote:
> On Thu, Nov 30, 2017 at 03:15:09PM +0000, C=E9dric Le Goater wrote:
>> On 11/30/2017 05:55 AM, David Gibson wrote:
>>> On Thu, Nov 23, 2017 at 02:29:47PM +0100, C=E9dric Le Goater wrote:
>>>> The XIVE object is designed to be always available, so it is created
>>>> unconditionally on newer machines.
>>>
>>> There doesn't actually seem to be anything dependent on machine
>>> version here.
>>
>> No. I thought that was too early in the patchset. This is handled=20
>> in the last patch with a 'xive_exploitation' bool which is set to=20
>> false on older machines.=20
>>
>> But, nevertheless, the XIVE objects are always created even if not
>> used. Something to discuss.
>=20
> That'll definitely break backwards migration, since the destination
> won't understand the (unused but still present) xive state it
> receives.=20

no because it's not sent. the vmstate 'needed' op of the sPAPRXive
object discards it :

    static bool vmstate_spapr_xive_needed(void *opaque)
    {
        sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
=20
        return spapr->xive_exploitation;
    }

> So xives can only be created on new machine types.=20

That would be better I agree. I can probably use the 'xive_exploitation'
bool to condition its creation.

> I'm ok
> (at least tentatively) with always creating them on the newer machine
> types, regardless of whether the guest ends up exploiting it or not.

OK.


>>>> Depending on the configuration and
>>>> the guest capabilities, the CAS negotiation process will decide whic=
h
>>>> interrupt model to use, legacy or XIVE.
>>>>
>>>> The XIVE model makes use of the full range of the IRQ number space
>>>> because the IRQ numbers for the CPU IPIs are allocated in the range
>>>> below XICS_IRQ_BASE, which is unused by XICS.
>>>
>>> Ok.  And I take it 4096 is enough space for the XIVE IPIs for the
>>> forseeable future?
>>
>> The biggest real system I am aware of as 16 sockets, 192 cores, SMT8.=20
>> That's 1536 cpus. pseries has a max_cpus of 1024.
>=20
> Ok, so we can go to double the current system size, but not 4x.  Not
> sure if that seems adequate or not.  Still it's a relatively minor
> detail.
>=20
