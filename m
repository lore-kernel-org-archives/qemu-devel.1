Received: from eggs.gnu.org ([2001:4830:134:3::10]:40393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fdXJJ-0005Id-RZ
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 04:50:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fdXJE-0003J1-S6
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 04:50:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33500 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fdXJE-0003DE-Kf
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 04:50:44 -0400
Date: Thu, 12 Jul 2018 09:50:32 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180712085032.GA2610@work-vm>
References: <20180705031755.3254-1-peterx@redhat.com>
	<20180706091716.GA9761@work-vm> <20180706105658.GB2661@work-vm>
	<20180706124654.GA4141@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706124654.GA4141@localhost.localdomain>
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
To: Balamuruhan S <bala24@linux.vnet.ibm.com>
Cc: peterx@redhat.com, qemu-devel@nongnu.org

* Balamuruhan S (bala24@linux.vnet.ibm.com) wrote:
> On Fri, Jul 06, 2018 at 11:56:59AM +0100, Dr. David Alan Gilbert wrote:
> > * Dr. David Alan Gilbert (dgilbert@redhat.com) wrote:
> > > * Peter Xu (peterx@redhat.com) wrote:
> > > > Based-on: <20180627132246.5576-1-peterx@redhat.com>
> > > > 
> > > > Based on the series to unbreak postcopy:
> > > >   Subject: [PATCH v3 0/4] migation: unbreak postcopy recovery
> > > >   Message-Id: <20180627132246.5576-1-peterx@redhat.com>
> > > > 
> > > > This series introduce a new postcopy recovery test.  The new test
> > > > actually helped me to identify two bugs there so fix them as well
> > > > before 3.0 release.
> > > > 
> > > > Patch 1: a trivial cleanup for existing postcopy ram load, which I
> > > >          found a bit confusing during debugging the problem.
> > > > 
> > > > Patch 2-3: two bug fixes that address different issues.  Please see
> > > >            the commit log for more information.
> > > > 
> > > > Patch 4-9: add the postcopy recovery unit test.
> > > > 
> > > > Please review.  Thanks,
> > > 
> > > Queued
> > 
> > Hi Peter,
> >   There's a problem in there somewhere;  I'm getting
> > an intermittent failure of the test if I run a make check -j 8    on my
> > laptop.  Just running two copies of tests/migration-test in parallel
> > sometimes triggers it (but not if I turn on QTEST_LOG!).
> > But it's always failing with:
> > 
> >   ERROR:/home/dgilbert/git/migpull/tests/migration-test.c:373:migrate_recover: assertion failed: (qdict_haskey(rsp, "return"))
> > 
> > Dave
> 
> Hi Peter, Dave,

Hi Bala,

> I have applied this patchset in upstream Qemu to test postcopy
> pause/recovery.

Are you still seeing this with the set that got merged into 3.0-rc0?
The second of your errors looks similar to problems with the race
we had before Peter fixed it; but the set that I merged passed a 'make
check' on a Power box.

Dave

> I observed error after triggering recovery command from source monitor
> where the target is lost and the source remains to be in `postcopy-pause`
> state.
> 
> Please find my observation below,
> 
> Source:
> 
> # ppc64-softmmu/qemu-system-ppc64 --enable-kvm --nographic -vga none -machine \
> pseries -m 64G,slots=128,maxmem=128G -smp 16,maxcpus=32 -device virtio-blk-pci,drive=rootdisk \
> -drive file=/home/hostos-ppc64le.qcow2,if=none,cache=none,format=qcow2,id=rootdisk \
> -monitor telnet:127.0.0.1:1234,server,nowait -net nic,model=virtio -net user \
> -redir tcp:2000::22
> 
> qemu-system-ppc64: Detected IO failure for postcopy. Migration paused.
> 
> Source Monitor:
> 
> (qemu) migrate_set_capability postcopy-ram on
> (qemu) migrate_set_parameter max-postcopy-bandwidth 4096
> (qemu) migrate -d tcp:127.0.0.1:4444
> (qemu) migrate_start_postcopy
> (qemu) migrate_pause
> (qemu) migrate -r tcp:127.0.0.1:4446
> 
> After triggering recovery, target is lost with the error mentioned below
> and source remains to be in `postcopy-paused` state
> 
> (qemu) info migrate
> globals:
> store-global-state: on
> only-migratable: off
> send-configuration: on
> send-section-footer: on
> decompress-error-check: on
> capabilities: xbzrle: off rdma-pin-all: off auto-converge: off
> zero-blocks: off \
> compress: off events: off postcopy-ram: on x-colo: off release-ram: off
> block: off return-path: off pause-before-switchover: off x-multifd: off \
> dirty-bitmaps: off
> postcopy-blocktime: off late-block-activate: off 
> Migration status: postcopy-recover
> total time: 78818 milliseconds
> expected downtime: 300 milliseconds
> setup: 169 milliseconds
> transferred ram: 177749 kbytes
> throughput: 63.72 mbps
> remaining ram: 28061376 kbytes
> total ram: 67109120 kbytes
> duplicate: 9742102 pages
> skipped: 0 pages
> normal: 22986 pages
> normal bytes: 91944 kbytes
> dirty sync count: 2
> page size: 4 kbytes
> multifd bytes: 0 kbytes
> dirty pages rate: 1273187 pages
> postcopy request count: 236
> 
> 
> Target:
> 
> # ppc64-softmmu/qemu-system-ppc64 --enable-kvm --nographic -vga none -machine \
> pseries -m 64G,slots=128,maxmem=128G -smp 16,maxcpus=32 -device virtio-blk-pci,drive=rootdisk \
> -drive file=/home/bala/sharing/hostos-ppc64le.qcow2,if=none,cache=none,format=qcow2,id=rootdisk \
> -monitor telnet:127.0.0.1:1235,server,nowait -net nic,model=virtio -net user \
> -redir tcp:2001::22 -incoming tcp:127.0.0.1:4444
> 
> 
> qemu-system-ppc64: check_section_footer: Read section footer failed: -5
> qemu-system-ppc64: Detected IO failure for postcopy. Migration paused.
> qemu-system-ppc64: Not a migration stream
> qemu-system-ppc64: load of migration failed: Invalid argument
> 
> 
> Target Monitor:
> 
> (qemu) migrate_set_capability postcopy-ram on
> (qemu) migrate_recover tcp:127.0.0.1:4446
> (qemu) Connection closed by foreign host.
> 
> QTest:
> 
> Also with respect to Qtest, I have tested it and the recovery test
> doesn't complete as it waits on the source for "completed" but due to this
> issue source remains to be in `postcopy-paused`
> 
> `migrate_postcopy_complete(from, to);`
> 
> but it actually doesn't end.
> 
> As it did not complete, I cancelled it forcefully
> 
> # time QTEST_QEMU_BINARY=./ppc64-softmmu/qemu-system-ppc64 ./tests/migration-test
> /ppc64/migration/deprecated: OK
> /ppc64/migration/bad_dest: OK
> /ppc64/migration/postcopy/unix: OK
> /ppc64/migration/postcopy/recovery: ^C
> 
> real    21m55.176s
> user    2m28.800s
> sys 4m55.980s
> 
> -- Bala
> > 
> > > > Peter Xu (9):
> > > >   migration: simplify check to use qemu file buffer
> > > >   migration: loosen recovery check when load vm
> > > >   migration: fix incorrect bitmap size calculation
> > > >   tests: introduce migrate_postcopy_* helpers
> > > >   tests: allow migrate() to take extra flags
> > > >   tests: introduce migrate_query*() helpers
> > > >   tests: introduce wait_for_migration_status()
> > > >   tests: add postcopy recovery test
> > > >   tests: hide stderr for postcopy recovery test
> > > > 
> > > >  migration/ram.c        |  21 +++--
> > > >  migration/savevm.c     |  16 ++--
> > > >  tests/migration-test.c | 198 ++++++++++++++++++++++++++++++++---------
> > > >  3 files changed, 176 insertions(+), 59 deletions(-)
> > > > 
> > > > -- 
> > > > 2.17.1
> > > > 
> > > > 
> > > --
> > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
