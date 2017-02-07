Received: from eggs.gnu.org ([2001:4830:134:3::10]:57794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cb7L9-0000Vu-Co
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 10:05:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cb7L3-00077p-Ck
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 10:05:55 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue,  7 Feb 2017 18:05:33 +0300
Message-Id: <1486479940-163258-11-git-send-email-vsementsov@virtuozzo.com>
In-Reply-To: <1486479940-163258-1-git-send-email-vsementsov@virtuozzo.com>
References: <1486479940-163258-1-git-send-email-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 10/17] migration/qemu-file: add
 qemu_put_counted_string()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, famz@redhat.com, stefanha@redhat.com, amit.shah@redhat.com, quintela@redhat.com, mreitz@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, dgilbert@redhat.com, den@openvz.org, jsnow@redhat.com, vsementsov@virtuozzo.com, lirans@il.ibm.com

Add function opposite to qemu_get_counted_string.
qemu_put_counted_string puts one-byte length of the string (string
should not be longer than 255 characters), and then it puts the string,
without last zero byte.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
---
 include/migration/qemu-file.h |  2 ++
 migration/qemu-file.c         | 13 +++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/migration/qemu-file.h b/include/migration/qemu-file.h
index abedd46..d860c92 100644
--- a/include/migration/qemu-file.h
+++ b/include/migration/qemu-file.h
@@ -309,4 +309,6 @@ static inline void qemu_get_sbe64s(QEMUFile *f, int64_t *pv)
 
 size_t qemu_get_counted_string(QEMUFile *f, char buf[256]);
 
+void qemu_put_counted_string(QEMUFile *f, const char *name);
+
 #endif
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index e9fae31..8e928b2 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -691,6 +691,19 @@ size_t qemu_get_counted_string(QEMUFile *f, char buf[256])
 }
 
 /*
+ * Put a string with one preceding byte containing its length. The length of
+ * the string should be less than 256.
+ */
+void qemu_put_counted_string(QEMUFile *f, const char *str)
+{
+    size_t len = strlen(str);
+
+    assert(len < 256);
+    qemu_put_byte(f, len);
+    qemu_put_buffer(f, (const uint8_t *)str, len);
+}
+
+/*
  * Set the blocking state of the QEMUFile.
  * Note: On some transports the OS only keeps a single blocking state for
  *       both directions, and thus changing the blocking on the main
-- 
1.8.3.1
