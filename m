Received: from eggs.gnu.org ([2001:4830:134:3::10]:56950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g8SMB-0006am-4Z
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:49:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g8SM9-0006Dy-AY
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:49:34 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:52744)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1g8SM8-00062l-Rn
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:49:33 -0400
Received: by mail-wm1-x335.google.com with SMTP id 189-v6so2313796wmw.2
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 08:49:18 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  5 Oct 2018 16:48:54 +0100
Message-Id: <20181005154910.3099-6-alex.bennee@linaro.org>
In-Reply-To: <20181005154910.3099-1-alex.bennee@linaro.org>
References: <20181005154910.3099-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 05/21] trace: keep a count of trace-point
 hits
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

When working via the HMP to dynamically enable trace points it would
be useful to know if trace points are currently being hit. As the cost
is low we can simply increment a counter as we consider if we are
going to trace the event.

This cannot be precise as we don't take care to use atomic accesses
but it is usefully indicative.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 scripts/tracetool/backend/simple.py | 2 ++
 trace/event-internal.h              | 1 +
 2 files changed, 3 insertions(+)

diff --git a/scripts/tracetool/backend/simple.py b/scripts/tracetool/backend/simple.py
index c2fd1c24c4..eaa19a1032 100644
--- a/scripts/tracetool/backend/simple.py
+++ b/scripts/tracetool/backend/simple.py
@@ -81,6 +81,8 @@ def generate_c(event, group):
         cond = "trace_event_get_state(%s)" % event_id
 
     out('',
+        '    %(event_obj)s.count++;',
+        '',
         '    if (!%(cond)s) {',
         '        return;',
         '    }',
diff --git a/trace/event-internal.h b/trace/event-internal.h
index f63500b37e..8ab3a29941 100644
--- a/trace/event-internal.h
+++ b/trace/event-internal.h
@@ -37,6 +37,7 @@ typedef struct TraceEvent {
     const char * name;
     const bool sstate;
     uint16_t *dstate;
+    uint64_t count;
 } TraceEvent;
 
 void trace_event_set_state_dynamic_init(TraceEvent *ev, bool state);
-- 
2.17.1
