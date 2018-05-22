Received: from eggs.gnu.org ([2001:4830:134:3::10]:50742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bala24@linux.vnet.ibm.com>) id 1fL5YF-0001hS-Tn
	for qemu-devel@nongnu.org; Tue, 22 May 2018 07:34:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bala24@linux.vnet.ibm.com>) id 1fL5YC-00022y-O0
	for qemu-devel@nongnu.org; Tue, 22 May 2018 07:33:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37368)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bala24@linux.vnet.ibm.com>)
	id 1fL5YC-00021Z-E1
	for qemu-devel@nongnu.org; Tue, 22 May 2018 07:33:56 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4MBTUeN061742
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 07:33:52 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2j4gv7cbuk-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 07:33:51 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bala24@linux.vnet.ibm.com>;
	Tue, 22 May 2018 12:33:49 +0100
Date: Tue, 22 May 2018 17:03:43 +0530
From: Balamuruhan S <bala24@linux.vnet.ibm.com>
References: <20180425071040.25542-1-bala24@linux.vnet.ibm.com>
	<20180425071040.25542-2-bala24@linux.vnet.ibm.com>
	<20180501143737.GA25113@9.122.211.20>
	<d4e1788d-64c9-4b43-5fd6-4008b616362e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4e1788d-64c9-4b43-5fd6-4008b616362e@redhat.com>
Message-Id: <20180522113343.GA11538@9.122.211.20>
Subject: Re: [Qemu-devel] [PATCH v3 1/1] migration: calculate
 expected_downtime with ram_bytes_remaining()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org

On Wed, May 16, 2018 at 03:43:48PM +0200, Laurent Vivier wrote:
> Hi Bala,
> 
> I've tested you patch migrating a pseries between a P9 host and a P8
> host with 1G huge page size on the P9 side and 16MB on P8 side and the
> information are strange now.
Hi Laurent,

Thank you for testing the patch,

I too have worked on recreate the same setup and my observation is that
remaining ram is reducing where as expected_downtime remains to be same
as 300 which is same as downtime-limit because, it gets assigned in
migrate_fd_connect() as 300,

s->expected_downtime = s->parameters.downtime_limit;

expected_downtime is not calculated immediately after migration is
started, it takes time to calculate expected_downtime even without this patch
because of the condition in migration_update_counters(), 

/*
 * if we haven't sent anything, we don't want to
 * recalculate. 10000 is a small enough number for our purposes
 */
if (ram_counters.dirty_pages_rate && transferred > 10000) {
    calculate expected_downtime
}

> "remaining ram" doesn't change, and after a while it can be set to "0"
> and estimated downtime is 0 too, but the migration is not completed and

I see remaining ram reduces continuously to a point and bumps up again.

migration completes successfully after setting downtime-limit same as
expected_dowtime which is calculated after it enters the condition
mentioned above,

Tested with this patch,

(qemu) info migrate
globals:
store-global-state: on
only-migratable: off
send-configuration: on
send-section-footer: on
capabilities: xbzrle: off rdma-pin-all: off auto-converge: off zero-blocks: off compress: off events: off postcopy-ram: off x-colo: off release-ram: off block: off return-path: off pause-before-switchover: off x-multifd: off dirty-bitmaps: off postcopy-blocktime: off
Migration status: active
total time: 50753 milliseconds
expected downtime: 46710 milliseconds
setup: 15 milliseconds
transferred ram: 582332 kbytes
throughput: 95.33 mbps
remaining ram: 543552 kbytes
total ram: 8388864 kbytes
duplicate: 1983194 pages
skipped: 0 pages
normal: 140950 pages
normal bytes: 563800 kbytes
dirty sync count: 2
page size: 4 kbytes
dirty pages rate: 49351 pages

(qemu) migrate_set_parameter downtime-limit 46710

(qemu) info migrate
globals:
store-global-state: on
only-migratable: off
send-configuration: on
send-section-footer: on
capabilities: xbzrle: off rdma-pin-all: off auto-converge: off zero-blocks: off compress: off events: off postcopy-ram: off x-colo: off release-ram: off block: off return-path: off pause-before-switchover: off x-multifd: off dirty-bitmaps: off postcopy-blocktime: off
Migration status: completed
total time: 118389 milliseconds
downtime: 20324 milliseconds
setup: 15 milliseconds
transferred ram: 1355349 kbytes
throughput: 94.07 mbps
remaining ram: 0 kbytes
total ram: 8388864 kbytes
duplicate: 2139396 pages
skipped: 0 pages
normal: 333485 pages
normal bytes: 1333940 kbytes
dirty sync count: 6
page size: 4 kbytes


> "transferred ram" continues to increase.

If we do not set the downtime-limit, the remaining ram and transferred
ram gets bumped up and migration continues infinitely.

-- Bala
> 
> so think there is a problem somewhere...
> 
> thanks,
> Laurent
> 
> On 01/05/2018 16:37, Balamuruhan S wrote:
> > Hi,
> > 
> > Dave, David and Juan if you guys are okay with the patch, please
> > help to merge it.
> > 
> > Thanks,
> > Bala
> > 
> > On Wed, Apr 25, 2018 at 12:40:40PM +0530, Balamuruhan S wrote:
> >> expected_downtime value is not accurate with dirty_pages_rate * page_size,
> >> using ram_bytes_remaining would yeild it correct. It will initially be a
> >> gross over-estimate, but for for non-converging migrations it should
> >> approach a reasonable estimate later on.
> >>
> >> currently bandwidth and expected_downtime value are calculated in
> >> migration_update_counters() during each iteration from
> >> migration_thread(), where as remaining ram is calculated in
> >> qmp_query_migrate() when we actually call "info migrate". Due to this
> >> there is some difference in expected_downtime value being calculated.
> >>
> >> with this patch bandwidth, expected_downtime and remaining ram are
> >> calculated in migration_update_counters(), retrieve the same value during
> >> "info migrate". By this approach we get almost close enough value.
> >>
> >> Reported-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> >> Signed-off-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
> >> ---
> >>  migration/migration.c | 11 ++++++++---
> >>  migration/migration.h |  1 +
> >>  2 files changed, 9 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/migration/migration.c b/migration/migration.c
> >> index 52a5092add..5d721ee481 100644
> >> --- a/migration/migration.c
> >> +++ b/migration/migration.c
> >> @@ -614,7 +614,7 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
> >>      }
> >>
> >>      if (s->state != MIGRATION_STATUS_COMPLETED) {
> >> -        info->ram->remaining = ram_bytes_remaining();
> >> +        info->ram->remaining = s->ram_bytes_remaining;
> >>          info->ram->dirty_pages_rate = ram_counters.dirty_pages_rate;
> >>      }
> >>  }
> >> @@ -2227,6 +2227,7 @@ static void migration_update_counters(MigrationState *s,
> >>      transferred = qemu_ftell(s->to_dst_file) - s->iteration_initial_bytes;
> >>      time_spent = current_time - s->iteration_start_time;
> >>      bandwidth = (double)transferred / time_spent;
> >> +    s->ram_bytes_remaining = ram_bytes_remaining();
> >>      s->threshold_size = bandwidth * s->parameters.downtime_limit;
> >>
> >>      s->mbps = (((double) transferred * 8.0) /
> >> @@ -2237,8 +2238,12 @@ static void migration_update_counters(MigrationState *s,
> >>       * recalculate. 10000 is a small enough number for our purposes
> >>       */
> >>      if (ram_counters.dirty_pages_rate && transferred > 10000) {
> >> -        s->expected_downtime = ram_counters.dirty_pages_rate *
> >> -            qemu_target_page_size() / bandwidth;
> >> +        /*
> >> +         * It will initially be a gross over-estimate, but for for
> >> +         * non-converging migrations it should approach a reasonable estimate
> >> +         * later on
> >> +         */
> >> +        s->expected_downtime = s->ram_bytes_remaining / bandwidth;
> >>      }
> >>
> >>      qemu_file_reset_rate_limit(s->to_dst_file);
> >> diff --git a/migration/migration.h b/migration/migration.h
> >> index 8d2f320c48..8584f8e22e 100644
> >> --- a/migration/migration.h
> >> +++ b/migration/migration.h
> >> @@ -128,6 +128,7 @@ struct MigrationState
> >>      int64_t downtime_start;
> >>      int64_t downtime;
> >>      int64_t expected_downtime;
> >> +    int64_t ram_bytes_remaining;
> >>      bool enabled_capabilities[MIGRATION_CAPABILITY__MAX];
> >>      int64_t setup_time;
> >>      /*
> >> -- 
> >> 2.14.3
> >>
> >>
> > 
> > 
> 
> 
