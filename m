Received: from eggs.gnu.org ([2001:4830:134:3::10]:45401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1flQ2q-0003f1-18
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 22:42:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1flQ2m-0000Ml-U0
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 22:42:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49034 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1flQ2m-0000MU-OR
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 22:42:20 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 043164015A58
	for <qemu-devel@nongnu.org>; Fri,  3 Aug 2018 02:42:20 +0000 (UTC)
Date: Fri, 3 Aug 2018 10:42:17 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180803024217.GC16395@lemon.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] Node deletion in aio_set_fd_handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com
Cc: qemu-devel@nongnu.org

Paolo, is this else branch dead code (or bug?):

        /* If the lock is held, just mark the node as deleted */
        if (qemu_lockcnt_count(&ctx->list_lock)) {
            node->deleted = 1;
            node->pfd.revents = 0;
        } else {
            /* Otherwise, delete it for real.  We can't just mark it as
             * deleted because deleted nodes are only cleaned up while
             * no one is walking the handlers list.
             */
            QLIST_REMOVE(node, node);
            deleted = true;
        }

Since we are in a qemu_lockcnt_lock/unlock section?

Fam
