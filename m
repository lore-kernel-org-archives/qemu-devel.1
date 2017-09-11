Received: from eggs.gnu.org ([2001:4830:134:3::10]:54396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1drPkg-0006bD-TK
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 10:31:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1drPkb-0001Uj-43
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 10:31:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47242)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1drPka-0001U4-RP
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 10:31:49 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A7F8311AD08
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 14:31:47 +0000 (UTC)
References: <1504776162-31400-1-git-send-email-thuth@redhat.com>
	<20170911145344.4f2e192c@nial.brq.redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f62b660d-596a-f5ed-b4c7-d5adf58d2913@redhat.com>
Date: Mon, 11 Sep 2017 16:31:39 +0200
MIME-Version: 1.0
In-Reply-To: <20170911145344.4f2e192c@nial.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/core/qdev: Do not allow hot-plugging
 without hotplug controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>

On 11.09.2017 14:53, Igor Mammedov wrote:
> On Thu,  7 Sep 2017 11:22:42 +0200
> Thomas Huth <thuth@redhat.com> wrote:
>=20
>> qdev_unplug() bails out with an assertion if the user tries to device_=
del
>> a hot-plugged device that does not have a hotplug controller. Unfortun=
ately,
>> our devices are all marked with hotpluggable =3D true by default (see =
the
>> device_class_init() function in qdev.c), so it currently can happen th=
at
>> the user runs into this situation and QEMU gets terminated unexpectedl=
y:
>>
>> $ qemu-system-aarch64 -M virt -nographic -nodefaults -monitor stdio -S
>> QEMU 2.10.50 monitor - type 'help' for more information
>> (qemu) device_add aux-to-i2c-bridge,id=3Dx
>> (qemu) device_del x
>> **
>> ERROR:qdev-monitor.c:872:qdev_unplug: assertion failed: (hotplug_ctrl)
>> Aborted (core dumped)
>> Hotplugging devices without a hotplug controller does not make much se=
nse,
>> so we should disallow this during the device_add process already!
>>
>> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  hw/core/qdev.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
>> index 606ab53..d9ccce6 100644
>> --- a/hw/core/qdev.c
>> +++ b/hw/core/qdev.c
>> @@ -908,6 +908,11 @@ static void device_set_realized(Object *obj, bool=
 value, Error **errp)
>>              if (local_err !=3D NULL) {
>>                  goto fail;
>>              }
>> +        } else if (dev->hotplugged) {
>> +            /* Hot-plugged device without hotplug controller? No way!=
 */
>> +            error_setg(&local_err, QERR_DEVICE_NO_HOTPLUG,
>> +                       object_get_typename(obj));
>> +            goto fail;
>>          }
>> =20
>>          if (dc->realize) {
>=20
> maybe it should be other way around, i.e, fix device so that following =
would work
>=20
>   device_set_realized()
>     if (dev->hotplugged && !dc->hotpluggable) {                        =
         =20
>         error_setg(errp, QERR_DEVICE_NO_HOTPLUG, object_get_typename(ob=
j));     =20
>         return;                                                        =
         =20
>     }
>=20
> instead of leaving device broken, like in yours
>  84ebd3e watchdog/wdt_diag288: Mark diag288 watchdog as non-hotpluggabl=
e

No, that apparently does not work right for new devices since people
keep forgetting to set hotpluggable =3D false there. Both, Paolo and Pete=
r
suggested that we should not allow hot-plugging if there's no hot plug
controller - it indeed does not make sense, so we should not allow it.

 Thomas
