Received: from eggs.gnu.org ([2001:4830:134:3::10]:58328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1deifR-0004pg-08
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:06:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1deifP-0005yZ-Ql
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:06:01 -0400
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <b750ff8d579d000c010c7465185801cfe8bb7a7d.1502109078.git.jcody@redhat.com>
References: <cover.1502109078.git.jcody@redhat.com>
	<b750ff8d579d000c010c7465185801cfe8bb7a7d.1502109078.git.jcody@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philippe@mathieu-daude.net>
Date: Mon, 7 Aug 2017 11:05:56 -0300
Message-ID: <CAAdtpL5evTV7OSNsgtNYc0oCkwYqywYoSDAECXDmf6a_xUWYAg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 for-2.10 2/4] block/vhdx: check for
 offset overflow to bdrv_truncate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

On Mon, Aug 7, 2017 at 9:38 AM, Jeff Cody <jcody@redhat.com> wrote:
> VHDX uses uint64_t types for most offsets, following the VHDX spec.
> However, bdrv_truncate() takes an int64_t value for the truncating
> offset.  Check for overflow before calling bdrv_truncate().
>
> While we are here, replace the bit shifting with QEMU_ALIGN_UP as well.
>
> N.B.: For a compliant image this is not an issue, as the maximum VHDX
> image size is defined per the spec to be 64TB.
>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Jeff Cody <jcody@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

> ---
>  block/vhdx-log.c | 6 +++++-
>  block/vhdx.c     | 3 +++
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/block/vhdx-log.c b/block/vhdx-log.c
> index 2e26fd4..9597223 100644
> --- a/block/vhdx-log.c
> +++ b/block/vhdx-log.c
> @@ -553,7 +553,11 @@ static int vhdx_log_flush(BlockDriverState *bs, BDRV=
VHDXState *s,
>              new_file_size =3D desc_entries->hdr.last_file_offset;
>              if (new_file_size % (1024*1024)) {
>                  /* round up to nearest 1MB boundary */
> -                new_file_size =3D ((new_file_size >> 20) + 1) << 20;
> +                new_file_size =3D QEMU_ALIGN_UP(new_file_size, MiB);
> +                if (new_file_size > INT64_MAX) {
> +                    ret =3D -EINVAL;
> +                    goto exit;
> +                }
>                  bdrv_truncate(bs->file, new_file_size, PREALLOC_MODE_OFF=
, NULL);
>              }
>          }
> diff --git a/block/vhdx.c b/block/vhdx.c
> index 37224b8..7ae4589 100644
> --- a/block/vhdx.c
> +++ b/block/vhdx.c
> @@ -1177,6 +1177,9 @@ static int vhdx_allocate_block(BlockDriverState *bs=
, BDRVVHDXState *s,
>
>      /* per the spec, the address for a block is in units of 1MB */
>      *new_offset =3D ROUND_UP(*new_offset, 1024 * 1024);
> +    if (*new_offset > INT64_MAX) {
> +        return -EINVAL;
> +    }
>
>      return bdrv_truncate(bs->file, *new_offset + s->block_size,
>                           PREALLOC_MODE_OFF, NULL);
> --
> 2.9.4
>
>
