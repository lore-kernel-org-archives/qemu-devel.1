Received: from eggs.gnu.org ([2001:4830:134:3::10]:53526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1d8he9-00009D-BD
	for qemu-devel@nongnu.org; Thu, 11 May 2017 02:32:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1d8he6-0004lj-5g
	for qemu-devel@nongnu.org; Thu, 11 May 2017 02:32:21 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:11405)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1d8he5-0004gE-TP
	for qemu-devel@nongnu.org; Thu, 11 May 2017 02:32:18 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0OPR0004VZHPBM10@mailout1.w1.samsung.com> for
	qemu-devel@nongnu.org; Thu, 11 May 2017 07:32:13 +0100 (BST)
Date: Thu, 11 May 2017 09:32:10 +0300
From: Alexey <a.perevalov@samsung.com>
Message-id: <20170511063210.GD4201@aperevalov-ubuntu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-disposition: inline
In-reply-to: <20170509190100.GJ2089@work-vm>
References: <CGME20170428065755eucas1p2ff9aa17eaa294e741d8c65f8d58a71fb@eucas1p2.samsung.com>
	<1493362658-8179-6-git-send-email-a.perevalov@samsung.com>
	<20170428100012.GB22801@pxdev.xzpeter.org>
	<d018d4a6-4b50-3f36-fe69-e232b63bebf0@samsung.com>
	<20170508062906.GC2820@pxdev.xzpeter.org>
	<20170508090807.GA4201@aperevalov-ubuntu>
	<20170509082622.GI2820@pxdev.xzpeter.org>
	<20170509094033.GB2089@work-vm>
	<20170509151942.GB4201@aperevalov-ubuntu>
	<20170509190100.GJ2089@work-vm>
Subject: Re: [Qemu-devel] [PATCH RESEND V3 5/6] migration: calculate
 downtime on dst side
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: i.maximets@samsung.com, qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, f4bug@amsat.org

On Tue, May 09, 2017 at 08:01:01PM +0100, Dr. David Alan Gilbert wrote:
> * Alexey (a.perevalov@samsung.com) wrote:
> > On Tue, May 09, 2017 at 10:40:34AM +0100, Dr. David Alan Gilbert wrote:
> > > * Peter Xu (peterx@redhat.com) wrote:
> > > > On Mon, May 08, 2017 at 12:08:07PM +0300, Alexey wrote:
> > > > > On Mon, May 08, 2017 at 02:29:06PM +0800, Peter Xu wrote:
> > > > > > On Fri, Apr 28, 2017 at 02:11:19PM +0300, Alexey Perevalov wrote:
> > > > > > > On 04/28/2017 01:00 PM, Peter Xu wrote:
> > > > > > > >On Fri, Apr 28, 2017 at 09:57:37AM +0300, Alexey Perevalov wrote:
> > > > > > > >>This patch provides downtime calculation per vCPU,
> > > > > > > >>as a summary and as a overlapped value for all vCPUs.
> > > > > > > >>
> > > > > > > >>This approach was suggested by Peter Xu, as an improvements of
> > > > > > > >>previous approch where QEMU kept tree with faulted page address and cpus bitmask
> > > > > > > >>in it. Now QEMU is keeping array with faulted page address as value and vCPU
> > > > > > > >>as index. It helps to find proper vCPU at UFFD_COPY time. Also it keeps
> > > > > > > >>list for downtime per vCPU (could be traced with page_fault_addr)
> > > > > > > >>
> > > > > > > >>For more details see comments for get_postcopy_total_downtime
> > > > > > > >>implementation.
> > > > > > > >>
> > > > > > > >>Downtime will not calculated if postcopy_downtime field of
> > > > > > > >>MigrationIncomingState wasn't initialized.
> > > > > > > >>
> > > > > > > >>Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
> > > > > > > >>---
> > > > > > > >>  include/migration/migration.h |   3 ++
> > > > > > > >>  migration/migration.c         | 103 ++++++++++++++++++++++++++++++++++++++++++
> > > > > > > >>  migration/postcopy-ram.c      |  20 +++++++-
> > > > > > > >>  migration/trace-events        |   6 ++-
> > > > > > > >>  4 files changed, 130 insertions(+), 2 deletions(-)
> > > > > > > >>
> > > > > > > >>diff --git a/include/migration/migration.h b/include/migration/migration.h
> > > > > > > >>index e8fb68f..a22f9ce 100644
> > > > > > > >>--- a/include/migration/migration.h
> > > > > > > >>+++ b/include/migration/migration.h
> > > > > > > >>@@ -139,6 +139,9 @@ void migration_incoming_state_destroy(void);
> > > > > > > >>   * Functions to work with downtime context
> > > > > > > >>   */
> > > > > > > >>  struct DowntimeContext *downtime_context_new(void);
> > > > > > > >>+void mark_postcopy_downtime_begin(uint64_t addr, int cpu);
> > > > > > > >>+void mark_postcopy_downtime_end(uint64_t addr);
> > > > > > > >>+uint64_t get_postcopy_total_downtime(void);
> > > > > > > >>  struct MigrationState
> > > > > > > >>  {
> > > > > > > >>diff --git a/migration/migration.c b/migration/migration.c
> > > > > > > >>index ec76e5c..2c6f150 100644
> > > > > > > >>--- a/migration/migration.c
> > > > > > > >>+++ b/migration/migration.c
> > > > > > > >>@@ -2150,3 +2150,106 @@ PostcopyState postcopy_state_set(PostcopyState new_state)
> > > > > > > >>      return atomic_xchg(&incoming_postcopy_state, new_state);
> > > > > > > >>  }
> > > > > > > >>+void mark_postcopy_downtime_begin(uint64_t addr, int cpu)
> > > > > > > >>+{
> > > > > > > >>+    MigrationIncomingState *mis = migration_incoming_get_current();
> > > > > > > >>+    DowntimeContext *dc;
> > > > > > > >>+    if (!mis->downtime_ctx || cpu < 0) {
> > > > > > > >>+        return;
> > > > > > > >>+    }
> > > > > > > >>+    dc = mis->downtime_ctx;
> > > > > > > >>+    dc->vcpu_addr[cpu] = addr;
> > > > > > > >>+    dc->last_begin = dc->page_fault_vcpu_time[cpu] =
> > > > > > > >>+        qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> > > > > > > >>+
> > > > > > > >>+    trace_mark_postcopy_downtime_begin(addr, dc, dc->page_fault_vcpu_time[cpu],
> > > > > > > >>+            cpu);
> > > > > > > >>+}
> > > > > > > >>+
> > > > > > > >>+void mark_postcopy_downtime_end(uint64_t addr)
> > > > > > > >>+{
> > > > > > > >>+    MigrationIncomingState *mis = migration_incoming_get_current();
> > > > > > > >>+    DowntimeContext *dc;
> > > > > > > >>+    int i;
> > > > > > > >>+    bool all_vcpu_down = true;
> > > > > > > >>+    int64_t now;
> > > > > > > >>+
> > > > > > > >>+    if (!mis->downtime_ctx) {
> > > > > > > >>+        return;
> > > > > > > >>+    }
> > > > > > > >>+    dc = mis->downtime_ctx;
> > > > > > > >>+    now = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> > > > > > > >>+
> > > > > > > >>+    /* check all vCPU down,
> > > > > > > >>+     * QEMU has bitmap.h, but even with bitmap_and
> > > > > > > >>+     * will be a cycle */
> > > > > > > >>+    for (i = 0; i < smp_cpus; i++) {
> > > > > > > >>+        if (dc->vcpu_addr[i]) {
> > > > > > > >>+            continue;
> > > > > > > >>+        }
> > > > > > > >>+        all_vcpu_down = false;
> > > > > > > >>+        break;
> > > > > > > >>+    }
> > > > > > > >>+
> > > > > > > >>+    if (all_vcpu_down) {
> > > > > > > >>+        dc->total_downtime += now - dc->last_begin;
> > > > > > > >Shall we do this accouting only if we are sure the copied page address
> > > > > > > >is one of the page faulted addresses? Can it be some other page? I
> > > > > > > >don't know. But since we have the loop below to make sure of it, why
> > > > > > > >not?
> > > > > > > no, the downtime implies since page fault till the
> > > > > > > page will be copied.
> > > > > > > Yes another pages could be copied as well as pagefaulted,
> > > > > > > and they are copied due to prefetching, but it's not a downtime.
> > > > > > 
> > > > > > Not sure I got the point... Do you mean that when reach here, then
> > > > > > this page address is definitely one of the faulted addresses? I am not
> > > > > > 100% sure of this, but if you are sure, I am okay with it.
> > > > > Let me clarify.
> > > > > 
> > > > > > > >Shall we do this accouting only if we are sure the copied page address
> > > > > > > >is one of the page faulted addresses?
> > > > > Yes it's primary condition, due to there are could be another pages,
> > > > > which weren't faulted, they just was sent from source to destination,
> > > > > I called it prefetching.
> > > > > 
> > > > > I think I got why did you ask that question, because in this version
> > > > > all_vcpu_down and as a result total_downtime calculated incorrectly,
> > > > > it calculates every time when any page is copied, but it should
> > > > > be calculated only when faulted page copied, so only dc->vcpu_downtime
> > > > > was correctly calculated.
> > > > 
> > > > Exactly. I am afraid if we have such "prefetching" stuff then
> > > > total_downtime will be more than its real value.
> > > 
> > > It should be OK as long as we measure the time between
> > >   userfault reporting a page miss for an address 
> > >   and
> > >   place_page for *that same address*
> > > 
> > > any places for other pages are irrelevant.
> > > 
> > > (I still worry that this definition of 'downtime' is possibly
> > > arbitrary - since if all but one of the vCPUs are down we
> > > don't count it but it's obviously still a big impact).
> > Technically we count downtime per vCPU  and storing it in
> >     vcpu_downtime field of PostcopyDowntimeContext (in this version
> >     still DowntimeContext). I traced downtime per vCPU in previous version.
> > But it just traced as total_downtime in current version.
> > 
> > Also total_downtime is not possible to get on destination, due to
> > query-migrate is about MigrationState, but not MigrationIncomingState,
> > so I think need to extend it to MigrationIncomingState too.
> 
> I don't think that's too problematic; just add it to qmp_query_migrate;
> the only thing to be careful of is what happens if the incoming
> migration finishes during the info migrate is reading the
> MigrationIncomingState.
Do you mean none atomic read of s->state in qmp_query_migrate, if so
it's also a pre-copy problem. I saw you atomic operations like
postcopy_state_get/set.

> Dave
> 
> > > 
> > > Dave
> > > 
> > > > -- 
> > > > Peter Xu
> > > --
> > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > > 
> > 
> > -- 
> > 
> > BR
> > Alexey
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 

-- 

BR
Alexey
