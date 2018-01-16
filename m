Received: from eggs.gnu.org ([2001:4830:134:3::10]:43032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ebVHi-0002rB-8B
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 12:44:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ebVHd-0006Vp-H2
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 12:44:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42896)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ebVHd-0006VR-Ao
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 12:44:25 -0500
Date: Tue, 16 Jan 2018 17:43:42 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180116174341.GD2521@work-vm>
References: <20180115115309.23982-1-quintela@redhat.com>
	<20180115115309.23982-10-quintela@redhat.com>
	<215cfa8f-1f2d-1155-bd0b-17ecd10c4c61@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <215cfa8f-1f2d-1155-bd0b-17ecd10c4c61@redhat.com>
Subject: Re: [Qemu-devel] [PULL 09/27] migration: calculate vCPU blocktime
 on dst side
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com, Alexey Perevalov <a.perevalov@samsung.com>

* Max Reitz (mreitz@redhat.com) wrote:
> On 2018-01-15 12:52, Juan Quintela wrote:
> > From: Alexey Perevalov <a.perevalov@samsung.com>
> > 
> > This patch provides blocktime calculation per vCPU,
> > as a summary and as a overlapped value for all vCPUs.
> > 
> > This approach was suggested by Peter Xu, as an improvements of
> > previous approch where QEMU kept tree with faulted page address and cpus bitmask
> > in it. Now QEMU is keeping array with faulted page address as value and vCPU
> > as index. It helps to find proper vCPU at UFFD_COPY time. Also it keeps
> > list for blocktime per vCPU (could be traced with page_fault_addr)
> > 
> > Blocktime will not calculated if postcopy_blocktime field of
> > MigrationIncomingState wasn't initialized.
> > 
> > Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
> > Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > Reviewed-by: Juan Quintela <quintela@redhat.com>
> > Signed-off-by: Juan Quintela <quintela@redhat.com>
> > ---
> >  migration/postcopy-ram.c | 143 ++++++++++++++++++++++++++++++++++++++++++++++-
> >  migration/trace-events   |   5 +-
> >  2 files changed, 146 insertions(+), 2 deletions(-)
> 
> For me, this breaks compilation with clang -m32:
> 
>   LINK    x86_64-softmmu/qemu-system-x86_64
> ../migration/postcopy-ram.o: In function `mark_postcopy_blocktime_begin':
> /home/maxx/projects/qemu/migration/postcopy-ram.c:599: undefined
> reference to `__atomic_exchange_8'
> /home/maxx/projects/qemu/migration/postcopy-ram.c:600: undefined
> reference to `__atomic_exchange_8'
> /home/maxx/projects/qemu/migration/postcopy-ram.c:609: undefined
> reference to `__atomic_exchange_8'
> ../migration/postcopy-ram.o: In function `mark_postcopy_blocktime_end':
> /home/maxx/projects/qemu/migration/postcopy-ram.c:665: undefined
> reference to `__atomic_fetch_add_8'
> /home/maxx/projects/qemu/migration/postcopy-ram.c:686: undefined
> reference to `__atomic_fetch_add_8'
> 
> Am I doing something wrong?

Hmm I also see that with clang on 32bit (gcc is fine);
the problem is the postcopy blocktime stuff is doing some 64bit
atomics, which you can never be sure 32bit will support.

Dave

> Max
> 



--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
