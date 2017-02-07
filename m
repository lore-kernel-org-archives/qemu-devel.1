Received: from eggs.gnu.org ([2001:4830:134:3::10]:56966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cb1zK-00087e-DT
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 04:23:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cb1zE-0003NU-Dj
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 04:23:02 -0500
Received: from greensocs.com ([193.104.36.180]:45699)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cb1zE-0003NP-1t
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 04:22:56 -0500
References: <1485424060-12217-1-git-send-email-fred.konrad@greensocs.com>
	<1485424060-12217-3-git-send-email-fred.konrad@greensocs.com>
	<6b974238-ab18-8bd5-ffe7-6f07627f59f3@kaod.org>
From: Frederic Konrad <fred.konrad@greensocs.com>
Message-ID: <5850976f-7e05-dbcf-3fdf-cf9d11038b3d@greensocs.com>
Date: Tue, 7 Feb 2017 10:22:53 +0100
MIME-Version: 1.0
In-Reply-To: <6b974238-ab18-8bd5-ffe7-6f07627f59f3@kaod.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V2 02/10] qemu-clk: allow to add a clock to
 a device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-devel@nongnu.org, edgar.iglesias@xilinx.com, peter.maydell@linaro.org, mark.burton@greensocs.com, alistair.francis@xilinx.com

On 02/06/2017 03:20 PM, C=E9dric Le Goater wrote:
> On 01/26/2017 10:47 AM, fred.konrad@greensocs.com wrote:
>> From: KONRAD Frederic <fred.konrad@greensocs.com>
>>
>> This allows to add a clock to a DeviceState.
>> Contrary to gpios, the clock pins are not contained in the DeviceState=
 but
>> with the child property so they can appears in the qom-tree.
>>
>> Signed-off-by: KONRAD Frederic <fred.konrad@greensocs.com>
>>
>> V1 -> V2:
>>   * Rename the function use 'add' instead of 'attach'
>> ---
>>  include/qemu/qemu-clock.h | 24 +++++++++++++++++++++++-
>>  qemu-clock.c              | 23 +++++++++++++++++++++++
>>  2 files changed, 46 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/qemu/qemu-clock.h b/include/qemu/qemu-clock.h
>> index e7acd68..3e692d3 100644
>> --- a/include/qemu/qemu-clock.h
>> +++ b/include/qemu/qemu-clock.h
>> @@ -33,8 +33,30 @@
>>  typedef struct qemu_clk {
>>      /*< private >*/
>>      Object parent_obj;
>> +    char *name;            /* name of this clock in the device. */
>>  } *qemu_clk;
>> =20
>> -#endif /* QEMU_CLOCK_H */
>> +/**
>> + * qemu_clk_device_add_clock:
>> + * @dev: the device on which the clock needs to be added.
>> + * @clk: the clock which needs to be added.
>> + * @name: the name of the clock can't be NULL.
>> + *
>> + * Add @clk to device @dev as a clock named @name.
>> + *
>> + */
>> +void qemu_clk_device_add_clock(DeviceState *dev, qemu_clk clk,
>> +                               const char *name);
>> =20
>> +/**
>> + * qemu_clk_device_get_clock:
>> + * @dev: the device which contains the clock.
>> + * @name: the name of the clock.
>> + *
>> + * Get the clock named @name contained in the device @dev, or NULL if=
 not found.
>> + *
>> + * Returns the clock named @name contained in @dev.
>> + */
>> +qemu_clk qemu_clk_device_get_clock(DeviceState *dev, const char *name=
);
>> =20
>> +#endif /* QEMU_CLOCK_H */
>> diff --git a/qemu-clock.c b/qemu-clock.c
>> index ceea98d..803deb3 100644
>> --- a/qemu-clock.c
>> +++ b/qemu-clock.c
>> @@ -25,6 +25,7 @@
>>  #include "qemu/qemu-clock.h"
>>  #include "hw/hw.h"
>>  #include "qemu/log.h"
>> +#include "qapi/error.h"
>> =20
>>  #ifndef DEBUG_QEMU_CLOCK
>>  #define DEBUG_QEMU_CLOCK 0
>> @@ -36,6 +37,28 @@
>>      }                                                                =
        \
>>  } while (0);
>> =20
>> +void qemu_clk_device_add_clock(DeviceState *dev, qemu_clk clk,
>> +                               const char *name)
>> +{
>> +    assert(name);
>> +    assert(!clk->name);
>> +    object_property_add_child(OBJECT(dev), name, OBJECT(clk), &error_=
abort);
>> +    clk->name =3D g_strdup(name);
>> +}
>> +
>> +qemu_clk qemu_clk_device_get_clock(DeviceState *dev, const char *name=
)
>> +{
>> +    gchar *path =3D NULL;
>> +    Object *clk;
>> +    bool ambiguous;
>> +
>> +    path =3D g_strdup_printf("%s/%s", object_get_canonical_path(OBJEC=
T(dev)),
>> +                           name);
>> +    clk =3D object_resolve_path(path, &ambiguous);
>> +    g_free(path);
>> +    return QEMU_CLOCK(clk);
>> +}
>=20
>=20
> I see how these routines are used in patch 10/10. But if we were
> open coding device CRF_APB, I don't think we would need them at
> all and it would make the code a little simple IMHO.

What do you mean by open coding?

Fred
>=20
> Thanks,
>=20
> C. =20
>=20
>>  static const TypeInfo qemu_clk_info =3D {
>>      .name          =3D TYPE_CLOCK,
>>      .parent        =3D TYPE_OBJECT,
>>
>=20
>=20
