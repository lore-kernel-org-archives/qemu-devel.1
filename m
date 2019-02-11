Received: from eggs.gnu.org ([209.51.188.92]:37550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gtCKI-0000hD-5m
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 09:12:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gtCKG-0000yG-Ol
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 09:12:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:64364)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gtCK9-0000sr-JP
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 09:12:44 -0500
References: <cover.1549406119.git.jag.raman@oracle.com>
	<59572a7353830be4b7aa57d79ccb7ad6b72f0dda.1549406119.git.jag.raman@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bc2da3f4-fcc1-cd45-f009-842d9fdde63d@redhat.com>
Date: Mon, 11 Feb 2019 15:12:35 +0100
MIME-Version: 1.0
In-Reply-To: <59572a7353830be4b7aa57d79ccb7ad6b72f0dda.1549406119.git.jag.raman@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] memory: Do not update coalesced IO range
 in the case of NOP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jagannathan Raman <jag.raman@oracle.com>, qemu-devel@nongnu.org

On 05/02/19 23:50, Jagannathan Raman wrote:
> Do not add/del coalesced IO ranges in the case where the
> same FlatRanges are present in both old and new FlatViews
> 
> Fixes: 3ac7d43a6fbb ("memory: update coalesced_range on transaction_commit")
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> ---
>  memory.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/memory.c b/memory.c
> index 61d66e4..e49369d 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -932,9 +932,7 @@ static void address_space_update_topology_pass(AddressSpace *as,
>          } else if (frold && frnew && flatrange_equal(frold, frnew)) {
>              /* In both and unchanged (except logging may have changed) */
>  
> -            if (!adding) {
> -                flat_range_coalesced_io_del(frold, as);
> -            } else {
> +            if (adding) {
>                  MEMORY_LISTENER_UPDATE_REGION(frnew, as, Forward, region_nop);
>                  if (frnew->dirty_log_mask & ~frold->dirty_log_mask) {
>                      MEMORY_LISTENER_UPDATE_REGION(frnew, as, Forward, log_start,
> @@ -946,7 +944,6 @@ static void address_space_update_topology_pass(AddressSpace *as,
>                                                    frold->dirty_log_mask,
>                                                    frnew->dirty_log_mask);
>                  }
> -                flat_range_coalesced_io_add(frnew, as);
>              }
>  
>              ++iold;
> 

Queued, thanks.

Paolo
