Received: from eggs.gnu.org ([209.51.188.92]:53817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNMKl-0001Iw-Ol
	for qemu-devel@nongnu.org; Sun, 05 May 2019 14:58:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNMKk-0001xE-Qw
	for qemu-devel@nongnu.org; Sun, 05 May 2019 14:57:59 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38582)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hNMKk-0001tT-K3
	for qemu-devel@nongnu.org; Sun, 05 May 2019 14:57:58 -0400
Received: by mail-wm1-f68.google.com with SMTP id f2so7670435wmj.3
	for <qemu-devel@nongnu.org>; Sun, 05 May 2019 11:57:58 -0700 (PDT)
References: <20190426162624.55977-1-stephen.checkoway@oberlin.edu>
	<20190426162624.55977-11-stephen.checkoway@oberlin.edu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1bad21e0-93ba-279a-4bec-9b1f2204184d@redhat.com>
Date: Sun, 5 May 2019 20:57:54 +0200
MIME-Version: 1.0
In-Reply-To: <20190426162624.55977-11-stephen.checkoway@oberlin.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 10/10] block/pflash_cfi02: Use the chip
 erase time specified in the CFI table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stephen Checkoway <stephen.checkoway@oberlin.edu>, QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 4/26/19 6:26 PM, Stephen Checkoway wrote:
> When erasing the chip, use the typical time specified in the CFI table
> rather than arbitrarily selecting 5 seconds.
> 
> Since the currently unconfigurable value set in the table is 12, this
> means a chip erase takes 4096 ms so this isn't a big change in behavior.
> 
> Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
> ---
>  hw/block/pflash_cfi02.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
> index d9087cafff..76c8af4365 100644
> --- a/hw/block/pflash_cfi02.c
> +++ b/hw/block/pflash_cfi02.c
> @@ -633,9 +633,9 @@ static void pflash_write(void *opaque, hwaddr offset, uint64_t value,
>                  pflash_update(pfl, 0, pfl->total_len);
>              }
>              set_dq7(pfl, 0x00);
> -            /* Let's wait 5 seconds before chip erase is done */
> +            /* Wait the time specified at CFI address 0x22. */
>              timer_mod(&pfl->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
> -                      (NANOSECONDS_PER_SECOND * 5));
> +                      (1ULL << pfl->cfi_table[0x22]) * SCALE_MS);
>              break;
>          case 0x30:
>              /* Sector erase */
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
