Received: from eggs.gnu.org ([2001:4830:134:3::10]:44122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1elYUW-0000g1-28
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 06:11:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1elYUR-0005oh-W8
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 06:11:16 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58734 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1elYUR-0005oQ-Rl
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 06:11:11 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 164538182D2E
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 11:11:00 +0000 (UTC)
Date: Tue, 13 Feb 2018 11:10:53 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180213111052.GB2378@work-vm>
References: <20180209104546.29401-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180209104546.29401-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/4] tcg: fix dirty bitmap race with MTTCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

* Paolo Bonzini (pbonzini@redhat.com) wrote:
> This is a race that can happen when migrating TCG guests under load.
> It was introduced by the change to run vCPUs outside the big QEMU lock.

That does seem to fix the case I was seeing on x86;

rmmod kvm-intel
taskset -c 0 bash
export QTEST_QEMU_BINARY=$PWD/x86_64-softmmu/qemu-system-x86_64
for S in $(seq 1 10); do ./tests/migration-test & done

that would throw a :
'Memory content inconsistency'

most times (may have to increase the 10 to get it to do it
every time?)

Dave


> Paolo Bonzini (4):
>   memory: remove memory_region_test_and_clear_dirty
>   memory: hide memory_region_sync_dirty_bitmap behind
>     DirtyBitmapSnapshot
>   memory: introduce memory_global_after_dirty_log_sync
>   memory: unify loops to sync dirty log bitmap
> 
>  exec.c                       | 31 ++++++++++++++++++
>  hw/display/cg3.c             |  1 -
>  hw/display/exynos4210_fimd.c |  1 -
>  hw/display/framebuffer.c     |  1 -
>  hw/display/g364fb.c          |  1 -
>  hw/display/sm501.c           |  1 -
>  hw/display/tcx.c             |  2 --
>  hw/display/vga.c             |  6 ----
>  include/exec/memory.h        | 47 +++++++++------------------
>  memory.c                     | 76 +++++++++++++++++---------------------------
>  migration/ram.c              |  1 +
>  11 files changed, 76 insertions(+), 92 deletions(-)
> 
> -- 
> 2.14.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
