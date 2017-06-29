Received: from eggs.gnu.org ([2001:4830:134:3::10]:56889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dQiMI-0001yk-NS
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 18:56:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dQiME-0006PC-1Q
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 18:56:22 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:48945)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dQiMD-0006P2-UN
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 18:56:17 -0400
Date: Thu, 29 Jun 2017 18:56:16 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170629225616.GB13979@flamenco>
References: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
	<149865268422.17063.3930054464827416476.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <149865268422.17063.3930054464827416476.stgit@frigg.lan>
Subject: Re: [Qemu-devel] [PATCH v11 02/29] cpu-exec: Avoid global variables
 in icount-related functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>
Cc: qemu-devel@nongnu.org, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

On Wed, Jun 28, 2017 at 15:24:44 +0300, Lluís Vilanova wrote:
> Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
> ---
(snip)
> @@ -62,14 +62,14 @@ static void gen_tb_end(TranslationBlock *tb, int num_insns)
>  static inline void gen_io_start(void)
>  {
>      TCGv_i32 tmp = tcg_const_i32(1);
> -    tcg_gen_st_i32(tmp, cpu_env, -ENV_OFFSET + offsetof(CPUState, can_do_io));
> +    tcg_gen_st_i32(tmp, tcg_ctx.tcg_env, -ENV_OFFSET + offsetof(CPUState, can_do_io));
>      tcg_temp_free_i32(tmp);
>  }
>  
>  static inline void gen_io_end(void)
>  {
>      TCGv_i32 tmp = tcg_const_i32(0);
> -    tcg_gen_st_i32(tmp, cpu_env, -ENV_OFFSET + offsetof(CPUState, can_do_io));
> +    tcg_gen_st_i32(tmp, tcg_ctx.tcg_env, -ENV_OFFSET + offsetof(CPUState, can_do_io));
>      tcg_temp_free_i32(tmp);

If you break these long lines as in this patch, you'll avoid a merge
conflict with it (it's been queued):
  [PATCH v2 2/2] gen-icount: use tcg_ctx.tcg_env instead of cpu_env
  https://patchwork.kernel.org/patch/9793381/

Or just pick up that patch verbatim.

		E.
