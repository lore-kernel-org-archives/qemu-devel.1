Received: from eggs.gnu.org ([2001:4830:134:3::10]:45520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dSXr4-0007pl-97
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 20:07:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dSXr0-000436-AO
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 20:07:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48996)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dSXr0-00042p-1O
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 20:07:38 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C61B24E4CB
	for <qemu-devel@nongnu.org>; Wed,  5 Jul 2017 00:07:36 +0000 (UTC)
References: <20170629132310.18865-1-marcandre.lureau@redhat.com>
	<20170629132310.18865-6-marcandre.lureau@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <f71401ea-2a98-5cc1-8d9f-5f2ffb683877@redhat.com>
Date: Wed, 5 Jul 2017 02:07:32 +0200
MIME-Version: 1.0
In-Reply-To: <20170629132310.18865-6-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 5/7] kdump: add vmcoreinfo ELF note
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, anderson@redhat.com, imammedo@redhat.com

On 06/29/17 15:23, Marc-Andr=C3=A9 Lureau wrote:
> kdump header provides offset and size of the vmcoreinfo ELF note,
> append it if available.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  dump.c | 48 ++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 44 insertions(+), 4 deletions(-)
>=20
> diff --git a/dump.c b/dump.c
> index 8fda5cc1ed..b78bc1fda7 100644
> --- a/dump.c
> +++ b/dump.c
> @@ -788,8 +788,9 @@ static void create_header32(DumpState *s, Error **e=
rrp)
>      uint32_t sub_hdr_size;
>      uint32_t bitmap_blocks;
>      uint32_t status =3D 0;
> -    uint64_t offset_note;
> +    uint64_t offset_note, offset_vmcoreinfo, size_vmcoreinfo =3D 0;
>      Error *local_err =3D NULL;
> +    uint8_t *vmcoreinfo =3D NULL;
> =20
>      /* write common header, the version of kdump-compressed format is =
6th */
>      size =3D sizeof(DiskDumpHeader32);
> @@ -838,7 +839,18 @@ static void create_header32(DumpState *s, Error **=
errp)
>      kh->phys_base =3D cpu_to_dump32(s, s->dump_info.phys_base);
>      kh->dump_level =3D cpu_to_dump32(s, DUMP_LEVEL);
> =20
> -    offset_note =3D DISKDUMP_HEADER_BLOCKS * block_size + size;
> +    offset_vmcoreinfo =3D DISKDUMP_HEADER_BLOCKS * block_size + size;
> +    if (s->vmcoreinfo) {
> +        uint64_t hsize, name_size;
> +
> +        get_note_sizes(s, s->vmcoreinfo, &hsize, &name_size, &size_vmc=
oreinfo);

Should we round up "size_vmcoreinfo" as well? (Without the rounding,
offset_note might become unaligned, plus I simply don't know what
alignment is expected from kh->size_vmcoreinfo.)

> +        vmcoreinfo =3D
> +            s->vmcoreinfo + (DIV_ROUND_UP(hsize, 4) + DIV_ROUND_UP(nam=
e_size, 4)) * 4;
> +        kh->offset_vmcoreinfo =3D cpu_to_dump64(s, offset_vmcoreinfo);
> +        kh->size_vmcoreinfo =3D cpu_to_dump32(s, size_vmcoreinfo);
> +    }
> +
> +    offset_note =3D offset_vmcoreinfo + size_vmcoreinfo;
>      kh->offset_note =3D cpu_to_dump64(s, offset_note);
>      kh->note_size =3D cpu_to_dump32(s, s->note_size);
> =20
> @@ -848,6 +860,14 @@ static void create_header32(DumpState *s, Error **=
errp)
>          goto out;
>      }
> =20
> +    if (vmcoreinfo) {
> +        if (write_buffer(s->fd, offset_vmcoreinfo, vmcoreinfo,
> +                         size_vmcoreinfo) < 0) {
> +            error_setg(errp, "dump: failed to vmcoreinfo");

The verb "write" is missing from the message.

Same comments for create_header64() below.

Thanks
Laszlo

> +            goto out;
> +        }
> +    }
> +
>      /* write note */
>      s->note_buf =3D g_malloc0(s->note_size);
>      s->note_buf_offset =3D 0;
> @@ -888,8 +908,9 @@ static void create_header64(DumpState *s, Error **e=
rrp)
>      uint32_t sub_hdr_size;
>      uint32_t bitmap_blocks;
>      uint32_t status =3D 0;
> -    uint64_t offset_note;
> +    uint64_t offset_note, offset_vmcoreinfo, size_vmcoreinfo =3D 0;
>      Error *local_err =3D NULL;
> +    uint8_t *vmcoreinfo =3D NULL;
> =20
>      /* write common header, the version of kdump-compressed format is =
6th */
>      size =3D sizeof(DiskDumpHeader64);
> @@ -938,7 +959,18 @@ static void create_header64(DumpState *s, Error **=
errp)
>      kh->phys_base =3D cpu_to_dump64(s, s->dump_info.phys_base);
>      kh->dump_level =3D cpu_to_dump32(s, DUMP_LEVEL);
> =20
> -    offset_note =3D DISKDUMP_HEADER_BLOCKS * block_size + size;
> +    offset_vmcoreinfo =3D DISKDUMP_HEADER_BLOCKS * block_size + size;
> +    if (s->vmcoreinfo) {
> +        uint64_t hsize, name_size;
> +
> +        get_note_sizes(s, s->vmcoreinfo, &hsize, &name_size, &size_vmc=
oreinfo);
> +        vmcoreinfo =3D
> +            s->vmcoreinfo + (DIV_ROUND_UP(hsize, 4) + DIV_ROUND_UP(nam=
e_size, 4)) * 4;
> +        kh->offset_vmcoreinfo =3D cpu_to_dump64(s, offset_vmcoreinfo);
> +        kh->size_vmcoreinfo =3D cpu_to_dump64(s, size_vmcoreinfo);
> +    }
> +
> +    offset_note =3D offset_vmcoreinfo + size_vmcoreinfo;
>      kh->offset_note =3D cpu_to_dump64(s, offset_note);
>      kh->note_size =3D cpu_to_dump64(s, s->note_size);
> =20
> @@ -948,6 +980,14 @@ static void create_header64(DumpState *s, Error **=
errp)
>          goto out;
>      }
> =20
> +    if (vmcoreinfo) {
> +        if (write_buffer(s->fd, offset_vmcoreinfo, vmcoreinfo,
> +                         size_vmcoreinfo) < 0) {
> +            error_setg(errp, "dump: failed to vmcoreinfo");
> +            goto out;
> +        }
> +    }
> +
>      /* write note */
>      s->note_buf =3D g_malloc0(s->note_size);
>      s->note_buf_offset =3D 0;
>=20
