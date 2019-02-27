Received: from eggs.gnu.org ([209.51.188.92]:35304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gyx5n-0000QN-V1
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 06:09:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gyx5j-0002vy-HK
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 06:09:37 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:36517)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gyx5h-0002tq-Kr
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 06:09:34 -0500
Received: by mail-wm1-x341.google.com with SMTP id j125so5167033wmj.1
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 03:09:32 -0800 (PST)
References: <20190226193408.23862-1-armbru@redhat.com>
	<20190226193408.23862-3-armbru@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190226193408.23862-3-armbru@redhat.com>
Date: Wed, 27 Feb 2019 11:09:24 +0000
Message-ID: <87sgw9lc7v.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 02/11] pflash_cfi01: Do not exit() on
 guest aborting "write to buffer"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, lersek@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, qemu-ppc@nongnu.org


Markus Armbruster <armbru@redhat.com> writes:

> When a guest tries to abort "write to buffer" (command 0xE8), we print
> "PFLASH: Possible BUG - Write block confirm", then exit(1).  Letting
> the guest terminate QEMU is not a good idea.  Instead, LOG_UNIMP we
> screwed up, then reset the device.
>
> Macro PFLASH_BUG() is now unused; delete it.
>
> Suggested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  hw/block/pflash_cfi01.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
> index a51ac9f399..e6d933a06d 100644
> --- a/hw/block/pflash_cfi01.c
> +++ b/hw/block/pflash_cfi01.c
> @@ -49,12 +49,6 @@
>  #include "sysemu/sysemu.h"
>  #include "trace.h"
>
> -#define PFLASH_BUG(fmt, ...) \
> -do { \
> -    fprintf(stderr, "PFLASH: Possible BUG - " fmt, ## __VA_ARGS__); \
> -    exit(1); \
> -} while(0)
> -
>  /* #define PFLASH_DEBUG */
>  #ifdef PFLASH_DEBUG
>  #define DPRINTF(fmt, ...)                                   \
> @@ -623,8 +617,11 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr of=
fset,
>                  pfl->wcycle =3D 0;
>                  pfl->status |=3D 0x80;
>              } else {
> -                DPRINTF("%s: unknown command for \"write block\"\n", __f=
unc__);
> -                PFLASH_BUG("Write block confirm");
> +                qemu_log_mask(LOG_UNIMP,
> +                    "%s: Aborting write to buffer not implemented,"
> +                    " the data is already written to storage!\n"
> +                    "Flash device reset into READ mode.\n",
> +                    __func__);
>                  goto reset_flash;
>              }
>              break;


--
Alex Benn=C3=A9e
