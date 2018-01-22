Received: from eggs.gnu.org ([2001:4830:134:3::10]:44099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1edgx6-0000Ba-F6
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 13:36:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1edgx5-0005GA-Kg
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 13:36:16 -0500
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:43254)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1edgx5-0005FI-GS
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 13:36:15 -0500
Received: by mail-oi0-x243.google.com with SMTP id t16so6630747oif.10
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 10:36:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180117161435.28981-2-richard.henderson@linaro.org>
References: <20180117161435.28981-1-richard.henderson@linaro.org>
	<20180117161435.28981-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jan 2018 18:35:54 +0000
Message-ID: <CAFEAcA-TfkUUP8C1u_WiPhQj+seMBER-MkcHXBOai4Yt27pCsw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v10.5 01/20] tcg: Allow multiple word
 entries into the constant pool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 17 January 2018 at 16:14, Richard Henderson
<richard.henderson@linaro.org> wrote:
> This will be required for storing vector constants.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/tcg-pool.inc.c | 115 +++++++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 93 insertions(+), 22 deletions(-)
>
> diff --git a/tcg/tcg-pool.inc.c b/tcg/tcg-pool.inc.c
> index 8a85131405..0f76e7bee3 100644
> --- a/tcg/tcg-pool.inc.c
> +++ b/tcg/tcg-pool.inc.c
> @@ -22,39 +22,110 @@
>
>  typedef struct TCGLabelPoolData {
>      struct TCGLabelPoolData *next;
> -    tcg_target_ulong data;
>      tcg_insn_unit *label;
> -    intptr_t addend;
> -    int type;
> +    int addend  : 32;
> +    int rtype   : 16;
> +    int nlong   : 16;
> +    tcg_target_ulong data[];
>  } TCGLabelPoolData;
>

Seems a bit odd to use bitfields for 32 and 16 bit values, but whatever.
(My default reaction to bitfields is "be suspicious" :-))

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
