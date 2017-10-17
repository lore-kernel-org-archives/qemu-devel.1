Received: from eggs.gnu.org ([2001:4830:134:3::10]:35488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e4NXD-00015l-Kz
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 04:47:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e4NX9-0002C2-A0
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 04:47:35 -0400
Date: Tue, 17 Oct 2017 10:47:25 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171017104725.14971395.cohuck@redhat.com>
In-Reply-To: <20171016202358.3633-1-david@redhat.com>
References: <20171016202358.3633-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 0/2] s390x/tcg: LAP support using
 immediate TLB invalidation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Peter Maydell <peter.maydell@linaro.org>

On Mon, 16 Oct 2017 22:23:56 +0200
David Hildenbrand <david@redhat.com> wrote:

> Details about Low-Address Protection can be found in description of
> patch 1 and 2. It is basically a subpage protection of the first two
> pages of every address space (for which it is enabled).
> 
> We can achieve this by simply directly invalidating the TLB entry and
> therefore forcing every write accesses onto these two pages into the slow
> path.
> 
> With this patch, I can boot Linux just fine (which uses LAP). This also
> makes all related kvm-unit-tests that we have pass.

Tested with a kernel based on the s390/features branch (4.14-rc2 + s390
patches) and the initrd from the debian installer, had udevd shot down
by the oomkiller. That happened only once, so it was probably an
unrelated fluke, but that combination worked well before.

[More config data + logs available on request.]

> 
> 
> RFC -> v1:
> - fix LAP range check (Thomas)
> - SIGP fix got picked up
> 
> Based on: https://github.com/cohuck/qemu.git s390-next
> Available on: https://github.com/dhildenb/qemu.git s390x_lap
> 
> 
> David Hildenbrand (2):
>   accel/tcg: allow to invalidate a write TLB entry immediately
>   s390x/tcg: low-address protection support
> 
>  accel/tcg/cputlb.c           |  5 ++-
>  accel/tcg/softmmu_template.h |  4 +-
>  include/exec/cpu-all.h       |  3 ++
>  target/s390x/excp_helper.c   |  3 +-
>  target/s390x/mem_helper.c    |  8 ----
>  target/s390x/mmu_helper.c    | 94 +++++++++++++++++++++++++++-----------------
>  6 files changed, 69 insertions(+), 48 deletions(-)
> 
