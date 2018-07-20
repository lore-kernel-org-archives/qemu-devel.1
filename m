Received: from eggs.gnu.org ([2001:4830:134:3::10]:32802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fgQKM-0008UU-4L
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 03:59:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fgQKI-00020T-T5
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 03:59:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56178 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fgQKI-00020N-O1
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 03:59:46 -0400
Date: Fri, 20 Jul 2018 15:59:37 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180720075937.GR4071@xz-mi>
References: <20180718154200.26777-1-dplotnikov@virtuozzo.com>
	<20180718154200.26777-6-dplotnikov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180718154200.26777-6-dplotnikov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v1 05/17] ram: extend the data structures
 for background snapshotting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Cc: dgilbert@redhat.com, quintela@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org

On Wed, Jul 18, 2018 at 06:41:48PM +0300, Denis Plotnikov wrote:
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> ---
>  include/exec/ram_addr.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
> index 6cbc02aa0f..5b403d537d 100644
> --- a/include/exec/ram_addr.h
> +++ b/include/exec/ram_addr.h
> @@ -36,6 +36,8 @@ struct RAMBlock {
>      char idstr[256];
>      /* RCU-enabled, writes protected by the ramlist lock */
>      QLIST_ENTRY(RAMBlock) next;
> +    /* blocks used for background snapshot */
> +    QLIST_ENTRY(RAMBlock) bgs_next;
>      QLIST_HEAD(, RAMBlockNotifier) ramblock_notifiers;
>      int fd;
>      size_t page_size;
> @@ -49,6 +51,11 @@ struct RAMBlock {
>      unsigned long *unsentmap;
>      /* bitmap of already received pages in postcopy */
>      unsigned long *receivedmap;
> +    /* The following 2 are for background snapshot */
> +    /* Pages currently being copied */
> +    unsigned long *touched_map;
> +    /* Pages has been copied already */
> +    unsigned long *copied_map;
>  };
>  
>  static inline bool offset_in_ramblock(RAMBlock *b, ram_addr_t offset)
> -- 
> 2.17.0
> 
> 

IMHO these new fields can be put into the patches where they are
firstly used.  Isolating them do not really help much for anything
AFAICT...

Regards,

-- 
Peter Xu
