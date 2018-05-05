Received: from eggs.gnu.org ([2001:4830:134:3::10]:40619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fEwML-0008MC-Ok
	for qemu-devel@nongnu.org; Sat, 05 May 2018 08:32:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fEwMI-0008Jg-Md
	for qemu-devel@nongnu.org; Sat, 05 May 2018 08:32:17 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:36565)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1fEwMI-0008IV-D9
	for qemu-devel@nongnu.org; Sat, 05 May 2018 08:32:14 -0400
Received: by mail-lf0-x242.google.com with SMTP id w8-v6so34571259lfe.3
	for <qemu-devel@nongnu.org>; Sat, 05 May 2018 05:32:14 -0700 (PDT)
Date: Sat, 5 May 2018 14:32:10 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <20180505123210.iq6abx5mhp62acdz@toto>
References: <20180503091922.28733-1-edgar.iglesias@gmail.com>
	<20180503091922.28733-14-edgar.iglesias@gmail.com>
	<3c49312e-5e4d-5c9d-0a6a-7f9ca606bd0d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c49312e-5e4d-5c9d-0a6a-7f9ca606bd0d@linaro.org>
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
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, sai.pavan.boddu@xilinx.com, alistair@alistair23.me, frasse.iglesias@gmail.com, edgar.iglesias@xilinx.com

On Thu, May 03, 2018 at 11:21:54AM -0700, Richard Henderson wrote:
> On 05/03/2018 02:19 AM, Edgar E. Iglesias wrote:
> > From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> > 
> > Use TCGv for load/store addresses, allowing for future
> > computation of 64-bit load/store address.
> > 
> > No functional change.
> > 
> > Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> 
> >          if (dc->imm == 0) {
> > -            tcg_gen_mov_i32(t, cpu_R[dc->ra]);
> > -            return;
> > +            tcg_gen_mov_i32(t32, cpu_R[dc->ra]);
> > +        } else {
> > +            tcg_gen_movi_i32(t32, (int32_t)((int16_t)dc->imm));
> > +            tcg_gen_add_i32(t32, cpu_R[dc->ra], t32);
> >          }
> 
> For future cleanup, this should be
> 
>   tcg_gen_addi_i32(t32, cpu_R[dc->ra], (int16_t)dc->imm);
> 
> The check for 0 will be done inside of tcg_gen_addi_i32.


Thanks, I've added a follow-up patch that cleans this up in v2 of this series.

Cheers,
Edgar
