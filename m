Received: from eggs.gnu.org ([2001:4830:134:3::10]:48077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1chE2M-0006b4-6n
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 06:27:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1chE2I-0000Lf-7D
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 06:27:46 -0500
Received: from 13.mo5.mail-out.ovh.net ([87.98.182.191]:46540)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1chE2I-0000Iy-13
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 06:27:42 -0500
Received: from player734.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 1B31DDC9D5
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 12:27:40 +0100 (CET)
References: <1487252865-12064-1-git-send-email-clg@kaod.org>
	<1487252865-12064-17-git-send-email-clg@kaod.org>
	<20170223024238.GB12577@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <6eb9d5d8-ea57-dc2b-afd7-7796b7e3295b@kaod.org>
Date: Fri, 24 Feb 2017 12:27:35 +0100
MIME-Version: 1.0
In-Reply-To: <20170223024238.GB12577@umbus.fritz.box>
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 02/23/2017 03:42 AM, David Gibson wrote:
> On Thu, Feb 16, 2017 at 02:47:39PM +0100, C=E9dric Le Goater wrote:
>> The reset of the ICP objects is currently handled by XICS but this can
>> be done for each individual ICP.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>=20
> Hrm.  I think whether device_reset() gets called automatically depends
> on how the device is wired into the composition tree, and I'm not sure
> the icps are in the right place for it to work.

reset gets called only if it under sysbus or if you have registered=20
a reset_handler. previously, XICS was a sysbus object so=20
xics_common_reset() was getting called automatically.

> This doesn't replace the code in xics_common_reset() so if it does
> work it means we must have previously been resetting the ICPs twice.
> Is that right?

no. but there has been some confusion with the recent changes
on XICS.

What replace the code in xics_common_reset() is :

	qdev_set_parent_bus(DEVICE(icp), sysbus_get_default());

That's how the reset handlers get called from QOM objects.=20

C.

>> ---
>>  hw/intc/xics.c | 18 ------------------
>>  hw/ppc/spapr.c |  1 +
>>  2 files changed, 1 insertion(+), 18 deletions(-)
>>
>> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
>> index dd41340d41a5..3ad7e8cf8ec4 100644
>> --- a/hw/intc/xics.c
>> +++ b/hw/intc/xics.c
>> @@ -137,29 +137,11 @@ static void ics_simple_pic_print_info(InterruptS=
tatsProvider *obj,
>>  /*
>>   * XICS Common class - parent for emulated XICS and KVM-XICS
>>   */
>> -static void xics_common_reset(DeviceState *d)
>> -{
>> -    XICSState *xics =3D XICS_COMMON(d);
>> -    int i;
>> -
>> -    for (i =3D 0; i < xics->nr_servers; i++) {
>> -        device_reset(DEVICE(&xics->ss[i]));
>> -    }
>> -}
>> -
>> -static void xics_common_class_init(ObjectClass *oc, void *data)
>> -{
>> -    DeviceClass *dc =3D DEVICE_CLASS(oc);
>> -
>> -    dc->reset =3D xics_common_reset;
>> -}
>> -
>>  static const TypeInfo xics_common_info =3D {
>>      .name          =3D TYPE_XICS_COMMON,
>>      .parent        =3D TYPE_DEVICE,
>>      .instance_size =3D sizeof(XICSState),
>>      .class_size    =3D sizeof(XICSStateClass),
>> -    .class_init    =3D xics_common_class_init,
>>  };
>> =20
>>  /*
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 9c1772f93155..445d9a6ddad4 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -130,6 +130,7 @@ static XICSState *try_create_xics(sPAPRMachineStat=
e *spapr,
>>          ICPState *icp =3D &xics->ss[i];
>> =20
>>          object_initialize(icp, sizeof(*icp), type_icp);
>> +        qdev_set_parent_bus(DEVICE(icp), sysbus_get_default());
>>          object_property_add_child(OBJECT(xics), "icp[*]", OBJECT(icp)=
, NULL);
>>          object_property_add_const_link(OBJECT(icp), "xics", OBJECT(xi=
cs), NULL);
>>          object_property_set_bool(OBJECT(icp), true, "realized", &err)=
;
>=20
