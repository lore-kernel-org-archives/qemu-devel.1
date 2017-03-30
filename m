Received: from eggs.gnu.org ([2001:4830:134:3::10]:46753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ctVs8-0004VU-Un
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 04:56:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ctVs3-00030v-VX
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 04:56:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ctVs3-00030N-GP
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 04:55:55 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F045E19CF90
	for <qemu-devel@nongnu.org>; Thu, 30 Mar 2017 08:55:51 +0000 (UTC)
Date: Thu, 30 Mar 2017 09:55:46 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170330085545.GB2800@work-vm>
References: <20170323204544.12015-1-quintela@redhat.com>
	<20170323204544.12015-41-quintela@redhat.com>
	<20170330080334.GB21915@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170330080334.GB21915@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] [PATCH 40/51] ram: Rename qemu_target_page_bits()
 to qemu_target_page_size()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org

* Peter Xu (peterx@redhat.com) wrote:
> On Thu, Mar 23, 2017 at 09:45:33PM +0100, Juan Quintela wrote:
> > It was used as a size in all cases except one.
> 
> Considering that:
> 
> - qemu_target_page_bits() is only used in migration codes, in only
>   several places below
> 
> - migration codes is using TARGET_PAGE_{BITS|SIZE} a lot as well
> 
> How about we just remove this function, and directly use
> TARGET_PAGE_{BITS|SIZE}?

We can't because the TARGET_* macros are defined in headers
that are only allowed to be included in target-specific builds.
Most of QEMUs code (including all migration/*) is built
target independent and so the headers error if we try and include
them.

That's why I added qemu_target_page_bits()

Dave

> Thanks,
> 
> > 
> > Signed-off-by: Juan Quintela <quintela@redhat.com>
> > ---
> >  exec.c                   | 4 ++--
> >  include/sysemu/sysemu.h  | 2 +-
> >  migration/migration.c    | 4 ++--
> >  migration/postcopy-ram.c | 8 ++++----
> >  migration/savevm.c       | 8 ++++----
> >  5 files changed, 13 insertions(+), 13 deletions(-)
> > 
> > diff --git a/exec.c b/exec.c
> > index e57a8a2..9a4c385 100644
> > --- a/exec.c
> > +++ b/exec.c
> > @@ -3349,9 +3349,9 @@ int cpu_memory_rw_debug(CPUState *cpu, target_ulong addr,
> >   * Allows code that needs to deal with migration bitmaps etc to still be built
> >   * target independent.
> >   */
> > -size_t qemu_target_page_bits(void)
> > +size_t qemu_target_page_size(void)
> >  {
> > -    return TARGET_PAGE_BITS;
> > +    return TARGET_PAGE_SIZE;
> >  }
> >  
> >  #endif
> > diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> > index 576c7ce..16175f7 100644
> > --- a/include/sysemu/sysemu.h
> > +++ b/include/sysemu/sysemu.h
> > @@ -67,7 +67,7 @@ int qemu_reset_requested_get(void);
> >  void qemu_system_killed(int signal, pid_t pid);
> >  void qemu_system_reset(bool report);
> >  void qemu_system_guest_panicked(GuestPanicInformation *info);
> > -size_t qemu_target_page_bits(void);
> > +size_t qemu_target_page_size(void);
> >  
> >  void qemu_add_exit_notifier(Notifier *notify);
> >  void qemu_remove_exit_notifier(Notifier *notify);
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 3f99ab3..92c3c6b 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -646,7 +646,7 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
> >      info->ram->skipped = 0;
> >      info->ram->normal = norm_mig_pages_transferred();
> >      info->ram->normal_bytes = norm_mig_pages_transferred() *
> > -        (1ul << qemu_target_page_bits());
> > +        qemu_target_page_size();
> >      info->ram->mbps = s->mbps;
> >      info->ram->dirty_sync_count = ram_dirty_sync_count();
> >      info->ram->postcopy_requests = ram_postcopy_requests();
> > @@ -2001,7 +2001,7 @@ static void *migration_thread(void *opaque)
> >                 10000 is a small enough number for our purposes */
> >              if (ram_dirty_pages_rate() && transferred_bytes > 10000) {
> >                  s->expected_downtime = ram_dirty_pages_rate() *
> > -                    (1ul << qemu_target_page_bits()) / bandwidth;
> > +                    qemu_target_page_size() / bandwidth;
> >              }
> >  
> >              qemu_file_reset_rate_limit(s->to_dst_file);
> > diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> > index dc80dbb..8756364 100644
> > --- a/migration/postcopy-ram.c
> > +++ b/migration/postcopy-ram.c
> > @@ -123,7 +123,7 @@ bool postcopy_ram_supported_by_host(void)
> >      struct uffdio_range range_struct;
> >      uint64_t feature_mask;
> >  
> > -    if ((1ul << qemu_target_page_bits()) > pagesize) {
> > +    if (qemu_target_page_size() > pagesize) {
> >          error_report("Target page size bigger than host page size");
> >          goto out;
> >      }
> > @@ -745,10 +745,10 @@ PostcopyDiscardState *postcopy_discard_send_init(MigrationState *ms,
> >  void postcopy_discard_send_range(MigrationState *ms, PostcopyDiscardState *pds,
> >                                  unsigned long start, unsigned long length)
> >  {
> > -    size_t tp_bits = qemu_target_page_bits();
> > +    size_t tp_size = qemu_target_page_size();
> >      /* Convert to byte offsets within the RAM block */
> > -    pds->start_list[pds->cur_entry] = (start - pds->offset) << tp_bits;
> > -    pds->length_list[pds->cur_entry] = length << tp_bits;
> > +    pds->start_list[pds->cur_entry] = (start - pds->offset) * tp_size;
> > +    pds->length_list[pds->cur_entry] = length * tp_size;
> >      trace_postcopy_discard_send_range(pds->ramblock_name, start, length);
> >      pds->cur_entry++;
> >      pds->nsentwords++;
> > diff --git a/migration/savevm.c b/migration/savevm.c
> > index 853a81a..bbf055d 100644
> > --- a/migration/savevm.c
> > +++ b/migration/savevm.c
> > @@ -871,7 +871,7 @@ void qemu_savevm_send_postcopy_advise(QEMUFile *f)
> >  {
> >      uint64_t tmp[2];
> >      tmp[0] = cpu_to_be64(ram_pagesize_summary());
> > -    tmp[1] = cpu_to_be64(1ul << qemu_target_page_bits());
> > +    tmp[1] = cpu_to_be64(qemu_target_page_size());
> >  
> >      trace_qemu_savevm_send_postcopy_advise();
> >      qemu_savevm_command_send(f, MIG_CMD_POSTCOPY_ADVISE, 16, (uint8_t *)tmp);
> > @@ -1390,13 +1390,13 @@ static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis)
> >      }
> >  
> >      remote_tps = qemu_get_be64(mis->from_src_file);
> > -    if (remote_tps != (1ul << qemu_target_page_bits())) {
> > +    if (remote_tps != qemu_target_page_size()) {
> >          /*
> >           * Again, some differences could be dealt with, but for now keep it
> >           * simple.
> >           */
> > -        error_report("Postcopy needs matching target page sizes (s=%d d=%d)",
> > -                     (int)remote_tps, 1 << qemu_target_page_bits());
> > +        error_report("Postcopy needs matching target page sizes (s=%d d=%zd)",
> > +                     (int)remote_tps, qemu_target_page_size());
> >          return -1;
> >      }
> >  
> > -- 
> > 2.9.3
> > 
> > 
> 
> -- peterx
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
