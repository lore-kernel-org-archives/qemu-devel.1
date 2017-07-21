Received: from eggs.gnu.org ([2001:4830:134:3::10]:53214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dYgZ8-0004LH-4T
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 18:38:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dYgZ5-00087M-1Q
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 18:38:34 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:39755)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dYgZ4-000874-Pe
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 18:38:30 -0400
Date: Fri, 21 Jul 2017 18:38:29 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170721223829.GJ10809@flamenco>
References: <20170715094243.28371-1-rth@twiddle.net>
	<20170715094243.28371-5-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170715094243.28371-5-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v14 04/34] target/arm: Use DISAS_NORETURN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, vilanova@ac.upc.edu, alex.bennee@linaro.org, crosthwaite.peter@gmail.com, pbonzini@redhat.com

On Fri, Jul 14, 2017 at 23:42:13 -1000, Richard Henderson wrote:
> Fold DISAS_EXC and DISAS_TB_JUMP into DISAS_NORETURN.
> 
> In both cases all following code is dead.  In the first
> case because we have exited the TB via exception; in the
> second case because we have exited the TB via goto_tb
> and its associated machinery.
> 
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/arm/translate.h     |  8 ++------
>  target/arm/translate-a64.c | 37 ++++++++++++++++++++-----------------
>  target/arm/translate.c     | 15 ++++++++-------
>  3 files changed, 30 insertions(+), 30 deletions(-)
> 
(snip)
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index e80cc35..fea76fb 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
(snip)
> @@ -12081,6 +12081,8 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
>          default:
>              /* FIXME: Single stepping a WFI insn will not halt the CPU. */
>              gen_singlestep_exception(dc);
> +        case DISAS_NORETURN:
> +            break;

Missing '/* fall-through */' above 'case DISAS_NORETURN'. Or just 'break' as
we otherwise end up doing in patch 26.

		E.
