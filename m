Received: from eggs.gnu.org ([2001:4830:134:3::10]:38520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gVAsK-0001EJ-2u
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 02:48:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gVAsF-0001JC-3l
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 02:48:40 -0500
Received: from 7.mo69.mail-out.ovh.net ([46.105.50.32]:34303)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gVAsE-00013B-PW
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 02:48:34 -0500
Received: from player690.ha.ovh.net (unknown [10.109.159.152])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 5433C35781
	for <qemu-devel@nongnu.org>; Fri,  7 Dec 2018 08:48:17 +0100 (CET)
References: <20181205232251.10446-1-clg@kaod.org>
	<20181205232251.10446-7-clg@kaod.org>
	<20181206040914.GO768@umbus.fritz.box>
	<16ae54d9-2bad-ea77-30be-fff2cf3dea89@kaod.org>
	<20181207020527.GX768@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <cc27bb87-611b-36dd-8152-3eea285dedcd@kaod.org>
Date: Fri, 7 Dec 2018 08:48:09 +0100
MIME-Version: 1.0
In-Reply-To: <20181207020527.GX768@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 06/37] ppc/xive: add support for the END
 Event State buffers
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

On 12/7/18 3:05 AM, David Gibson wrote:
> On Thu, Dec 06, 2018 at 07:30:34AM +0100, C=E9dric Le Goater wrote:
>> On 12/6/18 5:09 AM, David Gibson wrote:
>>> On Thu, Dec 06, 2018 at 12:22:20AM +0100, C=E9dric Le Goater wrote:
> [snip]
>>>> +/*
>>>> + * END ESB MMIO loads
>>>> + */
>>>> +static uint64_t xive_end_source_read(void *opaque, hwaddr addr, uns=
igned size)
>>>> +{
>>>> +    XiveENDSource *xsrc =3D XIVE_END_SOURCE(opaque);
>>>> +    XiveRouter *xrtr =3D xsrc->xrtr;
>>>> +    uint32_t offset =3D addr & 0xFFF;
>>>> +    uint8_t end_blk;
>>>> +    uint32_t end_idx;
>>>> +    XiveEND end;
>>>> +    uint32_t end_esmask;
>>>> +    uint8_t pq;
>>>> +    uint64_t ret =3D -1;
>>>> +
>>>> +    end_blk =3D xrtr->chip_id;
>>>
>>> .. instead I think it makes more sense to just configure the end_blk
>>> directly on the end_source, rather than reaching into another object
>>> to=20
>>
>> Ah. That's what I was asking in an email. I missed the answer maybe.
>> Let's drop it and sPAPRXive block will be 0.
>=20
> Actually, I think I might not have answered earlier, because it was
> far enough into the thread that I'd forgotten the original context too
> much to answer easily.
>
=20
> Anyway, proposed course of action sounds fine.

Let's be clear.=20

I will add a "block" property to the XiveENDSource model, which will be s=
et=20
to a fixed value (0) on sPAPRXive and to the chip_id on PowerNV. ok ?=20

>=20
> [snip]
>>>> +static void xive_source_end_reset(void *dev)
>>>> +{
>>>> +    /* TODO: Loop on all ENDs and mask off the ESn and ESe */
>>>
>>> IIUC you're talking about actually writing the (potentially in memory=
)
>>> END structures.  I don't think that makes sense for the END source
>>> hardware model.  I'm guessing you want this for PAPR, where the ENDs
>>> are in virtual hardware=20
>>
>> That's done already.
>>
>>> rather than guest memory, but in that case I
>>> think the reset handling should be in the PAPR specific Xive object,
>>> not the end_source itself.
>>
>> I will remove the TODO, it's obsolete.
>=20
> Ok, and the whole function with it, yes?  Or is there something else
> that will really belong here?

Nothing I would say.=20

The XiveENDSource are backed by the END structures, which are software=20
entities. So it's up to the PowerNV firmware, or the sPAPR IC model to=20
do the cleanup.

C.  =20
