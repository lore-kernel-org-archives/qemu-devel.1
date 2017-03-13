Received: from eggs.gnu.org ([2001:4830:134:3::10]:60222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cnPVb-0004x3-Pe
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 08:55:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cnPVW-0003MX-UJ
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 08:55:31 -0400
References: <20170313093104.1280-1-nikunj@linux.vnet.ibm.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <8401331f-bea9-b255-442c-161fd1d0b56e@ilande.co.uk>
Date: Mon, 13 Mar 2017 12:54:55 +0000
MIME-Version: 1.0
In-Reply-To: <20170313093104.1280-1-nikunj@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH fix for-2.9] target/ppc: fix cpu_ov setting
 for 32-bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Cc: qemu-devel@nongnu.org, rth@twiddle.net

On 13/03/17 09:31, Nikunj A Dadhania wrote:

> A bug was introduced in following commit:
> 
>     dc0ad84 target/ppc: update overflow flags for add/sub
> 
> As for 32-bit ppc target extracting bit 63 for overflow is not correct.
> Made it dependent on TARGET_LOG_BITS. This had broken booting MacOS
> 9.2.1 image
> 
> Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> ---
>  target/ppc/translate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index b6abc60..f40b5a1 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -818,7 +818,7 @@ static inline void gen_op_arith_compute_ov(DisasContext *ctx, TCGv arg0,
>          if (is_isa300(ctx)) {
>              tcg_gen_extract_tl(cpu_ov32, cpu_ov, 31, 1);
>          }
> -        tcg_gen_extract_tl(cpu_ov, cpu_ov, 63, 1);
> +        tcg_gen_extract_tl(cpu_ov, cpu_ov, TARGET_LONG_BITS - 1, 1);
>      }
>      tcg_gen_or_tl(cpu_so, cpu_so, cpu_ov);
>  }
> 

Hi Nikunj,

I can confirm that this patch fixes the segfault for me - thanks!

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

However even with this fix in place, I'm still seeing strange horizontal
artifacts on the screen as demonstrated here:

https://www.ilande.co.uk/tmp/qemu/macos9-stripe.png

With the patch above I'll try bisecting again later today to try and
understand where these lines are coming from. So far I've spotted them
in MacOS 9 and OS X during tests...


ATB,

Mark.
