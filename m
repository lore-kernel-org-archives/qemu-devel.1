Received: from eggs.gnu.org ([209.51.188.92]:40348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h13wb-0006UE-ON
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 01:52:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h13wa-0008B8-M8
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 01:52:53 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190225183757.27378-1-armbru@redhat.com>
	<20190225183757.27378-3-armbru@redhat.com>
	<47968abb-fc4e-4546-3cb5-339da5f7a268@redhat.com>
Date: Tue, 05 Mar 2019 07:52:39 +0100
In-Reply-To: <47968abb-fc4e-4546-3cb5-339da5f7a268@redhat.com> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 4 Mar 2019 16:57:10
	+0100")
Message-ID: <87r2blx16w.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 2/6] qom: Move compat_props machinery
 from qdev to QOM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org, mst@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, lersek@redhat.com

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 2/25/19 7:37 PM, Markus Armbruster wrote:
>> See the previous commit for rationale.
>>=20
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  hw/core/qdev.c         | 39 ---------------------------------------
>>  include/hw/qdev-core.h |  4 ----
>>  include/qom/object.h   |  3 +++
>>  qom/object.c           | 39 +++++++++++++++++++++++++++++++++++++++
>>  4 files changed, 42 insertions(+), 43 deletions(-)
>>=20
>> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
>> index 1a86c7990a..25dffad3ed 100644
>> --- a/hw/core/qdev.c
>> +++ b/hw/core/qdev.c
>> @@ -970,45 +970,6 @@ static void device_initfn(Object *obj)
>>      QLIST_INIT(&dev->gpios);
>>  }
>>=20=20
>> -/*
>> - * Global property defaults
>> - * Slot 0: accelerator's global property defaults
>> - * Slot 1: machine's global property defaults
>> - * Each is a GPtrArray of of GlobalProperty.
>> - * Applied in order, later entries override earlier ones.
>> - */
>> -static GPtrArray *object_compat_props[2];
>> -
>> -/*
>> - * Set machine's global property defaults to @compat_props.
>> - * May be called at most once.
>> - */
>> -void object_set_machine_compat_props(GPtrArray *compat_props)
>> -{
>> -    assert(!object_compat_props[1]);
>> -    object_compat_props[1] =3D compat_props;
>> -}
>> -
>> -/*
>> - * Set accelerator's global property defaults to @compat_props.
>> - * May be called at most once.
>> - */
>> -void object_set_accelerator_compat_props(GPtrArray *compat_props)
>> -{
>> -    assert(!object_compat_props[0]);
>> -    object_compat_props[0] =3D compat_props;
>> -}
>> -
>> -void object_apply_compat_props(Object *obj)
>> -{
>> -    int i;
>> -
>> -    for (i =3D 0; i < ARRAY_SIZE(object_compat_props); i++) {
>> -        object_apply_global_props(obj, object_compat_props[i],
>> -                                  &error_abort);
>> -    }
>> -}
>> -
>>  static void device_post_init(Object *obj)
>>  {
>>      /*
>> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
>> index bced1f2666..f2f0006234 100644
>> --- a/include/hw/qdev-core.h
>> +++ b/include/hw/qdev-core.h
>> @@ -418,10 +418,6 @@ const char *qdev_fw_name(DeviceState *dev);
>>=20=20
>>  Object *qdev_get_machine(void);
>>=20=20
>> -void object_set_machine_compat_props(GPtrArray *compat_props);
>> -void object_set_accelerator_compat_props(GPtrArray *compat_props);
>> -void object_apply_compat_props(Object *obj);
>> -
>>  /* FIXME: make this a link<> */
>>  void qdev_set_parent_bus(DeviceState *dev, BusState *bus);
>>=20=20
>> diff --git a/include/qom/object.h b/include/qom/object.h
>> index e0262962b5..288cdddf44 100644
>> --- a/include/qom/object.h
>> +++ b/include/qom/object.h
>> @@ -677,6 +677,9 @@ Object *object_new_with_propv(const char *typename,
>>=20=20
>>  void object_apply_global_props(Object *obj, const GPtrArray *props,
>>                                 Error **errp);
>> +void object_set_machine_compat_props(GPtrArray *compat_props);
>> +void object_set_accelerator_compat_props(GPtrArray *compat_props);
>> +void object_apply_compat_props(Object *obj);
>
> Documentation comments are in .c, OK :(

I chose to move the comments along with the code.  If we want the
function comments in object.h for local consistency, we should also
rewrite to conform to the style used there.  Separate patch, so this one
can remain pure code motion.

>>=20=20
>>  /**
>>   * object_set_props:
>> diff --git a/qom/object.c b/qom/object.c
>> index b8c732063b..adb9b7fe91 100644
>> --- a/qom/object.c
>> +++ b/qom/object.c
>> @@ -408,6 +408,45 @@ void object_apply_global_props(Object *obj, const G=
PtrArray *props, Error **errp
>>      }
>>  }
>>=20=20
>> +/*
>> + * Global property defaults
>> + * Slot 0: accelerator's global property defaults
>> + * Slot 1: machine's global property defaults
>> + * Each is a GPtrArray of of GlobalProperty.
>> + * Applied in order, later entries override earlier ones.
>> + */
>> +static GPtrArray *object_compat_props[2];
>> +
>> +/*
>> + * Set machine's global property defaults to @compat_props.
>> + * May be called at most once.
>> + */
>> +void object_set_machine_compat_props(GPtrArray *compat_props)
>> +{
>> +    assert(!object_compat_props[1]);
>> +    object_compat_props[1] =3D compat_props;
>> +}
>> +
>> +/*
>> + * Set accelerator's global property defaults to @compat_props.
>> + * May be called at most once.
>> + */
>> +void object_set_accelerator_compat_props(GPtrArray *compat_props)
>> +{
>> +    assert(!object_compat_props[0]);
>> +    object_compat_props[0] =3D compat_props;
>> +}
>> +
>
> Can you add a comment for this one too? (no need to respin)

Separate patch, so this one can remain pure code motion.  If we decide
to move (reformatted) function comments to object.h, the additional
comment can be added in that patch.

>> +void object_apply_compat_props(Object *obj)
>> +{
>> +    int i;
>> +
>> +    for (i =3D 0; i < ARRAY_SIZE(object_compat_props); i++) {
>> +        object_apply_global_props(obj, object_compat_props[i],
>> +                                  &error_abort);
>> +    }
>> +}
>> +
>>  static void object_initialize_with_type(void *data, size_t size, TypeIm=
pl *type)
>>  {
>>      Object *obj =3D data;
>>=20
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Thanks!
