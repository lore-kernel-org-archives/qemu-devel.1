Received: from eggs.gnu.org ([209.51.188.92]:33996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1goZN6-0004Tp-Jy
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 14:48:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1goZMz-0006pc-SR
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 14:48:33 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:38853)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1goZMx-0006ng-DE
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 14:48:29 -0500
Received: by mail-pl1-x643.google.com with SMTP id e5so9829364plb.5
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 11:48:25 -0800 (PST)
Date: Tue, 29 Jan 2019 11:48:23 -0800 (PST)
In-Reply-To: <20190126230256.10983-1-xi.wang@gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-e609a948-7637-494a-b7f7-8c23c51dd1a1@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] target/riscv: fix counter-enable checks in
 ctr()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, xi.wang@gmail.com, mjc@sifive.com, Alistair Francis <Alistair.Francis@wdc.com>, sagark@eecs.berkeley.edu, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

On Sat, 26 Jan 2019 15:02:56 PST (-0800), xi.wang@gmail.com wrote:
> Access to a counter in U-mode is permitted only if the corresponding
> bit is set in both mcounteren and scounteren.  The current code
> ignores mcounteren and checks scounteren only for U-mode access.
>
> Signed-off-by: Xi Wang <xi.wang@gmail.com>
> ---
>  target/riscv/csr.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 5e7e7d16b8..133f2ff7e2 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -56,9 +56,15 @@ static int fs(CPURISCVState *env, int csrno)
>  static int ctr(CPURISCVState *env, int csrno)
>  {
>  #if !defined(CONFIG_USER_ONLY)
> -    target_ulong ctr_en = env->priv == PRV_U ? env->scounteren :
> -                          env->priv == PRV_S ? env->mcounteren : -1U;
> -    if (!(ctr_en & (1 << (csrno & 31)))) {
> +    uint32_t ctr_en = ~0u;
> +
> +    if (env->priv < PRV_M) {
> +        ctr_en &= env->mcounteren;
> +    }
> +    if (env->priv < PRV_S) {
> +        ctr_en &= env->scounteren;
> +    }
> +    if (!(ctr_en & (1u << (csrno & 31)))) {
>          return -1;
>      }
>  #endif

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

I'll add this to my next PR.
