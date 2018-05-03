Received: from eggs.gnu.org ([2001:4830:134:3::10]:53695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fEIrh-0003Iq-Qy
	for qemu-devel@nongnu.org; Thu, 03 May 2018 14:22:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fEIre-0000P3-EP
	for qemu-devel@nongnu.org; Thu, 03 May 2018 14:22:01 -0400
Received: from mail-pg0-x22c.google.com ([2607:f8b0:400e:c05::22c]:37619)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fEIre-0000OO-8i
	for qemu-devel@nongnu.org; Thu, 03 May 2018 14:21:58 -0400
Received: by mail-pg0-x22c.google.com with SMTP id a13-v6so13704629pgu.4
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 11:21:58 -0700 (PDT)
References: <20180503091922.28733-1-edgar.iglesias@gmail.com>
	<20180503091922.28733-14-edgar.iglesias@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3c49312e-5e4d-5c9d-0a6a-7f9ca606bd0d@linaro.org>
Date: Thu, 3 May 2018 11:21:54 -0700
MIME-Version: 1.0
In-Reply-To: <20180503091922.28733-14-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 13/29] target-microblaze: Use TCGv for
 load/store addresses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, sai.pavan.boddu@xilinx.com, alistair@alistair23.me, frasse.iglesias@gmail.com, edgar.iglesias@xilinx.com

On 05/03/2018 02:19 AM, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> Use TCGv for load/store addresses, allowing for future
> computation of 64-bit load/store address.
> 
> No functional change.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


>          if (dc->imm == 0) {
> -            tcg_gen_mov_i32(t, cpu_R[dc->ra]);
> -            return;
> +            tcg_gen_mov_i32(t32, cpu_R[dc->ra]);
> +        } else {
> +            tcg_gen_movi_i32(t32, (int32_t)((int16_t)dc->imm));
> +            tcg_gen_add_i32(t32, cpu_R[dc->ra], t32);
>          }

For future cleanup, this should be

  tcg_gen_addi_i32(t32, cpu_R[dc->ra], (int16_t)dc->imm);

The check for 0 will be done inside of tcg_gen_addi_i32.


r~
