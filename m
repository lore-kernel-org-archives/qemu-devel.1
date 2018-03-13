Received: from eggs.gnu.org ([2001:4830:134:3::10]:51501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1evisa-00074V-HT
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:18:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1evisZ-0006ll-83
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:18:08 -0400
Date: Tue, 13 Mar 2018 12:17:46 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180313121745.GE3545@work-vm>
References: <20180207155837.92351-1-vsementsov@virtuozzo.com>
	<20180207155837.92351-6-vsementsov@virtuozzo.com>
	<20180312153020.GI3219@work-vm>
	<85d52f63-851d-870f-3af3-5b75cbf6219d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85d52f63-851d-870f-3af3-5b75cbf6219d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v10 05/12] migration: introduce
 postcopy-only pending
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, kwolf@redhat.com, peter.maydell@linaro.org, famz@redhat.com, lirans@il.ibm.com, qemu-block@nongnu.org, quintela@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com, stefanha@redhat.com, den@openvz.org, amit.shah@redhat.com, pbonzini@redhat.com, mreitz@redhat.com

* John Snow (jsnow@redhat.com) wrote:
> 
> 
> On 03/12/2018 11:30 AM, Dr. David Alan Gilbert wrote:
> > * Vladimir Sementsov-Ogievskiy (vsementsov@virtuozzo.com) wrote:
> >> There would be savevm states (dirty-bitmap) which can migrate only in
> >> postcopy stage. The corresponding pending is introduced here.
> >>
> >> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> >> ---
> >>  include/migration/register.h | 17 +++++++++++++++--
> >>  migration/savevm.h           |  5 +++--
> >>  hw/s390x/s390-stattrib.c     |  7 ++++---
> >>  migration/block.c            |  7 ++++---
> >>  migration/migration.c        | 16 +++++++++-------
> >>  migration/ram.c              |  9 +++++----
> >>  migration/savevm.c           | 13 ++++++++-----
> >>  migration/trace-events       |  2 +-
> >>  8 files changed, 49 insertions(+), 27 deletions(-)
> >>
> >> diff --git a/include/migration/register.h b/include/migration/register.h
> >> index f4f7bdc177..9436a87678 100644
> >> --- a/include/migration/register.h
> >> +++ b/include/migration/register.h
> >> @@ -37,8 +37,21 @@ typedef struct SaveVMHandlers {
> >>      int (*save_setup)(QEMUFile *f, void *opaque);
> >>      void (*save_live_pending)(QEMUFile *f, void *opaque,
> >>                                uint64_t threshold_size,
> >> -                              uint64_t *non_postcopiable_pending,
> >> -                              uint64_t *postcopiable_pending);
> >> +                              uint64_t *res_precopy_only,
> >> +                              uint64_t *res_compatible,
> >> +                              uint64_t *res_postcopy_only);
> >> +    /* Note for save_live_pending:
> >> +     * - res_precopy_only is for data which must be migrated in precopy phase
> >> +     *     or in stopped state, in other words - before target vm start
> >> +     * - res_compatible is for data which may be migrated in any phase
> >> +     * - res_postcopy_only is for data which must be migrated in postcopy phase
> >> +     *     or in stopped state, in other words - after source vm stop
> >> +     *
> >> +     * Sum of res_postcopy_only, res_compatible and res_postcopy_only is the
> >> +     * whole amount of pending data.
> >> +     */
> >> +
> >> +
> >>      LoadStateHandler *load_state;
> >>      int (*load_setup)(QEMUFile *f, void *opaque);
> >>      int (*load_cleanup)(void *opaque);
> >> diff --git a/migration/savevm.h b/migration/savevm.h
> >> index 295c4a1f2c..cf4f0d37ca 100644
> >> --- a/migration/savevm.h
> >> +++ b/migration/savevm.h
> >> @@ -38,8 +38,9 @@ void qemu_savevm_state_complete_postcopy(QEMUFile *f);
> >>  int qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only,
> >>                                         bool inactivate_disks);
> >>  void qemu_savevm_state_pending(QEMUFile *f, uint64_t max_size,
> >> -                               uint64_t *res_non_postcopiable,
> >> -                               uint64_t *res_postcopiable);
> >> +                               uint64_t *res_precopy_only,
> >> +                               uint64_t *res_compatible,
> >> +                               uint64_t *res_postcopy_only);
> >>  void qemu_savevm_send_ping(QEMUFile *f, uint32_t value);
> >>  void qemu_savevm_send_open_return_path(QEMUFile *f);
> >>  int qemu_savevm_send_packaged(QEMUFile *f, const uint8_t *buf, size_t len);
> >> diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
> >> index 2902f54f11..dd3fbfd1eb 100644
> >> --- a/hw/s390x/s390-stattrib.c
> >> +++ b/hw/s390x/s390-stattrib.c
> >> @@ -183,15 +183,16 @@ static int cmma_save_setup(QEMUFile *f, void *opaque)
> >>  }
> >>  
> >>  static void cmma_save_pending(QEMUFile *f, void *opaque, uint64_t max_size,
> >> -                             uint64_t *non_postcopiable_pending,
> >> -                             uint64_t *postcopiable_pending)
> >> +                              uint64_t *res_precopy_only,
> >> +                              uint64_t *res_compatible,
> >> +                              uint64_t *res_postcopy_only)
> >>  {
> >>      S390StAttribState *sas = S390_STATTRIB(opaque);
> >>      S390StAttribClass *sac = S390_STATTRIB_GET_CLASS(sas);
> >>      long long res = sac->get_dirtycount(sas);
> >>  
> >>      if (res >= 0) {
> >> -        *non_postcopiable_pending += res;
> >> +        *res_precopy_only += res;
> >>      }
> >>  }
> >>  
> >> diff --git a/migration/block.c b/migration/block.c
> >> index 1f03946797..5652ca3337 100644
> >> --- a/migration/block.c
> >> +++ b/migration/block.c
> >> @@ -866,8 +866,9 @@ static int block_save_complete(QEMUFile *f, void *opaque)
> >>  }
> >>  
> >>  static void block_save_pending(QEMUFile *f, void *opaque, uint64_t max_size,
> >> -                               uint64_t *non_postcopiable_pending,
> >> -                               uint64_t *postcopiable_pending)
> >> +                               uint64_t *res_precopy_only,
> >> +                               uint64_t *res_compatible,
> >> +                               uint64_t *res_postcopy_only)
> >>  {
> >>      /* Estimate pending number of bytes to send */
> >>      uint64_t pending;
> >> @@ -888,7 +889,7 @@ static void block_save_pending(QEMUFile *f, void *opaque, uint64_t max_size,
> >>  
> >>      DPRINTF("Enter save live pending  %" PRIu64 "\n", pending);
> >>      /* We don't do postcopy */
> >> -    *non_postcopiable_pending += pending;
> >> +    *res_precopy_only += pending;
> >>  }
> >>  
> >>  static int block_load(QEMUFile *f, void *opaque, int version_id)
> >> diff --git a/migration/migration.c b/migration/migration.c
> >> index c99a4e62d7..3beedd676e 100644
> >> --- a/migration/migration.c
> >> +++ b/migration/migration.c
> >> @@ -2215,21 +2215,23 @@ typedef enum {
> >>   */
> >>  static MigIterateState migration_iteration_run(MigrationState *s)
> >>  {
> >> -    uint64_t pending_size, pend_post, pend_nonpost;
> >> +    uint64_t pending_size, pend_pre, pend_compat, pend_post;
> >>      bool in_postcopy = s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE;
> >>  
> >> -    qemu_savevm_state_pending(s->to_dst_file, s->threshold_size,
> >> -                              &pend_nonpost, &pend_post);
> >> -    pending_size = pend_nonpost + pend_post;
> >> +    qemu_savevm_state_pending(s->to_dst_file, s->threshold_size, &pend_pre,
> >> +                              &pend_compat, &pend_post);
> >> +    pending_size = pend_pre + pend_compat + pend_post;
> >>  
> >>      trace_migrate_pending(pending_size, s->threshold_size,
> >> -                          pend_post, pend_nonpost);
> >> +                          pend_pre, pend_compat, pend_post);
> >>  
> >>      if (pending_size && pending_size >= s->threshold_size) {
> >>          /* Still a significant amount to transfer */
> >>          if (migrate_postcopy() && !in_postcopy &&
> >> -            pend_nonpost <= s->threshold_size &&
> >> -            atomic_read(&s->start_postcopy)) {
> >> +            pend_pre <= s->threshold_size &&
> >> +            (atomic_read(&s->start_postcopy) ||
> >> +             (pend_pre + pend_compat <= s->threshold_size)))
> > 
> > This change does something different from the description;
> > it causes a postcopy_start even if the user never ran the postcopy-start
> > command; so sorry, we can't do that; because postcopy for RAM is
> > something that users can enable but only switch into when they've given
> > up on it completing normally.
> > 
> > However, I guess that leaves you with a problem; which is what happens
> > to the system when you've run out of pend_pre+pend_compat but can't
> > complete because pend_post is non-0; so I don't know the answer to that.
> > 
> > Dave
> > 
> 
> I'm willing to pull the bitmap related changes into my tree for 2.12,
> but it would be _really_ nice to have this patchset in 2.12 -- is there
> anything we can do to get this into the migration queue?
> 
> I'm afraid I don't know what the right answer here is either, so I can't
> fix this up myself and I imagine Vladimir will need some feedback from
> you to change this design.

Well I'm good with everything except the change in semantics for
existing migration;  we can't do that because it can break existing users.


> Are we -hosed- ?

Dave
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
