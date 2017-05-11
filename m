Received: from eggs.gnu.org ([2001:4830:134:3::10]:57943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1d8uoi-0000FE-Ke
	for qemu-devel@nongnu.org; Thu, 11 May 2017 16:36:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1d8uoi-0004vK-0I
	for qemu-devel@nongnu.org; Thu, 11 May 2017 16:36:08 -0400
Date: Thu, 11 May 2017 16:35:58 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170511203558.GA19824@localhost.localdomain>
References: <20170510143205.32013-1-pbonzini@redhat.com>
	<20170510143205.32013-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170510143205.32013-2-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/7] curl: strengthen assertion in
 curl_clean_state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, qemu-block@nongnu.org, rjones@redhat.com

On Wed, May 10, 2017 at 04:31:59PM +0200, Paolo Bonzini wrote:
> curl_clean_state should only be called after all AIOCBs have been
> completed.  This is not so obvious for the call from curl_detach_aio_context,
> so assert that.
> 
> Cc: qemu-stable@nongnu.org
> Cc: jcody@redhat.com
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block/curl.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/block/curl.c b/block/curl.c
> index 2708d57c2f..25a301e7b4 100644
> --- a/block/curl.c
> +++ b/block/curl.c
> @@ -532,6 +532,11 @@ static CURLState *curl_init_state(BlockDriverState *bs, BDRVCURLState *s)
>  
>  static void curl_clean_state(CURLState *s)
>  {
> +    int j;
> +    for (j=0; j<CURL_NUM_ACB; j++) {
> +        assert(!s->acb[j]);
> +    }
> +
>      if (s->s->multi)
>          curl_multi_remove_handle(s->s->multi, s->curl);
>  
> -- 
> 2.12.2
> 
>

Minor formatting nit aside (if no other revisions needed, I can fix that on
apply):

Reviewed-by: Jeff Cody <jcody@redhat.com>
