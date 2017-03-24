Received: from eggs.gnu.org ([2001:4830:134:3::10]:48053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1crLwN-0005tU-WE
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 05:55:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1crLwK-0005Ki-SV
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 05:55:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40376)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1crLwK-0005KS-JK
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 05:55:24 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0F935C04B945
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 09:55:23 +0000 (UTC)
Date: Fri, 24 Mar 2017 17:55:17 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170324095517.GC17755@pxdev.xzpeter.org>
References: <20170323204544.12015-1-quintela@redhat.com>
	<20170323204544.12015-2-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170323204544.12015-2-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 01/51] ram: Update all functions comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com

Hi, Juan,

Got several nitpicks below... (along with some questions)

On Thu, Mar 23, 2017 at 09:44:54PM +0100, Juan Quintela wrote:

[...]

>  static void xbzrle_cache_zero_page(ram_addr_t current_addr)
>  {
> @@ -459,8 +474,8 @@ static void xbzrle_cache_zero_page(ram_addr_t current_addr)
>   *          -1 means that xbzrle would be longer than normal
>   *
>   * @f: QEMUFile where to send the data
> - * @current_data:
> - * @current_addr:
> + * @current_data: contents of the page

Since current_data is a double pointer, so... maybe "pointer to the
address of page content"?

Btw, a question not related to this series... Why here in
save_xbzrle_page() we need to update *current_data to be the newly
created page cache? I see that we have:

    /* update *current_data when the page has been
       inserted into cache */
    *current_data = get_cached_data(XBZRLE.cache, current_addr);

What would be the difference if we just use the old pointer in
RAMBlock.host?

[...]

> @@ -1157,11 +1186,12 @@ static bool get_queued_page(MigrationState *ms, PageSearchStatus *pss,
>  }
>  
>  /**
> - * flush_page_queue: Flush any remaining pages in the ram request queue
> - *    it should be empty at the end anyway, but in error cases there may be
> - *    some left.
> + * flush_page_queue: flush any remaining pages in the ram request queue

Here the comment says (just like mentioned in function name) that we
will "flush any remaining pages in the ram request queue", however in
the implementation, we should be only freeing everything in
src_page_requests. The problem is "flush" let me think about "flushing
the rest of the pages to the other side"... while it's not.

Would it be nice we just rename the function into something else, like
migration_page_queue_free()? We can tune the comments correspondingly
as well.

[...]

> -/*
> - * Helper for postcopy_chunk_hostpages; it's called twice to cleanup
> - *   the two bitmaps, that are similar, but one is inverted.
> +/**
> + * postcopy_chuck_hostpages_pass: canocalize bitmap in hostpages
                  ^ should be n?     ^^^^^^^^^^ canonicalize?

>   *
> - * We search for runs of target-pages that don't start or end on a
> - * host page boundary;
> - * unsent_pass=true: Cleans up partially unsent host pages by searching
> - *                 the unsentmap
> - * unsent_pass=false: Cleans up partially dirty host pages by searching
> - *                 the main migration bitmap
> + * Helper for postcopy_chunk_hostpages; it's called twice to
> + * canonicalize the two bitmaps, that are similar, but one is
> + * inverted.
>   *
> + * Postcopy requires that all target pages in a hostpage are dirty or
> + * clean, not a mix.  This function canonicalizes the bitmaps.
> + *
> + * @ms: current migration state
> + * @unsent_pass: if true we need to canonicalize partially unsent host pages
> + *               otherwise we need to canonicalize partially dirty host pages
> + * @block: block that contains the page we want to canonicalize
> + * @pds: state for postcopy
>   */
>  static void postcopy_chunk_hostpages_pass(MigrationState *ms, bool unsent_pass,
>                                            RAMBlock *block,

[...]

> +/**
> + * ram_save_setup: iterative stage for migration
      ^^^^^^^^^^^^^^ should be ram_save_iterate()?

> + *
> + * Returns zero to indicate success and negative for error
> + *
> + * @f: QEMUFile where to send the data
> + * @opaque: RAMState pointer
> + */
>  static int ram_save_iterate(QEMUFile *f, void *opaque)
>  {
>      int ret;
> @@ -2091,7 +2169,16 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
>      return done;
>  }

[...]

> -/*
> - * Allocate data structures etc needed by incoming migration with postcopy-ram
> - * postcopy-ram's similarly names postcopy_ram_incoming_init does the work
> +/**
> + * ram_postococpy_incoming_init: allocate postcopy data structures
> + *
> + * Returns 0 for success and negative if there was one error
> + *
> + * @mis: current migration incoming state
> + *
> + * Allocate data structures etc needed by incoming migration with
> + * postcopy-ram postcopy-ram's similarly names
> + * postcopy_ram_incoming_init does the work

This sentence is slightly hard to understand... But I think the
function name explained itself enough though. :)

Thanks,

-- peterx
