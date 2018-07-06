Received: from eggs.gnu.org ([2001:4830:134:3::10]:57944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bala24@linux.vnet.ibm.com>) id 1fbQTU-0006V8-Q3
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 09:08:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bala24@linux.vnet.ibm.com>) id 1fbQTR-0006Jc-7T
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 09:08:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60408
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bala24@linux.vnet.ibm.com>)
	id 1fbQTR-0006JP-15
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 09:08:33 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w66BheNn062378
	for <qemu-devel@nongnu.org>; Fri, 6 Jul 2018 07:45:18 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2k26h1k27t-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 06 Jul 2018 07:45:18 -0400
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bala24@linux.vnet.ibm.com>;
	Fri, 6 Jul 2018 12:45:16 +0100
Date: Fri, 6 Jul 2018 17:15:09 +0530
From: Balamuruhan S <bala24@linux.vnet.ibm.com>
References: <20180705031755.3254-1-peterx@redhat.com>
	<20180706091716.GA9761@work-vm> <20180706105658.GB2661@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706105658.GB2661@work-vm>
Message-Id: <20180706114509.GC16585@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH for-3.0 0/9] migration: postcopy recovery
 unit test, bug fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org

On Fri, Jul 06, 2018 at 11:56:59AM +0100, Dr. David Alan Gilbert wrote:
> * Dr. David Alan Gilbert (dgilbert@redhat.com) wrote:
> > * Peter Xu (peterx@redhat.com) wrote:
> > > Based-on: <20180627132246.5576-1-peterx@redhat.com>
> > > 
> > > Based on the series to unbreak postcopy:
> > >   Subject: [PATCH v3 0/4] migation: unbreak postcopy recovery
> > >   Message-Id: <20180627132246.5576-1-peterx@redhat.com>
> > > 
> > > This series introduce a new postcopy recovery test.  The new test
> > > actually helped me to identify two bugs there so fix them as well
> > > before 3.0 release.
> > > 
> > > Patch 1: a trivial cleanup for existing postcopy ram load, which I
> > >          found a bit confusing during debugging the problem.
> > > 
> > > Patch 2-3: two bug fixes that address different issues.  Please see
> > >            the commit log for more information.
> > > 
> > > Patch 4-9: add the postcopy recovery unit test.
> > > 
> > > Please review.  Thanks,
> > 
> > Queued
> 
> Hi Peter,
>   There's a problem in there somewhere;  I'm getting
> an intermittent failure of the test if I run a make check -j 8    on my
> laptop.  Just running two copies of tests/migration-test in parallel
> sometimes triggers it (but not if I turn on QTEST_LOG!).
> But it's always failing with:
> 
>   ERROR:/home/dgilbert/git/migpull/tests/migration-test.c:373:migrate_recover: assertion failed: (qdict_haskey(rsp, "return"))

Hi Peter and Dave,

I have tested postcopy migration pause/recover after applying this
patchset on upstream Qemu,

Observation 1:

We loose the target after triggering migrate_pause,

source

# ppc64-softmmu/qemu-system-ppc64 --enable-kvm --nographic -vga none \
-machine pseries -m 64G,slots=128,maxmem=128G -smp 16,maxcpus=32 \
-device virtio-blk-pci,drive=rootdisk -drive \
file=/home/bala/sharing/hostos-ppc64le.qcow2,if=none,cache=none,format=qcow2,id=rootdisk \
-monitor telnet:127.0.0.1:1235,server,nowait -net nic,model=virtio \
-net user -redir tcp:2001::22 

qemu-system-ppc64: Detected IO failure for postcopy. Migration paused.

source Monitor
(qemu) migrate_set_capability postcopy-ram on
(qemu) migrate_set_parameter max-postcopy-bandwidth 4096
(qemu) migrate -d tcp:127.0.0.1:4444
(qemu) migrate_start_postcopy
(qemu) migrate_pause

(qemu) info migrate
globals:
store-global-state: on
only-migratable: off
send-configuration: on
send-section-footer: on
decompress-error-check: on
capabilities: xbzrle: off rdma-pin-all: off auto-converge: off
zero-blocks: off compress: off events: off postcopy-ram: on x-colo: off
release-ram: off block: off return-path: off pause-before-switchover:
off x-multifd: off dirty-bitmaps: off postcopy-blocktime: off
late-block-activate: off 
Migration status: postcopy-paused
total time: 371289 milliseconds
expected downtime: 656414 milliseconds
setup: 93 milliseconds
transferred ram: 690856 kbytes
throughput: 46.65 mbps
remaining ram: 3716864 kbytes
total ram: 67109120 kbytes
duplicate: 16631167 pages
skipped: 0 pages
normal: 135905 pages
normal bytes: 543620 kbytes
dirty sync count: 2
page size: 4 kbytes
multifd bytes: 0 kbytes
dirty pages rate: 626209 pages
postcopy request count: 395

source remains to be in postcopy-paused state as the target is lost.

target

# ppc64-softmmu/qemu-system-ppc64 --enable-kvm --nographic -vga none \
-machine pseries -m 64G,slots=128,maxmem=128G -smp 16,maxcpus=32 \
-device virtio-blk-pci,drive=rootdisk -drive \
file=/home/bala/sharing/hostos-ppc64le.qcow2,if=none,cache=none,format=qcow2,id=rootdisk
\
-monitor telnet:127.0.0.1:1235,server,nowait -net nic,model=virtio \
-net user -redir tcp:2001::22 -incoming tcp:127.0.0.1:4444

Error observed
check_section_footer: Read section footer failed: -5
qemu-system-ppc64: postcopy_ram_listen_thread: loadvm failed: -22
[  188.815436] Unable to handle kernel paging request for instruction
fetch

Target Monitor

(qemu) migrate_set_capability postcopy-ram on


Observation 2:
Unlike error observed by Dave in Qtest it hangs for me waiting for
the migration to complete, but the source remains to be in
migration-paused state.

# time QTEST_QEMU_BINARY=./ppc64-softmmu/qemu-system-ppc64
# ./tests/migration-test
/ppc64/migration/deprecated: OK
/ppc64/migration/bad_dest: OK
/ppc64/migration/postcopy/unix: OK
/ppc64/migration/postcopy/recovery: ^C

real    21m55.176s
user    2m28.800s
sys 4m55.980s

-- Bala

> 
> Dave
> 
> > > Peter Xu (9):
> > >   migration: simplify check to use qemu file buffer
> > >   migration: loosen recovery check when load vm
> > >   migration: fix incorrect bitmap size calculation
> > >   tests: introduce migrate_postcopy_* helpers
> > >   tests: allow migrate() to take extra flags
> > >   tests: introduce migrate_query*() helpers
> > >   tests: introduce wait_for_migration_status()
> > >   tests: add postcopy recovery test
> > >   tests: hide stderr for postcopy recovery test
> > > 
> > >  migration/ram.c        |  21 +++--
> > >  migration/savevm.c     |  16 ++--
> > >  tests/migration-test.c | 198 ++++++++++++++++++++++++++++++++---------
> > >  3 files changed, 176 insertions(+), 59 deletions(-)
> > > 
> > > -- 
> > > 2.17.1
> > > 
> > > 
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 
