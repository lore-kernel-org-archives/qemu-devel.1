Received: from eggs.gnu.org ([2001:4830:134:3::10]:59487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fZvuS-0005e8-Pc
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 06:18:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fZvuO-0003o4-9p
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 06:18:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59484 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fZvuO-0003no-3m
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 06:18:12 -0400
Date: Mon, 2 Jul 2018 18:18:03 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180702101803.GM2455@xz-mi>
References: <20180627132246.5576-1-peterx@redhat.com>
	<20180702080445.GA7894@localhost.localdomain>
	<20180702084618.GL2455@xz-mi>
	<20180702094241.GA6746@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180702094241.GA6746@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH v3 0/4] migation: unbreak postcopy recovery
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Balamuruhan S <bala24@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org

On Mon, Jul 02, 2018 at 03:12:41PM +0530, Balamuruhan S wrote:
> On Mon, Jul 02, 2018 at 04:46:18PM +0800, Peter Xu wrote:
> > On Mon, Jul 02, 2018 at 01:34:45PM +0530, Balamuruhan S wrote:
> > > On Wed, Jun 27, 2018 at 09:22:42PM +0800, Peter Xu wrote:
> > > > v3:
> > > > - keep the recovery logic even for RDMA by dropping the 3rd patch and
> > > >   touch up the original 4th patch (current 3rd patch) to suite that [Dave]
> > > > 
> > > > v2:
> > > > - break the first patch into several
> > > > - fix a QEMUFile leak
> > > > 
> > > > Please review.  Thanks,
> > > Hi Peter,
> > 
> > Hi, Balamuruhan,
> > 
> > Glad to know that you are playing this stuff with ppc.  I think the
> > major steps are correct, though...
> > 
> 
> Thank you Peter for correcting my mistake, It works like a charm.
> Nice feature!
> 
> Tested-by: Balamuruhan S <bala24@linux.vnet.ibm.com>

Thanks!  Good to know that it worked.

> 
> > > 
> > > I have applied this patchset with upstream Qemu for testing postcopy
> > > pause recover feature in PowerPC,
> > > 
> > > I used NFS shared qcow2 between source and target host
> > > 
> > > source:
> > > # ppc64-softmmu/qemu-system-ppc64 --enable-kvm --nographic -vga none \
> > > -machine pseries -m 64G,slots=128,maxmem=128G -smp 16,maxcpus=32 \
> > > -device virtio-blk-pci,drive=rootdisk -drive \
> > > file=/home/bala/sharing/hostos-ppc64le.qcow2,if=none,cache=none,format=qcow2,id=rootdisk \
> > > -monitor telnet:127.0.0.1:1234,server,nowait -net nic,model=virtio \
> > > -net user -redir tcp:2000::22
> > > 
> > > To keep the VM with workload I ran stress-ng inside guest,
> > > 
> > > # stress-ng --cpu 6 --vm 6 --io 6
> > > 
> > > target:
> > > # ppc64-softmmu/qemu-system-ppc64 --enable-kvm --nographic -vga none \
> > > -machine pseries -m 64G,slots=128,maxmem=128G -smp 16,maxcpus=32 \
> > > -device virtio-blk-pci,drive=rootdisk -drive \
> > > file=/home/bala/sharing/hostos-ppc64le.qcow2,if=none,cache=none,format=qcow2,id=rootdisk \
> > > -monitor telnet:127.0.0.1:1235,server,nowait -net nic,model=virtio \
> > > -net user -redir tcp:2001::22 -incoming tcp:0:4445
> > > 
> > > enabled postcopy on both source and destination from qemu monitor
> > > 
> > > (qemu) migrate_set_capability postcopy-ram on
> > > 
> > > From source qemu monitor,
> > > (qemu) migrate -d tcp:10.45.70.203:4445
> > 
> > [1]
> > 
> > > (qemu) info migrate
> > > globals:
> > > store-global-state: on
> > > only-migratable: off
> > > send-configuration: on
> > > send-section-footer: on
> > > decompress-error-check: on
> > > capabilities: xbzrle: off rdma-pin-all: off auto-converge: off
> > > zero-blocks: off compress: off events: off postcopy-ram: on x-colo: off
> > > release-ram: off block: off return-path: off pause-before-switchover:
> > > off x-multifd: off dirty-bitmaps: off postcopy-blocktime: off
> > > late-block-activate: off 
> > > Migration status: active
> > > total time: 2331 milliseconds
> > > expected downtime: 300 milliseconds
> > > setup: 65 milliseconds
> > > transferred ram: 38914 kbytes
> > > throughput: 273.16 mbps
> > > remaining ram: 67063784 kbytes
> > > total ram: 67109120 kbytes
> > > duplicate: 1627 pages
> > > skipped: 0 pages
> > > normal: 9706 pages
> > > normal bytes: 38824 kbytes
> > > dirty sync count: 1
> > > page size: 4 kbytes
> > > multifd bytes: 0 kbytes
> > > 
> > > triggered postcopy from source,
> > > (qemu) migrate_start_postcopy
> > > 
> > > After triggering postcopy from source, in target I tried to pause the
> > > postcopy migration
> > > 
> > > (qemu) migrate_pause
> > > 
> > > In target I see error as,
> > > error while loading state section id 4(ram)
> > > qemu-system-ppc64: Detected IO failure for postcopy. Migration paused.
> > > 
> > > In source I see error as,
> > > qemu-system-ppc64: Detected IO failure for postcopy. Migration paused.
> > > 
> > > Later from target I try for recovery from target monitor,
> > > (qemu) migrate_recover qemu+ssh://10.45.70.203/system
> > 
> > ... here is that URI for libvirt only?
> > 
> > Normally I'll use something similar to [1] above.
> > 
> > > Migrate recovery is triggered already
> > 
> > And this means that you have already sent one recovery command before
> > hand.  In the future we'd better allow the recovery command to be run
> > more than once (in case the first one mistyped...).
> > 
> > > 
> > > but in source still it remains to be in postcopy-paused state
> > > (qemu) info migrate
> > > globals:
> > > store-global-state: on
> > > only-migratable: off
> > > send-configuration: on
> > > send-section-footer: on
> > > decompress-error-check: on
> > > capabilities: xbzrle: off rdma-pin-all: off auto-converge: off
> > > zero-blocks: off compress: off events: off postcopy-ram: on x-colo: off
> > > release-ram: off block: off return-path: off pause-before-switchover:
> > > off x-multifd: off dirty-bitmaps: off postcopy-blocktime: off
> > > late-block-activate: off 
> > > Migration status: postcopy-paused
> > > total time: 222841 milliseconds
> > > expected downtime: 382991 milliseconds
> > > setup: 65 milliseconds
> > > transferred ram: 385270 kbytes
> > > throughput: 265.06 mbps
> > > remaining ram: 8150528 kbytes
> > > total ram: 67109120 kbytes
> > > duplicate: 14679647 pages
> > > skipped: 0 pages
> > > normal: 63937 pages
> > > normal bytes: 255748 kbytes
> > > dirty sync count: 2
> > > page size: 4 kbytes
> > > multifd bytes: 0 kbytes
> > > dirty pages rate: 854740 pages
> > > postcopy request count: 374
> > > 
> > > later I also tried to recover postcopy in source monitor,
> > > (qemu) migrate_recover qemu+ssh://10.45.193.21/system
> > 
> > This command should be run on destination side only.  Here the
> > "migrate-recover" command on destination will start a new listening
> > port there waiting for the migration to be continued.  Then after that
> > command we need an extra command on source to start the recovery:
> > 
> >   (HMP) migrate -r $URI
> > 
> > Here $URI should be the only you specified in the "migrate-recover"
> > command on destination machine.
> > 
> > > Migrate recover can only be run when postcopy is paused.
> > 
> > I can try to fix up this error.  Basically we shouldn't allow this
> > command to be run on source machine.
> 
> Sure, :+1:
> 
> > 
> > > 
> > > Looks to be it is broken, please help me if I missed something
> > > in this test.
> > 
> > Btw, I'm writting up an unit test for postcopy recovery recently, that
> > could be a good reference for the new feature.  Meanwhile I think I
> > should write up some documents too afterwards.
> 
> fine, I am also working on writing test scenario in tp-qemu using Avocado-VT
> for postcopy pause/recover and multifd features.

Nice!  I don't know avocado much inside, but definitely it'll be good
if we have more tests to cover it so we'll know its breakage asap (and
the same applies to multifd for sure).

Regards,

-- 
Peter Xu
