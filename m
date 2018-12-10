Received: from eggs.gnu.org ([2001:4830:134:3::10]:58706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gWJsv-00041t-Tp
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 06:38:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gWJsu-0006nB-As
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 06:38:01 -0500
MIME-Version: 1.0
References: <20181210112649.11581-1-peter.maydell@linaro.org>
	<20181210112649.11581-4-peter.maydell@linaro.org>
In-Reply-To: <20181210112649.11581-4-peter.maydell@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 10 Dec 2018 15:37:45 +0400
Message-ID: <CAJ+F1CJbOMcDtCWchyeD1_cRi9ovtKYsER5DtQuEde75Hxzoxg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/3] uuid: Make qemu_uuid_bswap() take and
 return a QemuUUID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, Ben Warren <ben@skyportsystems.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Weil <sw@weilnetz.de>, patches@linaro.org, Max Reitz <mreitz@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On Mon, Dec 10, 2018 at 3:27 PM Peter Maydell <peter.maydell@linaro.org> wr=
ote:
>
> Currently qemu_uuid_bswap() takes a pointer to the QemuUUID to
> be byte-swapped. This means it can't be used when the UUID
> to be swapped is in a packed member of a struct. It's also
> out of line with the general bswap*() functions we provide
> in bswap.h, which take the value to be swapped and return it.
>
> Make qemu_uuid_bswap() take a QemuUUID and return the swapped version.
>
> This fixes some clang warnings about taking the address of
> a packed struct member in block/vdi.c.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  include/qemu/uuid.h  |  2 +-
>  block/vdi.c          | 16 ++++++++--------
>  hw/acpi/vmgenid.c    |  6 ++----
>  tests/vmgenid-test.c |  2 +-
>  util/uuid.c          | 10 +++++-----
>  5 files changed, 17 insertions(+), 19 deletions(-)
>
> diff --git a/include/qemu/uuid.h b/include/qemu/uuid.h
> index 09489ce5c5e..037357d990b 100644
> --- a/include/qemu/uuid.h
> +++ b/include/qemu/uuid.h
> @@ -56,6 +56,6 @@ char *qemu_uuid_unparse_strdup(const QemuUUID *uuid);
>
>  int qemu_uuid_parse(const char *str, QemuUUID *uuid);
>
> -void qemu_uuid_bswap(QemuUUID *uuid);
> +QemuUUID qemu_uuid_bswap(QemuUUID uuid);
>
>  #endif
> diff --git a/block/vdi.c b/block/vdi.c
> index 4cc726047c3..0c34f6bae46 100644
> --- a/block/vdi.c
> +++ b/block/vdi.c
> @@ -203,10 +203,10 @@ static void vdi_header_to_cpu(VdiHeader *header)
>      header->block_extra =3D le32_to_cpu(header->block_extra);
>      header->blocks_in_image =3D le32_to_cpu(header->blocks_in_image);
>      header->blocks_allocated =3D le32_to_cpu(header->blocks_allocated);
> -    qemu_uuid_bswap(&header->uuid_image);
> -    qemu_uuid_bswap(&header->uuid_last_snap);
> -    qemu_uuid_bswap(&header->uuid_link);
> -    qemu_uuid_bswap(&header->uuid_parent);
> +    header->uuid_image =3D qemu_uuid_bswap(header->uuid_image);
> +    header->uuid_last_snap =3D qemu_uuid_bswap(header->uuid_last_snap);
> +    header->uuid_link =3D qemu_uuid_bswap(header->uuid_link);
> +    header->uuid_parent =3D qemu_uuid_bswap(header->uuid_parent);
>  }
>
>  static void vdi_header_to_le(VdiHeader *header)
> @@ -227,10 +227,10 @@ static void vdi_header_to_le(VdiHeader *header)
>      header->block_extra =3D cpu_to_le32(header->block_extra);
>      header->blocks_in_image =3D cpu_to_le32(header->blocks_in_image);
>      header->blocks_allocated =3D cpu_to_le32(header->blocks_allocated);
> -    qemu_uuid_bswap(&header->uuid_image);
> -    qemu_uuid_bswap(&header->uuid_last_snap);
> -    qemu_uuid_bswap(&header->uuid_link);
> -    qemu_uuid_bswap(&header->uuid_parent);
> +    header->uuid_image =3D qemu_uuid_bswap(header->uuid_image);
> +    header->uuid_last_snap =3D qemu_uuid_bswap(header->uuid_last_snap);
> +    header->uuid_link =3D qemu_uuid_bswap(header->uuid_link);
> +    header->uuid_parent =3D qemu_uuid_bswap(header->uuid_parent);
>  }
>
>  static void vdi_header_print(VdiHeader *header)
> diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
> index d78b579a201..02717a8b0dc 100644
> --- a/hw/acpi/vmgenid.c
> +++ b/hw/acpi/vmgenid.c
> @@ -30,8 +30,7 @@ void vmgenid_build_acpi(VmGenIdState *vms, GArray *tabl=
e_data, GArray *guid,
>       * first, since that's what the guest expects
>       */
>      g_array_set_size(guid, VMGENID_FW_CFG_SIZE - ARRAY_SIZE(guid_le.data=
));
> -    guid_le =3D vms->guid;
> -    qemu_uuid_bswap(&guid_le);
> +    guid_le =3D qemu_uuid_bswap(vms->guid);
>      /* The GUID is written at a fixed offset into the fw_cfg file
>       * in order to implement the "OVMF SDT Header probe suppressor"
>       * see docs/specs/vmgenid.txt for more details
> @@ -149,8 +148,7 @@ static void vmgenid_update_guest(VmGenIdState *vms)
>               * however, will expect the fields to be little-endian.
>               * Perform a byte swap immediately before writing.
>               */
> -            guid_le =3D vms->guid;
> -            qemu_uuid_bswap(&guid_le);
> +            guid_le =3D qemu_uuid_bswap(vms->guid);
>              /* The GUID is written at a fixed offset into the fw_cfg fil=
e
>               * in order to implement the "OVMF SDT Header probe suppress=
or"
>               * see docs/specs/vmgenid.txt for more details.
> diff --git a/tests/vmgenid-test.c b/tests/vmgenid-test.c
> index 0a6fb55f2eb..98db43f5a65 100644
> --- a/tests/vmgenid-test.c
> +++ b/tests/vmgenid-test.c
> @@ -110,7 +110,7 @@ static void read_guid_from_memory(QemuUUID *guid)
>      /* The GUID is in little-endian format in the guest, while QEMU
>       * uses big-endian.  Swap after reading.
>       */
> -    qemu_uuid_bswap(guid);
> +    *guid =3D qemu_uuid_bswap(*guid);
>  }
>
>  static void read_guid_from_monitor(QemuUUID *guid)
> diff --git a/util/uuid.c b/util/uuid.c
> index ebf06c049ad..5787f0978c1 100644
> --- a/util/uuid.c
> +++ b/util/uuid.c
> @@ -110,10 +110,10 @@ int qemu_uuid_parse(const char *str, QemuUUID *uuid=
)
>
>  /* Swap from UUID format endian (BE) to the opposite or vice versa.
>   */
> -void qemu_uuid_bswap(QemuUUID *uuid)
> +QemuUUID qemu_uuid_bswap(QemuUUID uuid)
>  {
> -    assert(QEMU_PTR_IS_ALIGNED(uuid, sizeof(uint32_t)));
> -    bswap32s(&uuid->fields.time_low);
> -    bswap16s(&uuid->fields.time_mid);
> -    bswap16s(&uuid->fields.time_high_and_version);
> +    bswap32s(&uuid.fields.time_low);
> +    bswap16s(&uuid.fields.time_mid);
> +    bswap16s(&uuid.fields.time_high_and_version);
> +    return uuid;
>  }
> --
> 2.19.2
>
>


--=20
Marc-Andr=C3=A9 Lureau
