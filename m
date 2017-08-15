Received: from eggs.gnu.org ([2001:4830:134:3::10]:39306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dhetD-0000JF-VG
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 12:40:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dhetD-0003D3-2A
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 12:40:23 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:35823)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dhetC-0003CE-Tz
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 12:40:22 -0400
Received: by mail-qk0-x243.google.com with SMTP id a77so1168161qkb.2
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 09:40:22 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 15 Aug 2017 13:39:58 -0300
Message-Id: <20170815163959.6632-2-f4bug@amsat.org>
In-Reply-To: <20170815163959.6632-1-f4bug@amsat.org>
References: <20170815163959.6632-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 1/2] libqtest: add qtest_accel() to avoid
 warnings when kvm is not available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S . Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

only warn once about it.

- kernel without kvm:

    # make check-qtest-x86_64
      GTESTER check-qtest-x86_64
    Could not access KVM kernel module: No such device
    qemu-system-x86_64: failed to initialize KVM: No such device
    qemu-system-x86_64: Back to tcg accelerator

- tests ran as user:

    $ make check-qtest-x86_64
      GTESTER check-qtest-x86_64
    Could not access KVM kernel module: Permission denied
    qemu-system-x86_64: failed to initialize KVM: Permission denied
    qemu-system-x86_64: Back to tcg accelerator

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/libqtest.h |  8 ++++++++
 tests/libqtest.c | 18 ++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/tests/libqtest.h b/tests/libqtest.h
index 38bc1e9953..24e03148eb 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -927,4 +927,12 @@ QDict *qmp_fd(int fd, const char *fmt, ...);
  */
 void qtest_cb_for_every_machine(void (*cb)(const char *machine));
 
+/**
+ * qtest_accel:
+ * @accel: List of accelerators
+ *
+ *  Filter accelerators accessible on the host.
+ */
+const char *qtest_accel(const char *accel);
+
 #endif
diff --git a/tests/libqtest.c b/tests/libqtest.c
index b9a1f180e1..d2dfca35a3 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -987,3 +987,21 @@ void qtest_cb_for_every_machine(void (*cb)(const char *machine))
     qtest_end();
     QDECREF(response);
 }
+
+const char *qtest_accel(const char *accel)
+{
+    static bool kvm_accessible = true;
+
+    if (strlen(accel) <= 4 || strncmp(accel, "kvm:", 4)) {
+        return accel; /* no match */
+    }
+
+    if (!kvm_accessible || !access("/dev/kvm", W_OK)) {
+        accel += 4; /* skip "kvm:" */
+        if (kvm_accessible) {
+            kvm_accessible = false; /* warn once */
+            g_printerr("kvm not accessible, using %s\n", accel);
+        }
+    }
+    return accel;
+}
-- 
2.14.1
