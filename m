Received: from eggs.gnu.org ([2001:4830:134:3::10]:34397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gRZ02-0000Ac-A1
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 03:45:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gRYzx-0002bx-BJ
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 03:45:42 -0500
Received: from 1.mo178.mail-out.ovh.net ([178.33.251.53]:38449)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gRYzx-0002YA-0m
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 03:45:37 -0500
Received: from player732.ha.ovh.net (unknown [10.109.143.72])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 2266340C6C
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 09:45:35 +0100 (CET)
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-5-clg@kaod.org>
	<20181122041119.GD10448@umbus.fritz.box>
	<5e4a0824-a014-c0c3-89f5-40aab83268f9@kaod.org>
	<20181123035036.GW10448@umbus.fritz.box>
	<31b6201b-420a-8560-19bd-8eab9dd2f3de@kaod.org>
	<20181127015402.GM2251@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <7d22cfa2-f038-e2ea-01dd-18edd05ad438@kaod.org>
Date: Tue, 27 Nov 2018 09:45:27 +0100
MIME-Version: 1.0
In-Reply-To: <20181127015402.GM2251@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 04/36] ppc/xive: introduce the
 XiveRouter model
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

On 11/27/18 2:54 AM, David Gibson wrote:
> On Fri, Nov 23, 2018 at 09:06:07AM +0100, C=E9dric Le Goater wrote:
>> On 11/23/18 4:50 AM, David Gibson wrote:
>>> On Thu, Nov 22, 2018 at 08:53:00AM +0100, C=E9dric Le Goater wrote:
>>>> On 11/22/18 5:11 AM, David Gibson wrote:
>>>>> On Fri, Nov 16, 2018 at 11:56:57AM +0100, C=E9dric Le Goater
>> wrote:
> [snip]
>>>>> So as far as I can see so far, the XiveFabric interface will
>>>>> essentially have to be implemented on the router object, so I'm not
>>>>> seeing much point to having the interface rather than just a direct
>>>>> call on the router object.  But I haven't read the whole series yet=
,
>>>>> so maybe I'm missing something.
>>>>
>>>> The PSIHB and PHB4 models are using it but there are not in the seri=
es.
>>>>
>>>> I can send the PSIHB patch in the next version if you like, it's the=
=20
>>>> patch right after PnvXive. It's attached below for the moment. Look =
at=20
>>>> pnv_psi_notify().
>>>
>>> Hrm, I see.  This seems like a really convoluted way of achieving wha=
t
>>> you need here.  We want to abstract exactly how the source delivers
>>> notifies,=20
>>
>> on sPAPR, I agree that the forwarding of event notification could be a=
=20
>> simple XiveRouter call but the XiveRouter covers both machines :/
>>
>> On PowerNV, HW uses MMIOs to forward events and only the device knows=20
>> about the IRQ number offset in the global IRQ number space and the=20
>> notification port to use for the MMIO store. A PowerNV XIVE source=20
>> would forward the event notification to a piece of logic which sends=20
>> a PowerBUS event notification message. How it reaches the XIVE IC is
>> beyong QEMU as it would means modeling the PowerBUS.=20
>>
>>> but doing it with an interface on some object that's not necessarily
>>> either the source or the router seems odd. =20
>> There is no direct link between the device owing the source and the=20
>> XIVE controller, they could be on the same Power chip but the routing=20
>> could be done by some other chips. This scenario is covered btw.
>>
>> See it as a connector object.
>>
>>> At the very least the names need to change (of both interface and > p=
roperty for the target object).
>>
>> I am fine with renaming it. With the above explanations, if they are=20
>> clear enough, how do see them ?
>=20
> TBH, I didn't find the info above particularly illuminating.

This is really a PowerNV need. So, I can reshuffle the code and make=20
a direct link between the XiveSource and the XiveRouter models for sPAPR.
It's a small change. and reintroduce XiveFabric (or whatever name we choo=
se)=20
later before the PowerNV Xive and PSIHB model.=20

>  However,
> I think perusing the code has finally gotten my head around the model
> (sorry it's taken so long).  I think two things were confusing me.
>=20
> 1) The name had be thinking in terms of the XicsFabric, but the
> function here is totally different.

Yes. I agree. It's not the same thing at all.

> 2) I was thinking of the XiveSource as handling all source-side irq
> related logic, but I guess it's real function is a bit more limited.
> As I now understand it, it's only really handling the ESB and
> immediately surrounding logic - the "owning" device (e.g. PHB or PSI)
> is responsible for the connection "up the stack" as it were.

yes.

> So, I'm ok with the model.  Just to verify that my understanding is
> correct, can you confirm my reasoning below:
>=20
>   * For PowerNV, we'd generally expect the notify function to be
>     implemented by the "owning" device.  For the XIVE internal source,
>     that would be the XiveRouter itself, immediately triggering the
>     right EAS.  For the PHB and PSI irq sources, that will code in the
>     PHB/PSI which performs the MMIO to poke a router.

exactly.
=20
>   * For PAPR, for simplicity, we'd expect to wire all sources direct
>     to a single system-wide router object.

yes.=20

>=20
> I definitely think it needs a name change though.  "XiveNotify"
> perhaps? =20

Yes. XiveNotifier may be ? to use a noun and not a verb.

> And the property to configure it on the XiveSource, maybe "notify"=20
> or "notify_via".

What the XIVE engines are doing is forwarding a trigger event to the=20
next engine that can possibly do the routing to the final target.=20
 =20
In the specs, the verbs 'trigger', 'forward', 'notify', 'route' are=20
commonly used. I think 'notify' is the most frequent.

ok for 'notify'.

Thanks,

C.
