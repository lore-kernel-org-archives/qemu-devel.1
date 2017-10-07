Received: from eggs.gnu.org ([2001:4830:134:3::10]:58267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1e0rIJ-0001n8-Sx
	for qemu-devel@nongnu.org; Sat, 07 Oct 2017 11:45:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1e0rIJ-0004qj-2i
	for qemu-devel@nongnu.org; Sat, 07 Oct 2017 11:45:39 -0400
References: <20171006235023.11952-1-f4bug@amsat.org>
	<20171006235023.11952-14-f4bug@amsat.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <286173de-a624-56c6-4521-576c8a9f97ce@redhat.com>
Date: Sat, 7 Oct 2017 11:45:21 -0400
MIME-Version: 1.0
In-Reply-To: <20171006235023.11952-14-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 13/88] Dirty Bitmaps: use g_new() family of
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu trival <qemu-trivial@nongnu.org>, qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>



On 10/06/2017 07:49 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> [PMD: squashed tests/test-hbitmap.c changes]
> ---
>  tests/test-hbitmap.c | 2 +-
>  util/hbitmap.c       | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/tests/test-hbitmap.c b/tests/test-hbitmap.c
> index af41642346..fea3a64712 100644
> --- a/tests/test-hbitmap.c
> +++ b/tests/test-hbitmap.c
> @@ -122,7 +122,7 @@ static void hbitmap_test_truncate_impl(TestHBitmapD=
ata *data,
> =20
>      n =3D hbitmap_test_array_size(size);
>      m =3D hbitmap_test_array_size(data->old_size);
> -    data->bits =3D g_realloc(data->bits, sizeof(unsigned long) * n);
> +    data->bits =3D g_renew(unsigned long, data->bits, n);
>      if (n > m) {
>          memset(&data->bits[m], 0x00, sizeof(unsigned long) * (n - m));
>      }
> diff --git a/util/hbitmap.c b/util/hbitmap.c
> index 2f9d0fdbd0..4eb0188836 100644
> --- a/util/hbitmap.c
> +++ b/util/hbitmap.c
> @@ -668,7 +668,7 @@ void hbitmap_truncate(HBitmap *hb, uint64_t size)
>          }
>          old =3D hb->sizes[i];
>          hb->sizes[i] =3D size;
> -        hb->levels[i] =3D g_realloc(hb->levels[i], size * sizeof(unsig=
ned long));
> +        hb->levels[i] =3D g_renew(unsigned long, hb->levels[i], size);
>          if (!shrink) {
>              memset(&hb->levels[i][old], 0x00,
>                     (size - old) * sizeof(*hb->levels[i]));
>=20

Hm, I guess g_renew() isn't a new addition to glib, and we can safely
use it.

Reviewed-by: John Snow <jsnow@redhat.com>

And for convenience, this can be staged by whomever wishes to stage the
whole 88 patch enchilada:

Acked-by: John Snow <jsnow@redhat.com>
