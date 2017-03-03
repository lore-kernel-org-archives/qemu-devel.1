Received: from eggs.gnu.org ([2001:4830:134:3::10]:59438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cjq6J-0003wy-RB
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:30:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cjq6I-0002Qs-Rr
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:30:39 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:35410)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cjq6I-0002Qk-LY
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:30:38 -0500
Received: by mail-wm0-x244.google.com with SMTP id z63so1735483wmg.2
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 08:30:38 -0800 (PST)
Received: from 640k.lan (94-36-245-171.adsl-ull.clienti.tiscali.it.
	[94.36.245.171]) by smtp.gmail.com with ESMTPSA id
	k195sm3667527wmd.7.2017.03.03.08.30.36 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 03 Mar 2017 08:30:36 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  3 Mar 2017 17:30:30 +0100
Message-Id: <1488558630-21522-5-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1488558630-21522-1-git-send-email-pbonzini@redhat.com>
References: <1488558630-21522-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 21/21] iscsi: fix missing unlock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Reported by Coverity.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/iscsi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/iscsi.c b/block/iscsi.c
index 76319a1..75d8905 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -637,6 +637,7 @@ retry:
     }
 #endif
     if (iTask.task == NULL) {
+        qemu_mutex_unlock(&iscsilun->mutex);
         return -ENOMEM;
     }
 #if LIBISCSI_API_VERSION < (20160603)
@@ -864,6 +865,7 @@ retry:
     }
 #endif
     if (iTask.task == NULL) {
+        qemu_mutex_unlock(&iscsilun->mutex);
         return -ENOMEM;
     }
 #if LIBISCSI_API_VERSION < (20160603)
@@ -904,6 +906,7 @@ static int coroutine_fn iscsi_co_flush(BlockDriverState *bs)
 retry:
     if (iscsi_synchronizecache10_task(iscsilun->iscsi, iscsilun->lun, 0, 0, 0,
                                       0, iscsi_co_generic_cb, &iTask) == NULL) {
+        qemu_mutex_unlock(&iscsilun->mutex);
         return -ENOMEM;
     }
 
@@ -1237,6 +1240,7 @@ retry:
                                             0, 0, iscsi_co_generic_cb, &iTask);
     }
     if (iTask.task == NULL) {
+        qemu_mutex_unlock(&iscsilun->mutex);
         return -ENOMEM;
     }
 
-- 
1.8.3.1
