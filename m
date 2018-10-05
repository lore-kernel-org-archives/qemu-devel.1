Received: from eggs.gnu.org ([2001:4830:134:3::10]:56965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g8SMB-0006b4-8W
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:49:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g8SM9-0006E4-Bj
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:49:35 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:41147)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1g8SM8-00067X-No
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:49:33 -0400
Received: by mail-wr1-x431.google.com with SMTP id x12-v6so14041395wru.8
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 08:49:27 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  5 Oct 2018 16:49:02 +0100
Message-Id: <20181005154910.3099-14-alex.bennee@linaro.org>
In-Reply-To: <20181005154910.3099-1-alex.bennee@linaro.org>
References: <20181005154910.3099-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 13/21] tracetool: generate plugin snippets
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 scripts/tracetool/backend/plugin.py | 79 +++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 scripts/tracetool/backend/plugin.py

diff --git a/scripts/tracetool/backend/plugin.py b/scripts/tracetool/backend/plugin.py
new file mode 100644
index 0000000000..d96b2df00a
--- /dev/null
+++ b/scripts/tracetool/backend/plugin.py
@@ -0,0 +1,79 @@
+#!/usr/bin/env python
+# -*- coding: utf-8 -*-
+
+"""
+Plugin backend.
+"""
+
+__author__     = "Alex Bennée <alex.bennee@linaro.org>"
+__copyright__  = "Copyright 2018, Alex Bennée <alex.bennee@linaro.org>"
+__license__    = "GPL version 2 or (at your option) any later version"
+
+__maintainer__ = "Alex Bennée"
+__email__      = "alex.bennee@linaro.org"
+
+
+from tracetool import out
+
+
+PUBLIC = True
+
+
+def generate_h_begin(events, group):
+    for event in events:
+        # prototype for plugin event
+        out('bool _plugin_%(api)s(%(args)s);',
+            api=event.api(),
+            args=event.args)
+        # prototype for plugin fn
+        out("typedef bool (* _plugin_%(api)s_fn)(%(args)s);",
+            api=event.api(),
+            args=event.args)
+
+
+def generate_h(event, group):
+    out('    if (!_plugin_%(api)s(%(args)s)) {',
+        '        return;',
+        '    };',
+        api=event.api(),
+        args=", ".join(event.args.names()))
+
+def generate_c_begin(events, group):
+    out('#include "qemu/osdep.h"',
+        '#include "trace/control.h"',
+        '')
+
+def generate_c(event, group):
+    out('bool _plugin_%(api)s(%(args)s)',
+        '{',
+        api=event.api(),
+        args=event.args)
+
+    event_id = 'TRACE_' + event.name.upper()
+    cond = "trace_event_get_state(%s)" % event_id
+
+    # Forst the pre-amble, bail early if the event is not enabled and
+    # if it is but no plugin is enabled let the reset of the events proceed.
+
+    out('',
+        '    if (!%(cond)s) {',
+        '        return false;',
+        '    }',
+        '',
+        '    uintptr_t fp = trace_event_get_plugin(&_%(event)s_EVENT);',
+        '    if (!fp) {',
+        '        return true;',
+        '    }',
+        '',
+        cond=cond,
+        event=event_id)
+
+    # We need to construct cast to the correct fn pointer to now call the plugin
+
+    out('',
+        '    _plugin_%(api)s_fn plug_fn = (_plugin_%(api)s_fn) fp;',
+        '    return plug_fn(%(names)s);',
+        '}',
+        '',
+        api=event.api(),
+        names=", ".join(event.args.names()))
-- 
2.17.1
