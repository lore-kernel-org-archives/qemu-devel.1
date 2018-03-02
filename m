Received: from eggs.gnu.org ([2001:4830:134:3::10]:36893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aarcange@redhat.com>) id 1eroil-0000PY-Jn
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 12:43:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aarcange@redhat.com>) id 1eroih-00034z-K3
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 12:43:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45192)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aarcange@redhat.com>) id 1eroih-00033E-DL
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 12:43:47 -0500
From: Andrea Arcangeli <aarcange@redhat.com>
Date: Fri,  2 Mar 2018 18:43:42 +0100
Message-Id: <20180302174343.5421-1-aarcange@redhat.com>
Subject: [Qemu-devel] [PATCH 0/1] FOLL_NOWAIT and get_user_pages_unlocked
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

Hello,

KVM is hanging on postcopy live migration.

David tracked it down to commit
ce53053ce378c21e7ffc45241fd67d6ee79daa2b and the problem is pretty
obvious then.

Either we teach get_user_pages_locked/unlocked to handle FOLL_NOWAIT
(so faultin_nopage works right even when the nonblocking pointer is
not NULL) or we need to revert part of commit
ce53053ce378c21e7ffc45241fd67d6ee79daa2b and keep using FOLL_NOWAIT
only as parameter to get_user_pages (which won't ever set nonblocking
pointer to non-NULL). I suppose the former approach is preferred to be
more robust.

Thanks,
Andrea

Andrea Arcangeli (1):
  mm: gup: teach get_user_pages_unlocked to handle FOLL_NOWAIT

 mm/gup.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)
