Received: from eggs.gnu.org ([209.51.188.92]:52932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hLZVC-0002Jh-RO
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 16:37:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hLZUw-0003qI-QM
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 16:37:07 -0400
References: <cover.1556650594.git.alistair.francis@wdc.com>
	<6bfa446eb7c351b5d867eb4158198231af724b11.1556650594.git.alistair.francis@wdc.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <d4dd0758-64af-e249-1f1b-b52af014b404@vivier.eu>
Date: Tue, 30 Apr 2019 22:36:44 +0200
MIME-Version: 1.0
In-Reply-To: <6bfa446eb7c351b5d867eb4158198231af724b11.1556650594.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 5/5] linux-user/elfload: Fix GCC 9 build
 warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alistair23@gmail.com" <alistair23@gmail.com>, "kraxel@redhat.com" <kraxel@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>

Le 30/04/2019 à 22:09, Alistair Francis a écrit :
> Fix this warning when building with GCC9 on Fedora 30:
> In function ‘strncpy’,
>     inlined from ‘fill_psinfo’ at /home/alistair/qemu/linux-user/elfload.c:3208:12,
>     inlined from ‘fill_note_info’ at /home/alistair/qemu/linux-user/elfload.c:3390:5,
>     inlined from ‘elf_core_dump’ at /home/alistair/qemu/linux-user/elfload.c:3539:9:
> /usr/include/bits/string_fortified.h:106:10: error: ‘__builtin_strncpy’ specified bound 16 equals destination size [-Werror=stringop-truncation]
>   106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (__dest));
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  linux-user/elfload.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index c1a26021f8..cbb7fc10fa 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -3206,7 +3206,7 @@ static int fill_psinfo(struct target_elf_prpsinfo *psinfo, const TaskState *ts)

       /*
        * Using strncpy here is fine: at max-length,
>       * this field is not NUL-terminated.
>       */>      (void) strncpy(psinfo->pr_fname, base_filename,
> -                   sizeof(psinfo->pr_fname));
> +                   sizeof(psinfo->pr_fname) - 1);

Read the comment above :)

>  
>      g_free(base_filename);
>      bswap_psinfo(psinfo);
> @@ -3389,7 +3389,7 @@ static int fill_note_info(struct elf_note_info *info,
>                sizeof (*info->prstatus), info->prstatus);
>      fill_psinfo(info->psinfo, ts);
>      fill_note(&info->notes[1], "CORE", NT_PRPSINFO,
> -              sizeof (*info->psinfo), info->psinfo);
> +              sizeof(*info->psinfo) - 1, info->psinfo);

Why?

>      fill_auxv_note(&info->notes[2], ts);
>      info->numnote = 3;
>  
> 

Thanks,
Laurent
