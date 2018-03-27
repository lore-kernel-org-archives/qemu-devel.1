Received: from eggs.gnu.org ([2001:4830:134:3::10]:53651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1f0inh-0007sm-72
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 03:13:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1f0ine-00072C-2n
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 03:13:45 -0400
Received: from 5.mo179.mail-out.ovh.net ([46.105.43.140]:58260)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1f0ind-00071H-Rq
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 03:13:41 -0400
Received: from player737.ha.ovh.net (unknown [10.109.120.201])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 979EAA92BE
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 09:13:39 +0200 (CEST)
Date: Tue, 27 Mar 2018 09:13:32 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180327091332.287435fc@bahia.lan>
In-Reply-To: <20180327043741.7705-3-david@gibson.dropbear.id.au>
References: <20180327043741.7705-1-david@gibson.dropbear.id.au>
	<20180327043741.7705-3-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC for-2.13 02/12] target/ppc: Simplify cpu
 valid check in ppc_cpu_realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, agraf@suse.de, qemu-devel@nongnu.org, benh@kernel.crashing.org, bharata@linux.vnet.ibm.com, clg@kaod.org

On Tue, 27 Mar 2018 15:37:31 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> The #if isn't necessary, because there's a suitable one inside
> ppc_cpu_is_valid().  We've already filtered for suitable cpu models in the
> functions that search and register them.  So by the time we get to realize
> having an invalid one indicates a code error, not a user error, so an
> assert() is more appropriate than error_setg().
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  target/ppc/translate_init.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index 56b80a204a..2ae718242a 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -9749,14 +9749,7 @@ static void ppc_cpu_realize(DeviceState *dev, Error **errp)
>          }
>      }
>  
> -#if defined(TARGET_PPCEMB)
> -    if (!ppc_cpu_is_valid(pcc)) {
> -        error_setg(errp, "CPU does not possess a BookE or 4xx MMU. "
> -                   "Please use qemu-system-ppc or qemu-system-ppc64 instead "
> -                   "or choose another CPU model.");
> -        goto unrealize;
> -    }
> -#endif
> +    assert(ppc_cpu_is_valid(pcc));
>  
>      create_ppc_opcodes(cpu, &local_err);
>      if (local_err != NULL) {
