Received: from eggs.gnu.org ([2001:4830:134:3::10]:57105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g8SMF-0006fL-FE
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:49:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g8SM9-0006F4-LU
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:49:39 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:52743)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1g8SM9-00065z-76
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:49:33 -0400
Received: by mail-wm1-x333.google.com with SMTP id 189-v6so2314139wmw.2
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 08:49:25 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  5 Oct 2018 16:49:00 +0100
Message-Id: <20181005154910.3099-12-alex.bennee@linaro.org>
In-Reply-To: <20181005154910.3099-1-alex.bennee@linaro.org>
References: <20181005154910.3099-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 11/21] trace: expose a plugin fn pointer in
 TraceEvent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel.Dovgaluk@ispras.ru, vilanova@ac.upc.edu, cota@braap.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

We'll need somewhere to stash this later. It's up to the generated
code to do the funky casting to what it really is.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 trace/control-internal.h | 6 ++++++
 trace/event-internal.h   | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/trace/control-internal.h b/trace/control-internal.h
index c7fbe2d3bf..d734576948 100644
--- a/trace/control-internal.h
+++ b/trace/control-internal.h
@@ -80,6 +80,12 @@ static inline bool trace_event_get_vcpu_state_dynamic(CPUState *vcpu,
     return trace_event_get_vcpu_state_dynamic_by_vcpu_id(vcpu, vcpu_id);
 }
 
+#ifdef CONFIG_TRACE_PLUGIN
+static inline uintptr_t trace_event_get_plugin(TraceEvent *ev)
+{
+    return ev->plugin;
+}
+#endif
 
 void trace_event_register_group(TraceEvent **events);
 
diff --git a/trace/event-internal.h b/trace/event-internal.h
index 8ab3a29941..3895ee9883 100644
--- a/trace/event-internal.h
+++ b/trace/event-internal.h
@@ -38,6 +38,9 @@ typedef struct TraceEvent {
     const bool sstate;
     uint16_t *dstate;
     uint64_t count;
+#ifdef CONFIG_TRACE_PLUGIN
+    uintptr_t plugin;
+#endif
 } TraceEvent;
 
 void trace_event_set_state_dynamic_init(TraceEvent *ev, bool state);
-- 
2.17.1
