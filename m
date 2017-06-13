Received: from eggs.gnu.org ([2001:4830:134:3::10]:36161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dKpyz-0005wL-1o
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 13:52:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dKpyu-0002mH-5z
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 13:52:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36922)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dKpyt-0002ke-St
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 13:51:56 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B353E7E9F0
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 17:51:54 +0000 (UTC)
Date: Tue, 13 Jun 2017 18:51:48 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170613175147.GB2463@work-vm>
References: <20170613095432.11623-1-quintela@redhat.com>
	<20170613095432.11623-2-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170613095432.11623-2-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] migration: Test for disabled features
 on reception
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com

* Juan Quintela (quintela@redhat.com) wrote:
> Right now, if we receive a compressed page while this features are
> disabled, Bad Things (TM) can happen.  Just add a test for them.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Yes, my R-b stands, there could be someone somewhere driving this by
hand who might get caught out, but seems saner this way.

> --
> 
> I had XBZRLE here also, but it don't need extra resources on
> destination, only on source.  Additionally libvirt don't enable it on
> destination, so don't put it here.
> ---
>  migration/ram.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index f35d65a..f2d1bce 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -2477,7 +2477,7 @@ static int ram_load_postcopy(QEMUFile *f)
>  
>  static int ram_load(QEMUFile *f, void *opaque, int version_id)
>  {
> -    int flags = 0, ret = 0;
> +    int flags = 0, ret = 0, invalid_flags;
>      static uint64_t seq_iter;
>      int len = 0;
>      /*
> @@ -2494,6 +2494,11 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
>          ret = -EINVAL;
>      }
>  
> +    invalid_flags = 0;

why didn't you use = 0 in the declaration like the rest of the flags?
(Only minor)

Dave

> +
> +    if (!migrate_use_compression()) {
> +        invalid_flags |= RAM_SAVE_FLAG_COMPRESS_PAGE;
> +    }
>      /* This RCU critical section can be very long running.
>       * When RCU reclaims in the code start to become numerous,
>       * it will be necessary to reduce the granularity of this
> @@ -2514,6 +2519,15 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
>          flags = addr & ~TARGET_PAGE_MASK;
>          addr &= TARGET_PAGE_MASK;
>  
> +        if (flags & invalid_flags) {
> +            if (flags & invalid_flags  & RAM_SAVE_FLAG_COMPRESS_PAGE) {
> +                error_report("Received an unexpected compressed page");
> +            }
> +
> +            ret = -EINVAL;
> +            break;
> +        }
> +
>          if (flags & (RAM_SAVE_FLAG_ZERO | RAM_SAVE_FLAG_PAGE |
>                       RAM_SAVE_FLAG_COMPRESS_PAGE | RAM_SAVE_FLAG_XBZRLE)) {
>              RAMBlock *block = ram_block_from_stream(f, flags);
> -- 
> 2.9.4
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
