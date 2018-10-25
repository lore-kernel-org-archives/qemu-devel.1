Received: from eggs.gnu.org ([2001:4830:134:3::10]:40456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjKj-0006j1-Bz
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:22:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjKi-0000QZ-AQ
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:22:09 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:41187)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gFjKi-0000Fb-3c
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:22:08 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 25 Oct 2018 13:20:56 -0400
Message-Id: <20181025172057.20414-48-cota@braap.org>
In-Reply-To: <20181025172057.20414-1-cota@braap.org>
References: <20181025172057.20414-1-cota@braap.org>
Subject: [Qemu-devel] [RFC 47/48] plugin: support guest hooks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>

These "hooks" are callbacks from the guest to plugins. This is
useful when we need guest-host communication, for instance to
signal the beginning/end of a certain "region of interest" in
the guest program. Simulators typically would use "magic"
instructions for this, but that is painful to maintain across
ISAs. Instead, we use plugin-chan PCI device through which we can
relay guest messages to the host.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/qemu/plugin-api.h |  6 ++++++
 include/qemu/plugin.h     |  2 ++
 plugin.c                  | 13 +++++++++++++
 qemu-plugins.symbols      |  1 +
 4 files changed, 22 insertions(+)

diff --git a/include/qemu/plugin-api.h b/include/qemu/plugin-api.h
index 5062e20e08..a5faff6a2a 100644
--- a/include/qemu/plugin-api.h
+++ b/include/qemu/plugin-api.h
@@ -234,6 +234,12 @@ void qemu_plugin_register_lockstep_cb(qemu_plugin_id_t id,
 
 void qemu_plugin_end_time_slice(void);
 
+typedef void (*qemu_plugin_hook_cb_t)(uint32_t cmd, const void *data,
+                                      size_t size);
+
+void qemu_plugin_register_hook_cb(qemu_plugin_id_t id,
+                                  qemu_plugin_hook_cb_t cb);
+
 /* returns -1 in user-mode */
 int qemu_plugin_n_vcpus(void);
 
diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index f3c18d1032..ced265a127 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -61,12 +61,14 @@ enum qemu_plugin_event {
     QEMU_PLUGIN_EV_LOCKSTEP,
     QEMU_PLUGIN_EV_FLUSH,
     QEMU_PLUGIN_EV_ATEXIT,
+    QEMU_PLUGIN_EV_HOOK,
     QEMU_PLUGIN_EV_MAX,
 };
 
 union qemu_plugin_cb_sig {
     qemu_plugin_simple_cb_t          simple;
     qemu_plugin_udata_cb_t           udata;
+    qemu_plugin_hook_cb_t            hook;
     qemu_plugin_vcpu_simple_cb_t     vcpu_simple;
     qemu_plugin_vcpu_udata_cb_t      vcpu_udata;
     qemu_plugin_vcpu_tb_trans_cb_t   vcpu_tb_trans;
diff --git a/plugin.c b/plugin.c
index 2bbc14e2f3..4004451bdb 100644
--- a/plugin.c
+++ b/plugin.c
@@ -1078,8 +1078,21 @@ void plugin_lockstep_cb(void)
     plugin_cb__simple(QEMU_PLUGIN_EV_LOCKSTEP);
 }
 
+void qemu_plugin_register_hook_cb(qemu_plugin_id_t id, qemu_plugin_hook_cb_t cb)
+{
+    plugin_register_cb(id, QEMU_PLUGIN_EV_HOOK, cb);
+}
+
 void plugin_chan_xmit(uint32_t cmd, const void *data, size_t size)
 {
+    struct qemu_plugin_cb *cb, *next;
+    enum qemu_plugin_event ev = QEMU_PLUGIN_EV_HOOK;
+
+    QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
+        qemu_plugin_hook_cb_t func = cb->f.hook;
+
+        func(cmd, data, size);
+    }
 }
 
 static void __attribute__((__constructor__)) plugin_init(void)
diff --git a/qemu-plugins.symbols b/qemu-plugins.symbols
index a3268a40c7..2e17693da8 100644
--- a/qemu-plugins.symbols
+++ b/qemu-plugins.symbols
@@ -31,6 +31,7 @@
   qemu_plugin_mem_is_big_endian;
   qemu_plugin_mem_is_store;
   qemu_plugin_vcpu_for_each;
+  qemu_plugin_register_hook_cb;
   qemu_plugin_n_vcpus;
   qemu_plugin_n_max_vcpus;
 };
-- 
2.17.1
