Received: from eggs.gnu.org ([2001:4830:134:3::10]:48112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f0iE5-0007Yd-VT
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 02:36:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f0iE1-0005Lt-Bq
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 02:36:58 -0400
References: <20180327043741.7705-1-david@gibson.dropbear.id.au>
	<20180327043741.7705-3-david@gibson.dropbear.id.au>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0e24234b-60b6-5374-1024-dff3e39cb717@redhat.com>
Date: Tue, 27 Mar 2018 08:36:41 +0200
MIME-Version: 1.0
In-Reply-To: <20180327043741.7705-3-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [RFC for-2.13 02/12] target/ppc:
 Simplify cpu valid check in ppc_cpu_realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, groug@kaod.org
Cc: qemu-devel@nongnu.org, clg@kaod.org, bharata@linux.vnet.ibm.com

On 27.03.2018 06:37, David Gibson wrote:
> The #if isn't necessary, because there's a suitable one inside
> ppc_cpu_is_valid().  We've already filtered for suitable cpu models in the
> functions that search and register them.  So by the time we get to realize
> having an invalid one indicates a code error, not a user error, so an
> assert() is more appropriate than error_setg().
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
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
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
