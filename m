Received: from eggs.gnu.org ([2001:4830:134:3::10]:39469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <damien.hedde@greensocs.com>) id 1flBS1-0000Id-AF
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 07:07:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <damien.hedde@greensocs.com>) id 1flBS0-0001zl-4X
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 07:07:25 -0400
References: <cover.1532701430.git.damien.hedde@greensocs.com>
	<2b92ae960dfc47149945c9e47f90b4433d8eee35.1532701430.git.damien.hedde@greensocs.com>
	<155529c9-2847-0f30-9277-6b2c8bb31b78@amsat.org>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <4210d2d7-1ad5-ccc6-d2ab-1a633e1f12e4@greensocs.com>
Date: Thu, 2 Aug 2018 13:07:04 +0200
MIME-Version: 1.0
In-Reply-To: <155529c9-2847-0f30-9277-6b2c8bb31b78@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [RFC PATCH 2/6] qdev: add power/clock
 gating control on bus tree
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

Hi,

On 07/27/2018 06:39 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Damien,
>=20
> On 07/27/2018 11:37 AM, Damien Hedde wrote:
>> Add functions [qdev|qbus]_set_[power|clock]_all(_fn).
>> Theses allow to control power and clock gating along a bus hierarchy.
>>
>> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
>> ---
>>  include/hw/qdev-core.h | 20 +++++++++++++++++
>>  hw/core/qdev.c         | 51 +++++++++++++++++++++++++++++++++++++++++=
+
>>  2 files changed, 71 insertions(+)
>>
>> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
>> index 659287e185..607c367738 100644
>> --- a/include/hw/qdev-core.h
>> +++ b/include/hw/qdev-core.h
>> @@ -464,4 +464,24 @@ void device_set_power(DeviceState *dev, bool en);
>>   */
>>  void device_set_clock(DeviceState *dev, bool en);
>> =20
>> +/**
>> + * qdev/qbus_set_power_all(_fn)
>> + * Enable/Disable the power of a tree starting
>> + * at given device or bus
>> + */
>> +void qdev_set_power_all(DeviceState *dev, bool en);
>> +void qdev_set_power_all_fn(void *opaque, bool en);
>> +void qbus_set_power_all(BusState *bus, bool en);
>> +void qbus_set_power_all_fn(void *opaque, bool en);
>=20
> I think we don't need the _fn() functions, most of the current codebase
> directly use DEVICE(x) or BUS(x) to casts.

Ok, I will remove them.

>=20
>> +
>> +/**
>> + * qdev/qbus_set_clock_all(_fn)
>> + * Enable/Disable the clock of a tree starting
>> + * at given device or bus
>> + */
>> +void qdev_set_clock_all(DeviceState *dev, bool en);
>> +void qdev_set_clock_all_fn(void *opaque, bool en);
>> +void qbus_set_clock_all(BusState *bus, bool en);
>> +void qbus_set_clock_all_fn(void *opaque, bool en);
>> +
>>  #endif
>> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
>> index bb6d36eab9..24b90bd45f 100644
>> --- a/hw/core/qdev.c
>> +++ b/hw/core/qdev.c
>> @@ -1138,6 +1138,57 @@ void device_set_clock(DeviceState *dev, bool en=
)
>>      }
>>  }
>> =20
>> +static int qdev_set_power_one(DeviceState *dev, void *opaque)
>> +{
>> +    device_set_power(dev, *((bool *)opaque));
>> +    return 0;
>> +}
>> +
>> +void qdev_set_power_all(DeviceState *dev, bool en)
>> +{
>> +    qdev_walk_children(dev, NULL, NULL, qdev_set_power_one, NULL, &en=
);
>> +}
>> +
>> +void qdev_set_power_all_fn(void *opaque, bool en)
>> +{
>> +    qdev_set_power_all(DEVICE(opaque), en);
>> +}
>> +
>> +void qbus_set_power_all(BusState *bus, bool en)
>> +{
>> +    qbus_walk_children(bus, NULL, NULL, qdev_set_power_one, NULL, &en=
);
>> +}
>> +
>> +void qbus_set_power_all_fn(void *opaque, bool en)
>> +{
>> +    qbus_set_power_all(BUS(opaque), en);
>> +}
>> +
>> +static int qdev_set_clock_one(DeviceState *dev, void *opaque)
>> +{
>> +    device_set_clock(dev, *((bool *)opaque));
>> +    return 0;
>> +}
>> +
>> +void qdev_set_clock_all(DeviceState *dev, bool en)
>> +{
>> +    qdev_walk_children(dev, NULL, NULL, qdev_set_clock_one, NULL, &en=
);
>> +}
>> +
>> +void qdev_set_clock_all_fn(void *opaque, bool en)
>> +{
>> +    qdev_set_clock_all(DEVICE(opaque), en);
>> +}
>> +
>> +void qbus_set_clock_all(BusState *bus, bool en)
>> +{
>> +    qbus_walk_children(bus, NULL, NULL, qdev_set_clock_one, NULL, &en=
);
>> +}
>> +
>> +void qbus_set_clock_all_fn(void *opaque, bool en)
>> +{
>> +    qbus_set_clock_all(BUS(opaque), en);
>> +}
>> =20
>>  Object *qdev_get_machine(void)
>>  {
>>
>=20
