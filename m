Received: from eggs.gnu.org ([2001:4830:134:3::10]:42749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cdzO0-0007Jg-NU
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 08:12:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cdzNx-0007QM-HT
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 08:12:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38158)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cdzNx-0007Py-Bc
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 08:12:41 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8C8956584C
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 13:12:41 +0000 (UTC)
Date: Wed, 15 Feb 2017 13:12:37 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170215131236.GE2731@work-vm>
References: <1487006388-7966-1-git-send-email-quintela@redhat.com>
	<1487006388-7966-2-git-send-email-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1487006388-7966-2-git-send-email-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PULL 01/12] migration: Test for disabled features
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
Cc: qemu-devel@nongnu.org

* Juan Quintela (quintela@redhat.com) wrote:
> Right now, if we receive a compressed page while this features are
> disabled, Bad Things (TM) can happen.  Just add a test for them.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

This could go in separately.

Dave

> 
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
> index ef8fadf..5817f8c 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -2455,7 +2455,7 @@ static int ram_load_postcopy(QEMUFile *f)
> 
>  static int ram_load(QEMUFile *f, void *opaque, int version_id)
>  {
> -    int flags = 0, ret = 0;
> +    int flags = 0, ret = 0, invalid_flags;
>      static uint64_t seq_iter;
>      int len = 0;
>      /*
> @@ -2470,6 +2470,11 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
>          ret = -EINVAL;
>      }
> 
> +    invalid_flags = 0;
> +
> +    if (!migrate_use_compression()) {
> +        invalid_flags |= RAM_SAVE_FLAG_COMPRESS_PAGE;
> +    }
>      /* This RCU critical section can be very long running.
>       * When RCU reclaims in the code start to become numerous,
>       * it will be necessary to reduce the granularity of this
> @@ -2490,6 +2495,15 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
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
>          if (flags & (RAM_SAVE_FLAG_COMPRESS | RAM_SAVE_FLAG_PAGE |
>                       RAM_SAVE_FLAG_COMPRESS_PAGE | RAM_SAVE_FLAG_XBZRLE)) {
>              RAMBlock *block = ram_block_from_stream(f, flags);
> -- 
> 2.7.4
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
