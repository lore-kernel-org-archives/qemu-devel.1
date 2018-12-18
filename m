Received: from eggs.gnu.org ([2001:4830:134:3::10]:43315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZOUn-0003ZM-2V
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:09:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZOUm-0007er-0j
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:09:48 -0500
Date: Tue, 18 Dec 2018 18:09:28 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181218180846-mutt-send-email-mst@kernel.org>
References: <20181218175122.3229-1-philmd@redhat.com>
	<20181218175122.3229-3-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181218175122.3229-3-philmd@redhat.com>
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
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, qemu-block@nongnu.org, 1803872@bugs.launchpad.net, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Howard Spoelstra <hsp.cat7@gmail.com>, Jeff Cody <jcody@redhat.com>, David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Ben Pye <ben@curlybracket.co.uk>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Liu Yuan <namei.unix@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Max Reitz <mreitz@redhat.com>

On Tue, Dec 18, 2018 at 06:51:19PM +0100, Philippe Mathieu-Daud=E9 wrote:
> GCC 8 added a -Wstringop-truncation warning:
>=20
>   The -Wstringop-truncation warning added in GCC 8.0 via r254630 for
>   bug 81117 is specifically intended to highlight likely unintended
>   uses of the strncpy function that truncate the terminating NUL
>   character from the source string.
>=20
> This new warning leads to compilation failures:
>=20
>     CC      block/sheepdog.o
>   qemu/block/sheepdog.c: In function 'find_vdi_name':
>   qemu/block/sheepdog.c:1239:5: error: 'strncpy' specified bound 256 eq=
uals destination size [-Werror=3Dstringop-truncation]
>        strncpy(buf + SD_MAX_VDI_LEN, tag, SD_MAX_VDI_TAG_LEN);
>        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   make: *** [qemu/rules.mak:69: block/sheepdog.o] Error 1
>=20
> As described previous to the strncpy() calls, the use of strncpy() is
> correct here:
>=20
>     /* This pair of strncpy calls ensures that the buffer is zero-fille=
d,
>      * which is desirable since we'll soon be sending those bytes, and
>      * don't want the send_req to read uninitialized data.
>      */
>     strncpy(buf, filename, SD_MAX_VDI_LEN);
>     strncpy(buf + SD_MAX_VDI_LEN, tag, SD_MAX_VDI_TAG_LEN);
>=20
> Use the QEMU_NONSTRING attribute, since this array is intended to store
> character arrays that do not necessarily contain a terminating NUL.
>=20
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  block/sheepdog.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/block/sheepdog.c b/block/sheepdog.c
> index 0125df9d49..d4ad6b119d 100644
> --- a/block/sheepdog.c
> +++ b/block/sheepdog.c
> @@ -1224,7 +1224,7 @@ static int find_vdi_name(BDRVSheepdogState *s, co=
nst char *filename,
>      SheepdogVdiReq hdr;
>      SheepdogVdiRsp *rsp =3D (SheepdogVdiRsp *)&hdr;
>      unsigned int wlen, rlen =3D 0;
> -    char buf[SD_MAX_VDI_LEN + SD_MAX_VDI_TAG_LEN];
> +    QEMU_NONSTRING char buf[SD_MAX_VDI_LEN + SD_MAX_VDI_TAG_LEN];

In case you decide to respin anyway - this would be
a bit nicer as:
	char buf[SD_MAX_VDI_LEN + SD_MAX_VDI_TAG_LEN] QEMU_NONSTRING




>      fd =3D connect_to_sdog(s, errp);
>      if (fd < 0) {
> --=20
> 2.17.2
