Received: from eggs.gnu.org ([2001:4830:134:3::10]:49978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eGt5m-0003RA-U4
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 15:54:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eGt5m-0007c4-12
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 15:54:59 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1511201308-23580-1-git-send-email-peter.maydell@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f5cc649a-8b33-fc0c-4a9c-559a33cda86b@redhat.com>
Date: Mon, 20 Nov 2017 21:54:37 +0100
MIME-Version: 1.0
In-Reply-To: <1511201308-23580-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 for-2.11 0/2] Fix TCG atomic writes to
 nondirty pages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <rth@twiddle.net>, Stuart Monteith <stuart.monteith@linaro.org>

On 20/11/2017 19:08, Peter Maydell wrote:
> To do a write to memory that is marked as notdirty, we need
> to invalidate any TBs we have cached for that memory, and
> update the cpu physical memory dirty flags for VGA and migration.
> The slowpath code in notdirty_mem_write() does all this correctly,
> but the new atomic handling code in atomic_mmu_lookup() doesn't
> do anything at all, it just clears the dirty bit in the TLB.
> 
> The effect of this bug is that if the first write to a notdirty
> page for which we have cached TBs is by a guest atomic access,
> we fail to invalidate the TBs and subsequently will execute
> incorrect code. This can be seen by trying to run 'javac' on AArch64.
> 
> The first patch here refactors notdirty_mem_write() to pull out
> the "correctly handle dirty bit updates" parts of the code into
> two new functions memory_notdirty_write_prepare() and
> memory_notdirty_write_complete(). The second patch then uses
> those functions to fix the atomic helpers.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

Thanks!

Paolo

> Changes v1->v2:
>  * add the 'bool active;' flag to NotDirtyInfo in patch 1
>  * change the comment on NotDirtyInfo in patch 1 to document
>    the active flag (and to fix incorrect references to function
>    names that I forgot to update when I decided on the names for
>    the prepare/complete functions)
>  * in patch 2, don't call prepare unless the TLB was notdirty
>  * in patch 2, use the active flag to track whether we need to
>    call complete or not
> 
> thanks
> -- PMM
> 
> Peter Maydell (2):
>   exec.c: Factor out before/after actions for notdirty memory writes
>   accel/tcg: Handle atomic accesses to notdirty memory correctly
> 
>  accel/tcg/atomic_template.h    | 12 ++++++++
>  include/exec/memory-internal.h | 62 ++++++++++++++++++++++++++++++++++++++++
>  accel/tcg/cputlb.c             | 38 +++++++++++++++---------
>  accel/tcg/user-exec.c          |  1 +
>  exec.c                         | 65 ++++++++++++++++++++++++++++--------------
>  5 files changed, 144 insertions(+), 34 deletions(-)
> 
