Received: from eggs.gnu.org ([2001:4830:134:3::10]:55319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjWVp-0001z5-6g
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:35:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjWVo-0002zH-Au
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:35:41 -0500
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:33436)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cjWVo-0002yF-4L
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:35:40 -0500
Received: by mail-wm0-x232.google.com with SMTP id i17so4697029wmf.0
	for <qemu-devel@nongnu.org>; Thu, 02 Mar 2017 11:35:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <42af1728d1f27eab0b20f2474cf0c18a15d94f96.1488068248.git.balaton@eik.bme.hu>
References: <cover.1488068248.git.balaton@eik.bme.hu>
	<42af1728d1f27eab0b20f2474cf0c18a15d94f96.1488068248.git.balaton@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Mar 2017 19:35:16 +0000
Message-ID: <CAFEAcA9pCL-YFqEi-SXFAiAZe3sRT=KK-Vqc87x-d5j7NQST3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2 08/14] sm501: Fix hardware cursor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On 4 December 2016 at 18:01, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Can you say in the commit message what the bugs you're fixing are,
please? Otherwise it's a bit hard to disentangle here what's
just refactoring and what's making behavioural changes.

> ---
>  hw/display/sm501.c          | 169 +++++++++++++++++++++++++-------------------
>  hw/display/sm501_template.h |  25 +++----
>  2 files changed, 107 insertions(+), 87 deletions(-)
>
> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
> index 2694081..c4bdc50 100644
> --- a/hw/display/sm501.c
> +++ b/hw/display/sm501.c
> @@ -553,6 +553,24 @@ static uint32_t get_local_mem_size_index(uint32_t size)
>      return index;
>  }
>
> +static inline int get_width(SM501State *s, int crt)
> +{
> +    int width = crt ? s->dc_crt_h_total : s->dc_panel_h_total;
> +    return (width & 0x00000FFF) + 1;
> +}
> +
> +static inline int get_height(SM501State *s, int crt)
> +{
> +    int height = crt ? s->dc_crt_v_total : s->dc_panel_v_total;
> +    return (height & 0x00000FFF) + 1;
> +}
> +
> +static inline int get_bpp(SM501State *s, int crt)
> +{
> +    int bpp = crt ? s->dc_crt_control : s->dc_panel_control;
> +    return (8 << (bpp & 3)) / 8;

Isn't this the same as "1 << (bpp & 3)" ?

> +}


thanks
-- PMM
