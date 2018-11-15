Received: from eggs.gnu.org ([2001:4830:134:3::10]:59335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gNIVi-000119-1p
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:20:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gNIVb-0005s8-UO
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:20:45 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36067)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gNIVT-0005jU-RX
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:20:37 -0500
Received: by mail-wm1-x342.google.com with SMTP id s11so8833706wmh.1
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 06:20:30 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 15 Nov 2018 15:20:24 +0100
Message-Id: <20181115142024.16765-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for-3.2 00/10] vhost: preparation for qgraph
 conversion of vhost-user-test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: lvivier@redhat.com, mst@redhat.com, jasowang@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

The vhost-user-test is one of the most complex qtests in the tree,
and converting it to qgraph poses some unique challenges.  This series
addresses them in a way that does not depend on the qgraph conversion
itself, but prepares for it.

First of all, vhost-user-test is slow and that is a pain when debugging
it. :) So patches 1 and 2 fix this bug.

Second, qgraph will be able to test vhost-user-test on pSeries and ARM
virt (with virtio-mmio) machine types.  Patches 3 and 4 prepares for this
by compiling vhost-net even on TCG-only targets, and by supporting
wrong-endianness vnet headers.  Patches 5 and 6 instead make the test
more robust, so that it can run on those machines too.

Third, vhost-user-test is a bit strange in that it has more global state
than other tests (in particular a GMainLoop, but also a directory in /tmp
and some weird uses of global_qtest).  Patches 7 to 10 thus remove this
global state already, which simplifies the code and also will reduce
the diff for the qgraph conversion.

Please review and ack!  Thanks,

Paolo

Paolo Bonzini (10):
  vhost-user-test: use g_cond_broadcast
  vhost-user-test: signal data_cond when s->rings changes
  vhost-net: compile it for all targets
  vhost-user: support cross-endian vnet headers
  vhost-user-test: support VHOST_USER_PROTOCOL_F_CROSS_ENDIAN
  vhost-user-test: skip if there is no memory at address 0
  vhost-user-test: reduce usage of global_qtest
  vhost-user-test: create a main loop per TestServer
  vhost-user-test: small changes to init_hugepagefs
  vhost-user-test: create a temporary directory per TestServer

 configure               |  13 +--
 include/exec/poison.h   |   1 -
 net/net.c               |   2 +-
 net/vhost-user.c        |  13 +++
 tests/Makefile.include  |   5 +-
 tests/vhost-user-test.c | 234 ++++++++++++++++++++++------------------
 6 files changed, 147 insertions(+), 121 deletions(-)

-- 
2.19.1

>From 478fa5ddebbed4731d4948e00077165d9baeff52 Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 22 Oct 2018 12:54:04 +0200
Subject: [PATCH 01/10] vhost-user-test: use g_cond_broadcast

g_cond_signal is rarely the right thing to do, it works now because
vhost-user-test only has two threads but it is not correct in general.
Fix it before adding more calls.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/vhost-user-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index 45d58d8ea2..656e51938b 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -393,7 +393,7 @@ static void chr_read(void *opaque, const uint8_t *buf, int size)
                                             G_N_ELEMENTS(s->fds));
 
         /* signal the test that it can continue */
-        g_cond_signal(&s->data_cond);
+        g_cond_broadcast(&s->data_cond);
         break;
 
     case VHOST_USER_SET_VRING_KICK:
@@ -419,7 +419,7 @@ static void chr_read(void *opaque, const uint8_t *buf, int size)
         p = (uint8_t *) &msg;
         qemu_chr_fe_write_all(chr, p, VHOST_USER_HDR_SIZE);
 
-        g_cond_signal(&s->data_cond);
+        g_cond_broadcast(&s->data_cond);
         break;
 
     case VHOST_USER_SET_VRING_BASE:
-- 
2.19.1


>From 3e3381f8f1cb8003b34ce089372f8b4c446afa64 Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 22 Oct 2018 12:52:12 +0200
Subject: [PATCH 02/10] vhost-user-test: signal data_cond when s->rings changes

This speeds up wait_for_rings_started, which currently is just waiting for
the timeout before checking s->rings.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/vhost-user-test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index 656e51938b..6a805e67be 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -384,6 +384,7 @@ static void chr_read(void *opaque, const uint8_t *buf, int size)
 
         assert(msg.payload.state.index < s->queues * 2);
         s->rings &= ~(0x1ULL << msg.payload.state.index);
+        g_cond_broadcast(&s->data_cond);
         break;
 
     case VHOST_USER_SET_MEM_TABLE:
@@ -425,6 +426,7 @@ static void chr_read(void *opaque, const uint8_t *buf, int size)
     case VHOST_USER_SET_VRING_BASE:
         assert(msg.payload.state.index < s->queues * 2);
         s->rings |= 0x1ULL << msg.payload.state.index;
+        g_cond_broadcast(&s->data_cond);
         break;
 
     case VHOST_USER_GET_QUEUE_NUM:
-- 
2.19.1


>From 0e6e86dae799f7f4404c6dedc8e7d2547a592beb Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 26 Oct 2018 11:18:01 +0200
Subject: [PATCH 03/10] vhost-net: compile it for all targets

Currently vhost-net is compiled only for KVM-enabled targets.  This is
not needed anymore because ioeventfd is supported and emulated by the
memory core.  Compile it and vhost-user-test for all targets.
While at it, fix the annoying typo CONFIG_VHOST_NET_USED.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure              | 13 +++++--------
 include/exec/poison.h  |  1 -
 net/net.c              |  2 +-
 tests/Makefile.include |  5 +----
 4 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/configure b/configure
index 5b1d83ea26..d8317e1832 100755
--- a/configure
+++ b/configure
@@ -6512,8 +6512,11 @@ fi
 if test "$vhost_scsi" = "yes" ; then
   echo "CONFIG_VHOST_SCSI=y" >> $config_host_mak
 fi
-if test "$vhost_net" = "yes" -a "$vhost_user" = "yes"; then
-  echo "CONFIG_VHOST_NET_USED=y" >> $config_host_mak
+if test "$vhost_net" = "yes" ; then
+  echo "CONFIG_VHOST_NET=y" >> $config_host_mak
+  if test "$vhost_user" = "yes"; then
+    echo "CONFIG_VHOST_NET_USER=y" >> $config_host_mak
+  fi
 fi
 if test "$vhost_crypto" = "yes" ; then
   echo "CONFIG_VHOST_CRYPTO=y" >> $config_host_mak
@@ -7275,12 +7278,6 @@ if supported_xen_target $target; then
 fi
 if supported_kvm_target $target; then
     echo "CONFIG_KVM=y" >> $config_target_mak
-    if test "$vhost_net" = "yes" ; then
-        echo "CONFIG_VHOST_NET=y" >> $config_target_mak
-        if test "$vhost_user" = "yes" ; then
-            echo "CONFIG_VHOST_USER_NET_TEST_$target_name=y" >> $config_host_mak
-        fi
-    fi
 fi
 if supported_hax_target $target; then
     echo "CONFIG_HAX=y" >> $config_target_mak
diff --git a/include/exec/poison.h b/include/exec/poison.h
index 32d53789f8..b158632791 100644
--- a/include/exec/poison.h
+++ b/include/exec/poison.h
@@ -85,7 +85,6 @@
 #pragma GCC poison CONFIG_XTENSA_DIS
 
 #pragma GCC poison CONFIG_LINUX_USER
-#pragma GCC poison CONFIG_VHOST_NET
 #pragma GCC poison CONFIG_KVM
 #pragma GCC poison CONFIG_SOFTMMU
 
diff --git a/net/net.c b/net/net.c
index 07c194a8f6..95a74add6c 100644
--- a/net/net.c
+++ b/net/net.c
@@ -955,7 +955,7 @@ static int (* const net_client_init_fun[NET_CLIENT_DRIVER__MAX])(
         [NET_CLIENT_DRIVER_BRIDGE]    = net_init_bridge,
 #endif
         [NET_CLIENT_DRIVER_HUBPORT]   = net_init_hubport,
-#ifdef CONFIG_VHOST_NET_USED
+#ifdef CONFIG_VHOST_NET_USER
         [NET_CLIENT_DRIVER_VHOST_USER] = net_init_vhost_user,
 #endif
 #ifdef CONFIG_L2TPV3
diff --git a/tests/Makefile.include b/tests/Makefile.include
index fb0b449c02..03a64ce9c8 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -204,10 +204,7 @@ check-qtest-i386-$(CONFIG_USB_XHCI_NEC) += tests/usb-hcd-xhci-test$(EXESUF)
 check-qtest-i386-y += tests/cpu-plug-test$(EXESUF)
 check-qtest-i386-y += tests/q35-test$(EXESUF)
 check-qtest-i386-y += tests/vmgenid-test$(EXESUF)
-check-qtest-i386-$(CONFIG_VHOST_USER_NET_TEST_i386) += tests/vhost-user-test$(EXESUF)
-ifeq ($(CONFIG_VHOST_USER_NET_TEST_i386),)
-check-qtest-x86_64-$(CONFIG_VHOST_USER_NET_TEST_x86_64) += tests/vhost-user-test$(EXESUF)
-endif
+check-qtest-i386-$(CONFIG_VHOST_NET_USER) += tests/vhost-user-test$(EXESUF)
 check-qtest-i386-$(CONFIG_TPM_CRB) += tests/tpm-crb-swtpm-test$(EXESUF)
 check-qtest-i386-$(CONFIG_TPM_CRB) += tests/tpm-crb-test$(EXESUF)
 check-qtest-i386-$(CONFIG_TPM_TIS) += tests/tpm-tis-swtpm-test$(EXESUF)
-- 
2.19.1


>From 24da32afab4433aec7ab61d39523a2f6ed2f7db6 Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 15 Nov 2018 09:29:03 +0100
Subject: [PATCH 04/10] vhost-user: support cross-endian vnet headers

vhost-user already has a way to communicate the endianness of the guest
via the vring endianness messages.  The vring endianness always matches
the vnet header endianness so there is no need to do anything else in
the backend.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 net/vhost-user.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/vhost-user.c b/net/vhost-user.c
index a39f9c9974..cd9659df87 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -172,6 +172,17 @@ static void net_vhost_user_cleanup(NetClientState *nc)
     qemu_purge_queued_packets(nc);
 }
 
+static int vhost_user_set_vnet_endianness(NetClientState *nc,
+                                          bool enable)
+{
+    /* Nothing to do.  If the server supports
+     * VHOST_USER_PROTOCOL_F_CROSS_ENDIAN, it will get the
+     * vnet header endianness from there.  If it doesn't, negotiation
+     * fails.
+     */
+    return 0;
+}
+
 static bool vhost_user_has_vnet_hdr(NetClientState *nc)
 {
     assert(nc->info->type == NET_CLIENT_DRIVER_VHOST_USER);
@@ -193,6 +204,8 @@ static NetClientInfo net_vhost_user_info = {
         .cleanup = net_vhost_user_cleanup,
         .has_vnet_hdr = vhost_user_has_vnet_hdr,
         .has_ufo = vhost_user_has_ufo,
+        .set_vnet_be = vhost_user_set_vnet_endianness,
+        .set_vnet_le = vhost_user_set_vnet_endianness,
 };
 
 static gboolean net_vhost_user_watch(GIOChannel *chan, GIOCondition cond,
-- 
2.19.1


>From 247409366d7ee6d2a8098977b8cebb5e20dbfac7 Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 15 Nov 2018 09:30:23 +0100
Subject: [PATCH 05/10] vhost-user-test: support
 VHOST_USER_PROTOCOL_F_CROSS_ENDIAN

This will be useful to run the qtest for ppc64 targets on (for example)
x86_64 hosts.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/vhost-user-test.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index 6a805e67be..82fc6c581b 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -51,6 +51,7 @@
 #define VHOST_USER_F_PROTOCOL_FEATURES 30
 #define VHOST_USER_PROTOCOL_F_MQ 0
 #define VHOST_USER_PROTOCOL_F_LOG_SHMFD 1
+#define VHOST_USER_PROTOCOL_F_CROSS_ENDIAN   6
 
 #define VHOST_LOG_PAGE 0x1000
 
@@ -251,7 +252,7 @@ static void wait_for_fds(TestServer *s)
 
 static void read_guest_mem_server(TestServer *s)
 {
-    uint32_t *guest_mem;
+    uint8_t *guest_mem;
     int i, j;
     size_t size;
 
@@ -278,8 +279,8 @@ static void read_guest_mem_server(TestServer *s)
         g_assert(guest_mem != MAP_FAILED);
         guest_mem += (s->memory.regions[i].mmap_offset / sizeof(*guest_mem));
 
-        for (j = 0; j < 256; j++) {
-            uint32_t a = readl(s->memory.regions[i].guest_phys_addr + j*4);
+        for (j = 0; j < 1024; j++) {
+            uint32_t a = readb(s->memory.regions[i].guest_phys_addr + j);
             uint32_t b = guest_mem[j];
 
             g_assert_cmpint(a, ==, b);
@@ -367,6 +368,7 @@ static void chr_read(void *opaque, const uint8_t *buf, int size)
         msg.flags |= VHOST_USER_REPLY_MASK;
         msg.size = sizeof(m.payload.u64);
         msg.payload.u64 = 1 << VHOST_USER_PROTOCOL_F_LOG_SHMFD;
+        msg.payload.u64 |= 1 << VHOST_USER_PROTOCOL_F_CROSS_ENDIAN;
         if (s->queues > 1) {
             msg.payload.u64 |= 1 << VHOST_USER_PROTOCOL_F_MQ;
         }
-- 
2.19.1


>From f0afa82c6878678b3c7f1f73098494e1110a2b1b Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 15 Nov 2018 09:50:19 +0100
Subject: [PATCH 06/10] vhost-user-test: skip if there is no memory at address
 0

The virt machine cannot run the vhost-user qtests because they hardcode
the presence of memory at address 0.  Report the tests as a skip so that
they can be converted to use qgraph.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/vhost-user-test.c | 58 ++++++++++++++++++++++++++++++++---------
 1 file changed, 45 insertions(+), 13 deletions(-)

diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index 82fc6c581b..59e1aec397 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -228,9 +228,11 @@ static void uninit_virtio_dev(TestServer *s)
     qvirtio_pci_device_free(s->dev);
 }
 
-static void wait_for_fds(TestServer *s)
+static bool wait_for_fds(TestServer *s)
 {
     gint64 end_time;
+    bool got_region;
+    int i;
 
     g_mutex_lock(&s->data_mutex);
 
@@ -248,6 +250,19 @@ static void wait_for_fds(TestServer *s)
     g_assert_cmpint(s->fds_num, ==, s->memory.nregions);
 
     g_mutex_unlock(&s->data_mutex);
+
+    got_region = false;
+    for (i = 0; i < s->memory.nregions; ++i) {
+        VhostUserMemoryRegion *reg = &s->memory.regions[i];
+        if (reg->guest_phys_addr == 0) {
+            got_region = true;
+            break;
+        }
+    }
+    if (!got_region) {
+        g_test_skip("No memory at address 0x0");
+    }
+    return got_region;
 }
 
 static void read_guest_mem_server(TestServer *s)
@@ -256,8 +271,6 @@ static void read_guest_mem_server(TestServer *s)
     int i, j;
     size_t size;
 
-    wait_for_fds(s);
-
     g_mutex_lock(&s->data_mutex);
 
     /* iterate all regions */
@@ -577,8 +590,6 @@ static void write_guest_mem(TestServer *s, uint32_t seed)
     int i, j;
     size_t size;
 
-    wait_for_fds(s);
-
     /* iterate all regions */
     for (i = 0; i < s->fds_num; i++) {
 
@@ -661,8 +672,13 @@ static void test_read_guest_mem(const void *arg)
 
     init_virtio_dev(server, 1u << VIRTIO_NET_F_MAC);
 
+    if (!wait_for_fds(server)) {
+        goto exit;
+    }
+
     read_guest_mem_server(server);
 
+exit:
     uninit_virtio_dev(server);
 
     qtest_quit(s);
@@ -689,8 +705,10 @@ static void test_migrate(void)
     g_free(cmd);
 
     init_virtio_dev(s, 1u << VIRTIO_NET_F_MAC);
-    init_virtio_dev(dest, 1u << VIRTIO_NET_F_MAC);
-    wait_for_fds(s);
+    if (!wait_for_fds(s)) {
+        goto exit;
+    }
+
     size = get_log_size(s);
     g_assert_cmpint(size, ==, (2 * 1024 * 1024) / (VHOST_LOG_PAGE * 8));
 
@@ -699,6 +717,7 @@ static void test_migrate(void)
     g_free(tmp);
     to = qtest_init(cmd);
     g_free(cmd);
+    init_virtio_dev(dest, 1u << VIRTIO_NET_F_MAC);
 
     source = g_source_new(&test_migrate_source_funcs,
                           sizeof(TestMigrateSource));
@@ -738,15 +757,18 @@ static void test_migrate(void)
     global_qtest = to;
     qmp_eventwait("RESUME");
 
+    g_assert(wait_for_fds(s));
     read_guest_mem_server(dest);
 
-    uninit_virtio_dev(s);
     uninit_virtio_dev(dest);
+    qtest_quit(to);
 
     g_source_destroy(source);
     g_source_unref(source);
 
-    qtest_quit(to);
+exit:
+    uninit_virtio_dev(s);
+
     test_server_free(dest);
     qtest_quit(from);
     test_server_free(s);
@@ -810,16 +832,20 @@ static void test_reconnect_subprocess(void)
     g_free(cmd);
 
     init_virtio_dev(s, 1u << VIRTIO_NET_F_MAC);
-    wait_for_fds(s);
+    if (!wait_for_fds(s)) {
+        goto exit;
+    }
+
     wait_for_rings_started(s, 2);
 
     /* reconnect */
     s->fds_num = 0;
     s->rings = 0;
     g_idle_add(reconnect_cb, s);
-    wait_for_fds(s);
+    g_assert(wait_for_fds(s));
     wait_for_rings_started(s, 2);
 
+exit:
     uninit_virtio_dev(s);
 
     qtest_end();
@@ -848,9 +874,12 @@ static void test_connect_fail_subprocess(void)
     g_free(cmd);
 
     init_virtio_dev(s, 1u << VIRTIO_NET_F_MAC);
-    wait_for_fds(s);
+    if (!wait_for_fds(s)) {
+        goto exit;
+    }
     wait_for_rings_started(s, 2);
 
+exit:
     uninit_virtio_dev(s);
 
     qtest_end();
@@ -878,9 +907,12 @@ static void test_flags_mismatch_subprocess(void)
     g_free(cmd);
 
     init_virtio_dev(s, 1u << VIRTIO_NET_F_MAC);
-    wait_for_fds(s);
+    if (!wait_for_fds(s)) {
+        goto exit;
+    }
     wait_for_rings_started(s, 2);
 
+exit:
     uninit_virtio_dev(s);
 
     qtest_end();
-- 
2.19.1


>From f0015ff92d653ce72ebd1873ff62c1c9265dde86 Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 15 Nov 2018 10:17:47 +0100
Subject: [PATCH 07/10] vhost-user-test: reduce usage of global_qtest

Whenever the code can run on multiple QTestStates, use them explicitly instead of
global_qtest.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/vhost-user-test.c | 38 +++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index 59e1aec397..c3a8af3d85 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -187,12 +187,12 @@ static char *get_qemu_cmd(TestServer *s,
     }
 }
 
-static void init_virtio_dev(TestServer *s, uint32_t features_mask)
+static void init_virtio_dev(QTestState *qts, TestServer *s, uint32_t features_mask)
 {
     uint32_t features;
     int i;
 
-    s->bus = qpci_init_pc(global_qtest, NULL);
+    s->bus = qpci_init_pc(qts, NULL);
     g_assert_nonnull(s->bus);
 
     s->dev = qvirtio_pci_device_find(s->bus, VIRTIO_ID_NET);
@@ -203,7 +203,7 @@ static void init_virtio_dev(TestServer *s, uint32_t features_mask)
     qvirtio_set_acknowledge(&s->dev->vdev);
     qvirtio_set_driver(&s->dev->vdev);
 
-    s->alloc = pc_alloc_init(global_qtest);
+    s->alloc = pc_alloc_init(qts);
 
     for (i = 0; i < s->queues * 2; i++) {
         s->vq[i] = qvirtqueue_setup(&s->dev->vdev, s->alloc, i);
@@ -265,7 +265,7 @@ static bool wait_for_fds(TestServer *s)
     return got_region;
 }
 
-static void read_guest_mem_server(TestServer *s)
+static void read_guest_mem_server(QTestState *qts, TestServer *s)
 {
     uint8_t *guest_mem;
     int i, j;
@@ -293,7 +293,7 @@ static void read_guest_mem_server(TestServer *s)
         guest_mem += (s->memory.regions[i].mmap_offset / sizeof(*guest_mem));
 
         for (j = 0; j < 1024; j++) {
-            uint32_t a = readb(s->memory.regions[i].guest_phys_addr + j);
+            uint32_t a = qtest_readb(qts, s->memory.regions[i].guest_phys_addr + j);
             uint32_t b = guest_mem[j];
 
             g_assert_cmpint(a, ==, b);
@@ -670,13 +670,13 @@ static void test_read_guest_mem(const void *arg)
     s = qtest_start(qemu_cmd);
     g_free(qemu_cmd);
 
-    init_virtio_dev(server, 1u << VIRTIO_NET_F_MAC);
+    init_virtio_dev(global_qtest, server, 1u << VIRTIO_NET_F_MAC);
 
     if (!wait_for_fds(server)) {
         goto exit;
     }
 
-    read_guest_mem_server(server);
+    read_guest_mem_server(global_qtest, server);
 
 exit:
     uninit_virtio_dev(server);
@@ -690,7 +690,7 @@ static void test_migrate(void)
     TestServer *s = test_server_new("src");
     TestServer *dest = test_server_new("dest");
     char *uri = g_strdup_printf("%s%s", "unix:", dest->mig_path);
-    QTestState *global = global_qtest, *from, *to;
+    QTestState *from, *to;
     GSource *source;
     gchar *cmd, *tmp;
     QDict *rsp;
@@ -704,7 +704,7 @@ static void test_migrate(void)
     from = qtest_start(cmd);
     g_free(cmd);
 
-    init_virtio_dev(s, 1u << VIRTIO_NET_F_MAC);
+    init_virtio_dev(from, s, 1u << VIRTIO_NET_F_MAC);
     if (!wait_for_fds(s)) {
         goto exit;
     }
@@ -717,7 +717,7 @@ static void test_migrate(void)
     g_free(tmp);
     to = qtest_init(cmd);
     g_free(cmd);
-    init_virtio_dev(dest, 1u << VIRTIO_NET_F_MAC);
+    init_virtio_dev(to, dest, 1u << VIRTIO_NET_F_MAC);
 
     source = g_source_new(&test_migrate_source_funcs,
                           sizeof(TestMigrateSource));
@@ -753,12 +753,10 @@ static void test_migrate(void)
     qobject_unref(rsp);
 
     qmp_eventwait("STOP");
+    qtest_qmp_eventwait(to, "RESUME");
 
-    global_qtest = to;
-    qmp_eventwait("RESUME");
-
-    g_assert(wait_for_fds(s));
-    read_guest_mem_server(dest);
+    g_assert(wait_for_fds(dest));
+    read_guest_mem_server(to, dest);
 
     uninit_virtio_dev(dest);
     qtest_quit(to);
@@ -773,8 +771,6 @@ exit:
     qtest_quit(from);
     test_server_free(s);
     g_free(uri);
-
-    global_qtest = global;
 }
 
 static void wait_for_rings_started(TestServer *s, size_t count)
@@ -831,7 +827,7 @@ static void test_reconnect_subprocess(void)
     qtest_start(cmd);
     g_free(cmd);
 
-    init_virtio_dev(s, 1u << VIRTIO_NET_F_MAC);
+    init_virtio_dev(global_qtest, s, 1u << VIRTIO_NET_F_MAC);
     if (!wait_for_fds(s)) {
         goto exit;
     }
@@ -873,7 +869,7 @@ static void test_connect_fail_subprocess(void)
     qtest_start(cmd);
     g_free(cmd);
 
-    init_virtio_dev(s, 1u << VIRTIO_NET_F_MAC);
+    init_virtio_dev(global_qtest, s, 1u << VIRTIO_NET_F_MAC);
     if (!wait_for_fds(s)) {
         goto exit;
     }
@@ -906,7 +902,7 @@ static void test_flags_mismatch_subprocess(void)
     qtest_start(cmd);
     g_free(cmd);
 
-    init_virtio_dev(s, 1u << VIRTIO_NET_F_MAC);
+    init_virtio_dev(global_qtest, s, 1u << VIRTIO_NET_F_MAC);
     if (!wait_for_fds(s)) {
         goto exit;
     }
@@ -957,7 +953,7 @@ static void test_multiqueue(void)
     qtest_start(cmd);
     g_free(cmd);
 
-    init_virtio_dev(s, features_mask);
+    init_virtio_dev(global_qtest, s, features_mask);
 
     wait_for_rings_started(s, s->queues * 2);
 
-- 
2.19.1


>From c2aead639b37f8e228d75aceddb4b8910fe76712 Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 15 Nov 2018 11:06:01 +0100
Subject: [PATCH 08/10] vhost-user-test: create a main loop per TestServer

This makes the tests more independent and removes the need to defer test_server_free
via an idle event source.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/vhost-user-test.c | 38 ++++++++++++++++----------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index c3a8af3d85..93d5157b13 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -143,6 +143,8 @@ typedef struct TestServer {
     int fds_num;
     int fds[VHOST_MEMORY_MAX_NREGIONS];
     VhostUserMemory memory;
+    GMainLoop *loop;
+    GThread *thread;
     GMutex data_mutex;
     GCond data_cond;
     int log_fd;
@@ -490,6 +492,10 @@ static TestServer *test_server_new(const gchar *name)
 {
     TestServer *server = g_new0(TestServer, 1);
 
+    server->loop = g_main_loop_new(NULL, FALSE);
+    /* run the main loop thread so the chardev may operate */
+    server->thread = g_thread_new(NULL, thread_function, server->loop);
+
     server->socket_path = g_strdup_printf("%s/%s.sock", tmpfs, name);
     server->mig_path = g_strdup_printf("%s/%s.mig", tmpfs, name);
     server->chr_name = g_strdup_printf("chr-%s", name);
@@ -533,9 +539,18 @@ static void test_server_listen(TestServer *server)
     test_server_create_chr(server, ",server,nowait");
 }
 
-static gboolean _test_server_free(TestServer *server)
+static void test_server_free(TestServer *server)
 {
     int i;
+    int ret;
+
+    /* finish the helper thread and dispatch pending sources */
+    g_main_loop_quit(server->loop);
+    g_thread_join(server->thread);
+    while (g_main_context_pending(NULL)) {
+        g_main_context_iteration (NULL, TRUE);
+    }
+    g_main_loop_unref(server->loop);
 
     qemu_chr_fe_deinit(&server->chr, true);
 
@@ -558,13 +573,6 @@ static gboolean _test_server_free(TestServer *server)
     qpci_free_pc(server->bus);
 
     g_free(server);
-
-    return FALSE;
-}
-
-static void test_server_free(TestServer *server)
-{
-    g_idle_add((GSourceFunc)_test_server_free, server);
 }
 
 static void wait_for_log_fd(TestServer *s)
@@ -969,8 +977,6 @@ int main(int argc, char **argv)
     const char *hugefs;
     int ret;
     char template[] = "/tmp/vhost-test-XXXXXX";
-    GMainLoop *loop;
-    GThread *thread;
 
     g_test_init(&argc, &argv, NULL);
 
@@ -991,10 +997,6 @@ int main(int argc, char **argv)
         root = tmpfs;
     }
 
-    loop = g_main_loop_new(NULL, FALSE);
-    /* run the main loop thread so the chardev may operate */
-    thread = g_thread_new(NULL, thread_function, loop);
-
     if (qemu_memfd_check(0)) {
         qtest_add_data_func("/vhost-user/read-guest-mem/memfd",
                             GINT_TO_POINTER(TEST_MEMFD_YES),
@@ -1022,14 +1024,6 @@ int main(int argc, char **argv)
 
     /* cleanup */
 
-    /* finish the helper thread and dispatch pending sources */
-    g_main_loop_quit(loop);
-    g_thread_join(thread);
-    while (g_main_context_pending(NULL)) {
-        g_main_context_iteration (NULL, TRUE);
-    }
-    g_main_loop_unref(loop);
-
     ret = rmdir(tmpfs);
     if (ret != 0) {
         g_test_message("unable to rmdir: path (%s): %s\n",
-- 
2.19.1


>From 8cd2ae9f308831668d5e950454386077f81caa00 Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 15 Nov 2018 10:07:41 +0100
Subject: [PATCH 09/10] vhost-user-test: small changes to init_hugepagefs

After the conversion to qgraph, the equivalent of "main" will be in
a constructor and will run even if the tests are not being requested.
Therefore, it should not assert that init_hugepagefs succeeds and will
be called when creating the TestServer.  This patch changes the prototype
of init_hugepagefs, this way the next patch looks nicer.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/vhost-user-test.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index 93d5157b13..a282fc57c8 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -461,13 +461,19 @@ static void chr_read(void *opaque, const uint8_t *buf, int size)
     g_mutex_unlock(&s->data_mutex);
 }
 
-static const char *init_hugepagefs(const char *path)
+static const char *init_hugepagefs(void)
 {
+    const char *path = getenv("QTEST_HUGETLBFS_PATH");
     struct statfs fs;
     int ret;
 
+    if (!path) {
+        return NULL;
+    }
+
     if (access(path, R_OK | W_OK | X_OK)) {
         g_test_message("access on path (%s): %s\n", path, strerror(errno));
+        abort();
         return NULL;
     }
 
@@ -477,11 +483,13 @@ static const char *init_hugepagefs(const char *path)
 
     if (ret != 0) {
         g_test_message("statfs on path (%s): %s\n", path, strerror(errno));
+        abort();
         return NULL;
     }
 
     if (fs.f_type != HUGETLBFS_MAGIC) {
         g_test_message("Warning: path not on HugeTLBFS: %s\n", path);
+        abort();
         return NULL;
     }
 
@@ -974,7 +982,6 @@ static void test_multiqueue(void)
 
 int main(int argc, char **argv)
 {
-    const char *hugefs;
     int ret;
     char template[] = "/tmp/vhost-test-XXXXXX";
 
@@ -989,13 +996,7 @@ int main(int argc, char **argv)
     }
     g_assert(tmpfs);
 
-    hugefs = getenv("QTEST_HUGETLBFS_PATH");
-    if (hugefs) {
-        root = init_hugepagefs(hugefs);
-        g_assert(root);
-    } else {
-        root = tmpfs;
-    }
+    root = init_hugepagefs() ? : tmpfs;
 
     if (qemu_memfd_check(0)) {
         qtest_add_data_func("/vhost-user/read-guest-mem/memfd",
-- 
2.19.1


>From b1094edbde802a7872bbbd1d6bc9594e716f0d53 Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 15 Nov 2018 13:42:32 +0100
Subject: [PATCH 10/10] vhost-user-test: create a temporary directory per
 TestServer

This makes the tests more independent, and also the source and destination
TestServers in the migration test.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/vhost-user-test.c | 75 +++++++++++++++++++----------------------
 1 file changed, 34 insertions(+), 41 deletions(-)

diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index a282fc57c8..23f129f6fe 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -139,6 +139,8 @@ typedef struct TestServer {
     gchar *socket_path;
     gchar *mig_path;
     gchar *chr_name;
+    const gchar *mem_path;
+    gchar *tmpfs;
     CharBackend chr;
     int fds_num;
     int fds[VHOST_MEMORY_MAX_NREGIONS];
@@ -159,9 +161,6 @@ static TestServer *test_server_new(const gchar *name);
 static void test_server_free(TestServer *server);
 static void test_server_listen(TestServer *server);
 
-static const char *tmpfs;
-static const char *root;
-
 enum test_memfd {
     TEST_MEMFD_AUTO,
     TEST_MEMFD_YES,
@@ -169,7 +168,7 @@ enum test_memfd {
 };
 
 static char *get_qemu_cmd(TestServer *s,
-                          int mem, enum test_memfd memfd, const char *mem_path,
+                          int mem, enum test_memfd memfd,
                           const char *chr_opts, const char *extra)
 {
     if (memfd == TEST_MEMFD_AUTO && qemu_memfd_check(0)) {
@@ -184,7 +183,7 @@ static char *get_qemu_cmd(TestServer *s,
     } else {
         return g_strdup_printf(QEMU_CMD_MEM QEMU_CMD_CHR
                                QEMU_CMD_NETDEV QEMU_CMD_NET "%s", mem, mem,
-                               mem_path, s->chr_name, s->socket_path,
+                               s->mem_path, s->chr_name, s->socket_path,
                                chr_opts, s->chr_name, extra);
     }
 }
@@ -499,11 +498,21 @@ static const char *init_hugepagefs(void)
 static TestServer *test_server_new(const gchar *name)
 {
     TestServer *server = g_new0(TestServer, 1);
+    char template[] = "/tmp/vhost-test-XXXXXX";
+    const char *tmpfs;
 
     server->loop = g_main_loop_new(NULL, FALSE);
     /* run the main loop thread so the chardev may operate */
     server->thread = g_thread_new(NULL, thread_function, server->loop);
 
+    tmpfs = mkdtemp(template);
+    if (!tmpfs) {
+        g_test_message("mkdtemp on path (%s): %s\n", template, strerror(errno));
+    }
+    g_assert(tmpfs);
+
+    server->tmpfs = g_strdup(tmpfs);
+    server->mem_path = init_hugepagefs() ? : server->tmpfs;
     server->socket_path = g_strdup_printf("%s/%s.sock", tmpfs, name);
     server->mig_path = g_strdup_printf("%s/%s.mig", tmpfs, name);
     server->chr_name = g_strdup_printf("chr-%s", name);
@@ -560,6 +569,18 @@ static void test_server_free(TestServer *server)
     }
     g_main_loop_unref(server->loop);
 
+    unlink(server->socket_path);
+    g_free(server->socket_path);
+
+    unlink(server->mig_path);
+    g_free(server->mig_path);
+
+    ret = rmdir(server->tmpfs);
+    if (ret != 0) {
+        g_test_message("unable to rmdir: path (%s): %s\n",
+                       server->tmpfs, strerror(errno));
+    }
+
     qemu_chr_fe_deinit(&server->chr, true);
 
     for (i = 0; i < server->fds_num; i++) {
@@ -570,12 +591,6 @@ static void test_server_free(TestServer *server)
         close(server->log_fd);
     }
 
-    unlink(server->socket_path);
-    g_free(server->socket_path);
-
-    unlink(server->mig_path);
-    g_free(server->mig_path);
-
     g_free(server->chr_name);
     g_assert(server->bus);
     qpci_free_pc(server->bus);
@@ -681,7 +696,7 @@ static void test_read_guest_mem(const void *arg)
                              "read-guest-memfd" : "read-guest-mem");
     test_server_listen(server);
 
-    qemu_cmd = get_qemu_cmd(server, 512, memfd, root, "", "");
+    qemu_cmd = get_qemu_cmd(server, 512, memfd, "", "");
 
     s = qtest_start(qemu_cmd);
     g_free(qemu_cmd);
@@ -716,7 +731,7 @@ static void test_migrate(void)
     test_server_listen(s);
     test_server_listen(dest);
 
-    cmd = get_qemu_cmd(s, 2, TEST_MEMFD_AUTO, root, "", "");
+    cmd = get_qemu_cmd(s, 2, TEST_MEMFD_AUTO, "", "");
     from = qtest_start(cmd);
     g_free(cmd);
 
@@ -729,7 +744,7 @@ static void test_migrate(void)
     g_assert_cmpint(size, ==, (2 * 1024 * 1024) / (VHOST_LOG_PAGE * 8));
 
     tmp = g_strdup_printf(" -incoming %s", uri);
-    cmd = get_qemu_cmd(dest, 2, TEST_MEMFD_AUTO, root, "", tmp);
+    cmd = get_qemu_cmd(dest, 2, TEST_MEMFD_AUTO, "", tmp);
     g_free(tmp);
     to = qtest_init(cmd);
     g_free(cmd);
@@ -839,7 +854,7 @@ static void test_reconnect_subprocess(void)
     char *cmd;
 
     g_thread_new("connect", connect_thread, s);
-    cmd = get_qemu_cmd(s, 2, TEST_MEMFD_AUTO, root, ",server", "");
+    cmd = get_qemu_cmd(s, 2, TEST_MEMFD_AUTO, ",server", "");
     qtest_start(cmd);
     g_free(cmd);
 
@@ -881,7 +896,7 @@ static void test_connect_fail_subprocess(void)
 
     s->test_fail = true;
     g_thread_new("connect", connect_thread, s);
-    cmd = get_qemu_cmd(s, 2, TEST_MEMFD_AUTO, root, ",server", "");
+    cmd = get_qemu_cmd(s, 2, TEST_MEMFD_AUTO, ",server", "");
     qtest_start(cmd);
     g_free(cmd);
 
@@ -914,7 +929,7 @@ static void test_flags_mismatch_subprocess(void)
 
     s->test_flags = TEST_FLAGS_DISCONNECT;
     g_thread_new("connect", connect_thread, s);
-    cmd = get_qemu_cmd(s, 2, TEST_MEMFD_AUTO, root, ",server", "");
+    cmd = get_qemu_cmd(s, 2, TEST_MEMFD_AUTO, ",server", "");
     qtest_start(cmd);
     g_free(cmd);
 
@@ -962,7 +977,7 @@ static void test_multiqueue(void)
         cmd = g_strdup_printf(
             QEMU_CMD_MEM QEMU_CMD_CHR QEMU_CMD_NETDEV ",queues=%d "
             "-device virtio-net-pci,netdev=net0,mq=on,vectors=%d",
-            512, 512, root, s->chr_name,
+            512, 512, s->mem_path, s->chr_name,
             s->socket_path, "", s->chr_name,
             s->queues, s->queues * 2 + 2);
     }
@@ -982,22 +997,11 @@ static void test_multiqueue(void)
 
 int main(int argc, char **argv)
 {
-    int ret;
-    char template[] = "/tmp/vhost-test-XXXXXX";
-
     g_test_init(&argc, &argv, NULL);
 
     module_call_init(MODULE_INIT_QOM);
     qemu_add_opts(&qemu_chardev_opts);
 
-    tmpfs = mkdtemp(template);
-    if (!tmpfs) {
-        g_test_message("mkdtemp on path (%s): %s\n", template, strerror(errno));
-    }
-    g_assert(tmpfs);
-
-    root = init_hugepagefs() ? : tmpfs;
-
     if (qemu_memfd_check(0)) {
         qtest_add_data_func("/vhost-user/read-guest-mem/memfd",
                             GINT_TO_POINTER(TEST_MEMFD_YES),
@@ -1021,16 +1025,5 @@ int main(int argc, char **argv)
         qtest_add_func("/vhost-user/flags-mismatch", test_flags_mismatch);
     }
 
-    ret = g_test_run();
-
-    /* cleanup */
-
-    ret = rmdir(tmpfs);
-    if (ret != 0) {
-        g_test_message("unable to rmdir: path (%s): %s\n",
-                       tmpfs, strerror(errno));
-    }
-    g_assert_cmpint(ret, ==, 0);
-
-    return ret;
+    return g_test_run();
 }
-- 
2.19.1
