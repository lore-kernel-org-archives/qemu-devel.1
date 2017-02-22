Received: from eggs.gnu.org ([2001:4830:134:3::10]:37586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cgaaR-0004Ip-HY
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 12:20:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cgaaO-0002ku-VN
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 12:20:19 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <1487763883-4877-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1487763883-4877-4-git-send-email-nikunj@linux.vnet.ibm.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <913ec2bb-2fd4-3488-e142-75d3574dfaf1@twiddle.net>
Date: Thu, 23 Feb 2017 04:20:08 +1100
MIME-Version: 1.0
In-Reply-To: <1487763883-4877-4-git-send-email-nikunj@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 03/10] target/ppc: support for 32-bit
 carry and overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Cc: qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com

Bah.  Hit return too soon...

On 02/22/2017 10:44 PM, Nikunj A Dadhania wrote:
> -static void gen_read_xer(TCGv dst)
> +static void gen_read_xer(DisasContext *ctx, TCGv dst)
>  {
>      TCGv t0 = tcg_temp_new();
>      TCGv t1 = tcg_temp_new();
> @@ -3715,15 +3719,30 @@ static void gen_read_xer(TCGv dst)
>      tcg_gen_or_tl(t0, t0, t1);
>      tcg_gen_or_tl(dst, dst, t2);
>      tcg_gen_or_tl(dst, dst, t0);
> +    if (is_isa300(ctx)) {
> +        tcg_gen_shli_tl(t0, cpu_ov32, XER_OV32);
> +        tcg_gen_or_tl(dst, dst, t0);
> +        tcg_gen_shli_tl(t0, cpu_ca32, XER_CA32);
> +        tcg_gen_or_tl(dst, dst, t0);
> +    }
>      tcg_temp_free(t0);
>      tcg_temp_free(t1);
>      tcg_temp_free(t2);
>  }
>
> -static void gen_write_xer(TCGv src)
> +static void gen_write_xer(DisasContext *ctx, TCGv src)
>  {
> -    tcg_gen_andi_tl(cpu_xer, src,
> -                    ~((1u << XER_SO) | (1u << XER_OV) | (1u << XER_CA)));
> +    if (is_isa300(ctx)) {
> +        tcg_gen_andi_tl(cpu_xer, src,
> +                        ~((1u << XER_SO) |
> +                          (1u << XER_OV) | (1u << XER_OV32) |
> +                          (1u << XER_CA) | (1u << XER_CA32)));
> +        tcg_gen_extract_tl(cpu_ov32, src, XER_OV32, 1);
> +        tcg_gen_extract_tl(cpu_ca32, src, XER_CA32, 1);
> +    } else {
> +        tcg_gen_andi_tl(cpu_xer, src,
> +                        ~((1u << XER_SO) | (1u << XER_OV) | (1u << XER_CA)));
> +    }
>      tcg_gen_extract_tl(cpu_so, src, XER_SO, 1);
>      tcg_gen_extract_tl(cpu_ov, src, XER_OV, 1);
>      tcg_gen_extract_tl(cpu_ca, src, XER_CA, 1);

These functions are becoming quite large.  Are they performance critical enough 
that they need to stay as inline code, or should they be moved to helpers and 
share code with cpu_read/write_xer?


r~
