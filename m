Received: from eggs.gnu.org ([2001:4830:134:3::10]:50109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dzpMq-0000FO-Ni
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 15:30:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dzpMn-0004dh-Id
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 15:30:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57842)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dzpMn-0004cP-Ao
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 15:30:01 -0400
References: <1507049162-27026-1-git-send-email-thuth@redhat.com>
	<20171004133659.1f656303@nial.brq.redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <591132a9-c4e5-47cd-bab9-f017a116c2ae@redhat.com>
Date: Wed, 4 Oct 2017 21:29:54 +0200
MIME-Version: 1.0
In-Reply-To: <20171004133659.1f656303@nial.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qdev: Check for the availability of a
 hotplug controller before adding a device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On 04.10.2017 13:36, Igor Mammedov wrote:
> On Tue,  3 Oct 2017 18:46:02 +0200
> Thomas Huth <thuth@redhat.com> wrote:
>=20
>> The qdev_unplug() function contains a g_assert(hotplug_ctrl) statement=
,
>> so QEMU crashes when the user tries to device_add + device_del a devic=
e
>> that does not have a corresponding hotplug controller. This could be
>> provoked for a couple of devices in the past (see commit 4c93950659487=
c7ad
>> or 84ebd3e8c7d4fe955 for example). So devices clearly need a hotplug
>> controller when they are suitable for device_add.
>> The code in qdev_device_add() already checks whether the bus has a pro=
per
>> hotplug controller, but for devices that do not have a corresponding b=
us,
>> there is no appropriate check available. In that case we should check
>> whether the machine itself provides a suitable hotplug controller and
>> refuse to plug the device if none is available.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  This is the follow-up patch from my earlier try "hw/core/qdev: Do not
>>  allow hot-plugging without hotplug controller" ... AFAICS the functio=
n
>>  qdev_device_add() is now the right spot to do the check.
>>
>>  hw/core/qdev.c         | 28 ++++++++++++++++++++--------
>>  include/hw/qdev-core.h |  1 +
>>  qdev-monitor.c         |  9 +++++++++
>>  3 files changed, 30 insertions(+), 8 deletions(-)
>>
>> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
>> index 606ab53..a953ec9 100644
>> --- a/hw/core/qdev.c
>> +++ b/hw/core/qdev.c
>> @@ -253,19 +253,31 @@ void qdev_set_legacy_instance_id(DeviceState *de=
v, int alias_id,
>>      dev->alias_required_for_version =3D required_for_version;
>>  }
>> =20
>> +HotplugHandler *qdev_get_machine_hotplug_handler(DeviceState *dev)
>> +{
>> +    MachineState *machine;
>> +    MachineClass *mc;
>> +    Object *m_obj =3D qdev_get_machine();
>> +
>> +    if (object_dynamic_cast(m_obj, TYPE_MACHINE)) {
>> +        machine =3D MACHINE(m_obj);
>> +        mc =3D MACHINE_GET_CLASS(machine);
>> +        if (mc->get_hotplug_handler) {
>> +            return mc->get_hotplug_handler(machine, dev);
>> +        }
>> +    }
>> +
>> +    return NULL;
>> +}
>> +
>>  HotplugHandler *qdev_get_hotplug_handler(DeviceState *dev)
>>  {
>> -    HotplugHandler *hotplug_ctrl =3D NULL;
>> +    HotplugHandler *hotplug_ctrl;
>> =20
>>      if (dev->parent_bus && dev->parent_bus->hotplug_handler) {
>>          hotplug_ctrl =3D dev->parent_bus->hotplug_handler;
>> -    } else if (object_dynamic_cast(qdev_get_machine(), TYPE_MACHINE))=
 {
>> -        MachineState *machine =3D MACHINE(qdev_get_machine());
>> -        MachineClass *mc =3D MACHINE_GET_CLASS(machine);
>> -
>> -        if (mc->get_hotplug_handler) {
>> -            hotplug_ctrl =3D mc->get_hotplug_handler(machine, dev);
>> -        }
>> +    } else {
>> +        hotplug_ctrl =3D qdev_get_machine_hotplug_handler(dev);
>>      }
>>      return hotplug_ctrl;
>>  }
>> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
>> index 0891461..5aa536d 100644
>> --- a/include/hw/qdev-core.h
>> +++ b/include/hw/qdev-core.h
>> @@ -285,6 +285,7 @@ DeviceState *qdev_try_create(BusState *bus, const =
char *name);
>>  void qdev_init_nofail(DeviceState *dev);
>>  void qdev_set_legacy_instance_id(DeviceState *dev, int alias_id,
>>                                   int required_for_version);
>> +HotplugHandler *qdev_get_machine_hotplug_handler(DeviceState *dev);
>>  HotplugHandler *qdev_get_hotplug_handler(DeviceState *dev);
>>  void qdev_unplug(DeviceState *dev, Error **errp);
>>  void qdev_simple_device_unplug_cb(HotplugHandler *hotplug_dev,
>> diff --git a/qdev-monitor.c b/qdev-monitor.c
>> index 8fd6df9..2891dde 100644
>> --- a/qdev-monitor.c
>> +++ b/qdev-monitor.c
>> @@ -626,6 +626,15 @@ DeviceState *qdev_device_add(QemuOpts *opts, Erro=
r **errp)
>>          return NULL;
>>      }
>> =20
>> +    /* In case we don't have a bus, there must be a machine hotplug h=
andler */
>> +    if (qdev_hotplug && !bus && !qdev_get_machine_hotplug_handler(dev=
)) {
> current machine hotplug handler serves both cold and hot-plug so in rea=
lity it's
> just  'plug' handler.
>=20
> Is there a point -device/device_add devices on board that doesn't have =
'hotplug'
> handler that would wire device up properly?

Sorry, I did not get that question ... do you mean whether there's any
code that uses qdev_device_add() to add a device without hotplug
controller? I don't think so. It's currently only used by
qmp_device_add() for the QMP/HMP command, in vl.c for -device and in the
USB code for xen-usb host device. So this function currently really only
makes sense for devices that have a hotplug controller.

 Thomas
