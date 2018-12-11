Received: from eggs.gnu.org ([2001:4830:134:3::10]:33190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gWk16-0005hk-Ox
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:32:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gWk15-0004IS-SG
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:32:12 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:45900)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gWk15-0004Hm-Ky
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:32:11 -0500
Received: by mail-ot1-x344.google.com with SMTP id 32so14351440ota.12
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 07:32:11 -0800 (PST)
MIME-Version: 1.0
References: <20181207103631.28193-1-richard.henderson@linaro.org>
	<20181207103631.28193-9-richard.henderson@linaro.org>
In-Reply-To: <20181207103631.28193-9-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Dec 2018 15:31:59 +0000
Message-ID: <CAFEAcA_aQ3osVWvwzhnW2Z1QwtRaKVyzKmyOnVhjRwhQpJqL5g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 08/26] target/arm: Decode PAuth within
 disas_data_proc_2src
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>

On Fri, 7 Dec 2018 at 10:36, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate-a64.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 7ba4c996cf..d034a5edf3 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -4884,6 +4884,13 @@ static void disas_data_proc_2src(DisasContext *s, uint32_t insn)
>      case 11: /* RORV */
>          handle_shift_reg(s, A64_SHIFT_TYPE_ROR, sf, rm, rn, rd);
>          break;
> +    case 12: /* PACGA */
> +        if (sf == 0 || !dc_isar_feature(aa64_pauth, s)) {
> +            goto do_unallocated;
> +        }
> +        gen_helper_pacga(cpu_reg(s, rd), cpu_env,
> +                         cpu_reg(s, rn), cpu_reg_sp(s, rm));
> +        break;
>      case 16:
>      case 17:
>      case 18:
> @@ -4899,6 +4906,7 @@ static void disas_data_proc_2src(DisasContext *s, uint32_t insn)
>          break;
>      }
>      default:
> +    do_unallocated:
>          unallocated_encoding(s);
>          break;
>      }

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
