Received: from eggs.gnu.org ([2001:4830:134:3::10]:44610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f4SeZ-0003ed-7v
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 10:47:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f4SeU-0004bG-KZ
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 10:47:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38916 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1f4SeU-0004bB-F2
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 10:47:42 -0400
References: <1522920750-11020-1-git-send-email-thuth@redhat.com>
	<6ce4143a-b96f-1367-a773-8da9924f1953@ilande.co.uk>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <911f1f80-fb79-8749-ddc4-c8c42f7aca1c@redhat.com>
Date: Fri, 6 Apr 2018 16:47:32 +0200
MIME-Version: 1.0
In-Reply-To: <6ce4143a-b96f-1367-a773-8da9924f1953@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/sparc64/sun4u: Fix introspection by
 converting prom instance_init to realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>

On 06.04.2018 16:41, Mark Cave-Ayland wrote:
> On 05/04/18 10:32, Thomas Huth wrote:
>=20
>> The instance_init function of devices should always succeed to be able
>> to introspect the device. However, the instance_init function of the
>> "openprom" device can currently fail, for example like this:
>>
>> $ echo "{'execute':'qmp_capabilities'}"\
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "{'execute':'device-list-pr=
operties',"\
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 " 'arguments':{'typename':'=
openprom'}}" \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | sparc64-softmmu/qemu-syst=
em-sparc64 -M sun4v,accel=3Dqtest
>> -qmp stdio
>> {"QMP": {"version": {"qemu": {"micro": 91, "minor": 11, "major": 2},
>> =C2=A0 "package": "build-all"}, "capabilities": []}}
>> {"return": {}}
>> RAMBlock "sun4u.prom" already registered, abort!
>> Aborted (core dumped)
>>
>> This should not happen. Fix this problem by moving the affected code f=
rom
>> instance_init into a realize function instead.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>> =C2=A0 hw/sparc64/sun4u.c | 18 ++++++++++++------
>> =C2=A0 1 file changed, 12 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
>> index 2044a52..d62f5a2 100644
>> --- a/hw/sparc64/sun4u.c
>> +++ b/hw/sparc64/sun4u.c
>> @@ -425,13 +425,19 @@ static void prom_init(hwaddr addr, const char
>> *bios_name)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 }
>> =C2=A0 -static void prom_init1(Object *obj)
>> +static void prom_realize(DeviceState *ds, Error **errp)
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0 PROMState *s =3D OPENPROM(obj);
>> -=C2=A0=C2=A0=C2=A0 SysBusDevice *dev =3D SYS_BUS_DEVICE(obj);
>> +=C2=A0=C2=A0=C2=A0 PROMState *s =3D OPENPROM(ds);
>> +=C2=A0=C2=A0=C2=A0 SysBusDevice *dev =3D SYS_BUS_DEVICE(ds);
>> +=C2=A0=C2=A0=C2=A0 Error *local_err =3D NULL;
>> +
>> +=C2=A0=C2=A0=C2=A0 memory_region_init_ram_nomigrate(&s->prom, OBJECT(=
ds), "sun4u.prom",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
PROM_SIZE_MAX, &local_err);
>> +=C2=A0=C2=A0=C2=A0 if (local_err) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_propagate(errp, loca=
l_err);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 memory_region_init_ram_nomigrate(&s->prom, =
obj, "sun4u.prom",
>> PROM_SIZE_MAX,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 &error_fatal);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vmstate_register_ram_global(&s->prom);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memory_region_set_readonly(&s->prom, tr=
ue);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sysbus_init_mmio(dev, &s->prom);
>> @@ -446,6 +452,7 @@ static void prom_class_init(ObjectClass *klass,
>> void *data)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DeviceClass *dc =3D DEVICE_CLASS(klass)=
;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dc->props =3D prom_properties;
>> +=C2=A0=C2=A0=C2=A0 dc->realize =3D prom_realize;
>> =C2=A0 }
>> =C2=A0 =C2=A0 static const TypeInfo prom_info =3D {
>> @@ -453,7 +460,6 @@ static const TypeInfo prom_info =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .parent=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 =3D TYPE_SYS_BUS_DEVICE,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .instance_size =3D sizeof(PROMState),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .class_init=C2=A0=C2=A0=C2=A0 =3D prom_=
class_init,
>> -=C2=A0=C2=A0=C2=A0 .instance_init =3D prom_init1,
>> =C2=A0 };
>=20
> Looks good to me:
>=20
> Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>=20
> I thought this would have been caught by the device introspect test, or
> is this something you've found whilst trying to add sun4v to the list o=
f
> machines to include in the test?

I've found it with this patch here:

https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg05033.html

The current device-introspect-test only checks with the "none" machine,
so it did not detect this problem yet since this only happens when you
use the sun4v machine.

 Thomas
