Received: from eggs.gnu.org ([2001:4830:134:3::10]:52055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e021J-0005rO-3X
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 05:00:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e021E-0000rk-7U
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 05:00:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59438)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1e021D-0000qP-V6
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 05:00:36 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D4813C9D2D
	for <qemu-devel@nongnu.org>; Thu,  5 Oct 2017 09:00:33 +0000 (UTC)
References: <1507049162-27026-1-git-send-email-thuth@redhat.com>
	<20171003184946.GR17385@localhost.localdomain>
	<20171005103629.156e9a9b@nial.brq.redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5165bbdd-b36a-ab89-e819-c85a788f8415@redhat.com>
Date: Thu, 5 Oct 2017 11:00:29 +0200
MIME-Version: 1.0
In-Reply-To: <20171005103629.156e9a9b@nial.brq.redhat.com>
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
To: Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 05.10.2017 10:36, Igor Mammedov wrote:
> On Tue, 3 Oct 2017 15:49:46 -0300
> Eduardo Habkost <ehabkost@redhat.com> wrote:
>=20
>> On Tue, Oct 03, 2017 at 06:46:02PM +0200, Thomas Huth wrote:
>>> The qdev_unplug() function contains a g_assert(hotplug_ctrl) statemen=
t,
>>> so QEMU crashes when the user tries to device_add + device_del a devi=
ce
>>> that does not have a corresponding hotplug controller. This could be
>>> provoked for a couple of devices in the past (see commit 4c9395065948=
7c7ad
>>> or 84ebd3e8c7d4fe955 for example). So devices clearly need a hotplug
>>> controller when they are suitable for device_add.
>>> The code in qdev_device_add() already checks whether the bus has a pr=
oper
>>> hotplug controller, but for devices that do not have a corresponding =
bus,
>>> there is no appropriate check available. In that case we should check
>>> whether the machine itself provides a suitable hotplug controller and
>>> refuse to plug the device if none is available.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>  This is the follow-up patch from my earlier try "hw/core/qdev: Do no=
t
>>>  allow hot-plugging without hotplug controller" ... AFAICS the functi=
on
>>>  qdev_device_add() is now the right spot to do the check.
>>>
>>>  hw/core/qdev.c         | 28 ++++++++++++++++++++--------
>>>  include/hw/qdev-core.h |  1 +
>>>  qdev-monitor.c         |  9 +++++++++
>>>  3 files changed, 30 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
>>> index 606ab53..a953ec9 100644
>>> --- a/hw/core/qdev.c
>>> +++ b/hw/core/qdev.c
>>> @@ -253,19 +253,31 @@ void qdev_set_legacy_instance_id(DeviceState *d=
ev, int alias_id,
>>>      dev->alias_required_for_version =3D required_for_version;
>>>  }
>>> =20
>>> +HotplugHandler *qdev_get_machine_hotplug_handler(DeviceState *dev)
>>> +{
>>> +    MachineState *machine;
>>> +    MachineClass *mc;
>>> +    Object *m_obj =3D qdev_get_machine();
>>> +
>>> +    if (object_dynamic_cast(m_obj, TYPE_MACHINE)) {
>>> +        machine =3D MACHINE(m_obj);
>>> +        mc =3D MACHINE_GET_CLASS(machine);
>>> +        if (mc->get_hotplug_handler) {
>>> +            return mc->get_hotplug_handler(machine, dev);
>>> +        }
>>> +    }
>>> +
>>> +    return NULL;
>>> +}
>>> +
>>>  HotplugHandler *qdev_get_hotplug_handler(DeviceState *dev)
>>>  {
>>> -    HotplugHandler *hotplug_ctrl =3D NULL;
>>> +    HotplugHandler *hotplug_ctrl;
>>> =20
>>>      if (dev->parent_bus && dev->parent_bus->hotplug_handler) {
>>>          hotplug_ctrl =3D dev->parent_bus->hotplug_handler;
>>> -    } else if (object_dynamic_cast(qdev_get_machine(), TYPE_MACHINE)=
) {
>>> -        MachineState *machine =3D MACHINE(qdev_get_machine());
>>> -        MachineClass *mc =3D MACHINE_GET_CLASS(machine);
>>> -
>>> -        if (mc->get_hotplug_handler) {
>>> -            hotplug_ctrl =3D mc->get_hotplug_handler(machine, dev);
>>> -        }
>>> +    } else {
>>> +        hotplug_ctrl =3D qdev_get_machine_hotplug_handler(dev);
>>>      }
>>>      return hotplug_ctrl;
>>>  }
>>> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
>>> index 0891461..5aa536d 100644
>>> --- a/include/hw/qdev-core.h
>>> +++ b/include/hw/qdev-core.h
>>> @@ -285,6 +285,7 @@ DeviceState *qdev_try_create(BusState *bus, const=
 char *name);
>>>  void qdev_init_nofail(DeviceState *dev);
>>>  void qdev_set_legacy_instance_id(DeviceState *dev, int alias_id,
>>>                                   int required_for_version);
>>> +HotplugHandler *qdev_get_machine_hotplug_handler(DeviceState *dev);
>>>  HotplugHandler *qdev_get_hotplug_handler(DeviceState *dev);
>>>  void qdev_unplug(DeviceState *dev, Error **errp);
>>>  void qdev_simple_device_unplug_cb(HotplugHandler *hotplug_dev,
>>> diff --git a/qdev-monitor.c b/qdev-monitor.c
>>> index 8fd6df9..2891dde 100644
>>> --- a/qdev-monitor.c
>>> +++ b/qdev-monitor.c
>>> @@ -626,6 +626,15 @@ DeviceState *qdev_device_add(QemuOpts *opts, Err=
or **errp)
>>>          return NULL;
>>>      }
>>> =20
>>> +    /* In case we don't have a bus, there must be a machine hotplug =
handler */
>>> +    if (qdev_hotplug && !bus && !qdev_get_machine_hotplug_handler(de=
v)) {
>>> +        error_setg(errp, "Device '%s' can not be hotplugged on this =
machine",
>>> +                   driver);
>>> +        object_unparent(OBJECT(dev)); =20
>>
>> Isn't it better to check qdev_get_machine_hotplug_handler()
>> earlier (before the qdev_set_parent_bus() and qdev_set_id()
>> lines), so object_unparent() isn't necessary?
>>
>> (We probably don't need to call object_unparent() here, already,
>> because bus is NULL.  But moving the check before the "if (bus)
>> qdev_set_parent_bus()" statement would make this more obvious).
> it might be bus or bus-less device, so making check before
> qdev_set_parent_bus() should be simpler.

The check for devices that have a bus is already done earlier in this
function ("if (qdev_hotplug && bus && !qbus_is_hotpluggable(bus))") ...
but yes, I'll move the new check for bus-less devices a little bit
earlier so that the unparent is not necessary anymore.

>> I would prefer to eventually make
>> MachineClass::get_hotplug_handler() get a typename or
>> DeviceClass* argument instead of DeviceState*, so we don't even
>> create the device object.  But I don't think it's a requirement
>> for this bug fix.
> choice of hotplug handler might theoretically depend on plugged
> device instance (over-engineered? as far as I recall none does it so fa=
r)

Yes, currently we might be able to do it with the typename only ... but
that seems to be a rather big rework right now, and we might indeed need
a real device instance later again, so I'd prefer to rather not do that
rework right now.

>>> +        object_unref(OBJECT(dev));
>>> +        return NULL;
>>> +    }
> wrt error exit path, I'd rework error path in qdev_device_add() in sepa=
rate patch first
> to look like it is in device_set_realized() and then just jump to appro=
priate label
> from here.

Ok, I can have a try whether that looks better.

 Thomas
