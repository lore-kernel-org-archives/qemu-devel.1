Received: from eggs.gnu.org ([2001:4830:134:3::10]:35492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ctxdW-0005r6-8F
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 10:34:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ctxdT-00045W-Kd
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 10:34:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57524)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ctxdT-000457-B9
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 10:34:43 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3DA0E3DBCE
	for <qemu-devel@nongnu.org>; Fri, 31 Mar 2017 14:34:42 +0000 (UTC)
Date: Fri, 31 Mar 2017 15:34:39 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170331143438.GJ4514@work-vm>
References: <20170323204544.12015-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170323204544.12015-1-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 00/51] Creating RAMState for migration
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
> Hi

Some high level points:

> Continuation of previous series, all review comments addressed. New things:
> - Consolidate all function comments in the same style (yes, docs)
> - Be much more careful with maintaining comments correct
> - Move all postcopy fields to RAMState

> - Move QEMUFile to RAMState
> - rename qemu_target_page_bits() to qemu_target_page_size() to reflect use
> - Remove MigrationState from functions that don't need it
> - reorganize last_sent_block to the place where it is used/needed
> - Move several places from offsets to pages
> - Rename last_ram_offset() to last_ram_page() to refect use

An interesting question is what happens if we ever have multiple threads
working on RAM at once, I assume you're thinking there will be multiple
RAMStates?  It'll be interesting to see whether everything we have now got
in RAMState is stuff that wants to be replicated that way.

Dave

> 
> Please comment.
> 
> 
> [v1]
> Currently, we have several places where we store informaticon about
> ram for migration pruposes:
> - global variables on migration/ram.c
> - inside the accounting_info struct in migration/ram.c
>   notice that not all the accounting vars are inside there
> - some stuff is in MigrationState, althought it belongs to migrate/ram.c
> 
> So, this series does:
> - move everything related to ram.c to RAMState struct
> - make all the statistics consistent, exporting them with an accessor
>   function
> 
> Why now?
> 
> Because I am trying to do some more optimizations about how we send
> data around and it is basically impossible to do with current code, we
> still need to add more variables.  Notice that there are things like that:
> - accounting info was only reset if we had xbzrle enabled
> - How/where to initialize variables are completely inconsistent.
> 
> 
> 
> To Do:
> 
> - There are still places that access directly the global struct.
>   Mainly postcopy.  We could finfd a way to make a pointer to the
>   current migration.  If people like the approach, I will search where
>   to put it.
> - I haven't posted any real change here, this is just the move of
>   variables to the struct and pass the struct around.  Optimizations
>   will came after.
> 
> - Consolidate XBZRLE, Compression params, etc in its own structs
>   (inside or not RAMState, to be able to allocate ones, others, or
>   ...)
> 
> Comments, please.
> 
> 
> Chao Fan (1):
>   Add page-size to output in 'info migrate'
> 
> Juan Quintela (50):
>   ram: Update all functions comments
>   ram: rename block_name to rbname
>   ram: Create RAMState
>   ram: Add dirty_rate_high_cnt to RAMState
>   ram: Move bitmap_sync_count into RAMState
>   ram: Move start time into RAMState
>   ram: Move bytes_xfer_prev into RAMState
>   ram: Move num_dirty_pages_period into RAMState
>   ram: Move xbzrle_cache_miss_prev into RAMState
>   ram: Move iterations_prev into RAMState
>   ram: Move dup_pages into RAMState
>   ram: Remove unused dup_mig_bytes_transferred()
>   ram: Remove unused pages_skipped variable
>   ram: Move norm_pages to RAMState
>   ram: Remove norm_mig_bytes_transferred
>   ram: Move iterations into RAMState
>   ram: Move xbzrle_bytes into RAMState
>   ram: Move xbzrle_pages into RAMState
>   ram: Move xbzrle_cache_miss into RAMState
>   ram: Move xbzrle_cache_miss_rate into RAMState
>   ram: Move xbzrle_overflows into RAMState
>   ram: Move migration_dirty_pages to RAMState
>   ram: Everything was init to zero, so use memset
>   ram: Move migration_bitmap_mutex into RAMState
>   ram: Move migration_bitmap_rcu into RAMState
>   ram: Move bytes_transferred into RAMState
>   ram: Use the RAMState bytes_transferred parameter
>   ram: Remove ram_save_remaining
>   ram: Move last_req_rb to RAMState
>   ram: Move src_page_req* to RAMState
>   ram: Create ram_dirty_sync_count()
>   ram: Remove dirty_bytes_rate
>   ram: Move dirty_pages_rate to RAMState
>   ram: Move postcopy_requests into RAMState
>   ram: Add QEMUFile to RAMState
>   ram: Move QEMUFile into RAMState
>   ram: Move compression_switch to RAMState
>   migration: Remove MigrationState from migration_in_postcopy
>   ram: We don't need MigrationState parameter anymore
>   ram: Rename qemu_target_page_bits() to qemu_target_page_size()
>   ram: Pass RAMBlock to bitmap_sync
>   ram: ram_discard_range() don't use the mis parameter
>   ram: reorganize last_sent_block
>   ram: Use page number instead of an address for the bitmap operations
>   ram: Remember last_page instead of last_offset
>   ram: Change offset field in PageSearchStatus to page
>   ram: Use ramblock and page offset instead of absolute offset
>   ram: rename last_ram_offset() last_ram_pages()
>   ram: Use RAMBitmap type for coherence
>   migration: Remove MigrationState parameter from migration_is_idle()
> 
>  exec.c                        |   10 +-
>  hmp.c                         |    3 +
>  include/exec/ram_addr.h       |    4 +-
>  include/migration/migration.h |   41 +-
>  include/sysemu/sysemu.h       |    2 +-
>  migration/migration.c         |   44 +-
>  migration/postcopy-ram.c      |   14 +-
>  migration/ram.c               | 1190 ++++++++++++++++++++++-------------------
>  migration/savevm.c            |   15 +-
>  migration/trace-events        |    2 +-
>  qapi-schema.json              |    5 +-
>  11 files changed, 695 insertions(+), 635 deletions(-)
> 
> -- 
> 2.9.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
