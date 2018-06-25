Received: from eggs.gnu.org ([2001:4830:134:3::10]:36797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fXLiS-0005tt-25
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 03:15:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fXLiN-0006qL-3c
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 03:15:12 -0400
Received: from 18.mo3.mail-out.ovh.net ([87.98.172.162]:33138)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fXLiM-0006pT-PV
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 03:15:07 -0400
Received: from player738.ha.ovh.net (unknown [10.109.122.87])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id DAB031BF0F8
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 09:15:04 +0200 (CEST)
References: <20180615152536.30093-1-clg@kaod.org>
	<20180615152536.30093-4-clg@kaod.org>
	<20180618103844.GX25461@umbus.fritz.box>
	<9d1ce421-9caa-08eb-2417-15307dd271ed@kaod.org>
	<20180618121328.GY25461@umbus.fritz.box>
	<048d2369-389f-1118-03b0-b81e6bd565a0@kaod.org>
	<20180620005622.GG3546@umbus.fritz.box>
	<36801260-2573-ce87-7f10-a6c76072ad23@kaod.org>
	<20180625063651.GE22971@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <0466066e-15e7-8f23-9ac4-76d4587de370@kaod.org>
Date: Mon, 25 Jun 2018 09:14:57 +0200
MIME-Version: 1.0
In-Reply-To: <20180625063651.GE22971@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/4] ppc/pnv: introduce Pnv8Chip and
 Pnv9Chip models
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

On 06/25/2018 08:36 AM, David Gibson wrote:
> On Wed, Jun 20, 2018 at 07:29:37AM +0200, C=E9dric Le Goater wrote:
>> On 06/20/2018 02:56 AM, David Gibson wrote:
>>> On Tue, Jun 19, 2018 at 07:24:44AM +0200, C=E9dric Le Goater wrote:
>>>>
>>>>>>>  typedef struct PnvChipClass {
>>>>>>>      /*< private >*/
>>>>>>> @@ -75,6 +95,7 @@ typedef struct PnvChipClass {
>>>>>>> =20
>>>>>>>      hwaddr       xscom_base;
>>>>>>> =20
>>>>>>> +    void (*realize)(PnvChip *chip, Error **errp);
>>>>>>
>>>>>> This looks the wrong way round from how things are usually done.
>>>>>> Rather than having the base class realize() call the subclass spec=
ific
>>>>>> realize hook, it's more usual for the subclass to set the
>>>>>> dc->realize() and have it call a k->parent_realize() to call up th=
e
>>>>>> chain.  grep for device_class_set_parent_realize() for some more
>>>>>> examples.
>>>>>
>>>>> Ah. That is more to my liking. There are a couple of models followi=
ng
>>>>> the wrong object pattern, xics, vio. I will check them.
>>>>
>>>> So XICS is causing some head-aches because the ics-kvm model inherit=
s
>>>> from ics-simple which inherits from ics-base. so we have a grand-par=
ent
>>>> class to handle.
>>>
>>> Ok.  I mean, we should probably switch ics around to use the
>>> parent_realize model, rather than the backwards one it does now.  But
>>> it's not immediately obvious to me why having a grandparent class
>>> breaks things.
>>
>> If you follow the common realize pattern, you end up with a recursive=20
>> loop with one of the realize routine. I didn't dig much the issue.
>=20
> Hmm.
>=20
>>>> if we could affiliate ics-kvm directly to ics-base it would make the=
=20
>>>> family affair easier. we need to check migration though.
>>>
>>> But that said, I've been thinking for a while that it might make sens=
e
>>> to fold ics-kvm into ics-base.  It seems very risky to have two
>>> different object classes that are supposed to have guest-identical
>>> behaviour.  Certainly adding any migratable state to one not the othe=
r
>>> would be horribly wrong.
>>
>> yes. clearly. something like bellow would be better:
>>
>>                    +---------------+
>>                    |     ICS       |
>>          +---------+  common/base  +--------+
>>          |         +---------------+        |
>>          |                                  |
>>          | spapr                    spapr   |
>>          |  pnv                             |
>>   +------v--------+                +--------v--------+
>>   |     ICS       |                |       ICS       |
>>   |  simple/QEMU  |                |       KVM       |
>>   +---------------+                +-----------------+
>>
>> with only some reset and realize handling in the subclasses. The only
>> extra field we could add under the KVM class is the KVM XICS device fd=
. =20
>=20
> I think that would be an improvement over what we have, yes.  However,
> it's not what I actually had in mind.  In fact I was planning on
> getting rid of the KVM specific subclass entirely and merging it into
> the base/simple classes with explicit if (kvm) logic.

That is one way to do it yes, even if the common pattern used in other=20
systems is more like the above. I don't have strong preferences.
=20
We should see what is driving our needs. The most complex so far is to=20
be able on P9 to switch from XICS to XIVE under KVM.=20

> The reason is that having different object classes for devices based
> on accelerator is unusual and kind of dangerous.=20

I agree.

> We get away with it
> because we don't have any migration information that gets tied to the
> object class name - but that's a pretty non-obvious restriction that
> would be easy to break in future.

Here is a summary of the KVM needs which applies to both XICS and XIVE,
when not activated both at the same time.=20

The source and presenter objects need extra handlers to save/restore and=20
synchronize KVM/QEMU states :

  - pre_save()
  - post_load()
  - synchronize_state()

The source object needs :

  - to create the KVM IRQ device (and surrounding support, VMAs for XIVE)=
,=20
  - to set up a different qemu_irq handler using the KVM device=20

The presenter needs =20

  - to attach the KVM vCPU to the KVM IRQ device=20
  - a cpu hotplug/unplug tracking mechanism

C.
