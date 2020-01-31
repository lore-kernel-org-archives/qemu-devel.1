Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E945EC33CB2
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 13:09:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0195205F4
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 13:09:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0195205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixW3D-0000ND-Uf
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 08:09:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46449)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ixVvk-0006kH-Uh
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 08:01:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ixVvj-0008Ol-9g
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 08:01:52 -0500
Received: from relay.sw.ru ([185.231.240.75]:59648)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1ixVvj-0007ve-1j; Fri, 31 Jan 2020 08:01:51 -0500
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1ixVvI-0000zU-3z; Fri, 31 Jan 2020 16:01:24 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 03/11] scripts: add coccinelle script to use auto
 propagated errp
Date: Fri, 31 Jan 2020 16:01:10 +0300
Message-Id: <20200131130118.1716-4-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200131130118.1716-1-vsementsov@virtuozzo.com>
References: <20200131130118.1716-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 185.231.240.75
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Laszlo Ersek <lersek@redhat.com>, qemu-block@nongnu.org,
 Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Greg Kurz <groug@kaod.org>, armbru@redhat.com,
 Stefano Stabellini <sstabellini@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Max Reitz <mreitz@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Script adds ERRP_AUTO_PROPAGATE macro invocation where appropriate and
does corresponding changes in code (look for details in
include/qapi/error.h)

Usage example:
spatch --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
 --macro-file scripts/cocci-macro-file.h --in-place --no-show-diff \
 blockdev-nbd.c qemu-nbd.c {block/nbd*,nbd/*,include/block/nbd*}.[hc]

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---

CC: Eric Blake <eblake@redhat.com>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Max Reitz <mreitz@redhat.com>
CC: Greg Kurz <groug@kaod.org>
CC: Stefano Stabellini <sstabellini@kernel.org>
CC: Anthony Perard <anthony.perard@citrix.com>
CC: Paul Durrant <paul@xen.org>
CC: Stefan Hajnoczi <stefanha@redhat.com>
CC: "Philippe Mathieu-Daudé" <philmd@redhat.com>
CC: Laszlo Ersek <lersek@redhat.com>
CC: Gerd Hoffmann <kraxel@redhat.com>
CC: Stefan Berger <stefanb@linux.ibm.com>
CC: Markus Armbruster <armbru@redhat.com>
CC: Michael Roth <mdroth@linux.vnet.ibm.com>
CC: qemu-block@nongnu.org
CC: xen-devel@lists.xenproject.org

 include/qapi/error.h                          |   3 +
 scripts/coccinelle/auto-propagated-errp.cocci | 158 ++++++++++++++++++
 2 files changed, 161 insertions(+)
 create mode 100644 scripts/coccinelle/auto-propagated-errp.cocci

diff --git a/include/qapi/error.h b/include/qapi/error.h
index b9452d4806..79f8e95214 100644
--- a/include/qapi/error.h
+++ b/include/qapi/error.h
@@ -141,6 +141,9 @@
  *         ...
  *     }
  *
+ * For mass conversion use script
+ *   scripts/coccinelle/auto-propagated-errp.cocci
+ *
  *
  * Receive and accumulate multiple errors (first one wins):
  *     Error *err = NULL, *local_err = NULL;
diff --git a/scripts/coccinelle/auto-propagated-errp.cocci b/scripts/coccinelle/auto-propagated-errp.cocci
new file mode 100644
index 0000000000..fb03c871cb
--- /dev/null
+++ b/scripts/coccinelle/auto-propagated-errp.cocci
@@ -0,0 +1,158 @@
+// Use ERRP_AUTO_PROPAGATE (see include/qapi/error.h)
+//
+// Copyright (c) 2020 Virtuozzo International GmbH.
+//
+// This program is free software; you can redistribute it and/or modify
+// it under the terms of the GNU General Public License as published by
+// the Free Software Foundation; either version 2 of the License, or
+// (at your option) any later version.
+//
+// This program is distributed in the hope that it will be useful,
+// but WITHOUT ANY WARRANTY; without even the implied warranty of
+// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+// GNU General Public License for more details.
+//
+// You should have received a copy of the GNU General Public License
+// along with this program.  If not, see <http://www.gnu.org/licenses/>.
+//
+// Usage example:
+// spatch --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
+//  --macro-file scripts/cocci-macro-file.h --in-place --no-show-diff \
+//  blockdev-nbd.c qemu-nbd.c {block/nbd*,nbd/*,include/block/nbd*}.[hc]
+
+@rule0@
+// Add invocation to errp-functions where necessary
+// We should skip functions with "Error *const *errp"
+// parameter, but how to do it with coccinelle?
+// I don't know, so, I skip them by function name regex.
+// It's safe: if we did not skip some functions with
+// "Error *const *errp", ERRP_AUTO_PROPAGATE invocation
+// will fail to compile, because of const violation.
+identifier fn !~ "error_append_.*_hint";
+identifier local_err, ERRP;
+@@
+
+ fn(..., Error **ERRP, ...)
+ {
++   ERRP_AUTO_PROPAGATE();
+    <+...
+        when != ERRP_AUTO_PROPAGATE();
+(
+    error_append_hint(ERRP, ...);
+|
+    error_prepend(ERRP, ...);
+|
+    Error *local_err = NULL;
+)
+    ...+>
+ }
+
+@@
+// Switch unusual (Error **) parameter names to errp
+// (this is necessary to use ERRP_AUTO_PROPAGATE).
+identifier rule0.fn;
+identifier rule0.ERRP != errp;
+@@
+
+ fn(...,
+-   Error **ERRP
++   Error **errp
+    ,...)
+ {
+     <...
+-    ERRP
++    errp
+     ...>
+ }
+
+@rule1@
+// We want to patch error propagation in functions regardless of
+// whether the function already uses ERRP_AUTO_PROPAGATE prior to
+// applying rule0, hence this one does not inherit from it.
+identifier fn !~ "error_append_.*_hint";
+identifier local_err;
+symbol errp;
+@@
+
+ fn(..., Error **errp, ...)
+ {
+     <...
+-    Error *local_err = NULL;
+     ...>
+ }
+
+@@
+// Handle pattern with goto, otherwise we'll finish up
+// with labels at function end which will not compile.
+identifier rule1.fn, rule1.local_err;
+identifier OUT;
+@@
+
+ fn(...)
+ {
+     <...
+-    goto OUT;
++    return;
+     ...>
+- OUT:
+-    error_propagate(errp, local_err);
+ }
+
+@@
+identifier rule1.fn, rule1.local_err;
+expression list args; // to reindent error_propagate_prepend
+@@
+
+ fn(...)
+ {
+     <...
+(
+-    error_free(local_err);
+-    local_err = NULL;
++    error_free_errp(errp);
+|
+-    error_free(local_err);
++    error_free_errp(errp);
+|
+-    error_report_err(local_err);
++    error_report_errp(errp);
+|
+-    warn_report_err(local_err);
++    warn_report_errp(errp);
+|
+-    error_propagate_prepend(errp, local_err, args);
++    error_prepend(errp, args);
+|
+-    error_propagate(errp, local_err);
+)
+     ...>
+ }
+
+@@
+identifier rule1.fn, rule1.local_err;
+@@
+
+ fn(...)
+ {
+     <...
+(
+-    &local_err
++    errp
+|
+-    local_err
++    *errp
+)
+     ...>
+ }
+
+@@
+identifier rule1.fn;
+@@
+
+ fn(...)
+ {
+     <...
+- *errp != NULL
++ *errp
+     ...>
+ }
-- 
2.21.0


