Received: from eggs.gnu.org ([2001:4830:134:3::10]:39654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1coU8k-0003jG-8B
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 08:04:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1coU8f-00069u-B1
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 08:04:22 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:37937)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1coU8f-00068Z-4C
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 08:04:17 -0400
Received: by mail-wm0-x229.google.com with SMTP id t189so45862051wmt.1
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 05:04:16 -0700 (PDT)
References: <1489638621-31978-1-git-send-email-rimjhim0107@gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1489638621-31978-1-git-send-email-rimjhim0107@gmail.com>
Date: Thu, 16 Mar 2017 12:04:34 +0000
Message-ID: <874lytpgvh.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] puv3: always compile-check debug printf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anishka0107 <rimjhim0107@gmail.com>
Cc: jsnow@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org


Anishka0107 <rimjhim0107@gmail.com> writes:

>     To prevent bitrot of the format string of the debug statement, files with
>   conditional debug statements should ensure that printf is compiled always,
>   and enclosed within if(0) statements and not in #ifdef.
>
> Signed-off-by: Anishka Gupta <rimjhim0107@gmail.com>
> ---
>  include/hw/unicore32/puv3.h | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/include/hw/unicore32/puv3.h b/include/hw/unicore32/puv3.h
> index 5a4839f..e268484 100644
> --- a/include/hw/unicore32/puv3.h
> +++ b/include/hw/unicore32/puv3.h
> @@ -41,10 +41,14 @@
>  #define PUV3_IRQS_OST0          (26)
>
>  /* All puv3_*.c use DPRINTF for debug. */
> -#ifdef DEBUG_PUV3
> -#define DPRINTF(fmt, ...) printf("%s: " fmt , __func__, ## __VA_ARGS__)
> -#else
> -#define DPRINTF(fmt, ...) do {} while (0)
> -#endif
> +#define DEBUG_PUV3 0
> +
> +#define DPRINTF(fmt, ...)
> +    if (DEBUG_PUV3) {
> +        fprintf(stderr, "%s: " fmt , __func__, ## __VA_ARGS__)
> +    }
> +    else {
> +        do {} while (0)
> +    }

This is incorrect. It's fine not to have an else leg as the compiler
will dead-code away the if (0) part. However you still need to wrap in a
do {} while to avoid problems with trailing ;'s. Also you need line
continuations for defining macros.

Did you actually compile test this patch? I suspect it wouldn't build
due to the missing ;s for your fprintf and do while.

See hw/misc/imx6_src.c for a debug printf I recently converted.

>
>  #endif /* QEMU_HW_PUV3_H */


--
Alex Bennée
