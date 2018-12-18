Received: from eggs.gnu.org ([2001:4830:134:3::10]:46551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gZK8y-0003nv-HR
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 13:31:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gZK8w-0001Hi-NS
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 13:31:00 -0500
References: <20181218175122.3229-1-philmd@redhat.com>
	<20181218175122.3229-3-philmd@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bb7d361d-091d-4806-d5c4-3954c17a5260@redhat.com>
Date: Tue, 18 Dec 2018 12:30:02 -0600
MIME-Version: 1.0
In-Reply-To: <20181218175122.3229-3-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 2/5] block/sheepdog: Use QEMU_NONSTRING
 for non NUL-terminated arrays
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-block@nongnu.org, 1803872@bugs.launchpad.net, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Howard Spoelstra <hsp.cat7@gmail.com>, Jeff Cody <jcody@redhat.com>, David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Ben Pye <ben@curlybracket.co.uk>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Liu Yuan <namei.unix@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Max Reitz <mreitz@redhat.com>

On 12/18/18 11:51 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> GCC 8 added a -Wstringop-truncation warning:
>=20
>    The -Wstringop-truncation warning added in GCC 8.0 via r254630 for
>    bug 81117 is specifically intended to highlight likely unintended
>    uses of the strncpy function that truncate the terminating NUL
>    character from the source string.
>=20
> This new warning leads to compilation failures:
>=20
>      CC      block/sheepdog.o
>    qemu/block/sheepdog.c: In function 'find_vdi_name':
>    qemu/block/sheepdog.c:1239:5: error: 'strncpy' specified bound 256 e=
quals destination size [-Werror=3Dstringop-truncation]
>         strncpy(buf + SD_MAX_VDI_LEN, tag, SD_MAX_VDI_TAG_LEN);
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    make: *** [qemu/rules.mak:69: block/sheepdog.o] Error 1
>=20
> As described previous to the strncpy() calls, the use of strncpy() is
> correct here:
>=20
>      /* This pair of strncpy calls ensures that the buffer is zero-fill=
ed,
>       * which is desirable since we'll soon be sending those bytes, and
>       * don't want the send_req to read uninitialized data.
>       */
>      strncpy(buf, filename, SD_MAX_VDI_LEN);
>      strncpy(buf + SD_MAX_VDI_LEN, tag, SD_MAX_VDI_TAG_LEN);
>=20
> Use the QEMU_NONSTRING attribute, since this array is intended to store
> character arrays that do not necessarily contain a terminating NUL.
>=20
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>   block/sheepdog.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/block/sheepdog.c b/block/sheepdog.c
> index 0125df9d49..d4ad6b119d 100644
> --- a/block/sheepdog.c
> +++ b/block/sheepdog.c
> @@ -1224,7 +1224,7 @@ static int find_vdi_name(BDRVSheepdogState *s, co=
nst char *filename,
>       SheepdogVdiReq hdr;
>       SheepdogVdiRsp *rsp =3D (SheepdogVdiRsp *)&hdr;
>       unsigned int wlen, rlen =3D 0;
> -    char buf[SD_MAX_VDI_LEN + SD_MAX_VDI_TAG_LEN];
> +    QEMU_NONSTRING char buf[SD_MAX_VDI_LEN + SD_MAX_VDI_TAG_LEN];
>  =20
>       fd =3D connect_to_sdog(s, errp);
>       if (fd < 0) {
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
