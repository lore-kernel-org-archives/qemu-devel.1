Received: from eggs.gnu.org ([2001:4830:134:3::10]:35206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fVVgg-00085y-Hu
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 01:29:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fVVgd-0005QP-5o
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 01:29:46 -0400
Received: from 7.mo3.mail-out.ovh.net ([46.105.57.200]:52963)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fVVgc-0005PZ-VX
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 01:29:43 -0400
Received: from player793.ha.ovh.net (unknown [10.109.108.117])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 441021BC5D1
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 07:29:41 +0200 (CEST)
References: <20180615152536.30093-1-clg@kaod.org>
	<20180615152536.30093-4-clg@kaod.org>
	<20180618103844.GX25461@umbus.fritz.box>
	<9d1ce421-9caa-08eb-2417-15307dd271ed@kaod.org>
	<20180618121328.GY25461@umbus.fritz.box>
	<048d2369-389f-1118-03b0-b81e6bd565a0@kaod.org>
	<20180620005622.GG3546@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <36801260-2573-ce87-7f10-a6c76072ad23@kaod.org>
Date: Wed, 20 Jun 2018 07:29:37 +0200
MIME-Version: 1.0
In-Reply-To: <20180620005622.GG3546@umbus.fritz.box>
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

On 06/20/2018 02:56 AM, David Gibson wrote:
> On Tue, Jun 19, 2018 at 07:24:44AM +0200, C=E9dric Le Goater wrote:
>>
>>>>>  typedef struct PnvChipClass {
>>>>>      /*< private >*/
>>>>> @@ -75,6 +95,7 @@ typedef struct PnvChipClass {
>>>>> =20
>>>>>      hwaddr       xscom_base;
>>>>> =20
>>>>> +    void (*realize)(PnvChip *chip, Error **errp);
>>>>
>>>> This looks the wrong way round from how things are usually done.
>>>> Rather than having the base class realize() call the subclass specif=
ic
>>>> realize hook, it's more usual for the subclass to set the
>>>> dc->realize() and have it call a k->parent_realize() to call up the
>>>> chain.  grep for device_class_set_parent_realize() for some more
>>>> examples.
>>>
>>> Ah. That is more to my liking. There are a couple of models following
>>> the wrong object pattern, xics, vio. I will check them.
>>
>> So XICS is causing some head-aches because the ics-kvm model inherits
>> from ics-simple which inherits from ics-base. so we have a grand-paren=
t
>> class to handle.
>=20
> Ok.  I mean, we should probably switch ics around to use the
> parent_realize model, rather than the backwards one it does now.  But
> it's not immediately obvious to me why having a grandparent class
> breaks things.

If you follow the common realize pattern, you end up with a recursive=20
loop with one of the realize routine. I didn't dig much the issue.

>> if we could affiliate ics-kvm directly to ics-base it would make the=20
>> family affair easier. we need to check migration though.
>=20
> But that said, I've been thinking for a while that it might make sense
> to fold ics-kvm into ics-base.  It seems very risky to have two
> different object classes that are supposed to have guest-identical
> behaviour.  Certainly adding any migratable state to one not the other
> would be horribly wrong.

yes. clearly. something like bellow would be better:

                   +---------------+
                   |     ICS       |
         +---------+  common/base  +--------+
         |         +---------------+        |
         |                                  |
         | spapr                    spapr   |
         |  pnv                             |
  +------v--------+                +--------v--------+
  |     ICS       |                |       ICS       |
  |  simple/QEMU  |                |       KVM       |
  +---------------+                +-----------------+

with only some reset and realize handling in the subclasses. The only
extra field we could add under the KVM class is the KVM XICS device fd. =20


Thanks,

C.
