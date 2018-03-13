Received: from eggs.gnu.org ([2001:4830:134:3::10]:36681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1evoGz-0000zR-Sz
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 14:03:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1evoGv-0008AY-Pw
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 14:03:41 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 13 Mar 2018 21:03:15 +0300
Message-Id: <20180313180320.339796-9-vsementsov@virtuozzo.com>
In-Reply-To: <20180313180320.339796-1-vsementsov@virtuozzo.com>
References: <20180313180320.339796-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v11 08/13] migration/qemu-file: add
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
Reviewed-by: Fam Zheng <famz@redhat.com>
---
 migration/qemu-file.h |  2 ++
 migration/qemu-file.c | 13 +++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/migration/qemu-file.h b/migration/qemu-file.h
index aae4e5ed36..f4f356ab12 100644
--- a/migration/qemu-file.h
+++ b/migration/qemu-file.h
@@ -174,4 +174,6 @@ size_t ram_control_save_page(QEMUFile *f, ram_addr_t block_offset,
                              ram_addr_t offset, size_t size,
                              uint64_t *bytes_sent);
 
+void qemu_put_counted_string(QEMUFile *f, const char *name);
+
 #endif
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 2ab2bf362d..e85f501f86 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -734,6 +734,19 @@ size_t qemu_get_counted_string(QEMUFile *f, char buf[256])
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
2.11.1
