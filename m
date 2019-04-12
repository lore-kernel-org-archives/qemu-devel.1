Received: from eggs.gnu.org ([209.51.188.92]:42881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hEvRd-0006Vh-LN
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:38:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hEvRb-0003cK-RM
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:38:13 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:43404)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hEvRb-0003aU-3b
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:38:11 -0400
Received: by mail-ot1-x342.google.com with SMTP id u15so8210420otq.10
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 05:38:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190402073018.17747-1-kraxel@redhat.com>
In-Reply-To: <20190402073018.17747-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Apr 2019 13:37:56 +0100
Message-ID: <CAFEAcA8L+qBhSG_6+L60VgA8_P+Eo_VuD1VEELJX2-pfUbFwrA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] curses: fix wchar_t printf warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Tue, 2 Apr 2019 at 08:34, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On some systems wchar_t is "long int", on others just "int".
> So go cast to "long int" and adjust the printf format accordingly.
>
> Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  ui/curses.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/ui/curses.c b/ui/curses.c
> index cc6d6da68463..fb63945188b2 100644
> --- a/ui/curses.c
> +++ b/ui/curses.c
> @@ -453,8 +453,8 @@ static uint16_t get_ucs(wchar_t wch, iconv_t conv)
>      swch = sizeof(wch);
>
>      if (iconv(conv, &pwch, &swch, &pch, &sch) == (size_t) -1) {
> -        fprintf(stderr, "Could not convert 0x%02x from WCHAR_T to UCS-2: %s\n",
> -                        wch, strerror(errno));
> +        fprintf(stderr, "Could not convert 0x%02lx from WCHAR_T to UCS-2: %s\n",
> +                (unsigned long)wch, strerror(errno));
>          return 0xFFFD;
>      }
>

Applied to master since we needed an rc4 for other reasons.

thanks
-- PMM
