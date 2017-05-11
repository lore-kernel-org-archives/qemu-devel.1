Received: from eggs.gnu.org ([2001:4830:134:3::10]:41263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1d8iEP-0000xB-LQ
	for qemu-devel@nongnu.org; Thu, 11 May 2017 03:09:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1d8iEL-0000js-Jc
	for qemu-devel@nongnu.org; Thu, 11 May 2017 03:09:49 -0400
Received: from mailout4.w1.samsung.com ([210.118.77.14]:50718)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1d8iEL-0000he-Br
	for qemu-devel@nongnu.org; Thu, 11 May 2017 03:09:45 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout4.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0OPS00KSM186D310@mailout4.w1.samsung.com> for
	qemu-devel@nongnu.org; Thu, 11 May 2017 08:09:42 +0100 (BST)
Date: Thu, 11 May 2017 10:09:38 +0300
From: Alexey <a.perevalov@samsung.com>
Message-id: <20170511070938.GF4201@aperevalov-ubuntu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-disposition: inline
In-reply-to: <20170511045655.GE28293@pxdev.xzpeter.org>
References: <20170428100012.GB22801@pxdev.xzpeter.org>
	<d018d4a6-4b50-3f36-fe69-e232b63bebf0@samsung.com>
	<20170508062906.GC2820@pxdev.xzpeter.org>
	<20170508090807.GA4201@aperevalov-ubuntu>
	<20170509082622.GI2820@pxdev.xzpeter.org>
	<20170509094033.GB2089@work-vm> <20170509094434.GF1669@redhat.com>
	<20170510154650.GC4201@aperevalov-ubuntu>
	<20170510155859.GA31558@redhat.com>
	<20170511045655.GE28293@pxdev.xzpeter.org>
	<CGME20170511070940eucas1p2ca3e44c15c84eef00e33d755a11c0ea1@eucas1p2.samsung.com>
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
To: Peter Xu <peterx@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, i.maximets@samsung.com, qemu-devel@nongnu.org, f4bug@amsat.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Thu, May 11, 2017 at 12:56:55PM +0800, Peter Xu wrote:
> On Wed, May 10, 2017 at 04:58:59PM +0100, Daniel P. Berrange wrote:
> > On Wed, May 10, 2017 at 06:46:50PM +0300, Alexey wrote:
> > > On Tue, May 09, 2017 at 10:44:34AM +0100, Daniel P. Berrange wrote:
> > > > On Tue, May 09, 2017 at 10:40:34AM +0100, Dr. David Alan Gilbert wrote:
> > > > > * Peter Xu (peterx@redhat.com) wrote:
> > > > > > On Mon, May 08, 2017 at 12:08:07PM +0300, Alexey wrote:
> > > > > > > On Mon, May 08, 2017 at 02:29:06PM +0800, Peter Xu wrote:
> > > > > > > > On Fri, Apr 28, 2017 at 02:11:19PM +0300, Alexey Perevalov wrote:
> > > > > > > > > On 04/28/2017 01:00 PM, Peter Xu wrote:
> > > > > > > > > >On Fri, Apr 28, 2017 at 09:57:37AM +0300, Alexey Perevalov wrote:
> > > > > > > > > >>This patch provides downtime calculation per vCPU,
> > > > > > > > > >>as a summary and as a overlapped value for all vCPUs.
> > > > > > > > > >>
> > > > > > > > > >>This approach was suggested by Peter Xu, as an improvements of
> > > > > > > > > >>previous approch where QEMU kept tree with faulted page address and cpus bitmask
> > > > > > > > > >>in it. Now QEMU is keeping array with faulted page address as value and vCPU
> > > > > > > > > >>as index. It helps to find proper vCPU at UFFD_COPY time. Also it keeps
> > > > > > > > > >>list for downtime per vCPU (could be traced with page_fault_addr)
> > > > > > > > > >>
> > > > > > > > > >>For more details see comments for get_postcopy_total_downtime
> > > > > > > > > >>implementation.
> > > > > > > > > >>
> > > > > > > > > >>Downtime will not calculated if postcopy_downtime field of
> > > > > > > > > >>MigrationIncomingState wasn't initialized.
> > > > > > > > > >>
> > > > > > > > > >>Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
> > > > > > > > > >>---
> > > > > > > > > >>  include/migration/migration.h |   3 ++
> > > > > > > > > >>  migration/migration.c         | 103 ++++++++++++++++++++++++++++++++++++++++++
> > > > > > > > > >>  migration/postcopy-ram.c      |  20 +++++++-
> > > > > > > > > >>  migration/trace-events        |   6 ++-
> > > > > > > > > >>  4 files changed, 130 insertions(+), 2 deletions(-)
> > > > > > > > > >>
> > > > > > > > > >>diff --git a/include/migration/migration.h b/include/migration/migration.h
> > > > > > > > > >>index e8fb68f..a22f9ce 100644
> > > > > > > > > >>--- a/include/migration/migration.h
> > > > > > > > > >>+++ b/include/migration/migration.h
> > > > > > > > > >>@@ -139,6 +139,9 @@ void migration_incoming_state_destroy(void);
> > > > > > > > > >>   * Functions to work with downtime context
> > > > > > > > > >>   */
> > > > > > > > > >>  struct DowntimeContext *downtime_context_new(void);
> > > > > > > > > >>+void mark_postcopy_downtime_begin(uint64_t addr, int cpu);
> > > > > > > > > >>+void mark_postcopy_downtime_end(uint64_t addr);
> > > > > > > > > >>+uint64_t get_postcopy_total_downtime(void);
> > > > > > > > > >>  struct MigrationState
> > > > > > > > > >>  {
> > > > > > > > > >>diff --git a/migration/migration.c b/migration/migration.c
> > > > > > > > > >>index ec76e5c..2c6f150 100644
> > > > > > > > > >>--- a/migration/migration.c
> > > > > > > > > >>+++ b/migration/migration.c
> > > > > > > > > >>@@ -2150,3 +2150,106 @@ PostcopyState postcopy_state_set(PostcopyState new_state)
> > > > > > > > > >>      return atomic_xchg(&incoming_postcopy_state, new_state);
> > > > > > > > > >>  }
> > > > > > > > > >>+void mark_postcopy_downtime_begin(uint64_t addr, int cpu)
> > > > > > > > > >>+{
> > > > > > > > > >>+    MigrationIncomingState *mis = migration_incoming_get_current();
> > > > > > > > > >>+    DowntimeContext *dc;
> > > > > > > > > >>+    if (!mis->downtime_ctx || cpu < 0) {
> > > > > > > > > >>+        return;
> > > > > > > > > >>+    }
> > > > > > > > > >>+    dc = mis->downtime_ctx;
> > > > > > > > > >>+    dc->vcpu_addr[cpu] = addr;
> > > > > > > > > >>+    dc->last_begin = dc->page_fault_vcpu_time[cpu] =
> > > > > > > > > >>+        qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> > > > > > > > > >>+
> > > > > > > > > >>+    trace_mark_postcopy_downtime_begin(addr, dc, dc->page_fault_vcpu_time[cpu],
> > > > > > > > > >>+            cpu);
> > > > > > > > > >>+}
> > > > > > > > > >>+
> > > > > > > > > >>+void mark_postcopy_downtime_end(uint64_t addr)
> > > > > > > > > >>+{
> > > > > > > > > >>+    MigrationIncomingState *mis = migration_incoming_get_current();
> > > > > > > > > >>+    DowntimeContext *dc;
> > > > > > > > > >>+    int i;
> > > > > > > > > >>+    bool all_vcpu_down = true;
> > > > > > > > > >>+    int64_t now;
> > > > > > > > > >>+
> > > > > > > > > >>+    if (!mis->downtime_ctx) {
> > > > > > > > > >>+        return;
> > > > > > > > > >>+    }
> > > > > > > > > >>+    dc = mis->downtime_ctx;
> > > > > > > > > >>+    now = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> > > > > > > > > >>+
> > > > > > > > > >>+    /* check all vCPU down,
> > > > > > > > > >>+     * QEMU has bitmap.h, but even with bitmap_and
> > > > > > > > > >>+     * will be a cycle */
> > > > > > > > > >>+    for (i = 0; i < smp_cpus; i++) {
> > > > > > > > > >>+        if (dc->vcpu_addr[i]) {
> > > > > > > > > >>+            continue;
> > > > > > > > > >>+        }
> > > > > > > > > >>+        all_vcpu_down = false;
> > > > > > > > > >>+        break;
> > > > > > > > > >>+    }
> > > > > > > > > >>+
> > > > > > > > > >>+    if (all_vcpu_down) {
> > > > > > > > > >>+        dc->total_downtime += now - dc->last_begin;
> > > > > > > > > >Shall we do this accouting only if we are sure the copied page address
> > > > > > > > > >is one of the page faulted addresses? Can it be some other page? I
> > > > > > > > > >don't know. But since we have the loop below to make sure of it, why
> > > > > > > > > >not?
> > > > > > > > > no, the downtime implies since page fault till the
> > > > > > > > > page will be copied.
> > > > > > > > > Yes another pages could be copied as well as pagefaulted,
> > > > > > > > > and they are copied due to prefetching, but it's not a downtime.
> > > > > > > > 
> > > > > > > > Not sure I got the point... Do you mean that when reach here, then
> > > > > > > > this page address is definitely one of the faulted addresses? I am not
> > > > > > > > 100% sure of this, but if you are sure, I am okay with it.
> > > > > > > Let me clarify.
> > > > > > > 
> > > > > > > > > >Shall we do this accouting only if we are sure the copied page address
> > > > > > > > > >is one of the page faulted addresses?
> > > > > > > Yes it's primary condition, due to there are could be another pages,
> > > > > > > which weren't faulted, they just was sent from source to destination,
> > > > > > > I called it prefetching.
> > > > > > > 
> > > > > > > I think I got why did you ask that question, because in this version
> > > > > > > all_vcpu_down and as a result total_downtime calculated incorrectly,
> > > > > > > it calculates every time when any page is copied, but it should
> > > > > > > be calculated only when faulted page copied, so only dc->vcpu_downtime
> > > > > > > was correctly calculated.
> > > > > > 
> > > > > > Exactly. I am afraid if we have such "prefetching" stuff then
> > > > > > total_downtime will be more than its real value.
> > > > > 
> > > > > It should be OK as long as we measure the time between
> > > > >   userfault reporting a page miss for an address 
> > > > >   and
> > > > >   place_page for *that same address*
> > > > > 
> > > > > any places for other pages are irrelevant.
> > > > > 
> > > > > (I still worry that this definition of 'downtime' is possibly
> > > > > arbitrary - since if all but one of the vCPUs are down we
> > > > > don't count it but it's obviously still a big impact).
> > > > 
> > > > Can we also *not* call it "downtime", as it is measuring a very different
> > > > thing than the "downtime" we have measured today on the source during
> > > > pre-copy migration.
> > > 
> > > As I know downtime in pre-copy migration it's a time since all vCPU
> > > were disabled on source till enabling these vCPU on destination,
> > > but it's continuous time. So the meaning of both downtime is the same.
> > > It's time when all vCPU are down.
> > 
> > It is really not the same. In pre-copy, all the CPUs are in an explicit
> > "stopped" state for a continuous period of time. In post-copy the CPUs
> > are all in the "running" state, but repeatedly get blocked with arbitrary
> > time intervals to fetch pages from the source. This is totally different
> > information being reported, so should have a different name.
> > 
> > Calling it downtime will also lead to confusion wrt to the "max downtime"
> > tunable parameter, which is not at all relevant here.
> 
> Indeed.
> 
> A big difference that this "postcopy downtime" differs from original
> downtime is that, this new "downtime" may even not be detected by
> guest user. It just like how operating system allocate time slides -
> the "downtime" during postcopy phase is intermittent and I believe the
> guest user can hardly differenciate that from general UI process
> switching on some platforms.
> 
> Since we are at this, Alex, could I ask in what case do we really care
> about this summation of "postcopy downtime"? Or say, how this
> requirement come from?
Suspend during postcopy migration leads to network packet drop in
network specific software, e.g. based on DPDK or another framework.
It's interesting to know amount of time when all vCPU were down as well
as each vCPU, "downtime" on source side doesn't give us real information
about guest on source side.
Looks like I forget to add rationale in this version.

Another way of measure it, it's using ping, but precision of the method isn't well.
Or use something inside guest.

In previous series V2 I also included patch to trace procfs's process
state/stack. And I found that not only vCPU is suspended due to page
fault.

> 
> Thanks,
> 
> -- 
> Peter Xu
> 

-- 

BR
Alexey
