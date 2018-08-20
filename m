Received: from eggs.gnu.org ([2001:4830:134:3::10]:53640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1frh2d-0005ed-6o
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:04:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1frgxy-0004Og-Mf
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 05:59:22 -0400
References: <20180818025600.21132-1-f4bug@amsat.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <3ce9ffc8-1902-8531-c19f-961a9d497e67@redhat.com>
Date: Mon, 20 Aug 2018 11:59:02 +0200
MIME-Version: 1.0
In-Reply-To: <20180818025600.21132-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] sheepdog: Replace strncpy() by g_strlcpy()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Howard Spoelstra <hsp.cat7@gmail.com>, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Liu Yuan <namei.unix@gmail.com>, Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Sheepdog" <qemu-block@nongnu.org>, "open list:Sheepdog" <sheepdog@lists.wpkg.org>

On 18.08.2018 04:56, Philippe Mathieu-Daud=C3=A9 wrote:
> Fedora 29 comes with GCC 8.1 which added the 'stringop-truncation' chec=
ks.
>=20
> Replace the strncpy() calls by g_strlcpy() to avoid the following warni=
ng:
>=20
>   block/sheepdog.c: In function 'find_vdi_name':
>   block/sheepdog.c:1239:5: error: 'strncpy' specified bound 256 equals
>   destination size [-Werror=3Dstringop-truncation]
>        strncpy(buf + SD_MAX_VDI_LEN, tag, SD_MAX_VDI_TAG_LEN);
>        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
> Reported-by: Howard Spoelstra <hsp.cat7@gmail.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> See http://lists.nongnu.org/archive/html/qemu-devel/2018-07/msg03723.ht=
ml
>=20
>  block/sheepdog.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/block/sheepdog.c b/block/sheepdog.c
> index b229a664d9..5dc3d0c39e 100644
> --- a/block/sheepdog.c
> +++ b/block/sheepdog.c
> @@ -1224,19 +1224,19 @@ static int find_vdi_name(BDRVSheepdogState *s, =
const char *filename,
>      SheepdogVdiReq hdr;
>      SheepdogVdiRsp *rsp =3D (SheepdogVdiRsp *)&hdr;
>      unsigned int wlen, rlen =3D 0;
> -    char buf[SD_MAX_VDI_LEN + SD_MAX_VDI_TAG_LEN];
> +    /* Ensures that the buffer is zero-filled,
> +     * which is desirable since we'll soon be sending those bytes, and
> +     * don't want the send_req to read uninitialized data.
> +     */

I this really necessary? The two g_strlcpy should still fill the whole
buffer, no?

> +    char buf[SD_MAX_VDI_LEN + SD_MAX_VDI_TAG_LEN] =3D { };
> =20
>      fd =3D connect_to_sdog(s, errp);
>      if (fd < 0) {
>          return fd;
>      }
> =20
> -    /* This pair of strncpy calls ensures that the buffer is zero-fill=
ed,
> -     * which is desirable since we'll soon be sending those bytes, and
> -     * don't want the send_req to read uninitialized data.
> -     */
> -    strncpy(buf, filename, SD_MAX_VDI_LEN);
> -    strncpy(buf + SD_MAX_VDI_LEN, tag, SD_MAX_VDI_TAG_LEN);
> +    g_strlcpy(buf, filename, SD_MAX_VDI_LEN);
> +    g_strlcpy(buf + SD_MAX_VDI_LEN, tag, SD_MAX_VDI_TAG_LEN);
> =20
>      memset(&hdr, 0, sizeof(hdr));
>      if (lock) {
>=20


--=20

Thanks,

David / dhildenb
