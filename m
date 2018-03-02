Received: from eggs.gnu.org ([2001:4830:134:3::10]:36892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aarcange@redhat.com>) id 1eroil-0000PX-Jl
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 12:43:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aarcange@redhat.com>) id 1eroih-00034t-Jx
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 12:43:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42000)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aarcange@redhat.com>) id 1eroih-000339-E8
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 12:43:47 -0500
From: Andrea Arcangeli <aarcange@redhat.com>
Date: Fri,  2 Mar 2018 18:43:43 +0100
Message-Id: <20180302174343.5421-2-aarcange@redhat.com>
In-Reply-To: <20180302174343.5421-1-aarcange@redhat.com>
References: <20180302174343.5421-1-aarcange@redhat.com>
Subject: [Qemu-devel] [PATCH 1/1] mm: gup: teach get_user_pages_unlocked to
 handle FOLL_NOWAIT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, linux-mm@kvack.org

KVM is hanging during postcopy live migration with userfaultfd because
get_user_pages_unlocked is not capable to handle FOLL_NOWAIT.

Earlier FOLL_NOWAIT was only ever passed to get_user_pages.

Specifically faultin_page (the callee of get_user_pages_unlocked
caller) doesn't know that if FAULT_FLAG_RETRY_NOWAIT was set in the
page fault flags, when VM_FAULT_RETRY is returned, the mmap_sem wasn't
actually released (even if nonblocking is not NULL). So it sets
*nonblocking to zero and the caller won't release the mmap_sem
thinking it was already released, but it wasn't because of
FOLL_NOWAIT.

Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Tested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
---
 mm/gup.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 1b46e6e74881..6afae32571ca 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -516,7 +516,7 @@ static int faultin_page(struct task_struct *tsk, struct vm_area_struct *vma,
 	}
 
 	if (ret & VM_FAULT_RETRY) {
-		if (nonblocking)
+		if (nonblocking && !(fault_flags & FAULT_FLAG_RETRY_NOWAIT))
 			*nonblocking = 0;
 		return -EBUSY;
 	}
@@ -890,7 +890,10 @@ static __always_inline long __get_user_pages_locked(struct task_struct *tsk,
 				break;
 		}
 		if (*locked) {
-			/* VM_FAULT_RETRY didn't trigger */
+			/*
+			 * VM_FAULT_RETRY didn't trigger or it was a
+			 * FOLL_NOWAIT.
+			 */
 			if (!pages_done)
 				pages_done = ret;
 			break;
