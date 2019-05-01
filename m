Received: from eggs.gnu.org ([209.51.188.92]:58823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hLscm-00035C-VP
	for qemu-devel@nongnu.org; Wed, 01 May 2019 13:02:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hLscj-00089C-T6
	for qemu-devel@nongnu.org; Wed, 01 May 2019 13:02:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46942)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1hLscj-00084L-He
	for qemu-devel@nongnu.org; Wed, 01 May 2019 13:02:25 -0400
References: <20190501170125.10244-1-brogers@suse.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <762726a2-22cd-103e-6cb8-728c4abf71bf@redhat.com>
Date: Wed, 1 May 2019 13:02:23 -0400
MIME-Version: 1.0
In-Reply-To: <20190501170125.10244-1-brogers@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] scsi-disk: assert positive value to avoid
 compiler warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bruce Rogers <brogers@suse.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, fam@euphon.net, eblake@redhat.com



On 5/1/19 1:01 PM, Bruce Rogers wrote:
> While investigating link-time-optimization, the compiler complained as
> follows:
> In function =E2=80=98scsi_disk_new_request_dump=E2=80=99,
>     inlined from =E2=80=98scsi_new_request.part.24=E2=80=99 at hw/scsi/=
scsi-disk.c:2549:9,
>     inlined from =E2=80=98scsi_new_request=E2=80=99 at hw/scsi/scsi-dis=
k.c:2533:21:
> hw/scsi/scsi-disk.c:2523:19: error: argument 1 value =E2=80=98184467440=
73709551612=E2=80=99 exceeds maximum object size 9223372036854775807 [-We=
rror=3Dalloc-size-larger-than=3D]
> hw/scsi/scsi-disk.c: In function =E2=80=98scsi_new_request=E2=80=99:
> /usr/include/glib-2.0/glib/gmem.h:78:10: note: in a call to allocation =
function =E2=80=98g_malloc=E2=80=99 declared here
>  gpointer g_malloc         (gsize  n_bytes) G_GNUC_MALLOC G_GNUC_ALLOC_=
SIZE(1);
>=20
> Asserting that len is positive avoids this diagnostic. This assert is
> reasonable since the error case of scsi_cdb_length() has already been
> handled by a previous call to that function.
>=20
> Signed-off-by: Bruce Rogers <brogers@suse.com>
> ---
>  hw/scsi/scsi-disk.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> index e7e865ab3b..ac180fdddf 100644
> --- a/hw/scsi/scsi-disk.c
> +++ b/hw/scsi/scsi-disk.c
> @@ -2520,6 +2520,7 @@ static void scsi_disk_new_request_dump(uint32_t l=
un, uint32_t tag, uint8_t *buf)
>      int len =3D scsi_cdb_length(buf);
>      char *line_buffer, *p;
> =20
> +    assert(len > 0);
>      line_buffer =3D g_malloc(len * 5 + 1);
> =20
>      for (i =3D 0, p =3D line_buffer; i < len; i++) {
>=20

Reviewed-by: John Snow <jsnow@redhat.com>
