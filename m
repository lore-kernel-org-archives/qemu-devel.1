Received: from eggs.gnu.org ([2001:4830:134:3::10]:39075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ctuiX-0002oJ-EA
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 07:27:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ctuiS-0007KN-Hs
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 07:27:45 -0400
Received: from 7.mo179.mail-out.ovh.net ([46.105.61.94]:55726)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ctuiS-0007JS-Bl
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 07:27:40 -0400
Received: from player755.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 266873420C
	for <qemu-devel@nongnu.org>; Fri, 31 Mar 2017 13:27:39 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Fri, 31 Mar 2017 13:27:31 +0200
Message-ID: <149095965106.26233.18168802196576430962.stgit@bahia.lan>
In-Reply-To: <149095959109.26233.3201018420228514740.stgit@bahia>
References: <149095959109.26233.3201018420228514740.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [for-2.9 PATCH 3/3] 9pfs: drop useless loop in
 v9fs_reset()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Li Qiang <liqiang6-s@360.cn>, Greg Kurz <groug@kaod.org>

We don't need to wait for the PDU active list to be empty: virtfs_reset()
already takes care of that.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 86ed9065c4e2..16ef6bd5bd8c 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -3601,6 +3601,7 @@ static void coroutine_fn virtfs_co_reset(void *opaque)
     VirtfsCoResetData *data = opaque;
 
     virtfs_reset(&data->pdu);
+    assert(QLIST_EMPTY(&data->pdu.s->active_list));
     data->done = true;
 }
 
@@ -3609,10 +3610,6 @@ void v9fs_reset(V9fsState *s)
     VirtfsCoResetData data = { .pdu = { .s = s }, .done = false };
     Coroutine *co;
 
-    while (!QLIST_EMPTY(&s->active_list)) {
-        aio_poll(qemu_get_aio_context(), true);
-    }
-
     co = qemu_coroutine_create(virtfs_co_reset, &data);
     qemu_coroutine_enter(co);
 
