Received: from eggs.gnu.org ([2001:4830:134:3::10]:59651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cm29M-0001T4-S4
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 12:46:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cm29J-00021j-PG
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 12:46:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58564)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cm29J-00020w-Gd
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 12:46:49 -0500
Date: Thu, 9 Mar 2017 17:46:43 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170309174642.GM2480@work-vm>
References: <57B7F948.9040701@huawei.com>
	<20170309113437.9667-1-c.pinto@virtualopensystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170309113437.9667-1-c.pinto@virtualopensystems.com>
Subject: Re: [Qemu-devel] [RFC PATCH 0/4] ARM/ARM64 fixes for live memory
 snapshot based on userfaultfd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Pinto <c.pinto@virtualopensystems.com>
Cc: zhang.zhanghailiang@huawei.com, b.reynal@virtualopensystems.com, aarcange@redhat.com, quintela@redhat.com, peter.huangpeng@huawei.com, hanweidong@huawei.com, qemu-devel@nongnu.org, tech@virtualopensystems.com

* Christian Pinto (c.pinto@virtualopensystems.com) wrote:
> This patch series introduces a set of fixes to the previous work proposed by
> Hailiang Zhang to enable in QEMU live memory snapshot based
> on userfaultfd. See discussion here:
> http://www.mail-archive.com/qemu-devel@nongnu.org/msg393118.html

Thanks for posting this,

> These patches apply on top of: 
> https://github.com/coloft/qemu/tree/snapshot-v2
> that is the latest version of Hailiang's work, and rely on the latest work on
> userfaultfd available on Andrea Arcangeli's Linux kernel tree:
> https://git.kernel.org/cgit/linux/kernel/git/andrea/aa.git/log/?h=userfault
> 
> The original work was mainly tested on x86 tcg machines and was not working
> ARM/ARM64 tcg.
> The fixes presented in this series enable the live memory snapshot
> to work for ARM64 tcg guests running on top of an ARM64 host.
> 
> The main problems encountered were:
>     - QEMU uses for ARM a memory page size of 1KB. Even though this size is not
>       supported by the Linux kernel, is is kept for backward compatibility
>       with older ARM CPU MMUs. Initial work was write-unprotecting pages with
>       a granularity not always aligned with host page size, causing userfaultfd
>       to fail.

Yes, Power similarly has a 4kb size for the target page size even though
the host kernel is normally a large page size.

>     - The VM execution was resumed right before the status of the migration
>       was switched from MIGRATION_STATUS_SETUP to MIGRATION_STATUS_ACTIVE.
>       This was causing again the VM to trigger a "Bus error", due to wrong
>       status of some memory pages.
>     - When unprotecting a memory page the flag
>       UFFDIO_WRITEPROTECT_MODE_DONTWAKE was used. This way, after a page is
>       copied into snapshot file, the virtual machine execution is not resumed.
> 
> 
> To test the patches on an ARM64 host, boot an ARM64 tcg machine:
> 
> qemu-system-aarch64 -machine virt,accel=tcg -cpu cortex-a57\
>         -m 256 -kernel Image \
>         -initrd rootfs.cpio.gz \
>         -append "earlyprintk rw console=ttyAMA0" \
>         -net nic -net user \
>         -nographic -serial pty -monitor stdio
> 
> start migration from QEMU monitor:
> 
>     (qemu) migrate file:/root/test_snapshot
> 
> 
> resume VM form snapshot:
> 
> qemu-system-aarch64 -machine virt,accel=tcg -cpu cortex-a57\
>         -m 256 -kernel Image \
>         -initrd rootfs.cpio.gz \
>         -append "earlyprintk rw console=ttyAMA0" \
>         -net nic -net user \
>         -nographic -serial stdio -monitor pty \
>         -incoming file:/root/test_snapshot

Nice, what's your use case and how are you dealing with storage?

Dave

> Christian Pinto (4):
>   migration/postcopy-ram: check pagefault flags in userfaultfd thread
>   migration/ram: Fix for ARM/ARM64 page size
>   migration: snapshot thread
>   migration/postcopy-ram: ram_set_pages_wp fix
> 
>  migration/migration.c    |  9 +++++----
>  migration/postcopy-ram.c | 25 ++++++++-----------------
>  migration/ram.c          | 18 ++++++++++++++----
>  3 files changed, 27 insertions(+), 25 deletions(-)
> 
> -- 
> 2.11.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
