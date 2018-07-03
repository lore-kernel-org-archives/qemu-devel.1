Received: from eggs.gnu.org ([2001:4830:134:3::10]:58265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1faN68-00088R-NR
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:20:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1faN64-0001ss-JH
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:20:08 -0400
Received: from 10.mo1.mail-out.ovh.net ([178.32.96.102]:55954)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1faN64-0001rR-Am
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:20:04 -0400
Received: from player755.ha.ovh.net (unknown [10.109.122.13])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 78A4B10D1B5
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 17:20:02 +0200 (CEST)
References: <20180619140729.21949-1-clg@kaod.org>
	<20180619140729.21949-2-clg@kaod.org>
	<eb1ad8ca-89f7-b059-3a3c-412375871113@kaod.org>
	<bc3ec7a5-a6c5-2a0d-7ac1-6583a182807b@kaod.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <dc0f292f-6f1f-791b-4073-88f347495d2c@kaod.org>
Date: Tue, 3 Jul 2018 17:19:56 +0200
MIME-Version: 1.0
In-Reply-To: <bc3ec7a5-a6c5-2a0d-7ac1-6583a182807b@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 1/3] spapr: introduce a fixed IRQ number
 space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>

On 07/02/2018 01:11 PM, C=C3=A9dric Le Goater wrote:
> On 07/02/2018 12:03 PM, C=C3=A9dric Le Goater wrote:
>>> --- a/hw/ppc/spapr_vio.c
>>> +++ b/hw/ppc/spapr_vio.c
>>> @@ -436,6 +436,9 @@ static void spapr_vio_busdev_reset(DeviceState *q=
dev)
>>>      }
>>>  }
>>> =20
>>> +/* TODO : poor VIO device indexing ... */
>>> +static uint32_t vio_index;
>>
>> I think we could also use (dev->reg & 0xff) as an index for=20
>> the VIO devices.
>>
>> The unit address of the virtual IOA is simply allocated using=20
>> an increment of bus->next_reg, next_reg being initialized at
>> 0x71000000.
>>
>> I did not see any restrictions in the PAPR specs or in QEMU=20
>> that would break the above.
>=20
> That was until I discovered this macro :=20
>=20
>   #define DEFINE_SPAPR_PROPERTIES(type, field)           \
>         DEFINE_PROP_UINT32("reg", type, field.reg, -1)
> =20
> so 'reg' could have any value. We can not use it ...

Would moving vio_index under the bus and incrementing it each time
a VIO device is created be acceptable ?=20

It does look like an allocator but I really don't know what else to=20
propose :/ See below.

Thanks,

C.


>From 35d206c8768498538ebc74764c65f7a8d59caa33 Mon Sep 17 00:00:00 2001
From: =3D?UTF-8?q?C=3DC3=3DA9dric=3D20Le=3D20Goater?=3D <clg@kaod.org>
Date: Tue, 3 Jul 2018 17:17:23 +0200
Subject: [PATCH] spapr/vio: introduce a device index
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

To introduce a static layout of IRQ numbers, we need a clear identifier
for all devices a sPAPR machine can use. The VIO devices have a "reg"
property which can be set to any value by the user (or libvirt) and we
can not rely on it. Add an "index" attribute defined by the bus when
the device is created.

The number of VIO devices is limited to 100 to fit the IRQ range.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/spapr_vio.h |  2 ++
 hw/ppc/spapr_vio.c         | 13 ++++++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/include/hw/ppc/spapr_vio.h b/include/hw/ppc/spapr_vio.h
index e8b006d18f4e..d95abeffe963 100644
--- a/include/hw/ppc/spapr_vio.h
+++ b/include/hw/ppc/spapr_vio.h
@@ -60,6 +60,7 @@ typedef struct VIOsPAPRDeviceClass {
=20
 struct VIOsPAPRDevice {
     DeviceState qdev;
+    uint32_t index;
     uint32_t reg;
     uint32_t irq;
     uint64_t signal_state;
@@ -75,6 +76,7 @@ struct VIOsPAPRDevice {
=20
 struct VIOsPAPRBus {
     BusState bus;
+    uint32_t next_index;
     uint32_t next_reg;
 };
=20
diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
index be9af71437cc..4665422c11d2 100644
--- a/hw/ppc/spapr_vio.c
+++ b/hw/ppc/spapr_vio.c
@@ -445,14 +445,23 @@ static void spapr_vio_busdev_reset(DeviceState *qde=
v)
     }
 }
=20
+#define SPAPR_VIO_MAX_DEVICES 0x100
+
 static void spapr_vio_busdev_realize(DeviceState *qdev, Error **errp)
 {
     sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
-    VIOsPAPRDevice *dev =3D (VIOsPAPRDevice *)qdev;
+    VIOsPAPRBus *bus =3D SPAPR_VIO_BUS(qdev_get_parent_bus(qdev));
+    VIOsPAPRDevice *dev =3D VIO_SPAPR_DEVICE(qdev);
     VIOsPAPRDeviceClass *pc =3D VIO_SPAPR_DEVICE_GET_CLASS(dev);
     char *id;
     Error *local_err =3D NULL;
=20
+    if (bus->next_index =3D=3D SPAPR_VIO_MAX_DEVICES) {
+        error_setg(errp, "Maximum number of VIO devices reached");
+        return;
+    }
+    dev->index =3D bus->next_index++;
+
     if (dev->reg !=3D -1) {
         /*
          * Explicitly assigned address, just verify that no-one else
@@ -471,8 +480,6 @@ static void spapr_vio_busdev_realize(DeviceState *qde=
v, Error **errp)
         }
     } else {
         /* Need to assign an address */
-        VIOsPAPRBus *bus =3D SPAPR_VIO_BUS(dev->qdev.parent_bus);
-
         do {
             dev->reg =3D bus->next_reg++;
         } while (reg_conflict(dev));
--=20
2.13.6
