Received: from eggs.gnu.org ([2001:4830:134:3::10]:46285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cJI0Z-0001nE-6U
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 05:51:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cJI0X-0004qf-LM
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 05:50:59 -0500
Received: from mail-yb0-x244.google.com ([2607:f8b0:4002:c09::244]:35231)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cJI0X-0004qA-F1
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 05:50:57 -0500
Received: by mail-yb0-x244.google.com with SMTP id d59so1075443ybi.2
	for <qemu-devel@nongnu.org>; Tue, 20 Dec 2016 02:50:57 -0800 (PST)
MIME-Version: 1.0
References: <1482156623-9111-1-git-send-email-peterx@redhat.com>
	<1482156623-9111-2-git-send-email-peterx@redhat.com>
In-Reply-To: <1482156623-9111-2-git-send-email-peterx@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 20 Dec 2016 10:50:45 +0000
Message-ID: <CAJ+F1CLyx97pFp=7tsmUeRPAJ03zWsOdZXMGUdiALC5tUBHhoA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] memory: provide common macros for
 mtree_print_mr()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com

Hi

On Mon, Dec 19, 2016 at 3:11 PM Peter Xu <peterx@redhat.com> wrote:

> mtree_print_mr() has some common codes. Generalize it.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  memory.c | 34 +++++++++++++++-------------------
>  1 file changed, 15 insertions(+), 19 deletions(-)
>
> diff --git a/memory.c b/memory.c
> index 33110e9..5dcc2e1 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -2450,6 +2450,13 @@ struct MemoryRegionList {
>
>  typedef QTAILQ_HEAD(queue, MemoryRegionList) MemoryRegionListHead;
>
> +#define MR_CHAR_RD(mr) ((mr)->romd_mode ? 'R' : '-')
> +#define MR_CHAR_WR(mr) (!(mr)->readonly && !((mr)->rom_device && \
> +                                             (mr)->romd_mode) ? 'W' : '-=
')
> +#define MR_SIZE(size) (int128_nz(size) ? (hwaddr)int128_get64( \
> +                           int128_sub((size), int128_one())) : 0)
> +#define MTREE_INDENT "  "
> +
>  static void mtree_print_mr(fprintf_function mon_printf, void *f,
>                             const MemoryRegion *mr, unsigned int level,
>                             hwaddr base,
> @@ -2465,7 +2472,7 @@ static void mtree_print_mr(fprintf_function
> mon_printf, void *f,
>      }
>
>      for (i =3D 0; i < level; i++) {
> -        mon_printf(f, "  ");
> +        mon_printf(f, MTREE_INDENT);
>

This one is perhaps superfluous


>      }
>
>      if (mr->alias) {
> @@ -2488,34 +2495,23 @@ static void mtree_print_mr(fprintf_function
> mon_printf, void *f,
>                     " (prio %d, %c%c): alias %s @%s " TARGET_FMT_plx
>                     "-" TARGET_FMT_plx "%s\n",
>                     base + mr->addr,
> -                   base + mr->addr
> -                   + (int128_nz(mr->size) ?
> -                      (hwaddr)int128_get64(int128_sub(mr->size,
> -                                                      int128_one())) : 0=
),
> +                   base + mr->addr + MR_SIZE(mr->size),
>                     mr->priority,
> -                   mr->romd_mode ? 'R' : '-',
> -                   !mr->readonly && !(mr->rom_device && mr->romd_mode) ?
> 'W'
> -                                                                       :
> '-',
> +                   MR_CHAR_RD(mr),
> +                   MR_CHAR_WR(mr),
>                     memory_region_name(mr),
>                     memory_region_name(mr->alias),
>                     mr->alias_offset,
> -                   mr->alias_offset
> -                   + (int128_nz(mr->size) ?
> -                      (hwaddr)int128_get64(int128_sub(mr->size,
> -                                                      int128_one())) : 0=
),
> +                   mr->alias_offset + MR_SIZE(mr->size),
>                     mr->enabled ? "" : " [disabled]");
>      } else {
>          mon_printf(f,
>                     TARGET_FMT_plx "-" TARGET_FMT_plx " (prio %d, %c%c):
> %s%s\n",
>                     base + mr->addr,
> -                   base + mr->addr
> -                   + (int128_nz(mr->size) ?
> -                      (hwaddr)int128_get64(int128_sub(mr->size,
> -                                                      int128_one())) : 0=
),
> +                   base + mr->addr + MR_SIZE(mr->size),
>                     mr->priority,
> -                   mr->romd_mode ? 'R' : '-',
> -                   !mr->readonly && !(mr->rom_device && mr->romd_mode) ?
> 'W'
> -                                                                       :
> '-',
> +                   MR_CHAR_RD(mr),
> +                   MR_CHAR_WR(mr),
>                     memory_region_name(mr),
>                     mr->enabled ? "" : " [disabled]");
>      }
> --
>


looks good,


Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


--=20
Marc-Andr=C3=A9 Lureau
