Received: from eggs.gnu.org ([2001:4830:134:3::10]:50784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eLmAm-0003Ob-9S
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 03:32:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eLmAh-0003Zf-8h
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 03:32:20 -0500
Received: from 18.mo3.mail-out.ovh.net ([87.98.172.162]:33771)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eLmAh-0003TO-2r
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 03:32:15 -0500
Received: from player732.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 1601C177ECD
	for <qemu-devel@nongnu.org>; Mon,  4 Dec 2017 09:32:06 +0100 (CET)
References: <20171123132955.1261-1-clg@kaod.org>
	<20171123132955.1261-18-clg@kaod.org>
	<20171130055542.GG3023@umbus.fritz.box>
	<2cee93ff-060a-aa04-852c-d3585dba0c7f@kaod.org>
	<20171201041423.GF30161@umbus.fritz.box>
	<8d2e92cc-a305-d9d4-b28c-873acd76ee6a@kaod.org>
	<20171204015918.GK2130@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <747d3b64-a068-6476-02e1-8a89161d4101@kaod.org>
Date: Mon, 4 Dec 2017 09:32:00 +0100
MIME-Version: 1.0
In-Reply-To: <20171204015918.GK2130@umbus.fritz.box>
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

On 12/04/2017 02:59 AM, David Gibson wrote:
> On Fri, Dec 01, 2017 at 09:10:24AM +0100, C=E9dric Le Goater wrote:
>> On 12/01/2017 05:14 AM, David Gibson wrote:
>>> On Thu, Nov 30, 2017 at 03:15:09PM +0000, C=E9dric Le Goater wrote:
>>>> On 11/30/2017 05:55 AM, David Gibson wrote:
>>>>> On Thu, Nov 23, 2017 at 02:29:47PM +0100, C=E9dric Le Goater wrote:
>>>>>> The XIVE object is designed to be always available, so it is creat=
ed
>>>>>> unconditionally on newer machines.
>>>>>
>>>>> There doesn't actually seem to be anything dependent on machine
>>>>> version here.
>>>>
>>>> No. I thought that was too early in the patchset. This is handled=20
>>>> in the last patch with a 'xive_exploitation' bool which is set to=20
>>>> false on older machines.=20
>>>>
>>>> But, nevertheless, the XIVE objects are always created even if not
>>>> used. Something to discuss.
>>>
>>> That'll definitely break backwards migration, since the destination
>>> won't understand the (unused but still present) xive state it
>>> receives.=20
>>
>> no because it's not sent. the vmstate 'needed' op of the sPAPRXive
>> object discards it :
>>
>>     static bool vmstate_spapr_xive_needed(void *opaque)
>>     {
>>         sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine())=
;
>> =20
>>         return spapr->xive_exploitation;
>>     }
>=20
> Ah, sorry, missed that.  Once we have negotiation we'll need to make
> sure the xive_exploitation bit is sent first, of course, but I'm
> pretty sure the machine state is already sent first.
>=20
>>> So xives can only be created on new machine types.=20
>>
>> That would be better I agree. I can probably use the 'xive_exploitatio=
n'
>> bool to condition its creation.
>=20
> Hrm.  I'm less sure about that - I'm not sure the lifetimes line up.
> But I'd like to avoid creating them on earlier machine types, even if
> xive_exploitation can't do the trick.

Yes. I agree. I think we can work something out without introducing
too much complexity. The XIVE object is directly used by the
machine only to set/unset IRQ numbers. Otherwise, it is always=20
conditioned by :

    spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)

I think adding a couple of more tests on the 'xive_exploitation'
bool should work out for older machines.

Thanks,
=20
C.
