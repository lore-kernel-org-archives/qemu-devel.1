Received: from eggs.gnu.org ([2001:4830:134:3::10]:35159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1ewGIX-0008KB-Si
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 19:59:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1ewGIX-0004xj-2K
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 19:59:09 -0400
Message-ID: <1521071936.5486.0.camel@gmail.com>
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Thu, 15 Mar 2018 10:58:56 +1100
In-Reply-To: <20180314173336.20055-1-clg@kaod.org>
References: <20180314173336.20055-1-clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] target/ppc: fix tlbsync to
 check privilege level depending on GTSE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On Wed, 2018-03-14 at 18:33 +0100, Cédric Le Goater wrote:
> tlbsync also needs to check the Guest Translation Shootdown Enable
> (GTSE) bit in the Logical Partition Control Register (LPCR) to
> determine at which privilege level it is running.
> 
> See commit c6fd28fd573d ("target/ppc: Update tlbie to check privilege
> level based on GTSE")
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>

Reviewed-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

> ---
> 
>  This will have its importance when we activate the HV bit on the
>  POWER9 CPU for the PowerNV machine.
> 
>  target/ppc/translate.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 0a0c090c9978..218665b4080b 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -4526,7 +4526,7 @@ static void gen_tlbie(DisasContext *ctx)
>      TCGv_i32 t1;
>  
>      if (ctx->gtse) {
> -        CHK_SV; /* If gtse is set then tblie is supervisor
> privileged */
> +        CHK_SV; /* If gtse is set then tlbie is supervisor
> privileged */

^^^ Did that line actually change? :)

>      } else {
>          CHK_HV; /* Else hypervisor privileged */
>      }
> @@ -4553,7 +4553,12 @@ static void gen_tlbsync(DisasContext *ctx)
>  #if defined(CONFIG_USER_ONLY)
>      GEN_PRIV;
>  #else
> -    CHK_HV;
> +
> +    if (ctx->gtse) {
> +        CHK_SV; /* If gtse is set then tlbsync is supervisor
> privileged */
> +    } else {
> +        CHK_HV; /* Else hypervisor privileged */
> +    }
>  
>      /* BookS does both ptesync and tlbsync make tlbsync a nop for
> server */
>      if (ctx->insns_flags & PPC_BOOKE) {
