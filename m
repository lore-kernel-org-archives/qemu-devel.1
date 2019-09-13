Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92171C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 16:36:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 607C320693
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 16:36:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 607C320693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8oYh-0003C8-ER
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 12:36:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35529)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i8oXa-0002Jn-8L
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 12:35:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i8oXZ-0001pd-0k
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 12:35:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53226)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1i8oXY-0001ox-Rm
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 12:35:20 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 26EFC81DE7
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 16:35:20 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 48E5E60CC0;
 Fri, 13 Sep 2019 16:35:19 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	quintela@redhat.com,
	peterx@redhat.com
Date: Fri, 13 Sep 2019 17:35:07 +0100
Message-Id: <20190913163507.1403-3-dgilbert@redhat.com>
In-Reply-To: <20190913163507.1403-1-dgilbert@redhat.com>
References: <20190913163507.1403-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Fri, 13 Sep 2019 16:35:20 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 2/2] migration/rdma.c: Swap synchronize_rcu for
 call_rcu
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

This fixes a deadlock that can occur on the migration source after
a failed RDMA migration;  as the source tries to cleanup it
clears a pair of pointers and uses synchronize_rcu to wait; this
is happening on the main thread.  With the CPUs running
a CPU thread can be an rcu reader and attempt to grab the main lock
(kvm_handle_io->address_space_write->flatview_write->flatview_write_conti=
nue->
prepare_mmio_access->qemu_mutex_lock_iothread_impl)

Replace the synchronize_rcu with a call_rcu to postpone the freeing.

Fixes: 74637e6f08fceda98806 ("migration: implement bi-directional RDMA QI=
OChannel")

( https://bugzilla.redhat.com/show_bug.cgi?id=3D1746787 )

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/rdma.c | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 0fcf02f48e..4c74e88a37 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3017,11 +3017,35 @@ static void qio_channel_rdma_set_aio_fd_handler(Q=
IOChannel *ioc,
     }
 }
=20
+struct rdma_close_rcu {
+    struct rcu_head rcu;
+    RDMAContext *rdmain;
+    RDMAContext *rdmaout;
+};
+
+/* callback from qio_channel_rdma_close via call_rcu */
+static void qio_channel_rdma_close_rcu(struct rdma_close_rcu *rcu)
+{
+    if (rcu->rdmain) {
+        qemu_rdma_cleanup(rcu->rdmain);
+    }
+
+    if (rcu->rdmaout) {
+        qemu_rdma_cleanup(rcu->rdmaout);
+    }
+
+    g_free(rcu->rdmain);
+    g_free(rcu->rdmaout);
+    g_free(rcu);
+}
+
 static int qio_channel_rdma_close(QIOChannel *ioc,
                                   Error **errp)
 {
     QIOChannelRDMA *rioc =3D QIO_CHANNEL_RDMA(ioc);
     RDMAContext *rdmain, *rdmaout;
+    struct rdma_close_rcu *rcu =3D g_new(struct rdma_close_rcu, 1);
+
     trace_qemu_rdma_close();
=20
     rdmain =3D rioc->rdmain;
@@ -3034,18 +3058,9 @@ static int qio_channel_rdma_close(QIOChannel *ioc,
         atomic_rcu_set(&rioc->rdmaout, NULL);
     }
=20
-    synchronize_rcu();
-
-    if (rdmain) {
-        qemu_rdma_cleanup(rdmain);
-    }
-
-    if (rdmaout) {
-        qemu_rdma_cleanup(rdmaout);
-    }
-
-    g_free(rdmain);
-    g_free(rdmaout);
+    rcu->rdmain =3D rdmain;
+    rcu->rdmaout =3D rdmaout;
+    call_rcu(rcu, qio_channel_rdma_close_rcu, rcu);
=20
     return 0;
 }
--=20
2.21.0


