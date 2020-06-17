Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C58AC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 13:49:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BC3C21655
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 13:49:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BC3C21655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlYR4-0001D3-BC
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 09:49:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jlYNV-000609-6l; Wed, 17 Jun 2020 09:45:21 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:64285)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jlYNR-0006w2-RQ; Wed, 17 Jun 2020 09:45:20 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 1BB877475FA;
 Wed, 17 Jun 2020 15:45:06 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 9D06E7482D3; Wed, 17 Jun 2020 15:45:05 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Wed, 17 Jun 2020 15:36:29 +0200
Subject: [PATCH 2/2] scripts/tracetool: Add plainlog backend
To: qemu-devel@nongnu.org
Message-Id: <20200617134505.9D06E7482D3@zero.eik.bme.hu>
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, PP_MIME_FAKE_ASCII_TEXT=1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-trivial@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a backend that is the same as the log backend but omits the
process id and timestamp so logs are easier to read and diff-able.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 scripts/tracetool/backend/plainlog.py | 48 +++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 scripts/tracetool/backend/plainlog.py

diff --git a/scripts/tracetool/backend/plainlog.py b/scripts/tracetool/backend/plainlog.py
new file mode 100644
index 0000000000..40bbfa6d76
--- /dev/null
+++ b/scripts/tracetool/backend/plainlog.py
@@ -0,0 +1,48 @@
+# -*- coding: utf-8 -*-
+
+"""
+Stderr built-in backend, plain log without proc ID and time.
+"""
+
+__author__     = "Lluís Vilanova <vilanova@ac.upc.edu>"
+__copyright__  = "Copyright 2012-2017, Lluís Vilanova <vilanova@ac.upc.edu>"
+__license__    = "GPL version 2 or (at your option) any later version"
+
+__maintainer__ = "Stefan Hajnoczi"
+__email__      = "stefanha@linux.vnet.ibm.com"
+
+
+from tracetool import out
+
+
+PUBLIC = True
+
+
+def generate_h_begin(events, group):
+    out('#include "qemu/log-for-trace.h"',
+        '')
+
+
+def generate_h(event, group):
+    argnames = ", ".join(event.args.names())
+    if len(event.args) > 0:
+        argnames = ", " + argnames
+
+    if "vcpu" in event.properties:
+        # already checked on the generic format code
+        cond = "true"
+    else:
+        cond = "trace_event_get_state(%s)" % ("TRACE_" + event.name.upper())
+
+    out('    if (%(cond)s && qemu_loglevel_mask(LOG_TRACE)) {',
+        '        qemu_log("%(name)s " %(fmt)s "\\n" %(argnames)s);',
+        '    }',
+        cond=cond,
+        name=event.name,
+        fmt=event.fmt.rstrip("\n"),
+        argnames=argnames)
+
+
+def generate_h_backend_dstate(event, group):
+    out('    trace_event_get_state_dynamic_by_id(%(event_id)s) || \\',
+        event_id="TRACE_" + event.name.upper())
-- 
2.21.3


