Received: from eggs.gnu.org ([2001:4830:134:3::10]:33907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cJblI-0002m5-ET
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 02:56:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cJblF-0001gI-DS
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 02:56:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52002)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cJblF-0001g4-7W
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 02:56:29 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F1DB132B719
	for <qemu-devel@nongnu.org>; Wed, 21 Dec 2016 07:56:27 +0000 (UTC)
Date: Wed, 21 Dec 2016 15:56:11 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20161221075611.GF22006@pxdev.xzpeter.org>
References: <1482156623-9111-1-git-send-email-peterx@redhat.com>
	<1482156623-9111-3-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1482156623-9111-3-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] memory: hmp: dump flat view for 'info
 mtree'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com

On Mon, Dec 19, 2016 at 10:10:23PM +0800, Peter Xu wrote:
> Dumping flat view will be useful to debug the memory rendering logic,
> also it'll be much easier with it to know what memory region is handling
> what address range.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  memory.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/memory.c b/memory.c
> index 5dcc2e1..a9154aa 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -2545,6 +2545,36 @@ static void mtree_print_mr(fprintf_function mon_printf, void *f,
>      }
>  }
>  
> +static void mtree_print_flatview(fprintf_function p, void *f,
> +                                 AddressSpace *as)
> +{
> +    FlatView *view = address_space_get_flatview(as);
> +    FlatRange *range = &view->ranges[0];
> +    MemoryRegion *mr;
> +    int n = view->nr;
> +
> +    if (n <= 0) {
> +        p(f, MTREE_INDENT "No rendered FlatView for "
> +          "address space '%s'\n", as->name);
> +        return;
> +    }
> +
> +    p(f, MTREE_INDENT "FlatView (address space '%s'):\n", as->name);
> +
> +    while (n--) {
> +        mr = range->mr;
> +        p(f, MTREE_INDENT MTREE_INDENT TARGET_FMT_plx "-"
> +          TARGET_FMT_plx " (prio %d, %c%c): %s\n",
> +          int128_get64(range->addr.start),
> +          int128_get64(range->addr.start) + MR_SIZE(mr->size),
                                                       ^^^^^^^^
                                   here it should be range->addr.size

Will repost. Thanks,

-- peterx
