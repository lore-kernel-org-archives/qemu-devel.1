Received: from eggs.gnu.org ([2001:4830:134:3::10]:58564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <damien.hedde@greensocs.com>) id 1fkS08-0004SU-Np
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 06:35:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <damien.hedde@greensocs.com>) id 1fkS07-00025L-6W
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 06:35:36 -0400
References: <cover.1532701430.git.damien.hedde@greensocs.com>
	<0379e54aecc5534d68e1ac3bdf61fda79916396e.1532701430.git.damien.hedde@greensocs.com>
	<994d20ce-5332-b0db-aac0-bc906ef12fdb@amsat.org>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <7c193b33-8188-2cda-cbf2-fb545254458b@greensocs.com>
Date: Tue, 31 Jul 2018 12:35:19 +0200
MIME-Version: 1.0
In-Reply-To: <994d20ce-5332-b0db-aac0-bc906ef12fdb@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 1/6] qdev: add a power and clock gating
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org
Cc: edgar.iglesias@xilinx.com, peter.maydell@linaro.org, alistair@alistair23.me, mark.burton@greensocs.com, saipava@xilinx.com, qemu-arm@nongnu.org, pbonzini@redhat.com, luc.michel@greensocs.com

Hi Philippe,

On 07/27/2018 06:33 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Damien,
>=20
> On 07/27/2018 11:37 AM, Damien Hedde wrote:
>> Add two boolean new fields _powered_ and _clocked_ to hold the gating
>> state. Also add methods to act on each gating change.
>> The power/clock gating is controlled by 2 functions *device_set_power*=
 and
>> *device_set_clock*.
>>
>> Add a default behavior to do a device_reset at power-up.
>>
>> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
>> ---
>>  include/hw/qdev-core.h | 30 ++++++++++++++++++++++++
>>  hw/core/qdev.c         | 52 +++++++++++++++++++++++++++++++++++++++++=
+
>>  2 files changed, 82 insertions(+)
>>
>> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
>> index f1fd0f8736..659287e185 100644
>> --- a/include/hw/qdev-core.h
>> +++ b/include/hw/qdev-core.h
>> @@ -34,6 +34,7 @@ typedef void (*DeviceUnrealize)(DeviceState *dev, Er=
ror **errp);
>>  typedef void (*DeviceReset)(DeviceState *dev);
>>  typedef void (*BusRealize)(BusState *bus, Error **errp);
>>  typedef void (*BusUnrealize)(BusState *bus, Error **errp);
>> +typedef void (*DeviceGatingUpdate)(DeviceState *dev);
>> =20
>>  struct VMStateDescription;
>> =20
>> @@ -109,6 +110,8 @@ typedef struct DeviceClass {
>>      DeviceReset reset;
>>      DeviceRealize realize;
>>      DeviceUnrealize unrealize;
>> +    DeviceGatingUpdate power_update;
>> +    DeviceGatingUpdate clock_update;
>=20
> Update(boolean) sounds weird to me.
>=20
> Why not name this set_power() or power_set(), or even power_switch()?

You're right. power_switch (or switch_power) seems also better to me.

>=20
>> =20
>>      /* device state */
>>      const struct VMStateDescription *vmsd;
>> @@ -151,6 +154,9 @@ struct DeviceState {
>>      int num_child_bus;
>>      int instance_id_alias;
>>      int alias_required_for_version;
>> +
>> +    bool powered;
>> +    bool clocked;
>>  };
>> =20
>>  struct DeviceListener {
>> @@ -404,6 +410,12 @@ void device_class_set_parent_realize(DeviceClass =
*dc,
>>  void device_class_set_parent_unrealize(DeviceClass *dc,
>>                                         DeviceUnrealize dev_unrealize,
>>                                         DeviceUnrealize *parent_unreal=
ize);
>> +void device_class_set_parent_power_update(DeviceClass *dc,
>> +                                          DeviceGatingUpdate dev_powe=
r_update,
>> +                                          DeviceGatingUpdate *parent_=
power_update);
>> +void device_class_set_parent_clock_update(DeviceClass *dc,
>> +                                          DeviceGatingUpdate dev_cloc=
k_update,
>> +                                          DeviceGatingUpdate *parent_=
clock_update);
>> =20
>>  const struct VMStateDescription *qdev_get_vmsd(DeviceState *dev);
>> =20
>> @@ -434,4 +446,22 @@ static inline bool qbus_is_hotpluggable(BusState =
*bus)
>>  void device_listener_register(DeviceListener *listener);
>>  void device_listener_unregister(DeviceListener *listener);
>> =20
>> +/**
>> + * device_set_power:
>> + * Enable/Disable the power of a device
>> + *
>> + * @dev: device to update
>> + * @en: true to enable, false to disable
>> + */
>> +void device_set_power(DeviceState *dev, bool en);
>=20
> Maybe en -> enabled?

ok.

>=20
>> +
>> +/**
>> + * device_set_clock:
>> + * Enable/Disable the clock of a device
>> + *
>> + * @dev: device to update
>> + * @en: true to enable, false to disable
>> + */
>> +void device_set_clock(DeviceState *dev, bool en);
>> +
>>  #endif
>> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
>> index 529b82de18..bb6d36eab9 100644
>> --- a/hw/core/qdev.c
>> +++ b/hw/core/qdev.c
>> @@ -950,6 +950,8 @@ static void device_initfn(Object *obj)
>> =20
>>      dev->instance_id_alias =3D -1;
>>      dev->realized =3D false;
>> +    dev->powered =3D true;
>> +    dev->clocked =3D true;
>> =20
>>      object_property_add_bool(obj, "realized",
>>                               device_get_realized, device_set_realized=
, NULL);
>> @@ -1038,6 +1040,13 @@ static void device_unparent(Object *obj)
>>      }
>>  }
>> =20
>> +static void device_power_update(DeviceState *dev)
>> +{
>> +    if (dev->powered) {
>> +        device_reset(dev);
>=20
> Hmm now we call device_reset() two times on device creation?
>=20
> So now this is hard/cold reset, ...

Yes it corresponds to cold_reset.
I did not want to modify current platform init behavior: powered/clocked
are initialized to true (See device_initfn above).
So a device is already powered at startup and device_power_update will
only be called if powering-down the device. With this implementation I
think device_reset is called only once.

>=20
>> +    }
>> +}
>> +
>>  static void device_class_init(ObjectClass *class, void *data)
>>  {
>>      DeviceClass *dc =3D DEVICE_CLASS(class);
>> @@ -1052,6 +1061,8 @@ static void device_class_init(ObjectClass *class=
, void *data)
>>       */
>>      dc->hotpluggable =3D true;
>>      dc->user_creatable =3D true;
>> +
>> +    dc->power_update =3D device_power_update;
>>  }
>> =20
>>  void device_class_set_parent_reset(DeviceClass *dc,
>> @@ -1078,6 +1089,22 @@ void device_class_set_parent_unrealize(DeviceCl=
ass *dc,
>>      dc->unrealize =3D dev_unrealize;
>>  }
>> =20
>> +void device_class_set_parent_power_update(DeviceClass *dc,
>> +                                       DeviceGatingUpdate dev_power_u=
pdate,
>> +                                       DeviceGatingUpdate *parent_pow=
er_update)
>> +{
>> +    *parent_power_update =3D dc->power_update;
>> +    dc->power_update =3D dev_power_update;
>> +}
>> +
>> +void device_class_set_parent_clock_update(DeviceClass *dc,
>> +                                       DeviceGatingUpdate dev_clock_u=
pdate,
>> +                                       DeviceGatingUpdate *parent_clo=
ck_update)
>> +{
>> +    *parent_clock_update =3D dc->clock_update;
>> +    dc->clock_update =3D dev_clock_update;
>> +}
>> +
>>  void device_reset(DeviceState *dev)
>>  {
>=20
> ... and this is soft/hot reset.
>=20
> All devices currently use this as hard reset.
>=20
> Should we rename this? At least we should add comments about it.

I think this function could stay hard/cold reset.
Right now there is no soft/hot reset (and no default/generic way to
trigger such a reset if I'm not mistaken). If a device need different
implementation between external cold/hot reset, it have to be handled
someway. But maybe it is beyond the scope of theses patches since
power-gating will only trigger cold reset ?

Anyway, I will add comments about this to make things clear.

>=20
>>      DeviceClass *klass =3D DEVICE_GET_CLASS(dev);
>> @@ -1087,6 +1114,31 @@ void device_reset(DeviceState *dev)
>>      }
>>  }
>> =20
>> +void device_set_power(DeviceState *dev, bool en)
>> +{
>> +    DeviceClass *klass =3D DEVICE_GET_CLASS(dev);
>> +
>=20
> /* TODO: trace events */

I will add theses.

>=20
>> +    if (en !=3D dev->powered) {
>> +        dev->powered =3D en;
>> +        if (klass->power_update) {
>> +            klass->power_update(dev);
>> +        }
>> +    }
>> +}
>> +
>> +void device_set_clock(DeviceState *dev, bool en)
>> +{
>> +    DeviceClass *klass =3D DEVICE_GET_CLASS(dev);
>> +
>=20
> /* TODO: trace events */>>> +    if (en !=3D dev->clocked) {
>> +        dev->clocked =3D en;
>> +        if (klass->clock_update) {
>> +            klass->clock_update(dev);
>> +        }
>> +    }
>> +}
>> +
>> +
>>  Object *qdev_get_machine(void)
>>  {
>>      static Object *dev;
>>
> This looks promising :)
>=20
> Regards,
>=20
> Phil.
>=20
