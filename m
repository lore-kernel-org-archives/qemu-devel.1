Received: from eggs.gnu.org ([2001:4830:134:3::10]:47130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ciHV5-0008Cx-Go
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 04:21:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ciHV2-0003pK-9T
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 04:21:47 -0500
Received: from 5.mo6.mail-out.ovh.net ([46.105.54.31]:60332)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ciHV2-0003oY-36
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 04:21:44 -0500
Received: from player761.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 59F31ADF52
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 10:21:42 +0100 (CET)
References: <1487252865-12064-1-git-send-email-clg@kaod.org>
	<1487252865-12064-17-git-send-email-clg@kaod.org>
	<20170223024238.GB12577@umbus.fritz.box>
	<6eb9d5d8-ea57-dc2b-afd7-7796b7e3295b@kaod.org>
	<20170227010024.GL17615@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <6c547a12-5c49-7fbe-14f6-5337889786a3@kaod.org>
Date: Mon, 27 Feb 2017 10:21:32 +0100
MIME-Version: 1.0
In-Reply-To: <20170227010024.GL17615@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 16/22] ppc/xics: register the
 reset handler of ICP objects
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

[ adding Peter for some insights ]=20

On 02/27/2017 02:00 AM, David Gibson wrote:
> On Fri, Feb 24, 2017 at 12:27:35PM +0100, C=E9dric Le Goater wrote:
>> On 02/23/2017 03:42 AM, David Gibson wrote:
>>> On Thu, Feb 16, 2017 at 02:47:39PM +0100, C=E9dric Le Goater wrote:
>>>> The reset of the ICP objects is currently handled by XICS but this c=
an
>>>> be done for each individual ICP.
>>>>
>>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>>>
>>> Hrm.  I think whether device_reset() gets called automatically depend=
s
>>> on how the device is wired into the composition tree, and I'm not sur=
e
>>> the icps are in the right place for it to work.
>>
>> reset gets called only if it under sysbus or if you have registered=20
>> a reset_handler. previously, XICS was a sysbus object so=20
>> xics_common_reset() was getting called automatically.
>=20
> Right.  Hmm.  So I think artificially placing the ics under the sysbus
> is not the right way to get the reset called - I think explicitly
> registering a reset handler is better.
>=20
> The only thing that concerns me about that is that the MMIO ICS
> variants we'll want for powernv really _do_ have a bus presence,
> either on sysbus or some descendent, so that will get its reset called
> automatically.  I'm not sure what the best way to ensure the reset
> gets called exactly once in all cases.

Well, I am not sure either. I have reproduced this pattern as it is=20
frequently used under ARM which has quite a few QOM'ified machines.

Thanks,

C.=20

>>> This doesn't replace the code in xics_common_reset() so if it does
>>> work it means we must have previously been resetting the ICPs twice.
>>> Is that right?
>>
>> no. but there has been some confusion with the recent changes
>> on XICS.
>>
>> What replace the code in xics_common_reset() is :
>>
>> 	qdev_set_parent_bus(DEVICE(icp), sysbus_get_default());
>>
>> That's how the reset handlers get called from QOM objects.
>=20
> Right, I saw that later on.
>=20
>>
>> C.
>>
>>>> ---
>>>>  hw/intc/xics.c | 18 ------------------
>>>>  hw/ppc/spapr.c |  1 +
>>>>  2 files changed, 1 insertion(+), 18 deletions(-)
>>>>
>>>> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
>>>> index dd41340d41a5..3ad7e8cf8ec4 100644
>>>> --- a/hw/intc/xics.c
>>>> +++ b/hw/intc/xics.c
>>>> @@ -137,29 +137,11 @@ static void ics_simple_pic_print_info(Interrup=
tStatsProvider *obj,
>>>>  /*
>>>>   * XICS Common class - parent for emulated XICS and KVM-XICS
>>>>   */
>>>> -static void xics_common_reset(DeviceState *d)
>>>> -{
>>>> -    XICSState *xics =3D XICS_COMMON(d);
>>>> -    int i;
>>>> -
>>>> -    for (i =3D 0; i < xics->nr_servers; i++) {
>>>> -        device_reset(DEVICE(&xics->ss[i]));
>>>> -    }
>>>> -}
>>>> -
>>>> -static void xics_common_class_init(ObjectClass *oc, void *data)
>>>> -{
>>>> -    DeviceClass *dc =3D DEVICE_CLASS(oc);
>>>> -
>>>> -    dc->reset =3D xics_common_reset;
>>>> -}
>>>> -
>>>>  static const TypeInfo xics_common_info =3D {
>>>>      .name          =3D TYPE_XICS_COMMON,
>>>>      .parent        =3D TYPE_DEVICE,
>>>>      .instance_size =3D sizeof(XICSState),
>>>>      .class_size    =3D sizeof(XICSStateClass),
>>>> -    .class_init    =3D xics_common_class_init,
>>>>  };
>>>> =20
>>>>  /*
>>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>>>> index 9c1772f93155..445d9a6ddad4 100644
>>>> --- a/hw/ppc/spapr.c
>>>> +++ b/hw/ppc/spapr.c
>>>> @@ -130,6 +130,7 @@ static XICSState *try_create_xics(sPAPRMachineSt=
ate *spapr,
>>>>          ICPState *icp =3D &xics->ss[i];
>>>> =20
>>>>          object_initialize(icp, sizeof(*icp), type_icp);
>>>> +        qdev_set_parent_bus(DEVICE(icp), sysbus_get_default());
>>>>          object_property_add_child(OBJECT(xics), "icp[*]", OBJECT(ic=
p), NULL);
>>>>          object_property_add_const_link(OBJECT(icp), "xics", OBJECT(=
xics), NULL);
>>>>          object_property_set_bool(OBJECT(icp), true, "realized", &er=
r);
>>>
>>
>=20
