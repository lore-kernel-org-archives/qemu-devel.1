Received: from eggs.gnu.org ([2001:4830:134:3::10]:35145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gWFhK-0004i6-HA
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 02:09:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gWFhG-0007hV-Eu
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 02:09:46 -0500
Received: from 6.mo6.mail-out.ovh.net ([87.98.177.69]:41449)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gWFhG-0007gb-4x
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 02:09:42 -0500
Received: from player734.ha.ovh.net (unknown [10.109.143.216])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 73C0719E032
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 08:09:40 +0100 (CET)
References: <20181209194610.29727-1-clg@kaod.org>
	<20181209194610.29727-18-clg@kaod.org>
	<131a6a34fcda6202739362ceb9555fd65d4439a9.camel@kernel.crashing.org>
	<20181210034121.GH4261@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <84313cab-f2f3-575b-c411-642b7c1bb840@kaod.org>
Date: Mon, 10 Dec 2018 08:09:34 +0100
MIME-Version: 1.0
In-Reply-To: <20181210034121.GH4261@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 17/19] spapr: Add a pseries-4.0 machine
 type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 12/10/18 4:41 AM, David Gibson wrote:
> On Mon, Dec 10, 2018 at 09:05:06AM +1100, Benjamin Herrenschmidt wrote:
>> On Sun, 2018-12-09 at 20:46 +0100, C=E9dric Le Goater wrote:
>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>>> ---
>>
>> If you're going to do that, can we include large decrementer in there
>> too ? (patches from Suraj in my tree but they night need a bit of
>> massaging).
>=20
> We don't need to worry about that here.  The machine type's not
> considered finalized until the release, so as long as you get the
> large dec stuff in before the 4.0 release, it's fine.

Are we talking about these 5 patches ?=20

  target/ppc: Implement large decrementer support for TCG=20
  https://github.com/legoater/qemu/commit/9b3131ae25aa1ee630c48a0489d7194=
b3046031a

  target/ppc: Implement large decrementer support for KVM=20
  https://github.com/legoater/qemu/commit/eceb9fe2c77ba40230621af56dd2009=
0a282e2f1

  target/ppc: Implement migration support for large decrementer=20
  https://github.com/legoater/qemu/commit/8da02805dfa39b888df530a6f00a59e=
6b2fbe34b
=20
  target/ppc: Enable the large decrementer for TCG and KVM guests=20
  https://github.com/legoater/qemu/commit/0cff350c80e19553c35a3fc8a985953=
3d606c3e8

  target/ppc: Add cmd line option to disable the large decrementer=20
  https://github.com/legoater/qemu/commit/7136bfa944d8dc405150d0bc281c3df=
5cab98ab1

The PowerNV POWER9 will need the TCG part.=20

> Looks like Eduardo and others are probably doing a big batch machine
> type update via the machine tree.  That will probably conflict, but it
> should be a fairly easy one for me to sort out when the time comes.

I think you can possibly just drop this patch if someone adds the=20
4.0 machine before or just drop the include/hw/compat.h changes

C.

>>
>>>  include/hw/compat.h |  3 +++
>>>  hw/ppc/spapr.c      | 25 ++++++++++++++++++++++---
>>>  2 files changed, 25 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/include/hw/compat.h b/include/hw/compat.h
>>> index 6f4d5fc64704..70958328fe7a 100644
>>> --- a/include/hw/compat.h
>>> +++ b/include/hw/compat.h
>>> @@ -1,6 +1,9 @@
>>>  #ifndef HW_COMPAT_H
>>>  #define HW_COMPAT_H
>>> =20
>>> +#define HW_COMPAT_3_1 \
>>> +    /* empty */
>>> +
>>>  #define HW_COMPAT_3_0 \
>>>      /* empty */
>>> =20
>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>>> index fa41927d95dd..4012ebd794a4 100644
>>> --- a/hw/ppc/spapr.c
>>> +++ b/hw/ppc/spapr.c
>>> @@ -3971,19 +3971,38 @@ static const TypeInfo spapr_machine_info =3D =
{
>>>      }                                                               =
 \
>>>      type_init(spapr_machine_register_##suffix)
>>> =20
>>> - /*
>>> +/*
>>> + * pseries-4.0
>>> + */
>>> +static void spapr_machine_4_0_instance_options(MachineState *machine=
)
>>> +{
>>> +}
>>> +
>>> +static void spapr_machine_4_0_class_options(MachineClass *mc)
>>> +{
>>> +    /* Defaults for the latest behaviour inherited from the base cla=
ss */
>>> +}
>>> +
>>> +DEFINE_SPAPR_MACHINE(4_0, "4.0", true);
>>> +
>>> +/*
>>>   * pseries-3.1
>>>   */
>>> +#define SPAPR_COMPAT_3_1                                            =
  \
>>> +    HW_COMPAT_3_1
>>> +
>>>  static void spapr_machine_3_1_instance_options(MachineState *machine=
)
>>>  {
>>> +    spapr_machine_4_0_instance_options(machine);
>>>  }
>>> =20
>>>  static void spapr_machine_3_1_class_options(MachineClass *mc)
>>>  {
>>> -    /* Defaults for the latest behaviour inherited from the base cla=
ss */
>>> +    spapr_machine_4_0_class_options(mc);
>>> +    SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_3_1);
>>>  }
>>> =20
>>> -DEFINE_SPAPR_MACHINE(3_1, "3.1", true);
>>> +DEFINE_SPAPR_MACHINE(3_1, "3.1", false);
>>> =20
>>>  /*
>>>   * pseries-3.0
>>
>=20
