Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1576DC3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 16:42:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3E9820838
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 16:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="axvnGX+4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3E9820838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9AcV-00015y-0P
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 11:42:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56875)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j9AVs-0004JF-IE
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 11:35:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j9AVr-000313-1c
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 11:35:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46859
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j9AVq-00030m-TX
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 11:35:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583253318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jlo30X4GLrqRRWhmO6ugS7pBjmrmoB9UDccQD7F+uNk=;
 b=axvnGX+4rMh3N2ewFLso6adhUs20u+jnI7e8m77x3EwFhmJ1ZPcrUXVoZUBlr3iDBEi5+i
 o5DelCTw9j7Ti99kl7BFSrQEux28TUNUzqzT5roNgFh6M83HweAy9uY/GDuEqbenUC5qQm
 zELYf3cP3qCVmEb3UPWXPeBPX+ceZhQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-bibwdYNwOHm8gQG9b_sQ5Q-1; Tue, 03 Mar 2020 11:35:17 -0500
X-MC-Unique: bibwdYNwOHm8gQG9b_sQ5Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C40718CA240;
 Tue,  3 Mar 2020 16:35:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-129.ams2.redhat.com
 [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A3D7B5DA2C;
 Tue,  3 Mar 2020 16:35:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 16126113278C; Tue,  3 Mar 2020 17:35:06 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 27/30] qemu-options: New -compat to set policy for
 deprecated interfaces
Date: Tue,  3 Mar 2020 17:35:02 +0100
Message-Id: <20200303163505.32041-28-armbru@redhat.com>
In-Reply-To: <20200303163505.32041-1-armbru@redhat.com>
References: <20200303163505.32041-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: libvir-list@redhat.com, berrange@redhat.com, mdroth@linux.vnet.ibm.com
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
 qapi/Makefile.objs           |  8 +++---
 qemu-options.hx              | 21 +++++++++++++++
 7 files changed, 117 insertions(+), 4 deletions(-)
 create mode 100644 qapi/compat.json
 create mode 100644 include/qapi/compat-policy.h

diff --git a/qapi/compat.json b/qapi/compat.json
new file mode 100644
index 0000000000..fd6f8e932c
--- /dev/null
+++ b/qapi/compat.json
@@ -0,0 +1,51 @@
+# -*- Mode: Python -*-
+
+##
+# =3D Compatibility policy
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
+# Since: 5.0
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
+# Since: 5.0
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
+# Since: 5.0
+##
+{ 'struct': 'CompatPolicy',
+  'data': { '*deprecated-input': 'CompatPolicyInput',
+            '*deprecated-output': 'CompatPolicyOutput' } }
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index fe980ce437..fa800042e0 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -98,6 +98,7 @@
 { 'include': 'migration.json' }
 { 'include': 'transaction.json' }
 { 'include': 'trace.json' }
+{ 'include': 'compat.json' }
 { 'include': 'control.json' }
 { 'include': 'introspect.json' }
 { 'include': 'qom.json' }
diff --git a/include/qapi/compat-policy.h b/include/qapi/compat-policy.h
new file mode 100644
index 0000000000..8efb2c58aa
--- /dev/null
+++ b/include/qapi/compat-policy.h
@@ -0,0 +1,20 @@
+/*
+ * Policy for handling "funny" management interfaces
+ *
+ * Copyright (C) 2019 Red Hat, Inc.
+ *
+ * Authors:
+ *  Markus Armbruster <armbru@redhat.com>,
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
index fb53687ce9..80beab517f 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -12,6 +12,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qapi/compat-policy.h"
 #include "qapi/error.h"
 #include "qapi/qmp/dispatch.h"
 #include "qapi/qmp/qdict.h"
@@ -19,6 +20,8 @@
 #include "sysemu/runstate.h"
 #include "qapi/qmp/qbool.h"
=20
+CompatPolicy compat_policy;
+
 static QDict *qmp_dispatch_check_obj(const QObject *request, bool allow_oo=
b,
                                      QObject **id, Error **errp)
 {
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 5549f4b619..0d6b769587 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -26,6 +26,7 @@
 #include "qemu-common.h"
 #include "qemu/units.h"
 #include "hw/qdev-properties.h"
+#include "qapi/compat-policy.h"
 #include "qapi/error.h"
 #include "qemu-version.h"
 #include "qemu/cutils.h"
@@ -104,6 +105,7 @@
 #include "sysemu/replay.h"
 #include "qapi/qapi-events-run-state.h"
 #include "qapi/qapi-visit-block-core.h"
+#include "qapi/qapi-visit-compat.h"
 #include "qapi/qapi-visit-ui.h"
 #include "qapi/qapi-commands-block-core.h"
 #include "qapi/qapi-commands-run-state.h"
@@ -3748,6 +3750,21 @@ void qemu_init(int argc, char **argv, char **envp)
                     qemu_opt_get_bool(opts, "mem-lock", false);
                 enable_cpu_pm =3D qemu_opt_get_bool(opts, "cpu-pm", false)=
;
                 break;
+            case QEMU_OPTION_compat:
+                {
+                    CompatPolicy *opts;
+                    Visitor *v;
+
+                    v =3D qobject_input_visitor_new_str(optarg, NULL,
+                                                      &error_fatal);
+
+                    visit_type_CompatPolicy(v, NULL, &opts, &error_fatal);
+                    QAPI_CLONE_MEMBERS(CompatPolicy, &compat_policy, opts)=
;
+
+                    qapi_free_CompatPolicy(opts);
+                    visit_free(v);
+                    break;
+                }
             case QEMU_OPTION_msg:
                 opts =3D qemu_opts_parse_noisily(qemu_find_opts("msg"), op=
targ,
                                                false);
diff --git a/qapi/Makefile.objs b/qapi/Makefile.objs
index 20fcc37c2c..6c71e5c701 100644
--- a/qapi/Makefile.objs
+++ b/qapi/Makefile.objs
@@ -5,10 +5,10 @@ util-obj-y +=3D opts-visitor.o qapi-clone-visitor.o
 util-obj-y +=3D qmp-event.o
 util-obj-y +=3D qapi-util.o
=20
-QAPI_COMMON_MODULES =3D audio authz block-core block char common control c=
rypto
-QAPI_COMMON_MODULES +=3D dump error introspect job machine migration misc
-QAPI_COMMON_MODULES +=3D net qdev qom rdma rocker run-state sockets tpm
-QAPI_COMMON_MODULES +=3D trace transaction ui
+QAPI_COMMON_MODULES =3D audio authz block-core block char common compat
+QAPI_COMMON_MODULES +=3D control crypto dump error introspect job
+QAPI_COMMON_MODULES +=3D machine migration misc net qdev qom rdma rocker
+QAPI_COMMON_MODULES +=3D run-state sockets tpm trace transaction ui
 QAPI_TARGET_MODULES =3D machine-target misc-target
 QAPI_MODULES =3D $(QAPI_COMMON_MODULES) $(QAPI_TARGET_MODULES)
=20
diff --git a/qemu-options.hx b/qemu-options.hx
index 084a1c1f8c..d02d6bfc15 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3360,6 +3360,27 @@ STEXI
 @table @option
 ETEXI
=20
+DEF("compat", HAS_ARG, QEMU_OPTION_compat,
+    "-compat [deprecated-input=3Daccept|reject][,deprecated-output=3Daccep=
t|hide]\n"
+    "                Policy for handling deprecated management interfaces\=
n",
+    QEMU_ARCH_ALL)
+STEXI
+@item -compat [deprecated-input=3D@var{input-policy}][,deprecated-output=
=3D@var{output-policy}]
+@findex -compat
+Set policy for handling deprecated management interfaces (experimental):
+@table @option
+@item deprecated-input=3Daccept (default)
+Accept deprecated commands and arguments
+@item deprecated-input=3Dreject
+Reject deprecated commands and arguments
+@item deprecated-output=3Daccept (default)
+Emit deprecated command results and events
+@item deprecated-output=3Dhide
+Suppress deprecated command results and events
+@end table
+Limitation: covers only syntactic aspects of QMP.
+ETEXI
+
 DEF("fw_cfg", HAS_ARG, QEMU_OPTION_fwcfg,
     "-fw_cfg [name=3D]<name>,file=3D<file>\n"
     "                add named fw_cfg entry with contents from file\n"
--=20
2.21.1


