Received: from eggs.gnu.org ([209.51.188.92]:56774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1go4nX-00068K-Dn
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 06:09:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1go4nW-0005az-Pf
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 06:09:51 -0500
MIME-Version: 1.0
References: <20190125182626.9221-1-peter.maydell@linaro.org>
	<20190125182626.9221-2-peter.maydell@linaro.org>
In-Reply-To: <20190125182626.9221-2-peter.maydell@linaro.org>
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Mon, 28 Jan 2019 12:09:39 +0100
Message-ID: <CABoDooPvj56h=3kkT80afx6FGGnS8fNqWNxouhX8xSBQ79pf7w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/7] target/arm/translate-a64: Don't
 underdecode system instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Patch Tracking <patches@linaro.org>

On Fri, Jan 25, 2019 at 7:26 PM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The "system instructions" and "system register move" subcategories
> of "branches, exception generating and system instructions" for A64
> only apply if bits [23:22] are zero; other values are currently
> unallocated. Correctly UNDEF these unallocated encodings.
>
> Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Laurent Desnogues <laurent.desnogues@gmail.com>

Thanks,

Laurent

> ---
>  target/arm/translate-a64.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 4d28a27c3bd..e6df303e321 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -2144,7 +2144,11 @@ static void disas_b_exc_sys(DisasContext *s, uint32_t insn)
>          break;
>      case 0x6a: /* Exception generation / System */
>          if (insn & (1 << 24)) {
> -            disas_system(s, insn);
> +            if (extract32(insn, 22, 2) == 0) {
> +                disas_system(s, insn);
> +            } else {
> +                unallocated_encoding(s);
> +            }
>          } else {
>              disas_exc(s, insn);
>          }
> --
> 2.20.1
>
