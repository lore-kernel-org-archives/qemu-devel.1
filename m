Received: from eggs.gnu.org ([2001:4830:134:3::10]:57651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cOgpv-0006x2-Fj
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 03:22:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cOgps-000074-8t
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 03:22:19 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41680)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cOgpr-00006Z-Uh
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 03:22:16 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v048Lx7J116127
	for <qemu-devel@nongnu.org>; Wed, 4 Jan 2017 03:22:14 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27rpavpwwn-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 04 Jan 2017 03:22:14 -0500
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Wed, 4 Jan 2017 08:22:12 -0000
From: Greg Kurz <groug@kaod.org>
Date: Wed,  4 Jan 2017 09:21:35 +0100
In-Reply-To: <1483518107-13218-1-git-send-email-groug@kaod.org>
References: <1483518107-13218-1-git-send-email-groug@kaod.org>
Message-Id: <1483518107-13218-2-git-send-email-groug@kaod.org>
Subject: [Qemu-devel] [PULL 01/13] 9pfs: move pdus to V9fsState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>, Stefano Stabellini <sstabellini@kernel.org>

From: Stefano Stabellini <sstabellini@kernel.org>

pdus are initialized and used in 9pfs common code. Move the array from
V9fsVirtioState to V9fsState.

Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p.c        | 7 +++----
 hw/9pfs/9p.h        | 1 +
 hw/9pfs/virtio-9p.h | 1 -
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index faebd91f5fab..6bd364f6a0d1 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -3440,7 +3440,6 @@ void pdu_submit(V9fsPDU *pdu)
 /* Returns 0 on success, 1 on failure. */
 int v9fs_device_realize_common(V9fsState *s, Error **errp)
 {
-    V9fsVirtioState *v = container_of(s, V9fsVirtioState, state);
     int i, len;
     struct stat stat;
     FsDriverEntry *fse;
@@ -3451,9 +3450,9 @@ int v9fs_device_realize_common(V9fsState *s, Error **errp)
     QLIST_INIT(&s->free_list);
     QLIST_INIT(&s->active_list);
     for (i = 0; i < (MAX_REQ - 1); i++) {
-        QLIST_INSERT_HEAD(&s->free_list, &v->pdus[i], next);
-        v->pdus[i].s = s;
-        v->pdus[i].idx = i;
+        QLIST_INSERT_HEAD(&s->free_list, &s->pdus[i], next);
+        s->pdus[i].s = s;
+        s->pdus[i].idx = i;
     }
 
     v9fs_path_init(&path);
diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
index 3976b7fe3dcd..07cee01abac3 100644
--- a/hw/9pfs/9p.h
+++ b/hw/9pfs/9p.h
@@ -229,6 +229,7 @@ typedef struct V9fsState
     char *tag;
     enum p9_proto_version proto_version;
     int32_t msize;
+    V9fsPDU pdus[MAX_REQ];
     /*
      * lock ensuring atomic path update
      * on rename.
diff --git a/hw/9pfs/virtio-9p.h b/hw/9pfs/virtio-9p.h
index 25c47c7cb6d6..52c4b9df51ca 100644
--- a/hw/9pfs/virtio-9p.h
+++ b/hw/9pfs/virtio-9p.h
@@ -10,7 +10,6 @@ typedef struct V9fsVirtioState
     VirtIODevice parent_obj;
     VirtQueue *vq;
     size_t config_size;
-    V9fsPDU pdus[MAX_REQ];
     VirtQueueElement *elems[MAX_REQ];
     V9fsState state;
 } V9fsVirtioState;
-- 
2.7.4
