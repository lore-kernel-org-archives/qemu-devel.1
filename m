Received: from eggs.gnu.org ([2001:4830:134:3::10]:60494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1erfhT-0002xw-L5
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 03:05:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1erfhO-00018F-Ni
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 03:05:55 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55678 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1erfhO-00017k-90
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 03:05:50 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C81358D6EF
	for <qemu-devel@nongnu.org>; Fri,  2 Mar 2018 08:05:39 +0000 (UTC)
Date: Fri, 2 Mar 2018 16:05:24 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180302080524.GO27381@xz-mi>
References: <20180216131625.9639-1-dgilbert@redhat.com>
	<20180216131625.9639-23-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180216131625.9639-23-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 22/29] vhost+postcopy: Call wakeups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, maxime.coquelin@redhat.com, marcandre.lureau@redhat.com, imammedo@redhat.com, mst@redhat.com, quintela@redhat.com, aarcange@redhat.com

On Fri, Feb 16, 2018 at 01:16:18PM +0000, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Cause the vhost-user client to be woken up whenever:
>   a) We place a page in postcopy mode
>   b) We get a fault and the page has already been received
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  migration/postcopy-ram.c | 14 ++++++++++----
>  migration/trace-events   |  1 +
>  2 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index 879711968c..13561703b5 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -566,7 +566,11 @@ int postcopy_request_shared_page(struct PostCopyFD *pcfd, RAMBlock *rb,
>  
>      trace_postcopy_request_shared_page(pcfd->idstr, qemu_ram_get_idstr(rb),
>                                         rb_offset);
> -    /* TODO: Check bitmap to see if we already have the page */
> +    if (ramblock_recv_bitmap_test_byte_offset(rb, aligned_rbo)) {
> +        trace_postcopy_request_shared_page_present(pcfd->idstr,
> +                                        qemu_ram_get_idstr(rb), rb_offset);
> +        return postcopy_wake_shared(pcfd, client_addr, rb);
> +    }
>      if (rb != mis->last_rb) {
>          mis->last_rb = rb;
>          migrate_send_rp_req_pages(mis, qemu_ram_get_idstr(rb),
> @@ -863,7 +867,8 @@ int postcopy_place_page(MigrationIncomingState *mis, void *host, void *from,
>      }
>  
>      trace_postcopy_place_page(host);
> -    return 0;
> +    return postcopy_notify_shared_wake(rb,
> +                                       qemu_ram_block_host_offset(rb, host));
>  }
>  
>  /*
> @@ -887,6 +892,9 @@ int postcopy_place_page_zero(MigrationIncomingState *mis, void *host,
>  
>              return -e;
>          }
> +        return postcopy_notify_shared_wake(rb,
> +                                           qemu_ram_block_host_offset(rb,
> +                                                                      host));
>      } else {
>          /* The kernel can't use UFFDIO_ZEROPAGE for hugepages */
>          if (!mis->postcopy_tmp_zero_page) {
> @@ -906,8 +914,6 @@ int postcopy_place_page_zero(MigrationIncomingState *mis, void *host,
>          return postcopy_place_page(mis, host, mis->postcopy_tmp_zero_page,
>                                     rb);
>      }
> -
> -    return 0;
>  }

Could there be race?  E.g.:

              ram_load_thread             page_fault_thread
             -----------------           -------------------

                                          if (recv_bitmap_set())
                                              wake()
             copy_page()
             recv_bitmap_set()
             wake()
                                          request_page()

Then the last requested page may never be serviced?

Thanks,

-- 
Peter Xu
