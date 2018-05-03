Received: from eggs.gnu.org ([2001:4830:134:3::10]:41335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fEG5g-0000WS-Ca
	for qemu-devel@nongnu.org; Thu, 03 May 2018 11:24:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fEG5b-0005k5-AI
	for qemu-devel@nongnu.org; Thu, 03 May 2018 11:24:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51852 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fEG5b-0005jp-3W
	for qemu-devel@nongnu.org; Thu, 03 May 2018 11:24:11 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B5C5C406C742
	for <qemu-devel@nongnu.org>; Thu,  3 May 2018 15:24:10 +0000 (UTC)
Date: Thu, 3 May 2018 16:24:03 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180503152402.GJ2660@work-vm>
References: <20180425112723.1111-1-quintela@redhat.com>
	<20180425112723.1111-22-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425112723.1111-22-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v12 21/21] migration: Stop sending whole
 pages through main channel
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
> We have to flush() the QEMUFile because now we sent really few data
> through that channel.

I think this makes sense, so


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

However, I think again it could really be folded into an earlier patch,
except the fflush's themselves which do make sense here.

Dave

> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/ram.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 23203756b7..f5cff2eb59 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1634,20 +1634,12 @@ static int ram_multifd_page(RAMState *rs, PageSearchStatus *pss,
>                              bool last_stage)
>  {
>      int pages;
> -    uint8_t *p;
>      RAMBlock *block = pss->block;
>      ram_addr_t offset = pss->page << TARGET_PAGE_BITS;
>  
> -    p = block->host + offset;
> -
>      pages = save_zero_page(rs, block, offset);
>      if (pages == -1) {
> -        ram_counters.transferred +=
> -            save_page_header(rs, rs->f, block,
> -                             offset | RAM_SAVE_FLAG_PAGE);
>          multifd_queue_page(block, offset);
> -        qemu_put_buffer(rs->f, p, TARGET_PAGE_SIZE);
> -        ram_counters.transferred += TARGET_PAGE_SIZE;
>          pages = 1;
>          ram_counters.normal++;
>      }
> @@ -2869,6 +2861,7 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
>  
>      multifd_send_sync_main();
>      qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
> +    qemu_fflush(f);
>  
>      return 0;
>  }
> @@ -2946,6 +2939,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
>      multifd_send_sync_main();
>  out:
>      qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
> +    qemu_fflush(f);
>      ram_counters.transferred += 8;
>  
>      ret = qemu_file_get_error(f);
> @@ -2999,6 +2993,7 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
>  
>      multifd_send_sync_main();
>      qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
> +    qemu_fflush(f);
>  
>      return 0;
>  }
> -- 
> 2.17.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
