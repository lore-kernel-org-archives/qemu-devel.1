Received: from eggs.gnu.org ([2001:4830:134:3::10]:59486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dioca-00071E-0x
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 17:16:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1diocW-0000qS-QQ
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 17:15:59 -0400
From: Eric Blake <eblake@redhat.com>
Date: Fri, 18 Aug 2017 16:15:38 -0500
Message-Id: <20170818211542.5380-10-eblake@redhat.com>
In-Reply-To: <20170818211542.5380-1-eblake@redhat.com>
References: <20170818211542.5380-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v5 09/13] libqtest: Shorten a couple more
 qtest_* functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, "open list:sPAPR" <qemu-ppc@nongnu.org>

qtest_rtas_call() and qtest_big_endian() did not have a short
version with an implied global_qtest; but changing these two
functions fits with the theme of the previous patch.

It doesn't hurt that we are now no longer ambiguous with the
qtest_rtas_call() of include/hw/ppc/spapr_rtos.h.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/libqos/virtio.h |  2 +-
 tests/libqtest.h      | 18 ++++++++----------
 tests/libqtest.c      | 13 ++++++-------
 tests/libqos/rtas.c   |  3 +--
 4 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/tests/libqos/virtio.h b/tests/libqos/virtio.h
index 8fbcd1869c..7bca1b418a 100644
--- a/tests/libqos/virtio.h
+++ b/tests/libqos/virtio.h
@@ -93,7 +93,7 @@ struct QVirtioBus {
 static inline bool qvirtio_is_big_endian(QVirtioDevice *d)
 {
     /* FIXME: virtio 1.0 is always little-endian */
-    return qtest_big_endian(global_qtest);
+    return big_endian();
 }

 static inline uint32_t qvring_size(uint32_t num, uint32_t align)
diff --git a/tests/libqtest.h b/tests/libqtest.h
index 3ae570927a..28945b3f7f 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -338,19 +338,17 @@ uint64_t qtest_readq(QTestState *s, uint64_t addr);
 void qtest_memread(QTestState *s, uint64_t addr, void *data, size_t size);

 /**
- * qtest_rtas_call:
- * @s: #QTestState instance to operate on.
+ * rtas_call:
  * @name: name of the command to call.
  * @nargs: Number of args.
  * @args: Guest address to read args from.
  * @nret: Number of return value.
  * @ret: Guest address to write return values to.
  *
- * Call an RTAS function
+ * Call an RTAS function, using #global_qtest
  */
-uint64_t qtest_rtas_call(QTestState *s, const char *name,
-                         uint32_t nargs, uint64_t args,
-                         uint32_t nret, uint64_t ret);
+uint64_t rtas_call(const char *name, uint32_t nargs, uint64_t args,
+                   uint32_t nret, uint64_t ret);

 /**
  * qtest_bufread:
@@ -430,12 +428,12 @@ int64_t qtest_clock_step(QTestState *s, int64_t step);
 int64_t qtest_clock_set(QTestState *s, int64_t val);

 /**
- * qtest_big_endian:
- * @s: QTestState instance to operate on.
+ * big_endian:
  *
- * Returns: True if the architecture under test has a big endian configuration.
+ * Returns: True if the architecture under test, via #global_qtest,
+ * has a big endian configuration.
  */
-bool qtest_big_endian(QTestState *s);
+bool big_endian(void);

 /**
  * qtest_get_arch:
diff --git a/tests/libqtest.c b/tests/libqtest.c
index b6dd26e54a..261d86df5a 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -816,13 +816,12 @@ void qtest_memread(QTestState *s, uint64_t addr, void *data, size_t size)
     g_strfreev(args);
 }

-uint64_t qtest_rtas_call(QTestState *s, const char *name,
-                         uint32_t nargs, uint64_t args,
-                         uint32_t nret, uint64_t ret)
+uint64_t rtas_call(const char *name, uint32_t nargs, uint64_t args,
+                   uint32_t nret, uint64_t ret)
 {
-    qtest_sendf(s, "rtas %s %u 0x%"PRIx64" %u 0x%"PRIx64"\n",
+    qtest_sendf(global_qtest, "rtas %s %u 0x%"PRIx64" %u 0x%"PRIx64"\n",
                 name, nargs, args, nret, ret);
-    qtest_rsp(s, 0);
+    qtest_rsp(global_qtest, 0);
     return 0;
 }

@@ -947,9 +946,9 @@ char *hmp(const char *fmt, ...)
     return ret;
 }

-bool qtest_big_endian(QTestState *s)
+bool big_endian(void)
 {
-    return s->big_endian;
+    return global_qtest->big_endian;
 }

 void qtest_cb_for_every_machine(void (*cb)(const char *machine))
diff --git a/tests/libqos/rtas.c b/tests/libqos/rtas.c
index 0269803ce0..e7ba7ab18f 100644
--- a/tests/libqos/rtas.c
+++ b/tests/libqos/rtas.c
@@ -37,8 +37,7 @@ static uint64_t qrtas_call(QGuestAllocator *alloc, const char *name,
     target_ret = guest_alloc(alloc, nret * sizeof(uint32_t));

     qrtas_copy_args(target_args, nargs, args);
-    res = qtest_rtas_call(global_qtest, name,
-                          nargs, target_args, nret, target_ret);
+    res = rtas_call(name, nargs, target_args, nret, target_ret);
     qrtas_copy_ret(target_ret, nret, ret);

     guest_free(alloc, target_ret);
-- 
2.13.5
