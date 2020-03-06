Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B30C3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 05:19:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BC532072A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 05:19:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BC532072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jA5OQ-0006Ro-IM
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 00:19:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51897)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jA5L0-0008Jt-Dd
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 00:15:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jA5Ky-0000ow-6p
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 00:15:54 -0500
Received: from relay.sw.ru ([185.231.240.75]:34038)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jA5Kx-0000iL-Sg; Fri, 06 Mar 2020 00:15:52 -0500
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1jA5Km-0001tg-7F; Fri, 06 Mar 2020 08:15:40 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 02/10] scripts: add coccinelle script to use auto
 propagated errp
Date: Fri,  6 Mar 2020 08:15:28 +0300
Message-Id: <20200306051536.27803-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200306051536.27803-1-vsementsov@virtuozzo.com>
References: <20200306051536.27803-1-vsementsov@virtuozzo.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com,
 Laszlo Ersek <lersek@redhat.com>, qemu-block@nongnu.org,
 Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 armbru@redhat.com, Stefano Stabellini <sstabellini@kernel.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
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

Cc: Eric Blake <eblake@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Cc: Greg Kurz <groug@kaod.org>
Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: Paul Durrant <paul@xen.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: "Philippe Mathieu-Daudé" <philmd@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Stefan Berger <stefanb@linux.ibm.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org

 include/qapi/error.h                          |   3 +
 scripts/coccinelle/auto-propagated-errp.cocci | 231 ++++++++++++++++++
 2 files changed, 234 insertions(+)
 create mode 100644 scripts/coccinelle/auto-propagated-errp.cocci

diff --git a/include/qapi/error.h b/include/qapi/error.h
index bb9bcf02fb..fbfc6f1c0b 100644
--- a/include/qapi/error.h
+++ b/include/qapi/error.h
@@ -211,6 +211,9 @@
  *         }
  *         ...
  *     }
+ *
+ * For mass conversion use script
+ *   scripts/coccinelle/auto-propagated-errp.cocci
  */
 
 #ifndef ERROR_H
diff --git a/scripts/coccinelle/auto-propagated-errp.cocci b/scripts/coccinelle/auto-propagated-errp.cocci
new file mode 100644
index 0000000000..bff274bd6d
--- /dev/null
+++ b/scripts/coccinelle/auto-propagated-errp.cocci
@@ -0,0 +1,231 @@
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
+//  --max-width 80 blockdev-nbd.c qemu-nbd.c \
+//  {block/nbd*,nbd/*,include/block/nbd*}.[hc]
+
+// Switch unusual (Error **) parameter names to errp
+// (this is necessary to use ERRP_AUTO_PROPAGATE).
+//
+// Disable optional_qualifier to skip functions with "Error *const *errp"
+// parameter.
+//
+// Skip functions with "assert(_errp && *_errp)" statement, as they have
+// non generic semantics and may have unusual Error ** argument name for purpose
+// (like nbd_iter_channel_error()).
+//
+// Skip util/error.c to not touch, for example, error_propagate and
+// error_propagate_prepend().
+@ depends on !(file in "util/error.c") disable optional_qualifier@
+identifier fn;
+identifier _errp != errp;
+@@
+
+ fn(...,
+-   Error **_errp
++   Error **errp
+    ,...)
+ {
+(
+     ... when != assert(_errp && *_errp)
+&
+     <...
+-    _errp
++    errp
+     ...>
+)
+ }
+
+// Add invocation of ERRP_AUTO_PROPAGATE to errp-functions where necessary
+//
+// Note, that without "when any" final "..." may not want to mach something
+// matched by previous pattern, i.e. the rule will not match double
+// error_prepend in control flow like in vfio_set_irq_signaling().
+//
+// Note, "exists" says that we want apply rule even if it matches not on
+// all possible control flows (otherwise, it will not match standard pattern
+// when error_propagate() call is in if branch).
+@ disable optional_qualifier exists@
+identifier fn, local_err, errp;
+@@
+
+ fn(..., Error **errp, ...)
+ {
++   ERRP_AUTO_PROPAGATE();
+    ...  when != ERRP_AUTO_PROPAGATE();
+(
+    error_append_hint(errp, ...);
+|
+    error_prepend(errp, ...);
+|
+    error_vprepend(errp, ...);
+|
+    Error *local_err = NULL;
+    ...
+(
+    error_propagate_prepend(errp, local_err, ...);
+|
+    error_propagate(errp, local_err);
+)
+)
+    ... when any
+ }
+
+
+// Match scenarios with propagation of local error to errp.
+@rule1 disable optional_qualifier exists@
+identifier fn, local_err;
+symbol errp;
+@@
+
+ fn(..., Error **errp, ...)
+ {
+     ...
+     Error *local_err = NULL;
+     ...
+(
+    error_propagate_prepend(errp, local_err, ...);
+|
+    error_propagate(errp, local_err);
+)
+     ...
+ }
+
+// Convert special case with goto in separate.
+// We can probably merge this into the following hunk with help of ( | )
+// operator, but it significantly reduce performance on block.c parsing (or it
+// hangs, I don't know)
+//
+// Note interesting thing: if we don't do it here, and try to fixup "out: }"
+// things later after all transformations (the rule will be the same, just
+// without error_propagate() call), coccinelle fails to match this "out: }".
+@@
+identifier rule1.fn, rule1.local_err, out;
+symbol errp;
+@@
+
+ fn(...)
+ {
+     <...
+-    goto out;
++    return;
+     ...>
+- out:
+-    error_propagate(errp, local_err);
+ }
+
+// Convert most of local_err related staff.
+//
+// Note, that we update everything related to matched by rule1 function name
+// and local_err name. We may match something not related to the pattern
+// matched by rule1. For example, local_err may be defined with the same name
+// in different blocks inside one function, and in one block follow the
+// propagation pattern and in other block doesn't. Or we may have several
+// functions with the same name (for different configurations).
+//
+// Note also that errp-cleaning functions
+//   error_free_errp
+//   error_report_errp
+//   error_reportf_errp
+//   warn_report_errp
+//   warn_reportf_errp
+// are not yet implemented. They must call corresponding Error* - freeing
+// function and then set *errp to NULL, to avoid further propagation to
+// original errp (consider ERRP_AUTO_PROPAGATE in use).
+// For example, error_free_errp may look like this:
+//
+//    void error_free_errp(Error **errp)
+//    {
+//        error_free(*errp);
+//        *errp = NULL;
+//    }
+@ exists@
+identifier rule1.fn, rule1.local_err;
+expression list args;
+symbol errp;
+@@
+
+ fn(...)
+ {
+     <...
+(
+-    Error *local_err = NULL;
+|
+
+// Convert error clearing functions
+(
+-    error_free(local_err);
++    error_free_errp(errp);
+|
+-    error_report_err(local_err);
++    error_report_errp(errp);
+|
+-    error_reportf_err(local_err, args);
++    error_reportf_errp(errp, args);
+|
+-    warn_report_err(local_err);
++    warn_report_errp(errp);
+|
+-    warn_reportf_err(local_err, args);
++    warn_reportf_errp(errp, args);
+)
+?-    local_err = NULL;
+
+|
+-    error_propagate_prepend(errp, local_err, args);
++    error_prepend(errp, args);
+|
+-    error_propagate(errp, local_err);
+|
+-    &local_err
++    errp
+)
+     ...>
+ }
+
+// Convert remaining local_err usage. It should be different kinds of error
+// checking in if operators. We can't merge this into previous hunk, as this
+// conflicts with other substitutions in it (at least with "- local_err = NULL").
+@@
+identifier rule1.fn, rule1.local_err;
+symbol errp;
+@@
+
+ fn(...)
+ {
+     <...
+-    local_err
++    *errp
+     ...>
+ }
+
+// Always use the same patter for checking error
+@@
+identifier rule1.fn;
+symbol errp;
+@@
+
+ fn(...)
+ {
+     <...
+-    *errp != NULL
++    *errp
+     ...>
+ }
-- 
2.21.0


