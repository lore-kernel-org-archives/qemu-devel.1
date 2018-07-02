Received: from eggs.gnu.org ([2001:4830:134:3::10]:50685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bala24@linux.vnet.ibm.com>) id 1fZtpV-0003OJ-WD
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 04:05:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bala24@linux.vnet.ibm.com>) id 1fZtpP-0001SV-Ec
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 04:05:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47174
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bala24@linux.vnet.ibm.com>)
	id 1fZtpP-0001RQ-7J
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 04:04:55 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w6284Ib1145533
	for <qemu-devel@nongnu.org>; Mon, 2 Jul 2018 04:04:53 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2jyby4153p-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 04:04:52 -0400
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bala24@linux.vnet.ibm.com>;
	Mon, 2 Jul 2018 09:04:51 +0100
Date: Mon, 2 Jul 2018 13:34:45 +0530
From: Balamuruhan S <bala24@linux.vnet.ibm.com>
References: <20180627132246.5576-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627132246.5576-1-peterx@redhat.com>
Message-Id: <20180702080445.GA7894@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH v3 0/4] migation: unbreak postcopy recovery
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org

On Wed, Jun 27, 2018 at 09:22:42PM +0800, Peter Xu wrote:
> v3:
> - keep the recovery logic even for RDMA by dropping the 3rd patch and
>   touch up the original 4th patch (current 3rd patch) to suite that [Dave]
> 
> v2:
> - break the first patch into several
> - fix a QEMUFile leak
> 
> Please review.  Thanks,
Hi Peter,

I have applied this patchset with upstream Qemu for testing postcopy
pause recover feature in PowerPC,

I used NFS shared qcow2 between source and target host

source:
# ppc64-softmmu/qemu-system-ppc64 --enable-kvm --nographic -vga none \
-machine pseries -m 64G,slots=128,maxmem=128G -smp 16,maxcpus=32 \
-device virtio-blk-pci,drive=rootdisk -drive \
file=/home/bala/sharing/hostos-ppc64le.qcow2,if=none,cache=none,format=qcow2,id=rootdisk \
-monitor telnet:127.0.0.1:1234,server,nowait -net nic,model=virtio \
-net user -redir tcp:2000::22

To keep the VM with workload I ran stress-ng inside guest,

# stress-ng --cpu 6 --vm 6 --io 6

target:
# ppc64-softmmu/qemu-system-ppc64 --enable-kvm --nographic -vga none \
-machine pseries -m 64G,slots=128,maxmem=128G -smp 16,maxcpus=32 \
-device virtio-blk-pci,drive=rootdisk -drive \
file=/home/bala/sharing/hostos-ppc64le.qcow2,if=none,cache=none,format=qcow2,id=rootdisk \
-monitor telnet:127.0.0.1:1235,server,nowait -net nic,model=virtio \
-net user -redir tcp:2001::22 -incoming tcp:0:4445

enabled postcopy on both source and destination from qemu monitor

(qemu) migrate_set_capability postcopy-ram on

>From source qemu monitor,
(qemu) migrate -d tcp:10.45.70.203:4445
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
Migration status: active
total time: 2331 milliseconds
expected downtime: 300 milliseconds
setup: 65 milliseconds
transferred ram: 38914 kbytes
throughput: 273.16 mbps
remaining ram: 67063784 kbytes
total ram: 67109120 kbytes
duplicate: 1627 pages
skipped: 0 pages
normal: 9706 pages
normal bytes: 38824 kbytes
dirty sync count: 1
page size: 4 kbytes
multifd bytes: 0 kbytes

triggered postcopy from source,
(qemu) migrate_start_postcopy

After triggering postcopy from source, in target I tried to pause the
postcopy migration

(qemu) migrate_pause

In target I see error as,
error while loading state section id 4(ram)
qemu-system-ppc64: Detected IO failure for postcopy. Migration paused.

In source I see error as,
qemu-system-ppc64: Detected IO failure for postcopy. Migration paused.

Later from target I try for recovery from target monitor,
(qemu) migrate_recover qemu+ssh://10.45.70.203/system
Migrate recovery is triggered already

but in source still it remains to be in postcopy-paused state
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
total time: 222841 milliseconds
expected downtime: 382991 milliseconds
setup: 65 milliseconds
transferred ram: 385270 kbytes
throughput: 265.06 mbps
remaining ram: 8150528 kbytes
total ram: 67109120 kbytes
duplicate: 14679647 pages
skipped: 0 pages
normal: 63937 pages
normal bytes: 255748 kbytes
dirty sync count: 2
page size: 4 kbytes
multifd bytes: 0 kbytes
dirty pages rate: 854740 pages
postcopy request count: 374

later I also tried to recover postcopy in source monitor,
(qemu) migrate_recover qemu+ssh://10.45.193.21/system
Migrate recover can only be run when postcopy is paused.

Looks to be it is broken, please help me if I missed something
in this test.

Thank you,
Bala
> 
> Peter Xu (4):
>   migration: delay postcopy paused state
>   migration: move income process out of multifd
>   migration: unbreak postcopy recovery
>   migration: unify incoming processing
> 
>  migration/ram.h       |  2 +-
>  migration/exec.c      |  3 ---
>  migration/fd.c        |  3 ---
>  migration/migration.c | 44 ++++++++++++++++++++++++++++++++++++-------
>  migration/ram.c       | 11 +++++------
>  migration/savevm.c    |  6 +++---
>  migration/socket.c    |  5 -----
>  7 files changed, 46 insertions(+), 28 deletions(-)
> 
> -- 
> 2.17.1
> 
> 
