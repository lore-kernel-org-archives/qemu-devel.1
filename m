Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78597C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 08:51:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B28320756
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 08:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dcoF7wRW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B28320756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHkCR-00034b-1h
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 04:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41370)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kHk9k-0006bN-SW
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 04:48:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41078
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kHk9i-0005DP-8c
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 04:48:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600073289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZVYGpXY6+gkZvGfPrHmNExooqUnhdkkdmUY/MaXIzPA=;
 b=dcoF7wRWFFCh7m9v09hL/EbxHFBcwyiUcHDizXrZ7K2A/10Ko8wKxt7wihZM/CnfKK+Gef
 XBUbXhRN3nhRky3F4hOfxzxlfpT0nQDOKh5KbiuBrZoMz33WgBi9zATSnWjGR8DEzmKYv+
 CRBZul4cXnWewa4+uFV2817xvxufko0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-56nd3RA0MYORTc6MJUxxDQ-1; Mon, 14 Sep 2020 04:48:07 -0400
X-MC-Unique: 56nd3RA0MYORTc6MJUxxDQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E57E801AE3;
 Mon, 14 Sep 2020 08:48:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F3AB75DE93;
 Mon, 14 Sep 2020 08:48:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 75F7F1138461; Mon, 14 Sep 2020 10:48:02 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 1/8] qemu-options: New -compat to set policy for deprecated
 interfaces
Date: Mon, 14 Sep 2020 10:47:55 +0200
Message-Id: <20200914084802.4185028-2-armbru@redhat.com>
In-Reply-To: <20200914084802.4185028-1-armbru@redhat.com>
References: <20200914084802.4185028-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 01:36:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.695,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: marcandre.lureau@gmail.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Policy is separate for input and output.

Input policy can be "accept" (accept silently), or "reject" (reject
the request with an error).

Output policy can be "accept" (pass on unchanged), or "hide" (filter
out the deprecated parts).

Default is "accept".  Policies other than "accept" are implemented
later in this series.

For now, -compat covers only syntactic aspects of QMP, i.e. stuff
tagged with feature 'deprecated'.  We may want to extend it to cover
semantic aspects, CLI, and experimental features.

The option is experimental.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/compat.json             | 51 ++++++++++++++++++++++++++++++++++++
 qapi/qapi-schema.json        |  1 +
 include/qapi/compat-policy.h | 20 ++++++++++++++
 qapi/qmp-dispatch.c          |  3 +++
 softmmu/vl.c                 | 17 ++++++++++++
 qapi/meson.build             |  1 +
 qemu-options.hx              | 20 ++++++++++++++
 7 files changed, 113 insertions(+)
 create mode 100644 qapi/compat.json
 create mode 100644 include/qapi/compat-policy.h

diff --git a/qapi/compat.json b/qapi/compat.json
new file mode 100644
index 0000000000..d2c02a21aa
--- /dev/null
+++ b/qapi/compat.json
@@ -0,0 +1,51 @@
+# -*- Mode: Python -*-
+
+##
+# = Compatibility policy
+##
+
+##
+# @CompatPolicyInput:
+#
+# Policy for handling "funny" input.
+#
+# @accept: Accept silently
+# @reject: Reject with an error
+#
+# Since: 5.2
+##
+{ 'enum': 'CompatPolicyInput',
+  'data': [ 'accept', 'reject' ] }
+
+##
+# @CompatPolicyOutput:
+#
+# Policy for handling "funny" output.
+#
+# @accept: Pass on unchanged
+# @hide: Filter out
+#
+# Since: 5.2
+##
+{ 'enum': 'CompatPolicyOutput',
+  'data': [ 'accept', 'hide' ] }
+
+##
+# @CompatPolicy:
+#
+# Policy for handling deprecated management interfaces.
+#
+# This is intended for testing users of the management interfaces.
+#
+# Limitation: covers only syntactic aspects of QMP, i.e. stuff tagged
+# with feature 'deprecated'.  We may want to extend it to cover
+# semantic aspects, CLI, and experimental features.
+#
+# @deprecated-input: how to handle deprecated input (default 'accept')
+# @deprecated-output: how to handle deprecated output (default 'accept')
+#
+# Since: 5.2
+##
+{ 'struct': 'CompatPolicy',
+  'data': { '*deprecated-input': 'CompatPolicyInput',
+            '*deprecated-output': 'CompatPolicyOutput' } }
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index f03ff91ceb..2550b16028 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -76,6 +76,7 @@
 { 'include': 'migration.json' }
 { 'include': 'transaction.json' }
 { 'include': 'trace.json' }
+{ 'include': 'compat.json' }
 { 'include': 'control.json' }
 { 'include': 'introspect.json' }
 { 'include': 'qom.json' }
diff --git a/include/qapi/compat-policy.h b/include/qapi/compat-policy.h
new file mode 100644
index 0000000000..b8c6638156
--- /dev/null
+++ b/include/qapi/compat-policy.h
@@ -0,0 +1,20 @@
+/*
+ * Policy for handling "funny" management interfaces
+ *
+ * Copyright (C) 2020 Red Hat, Inc.
+ *
+ * Authors:
+ *  Markus Armbruster <armbru@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * later.  See the COPYING file in the top-level directory.
+ */
+
+#ifndef QAPI_COMPAT_POLICY_H
+#define QAPI_COMPAT_POLICY_H
+
+#include "qapi/qapi-types-compat.h"
+
+extern CompatPolicy compat_policy;
+
+#endif
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 79347e0864..f65b8cf000 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -12,6 +12,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/compat-policy.h"
 #include "qapi/error.h"
 #include "qapi/qmp/dispatch.h"
 #include "qapi/qmp/qdict.h"
@@ -19,6 +20,8 @@
 #include "sysemu/runstate.h"
 #include "qapi/qmp/qbool.h"
 
+CompatPolicy compat_policy;
+
 static QDict *qmp_dispatch_check_obj(QDict *dict, bool allow_oob,
                                      Error **errp)
 {
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 0cc86b0766..dbe9dc06f0 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -27,6 +27,7 @@
 #include "qemu/units.h"
 #include "hw/boards.h"
 #include "hw/qdev-properties.h"
+#include "qapi/compat-policy.h"
 #include "qapi/error.h"
 #include "qemu-version.h"
 #include "qemu/cutils.h"
@@ -106,6 +107,7 @@
 #include "sysemu/replay.h"
 #include "qapi/qapi-events-run-state.h"
 #include "qapi/qapi-visit-block-core.h"
+#include "qapi/qapi-visit-compat.h"
 #include "qapi/qapi-visit-ui.h"
 #include "qapi/qapi-commands-block-core.h"
 #include "qapi/qapi-commands-run-state.h"
@@ -3771,6 +3773,21 @@ void qemu_init(int argc, char **argv, char **envp)
                     qemu_opt_get_bool(opts, "mem-lock", false);
                 enable_cpu_pm = qemu_opt_get_bool(opts, "cpu-pm", false);
                 break;
+            case QEMU_OPTION_compat:
+                {
+                    CompatPolicy *opts;
+                    Visitor *v;
+
+                    v = qobject_input_visitor_new_str(optarg, NULL,
+                                                      &error_fatal);
+
+                    visit_type_CompatPolicy(v, NULL, &opts, &error_fatal);
+                    QAPI_CLONE_MEMBERS(CompatPolicy, &compat_policy, opts);
+
+                    qapi_free_CompatPolicy(opts);
+                    visit_free(v);
+                    break;
+                }
             case QEMU_OPTION_msg:
                 opts = qemu_opts_parse_noisily(qemu_find_opts("msg"), optarg,
                                                false);
diff --git a/qapi/meson.build b/qapi/meson.build
index 2b2872a41d..c72fcd9616 100644
--- a/qapi/meson.build
+++ b/qapi/meson.build
@@ -20,6 +20,7 @@ qapi_all_modules = [
   'block',
   'char',
   'common',
+  'compat',
   'control',
   'crypto',
   'dump',
diff --git a/qemu-options.hx b/qemu-options.hx
index b0f020594e..bb0c6bb70e 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3391,6 +3391,26 @@ DEFHEADING()
 
 DEFHEADING(Debug/Expert options:)
 
+DEF("compat", HAS_ARG, QEMU_OPTION_compat,
+    "-compat [deprecated-input=accept|reject][,deprecated-output=accept|hide]\n"
+    "                Policy for handling deprecated management interfaces\n",
+    QEMU_ARCH_ALL)
+SRST
+``-compat [deprecated-input=@var{input-policy}][,deprecated-output=@var{output-policy}]``
+    Set policy for handling deprecated management interfaces (experimental):
+
+    ``deprecated-input=accept`` (default)
+        Accept deprecated commands and arguments
+    ``deprecated-input=reject``
+        Reject deprecated commands and arguments
+    ``deprecated-output=accept`` (default)
+        Emit deprecated command results and events
+    ``deprecated-output=hide``
+        Suppress deprecated command results and events
+
+    Limitation: covers only syntactic aspects of QMP.
+ERST
+
 DEF("fw_cfg", HAS_ARG, QEMU_OPTION_fwcfg,
     "-fw_cfg [name=]<name>,file=<file>\n"
     "                add named fw_cfg entry with contents from file\n"
-- 
2.26.2


