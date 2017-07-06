Received: from eggs.gnu.org ([2001:4830:134:3::10]:50033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dTALU-0001bO-Kh
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 13:13:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dTALR-0007o3-Em
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 13:13:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39798)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dTALR-0007nR-66
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 13:13:37 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3E23074864
	for <qemu-devel@nongnu.org>; Thu,  6 Jul 2017 17:13:36 +0000 (UTC)
References: <20170706101611.27031-1-marcandre.lureau@redhat.com>
	<20170706101611.27031-6-marcandre.lureau@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <72817738-deb5-f64e-7247-89dbdf10ddbd@redhat.com>
Date: Thu, 6 Jul 2017 19:13:31 +0200
MIME-Version: 1.0
In-Reply-To: <20170706101611.27031-6-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 5/7] kdump: add vmcoreinfo ELF note
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

On 07/06/17 12:16, Marc-Andr=C3=A9 Lureau wrote:
> kdump header provides offset and size of the vmcoreinfo ELF note,
> append it if available.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  dump.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>=20
> diff --git a/dump.c b/dump.c
> index f699198204..dd416ad271 100644
> --- a/dump.c
> +++ b/dump.c
> @@ -839,6 +839,16 @@ static void create_header32(DumpState *s, Error **=
errp)
>      kh->dump_level =3D cpu_to_dump32(s, DUMP_LEVEL);
> =20
>      offset_note =3D DISKDUMP_HEADER_BLOCKS * block_size + size;
> +    if (s->vmcoreinfo) {
> +        uint64_t hsize, name_size, size_vmcoreinfo_desc, offset_vmcore=
info;
> +
> +        get_note_sizes(s, s->vmcoreinfo, &hsize, &name_size, &size_vmc=
oreinfo_desc);
> +        offset_vmcoreinfo =3D offset_note + s->note_size - s->vmcorein=
fo_size +
> +            (DIV_ROUND_UP(hsize, 4) + DIV_ROUND_UP(name_size, 4)) * 4;
> +        kh->offset_vmcoreinfo =3D cpu_to_dump64(s, offset_vmcoreinfo);
> +        kh->size_vmcoreinfo =3D cpu_to_dump32(s, size_vmcoreinfo_desc)=
;
> +    }
> +
>      kh->offset_note =3D cpu_to_dump64(s, offset_note);
>      kh->note_size =3D cpu_to_dump32(s, s->note_size);
> =20
> @@ -939,6 +949,16 @@ static void create_header64(DumpState *s, Error **=
errp)
>      kh->dump_level =3D cpu_to_dump32(s, DUMP_LEVEL);
> =20
>      offset_note =3D DISKDUMP_HEADER_BLOCKS * block_size + size;
> +    if (s->vmcoreinfo) {
> +        uint64_t hsize, name_size, size_vmcoreinfo_desc, offset_vmcore=
info;
> +
> +        get_note_sizes(s, s->vmcoreinfo, &hsize, &name_size, &size_vmc=
oreinfo_desc);
> +        offset_vmcoreinfo =3D offset_note + s->note_size - s->vmcorein=
fo_size +
> +            (DIV_ROUND_UP(hsize, 4) + DIV_ROUND_UP(name_size, 4)) * 4;
> +        kh->offset_vmcoreinfo =3D cpu_to_dump64(s, offset_vmcoreinfo);
> +        kh->size_vmcoreinfo =3D cpu_to_dump64(s, size_vmcoreinfo_desc)=
;
> +    }
> +
>      kh->offset_note =3D cpu_to_dump64(s, offset_note);
>      kh->note_size =3D cpu_to_dump64(s, s->note_size);
> =20
>=20

I continue to think that this patch is unnecessary, but if you insist,
it does look OK to me.

Reviewed-by: Laszlo Ersek <lersek@redhat.com>
