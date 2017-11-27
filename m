Received: from eggs.gnu.org ([2001:4830:134:3::10]:43007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eJMeD-000686-Qt
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 11:52:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eJMeC-0006BD-QH
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 11:52:45 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:43559)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eJMeC-0006An-KK
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 11:52:44 -0500
Received: by mail-wm0-x243.google.com with SMTP id x63so35473529wmf.2
	for <qemu-devel@nongnu.org>; Mon, 27 Nov 2017 08:52:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171127130518.26703-3-rkagan@virtuozzo.com>
References: <20171127130518.26703-1-rkagan@virtuozzo.com>
	<20171127130518.26703-3-rkagan@virtuozzo.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 27 Nov 2017 17:52:42 +0100
Message-ID: <CAJ+F1CKic_SVa+Kaxp3YM2y=osyukB1Zu5=PyYZz6Txp=iYsgw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/2] vmgenid: use UUID property type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>
Cc: QEMU <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Ben Warren <ben@skyportsystems.com>, Markus Armbruster <armbru@redhat.com>, minyard@acm.org, "Denis V. Lunev" <den@openvz.org>

On Mon, Nov 27, 2017 at 2:05 PM, Roman Kagan <rkagan@virtuozzo.com> wrote:
> Switch vmgenid device to use the UUID property type introduced in the
> previous patch for its 'guid' property.
>
> One semantic change it introduces is that post-realize modification of
> 'guid' via HMP or QMP will now be rejected with an error; however,
> according to docs/specs/vmgenid.txt this is actually desirable.
>
> Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
> v1 -> v2:
>  - use the corresponding define for "guid" field name
>
>  hw/acpi/vmgenid.c | 30 ++++++++----------------------
>  1 file changed, 8 insertions(+), 22 deletions(-)
>
> diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
> index 105044f666..ba6f47b67b 100644
> --- a/hw/acpi/vmgenid.c
> +++ b/hw/acpi/vmgenid.c
> @@ -162,21 +162,6 @@ static void vmgenid_update_guest(VmGenIdState *vms)
>      }
>  }
>
> -static void vmgenid_set_guid(Object *obj, const char *value, Error **err=
p)
> -{
> -    VmGenIdState *vms =3D VMGENID(obj);
> -
> -    if (!strcmp(value, "auto")) {
> -        qemu_uuid_generate(&vms->guid);
> -    } else if (qemu_uuid_parse(value, &vms->guid) < 0) {
> -        error_setg(errp, "'%s. %s': Failed to parse GUID string: %s",
> -                   object_get_typename(OBJECT(vms)), VMGENID_GUID, value=
);
> -        return;
> -    }
> -
> -    vmgenid_update_guest(vms);
> -}
> -
>  /* After restoring an image, we need to update the guest memory and noti=
fy
>   * it of a potential change to VM Generation ID
>   */
> @@ -224,23 +209,24 @@ static void vmgenid_realize(DeviceState *dev, Error=
 **errp)
>      }
>
>      qemu_register_reset(vmgenid_handle_reset, vms);
> +
> +    vmgenid_update_guest(vms);
>  }
>
> +static Property vmgenid_device_properties[] =3D {
> +    DEFINE_PROP_UUID(VMGENID_GUID, VmGenIdState, guid),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
>  static void vmgenid_device_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>
>      dc->vmsd =3D &vmstate_vmgenid;
>      dc->realize =3D vmgenid_realize;
> +    dc->props =3D vmgenid_device_properties;
>      dc->hotpluggable =3D false;
>      set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> -
> -    object_class_property_add_str(klass, VMGENID_GUID, NULL,
> -                                  vmgenid_set_guid, NULL);
> -    object_class_property_set_description(klass, VMGENID_GUID,
> -                                    "Set Global Unique Identifier "
> -                                    "(big-endian) or auto for random val=
ue",
> -                                    NULL);
>  }
>
>  static const TypeInfo vmgenid_device_info =3D {
> --
> 2.14.3
>
>



--=20
Marc-Andr=C3=A9 Lureau
