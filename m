Received: from eggs.gnu.org ([2001:4830:134:3::10]:48423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eEFTq-00067q-JC
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 09:13:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eEFTl-0000Ee-GI
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 09:12:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37208)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eEFTl-0000Dr-7Y
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 09:12:49 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 747A6C0587FA
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 14:12:48 +0000 (UTC)
References: <1509617407-21191-1-git-send-email-thuth@redhat.com>
	<1509617407-21191-3-git-send-email-thuth@redhat.com>
	<87vaiecm8s.fsf@dusky.pond.sub.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <4ca401d1-4e3b-01c7-ab56-71aa524d49c1@redhat.com>
Date: Mon, 13 Nov 2017 15:12:31 +0100
MIME-Version: 1.0
In-Reply-To: <87vaiecm8s.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 2/2] qdev: Check for the availability of
 a hotplug controller before adding a device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, david@redhat.com

On 13.11.2017 15:00, Markus Armbruster wrote:
> Thomas Huth <thuth@redhat.com> writes:
>=20
>> The qdev_unplug() function contains a g_assert(hotplug_ctrl) statement=
,
>> so QEMU crashes when the user tries to device_add + device_del a devic=
e
>> that does not have a corresponding hotplug controller. This could be
>> provoked for a couple of devices in the past (see commit 4c93950659487=
c7ad
>> or 84ebd3e8c7d4fe955 for example), and can currently for example also =
be
>> triggered like this:
>>
>> $ s390x-softmmu/qemu-system-s390x -M none -nographic=20
>> QEMU 2.10.50 monitor - type 'help' for more information
>> (qemu) device_add qemu-s390x-cpu,id=3Dx
>> (qemu) device_del x
>> **
>> ERROR:qemu/qdev-monitor.c:872:qdev_unplug: assertion failed: (hotplug_=
ctrl)
>> Aborted (core dumped)
>>
>> So devices clearly need a hotplug controller when they should be usabl=
e
>> with device_add.
>> The code in qdev_device_add() already checks whether the bus has a pro=
per
>> hotplug controller,
>=20
> Where?  Hmm, I guess it's this one:
>=20
>     if (qdev_hotplug && bus && !qbus_is_hotpluggable(bus)) {
>         error_setg(errp, QERR_BUS_NO_HOTPLUG, bus->name);
>         return NULL;
>     }

Right.

>>                     but for devices that do not have a corresponding b=
us,
>> there is no appropriate check available yet. In that case we should ch=
eck
>> whether the machine itself provides a suitable hotplug controller and
>> refuse to plug the device if none is available.
[...]
>> diff --git a/qdev-monitor.c b/qdev-monitor.c
>> index 9188d20..38c0fc2 100644
>> --- a/qdev-monitor.c
>> +++ b/qdev-monitor.c
>> @@ -614,6 +614,11 @@ DeviceState *qdev_device_add(QemuOpts *opts, Erro=
r **errp)
>> =20
>        if (qdev_hotplug && bus && !qbus_is_hotpluggable(bus)) {
>            error_setg(errp, QERR_BUS_NO_HOTPLUG, bus->name);
>            return NULL;
>        }
>=20
>        if (!migration_is_idle()) {
>            error_setg(errp, "device_add not allowed while migrating");
>            return NULL;
>        }
>=20
>        /* create device */
>        dev =3D DEVICE(object_new(driver));
>=20
>>      if (bus) {
>>          qdev_set_parent_bus(dev, bus);
>> +    } else if (qdev_hotplug && !qdev_get_machine_hotplug_handler(dev)=
) {
>> +        /* No bus, no machine hotplug handler --> device is not hotpl=
uggable */
>=20
> Long line.

Less than 80 columns, so that's fine.

>> +        error_setg(&err, "Device '%s' can not be hotplugged on this m=
achine",
>> +                   driver);
>> +        goto err_del_dev;
>>      }
>> =20
>>      qdev_set_id(dev, qemu_opts_id(opts));
>=20
> Hmm.  We need to check "can hotplug" in two separate ways, with bus and
> without bus.  Can we keep the two ways on one place?  Something like
>=20
>        if (qdev_hotplug) {
>            if (bus && !qbus_is_hotpluggable(bus)) {
>                error_setg(errp, QERR_BUS_NO_HOTPLUG, bus->name);
>                return NULL;
>            }
>            if (!bus && !qdev_get_machine_hotplug_handler(dev)) {
>                error_setg(&err,
>                           "Machine doesn't support hot-plugging device =
'%s'"
>                           driver);
>                return NULL;
>            }
>       }

We likely could ... but I don't like that change since in that case
you've got to always do "dev =3D DEVICE(object_new(driver))" (and the cod=
e
needs to be at the end of the function, so it would need "goto
err_del_dev" instead of "return NULL"). If we keep the checks separate,
the first check can bail out without creating the device first, so I'd
really prefer to keep my patch that way.

 Thomas
