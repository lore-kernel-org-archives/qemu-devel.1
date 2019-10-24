Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E57CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 13:16:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 704BE2084C
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 13:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h+HkkTW1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 704BE2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNcz3-0004xb-Cr
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 09:16:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47761)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iNcKj-0003wk-Gc
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:35:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iNcKh-0006B6-Hj
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:35:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52863
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iNcKh-0006Af-CE
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:35:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571920514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XQfcleXTWeT7+7TghUYFF7xtI7QrLnKZNmatYtINs+o=;
 b=h+HkkTW1dO01cRKYUSPOButONlVCea20dKj5ANATx3Q3y5BS0FONIUleX0BVu/gNWbw3qD
 Gg1e72i2mZKCEaOcOLVdZ38/yfEXBiNt5IVgHcBMb7gNuEZZ1EvGrDAkXzmz4p0suE6IKh
 ltsGkcd4u1CkIJRpurkyO9xtoqVZMAE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-sJgHF0iVORqmyQHAHpHIoA-1; Thu, 24 Oct 2019 08:35:11 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92840801E5F;
 Thu, 24 Oct 2019 12:35:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4AF245D713;
 Thu, 24 Oct 2019 12:35:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 27E981130341; Thu, 24 Oct 2019 14:34:59 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 14/19] qemu-options: New -compat to set policy for "funny"
 interfaces
Date: Thu, 24 Oct 2019 14:34:53 +0200
Message-Id: <20191024123458.13505-15-armbru@redhat.com>
In-Reply-To: <20191024123458.13505-1-armbru@redhat.com>
References: <20191024123458.13505-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: sJgHF0iVORqmyQHAHpHIoA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: libvir-list@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"Funny" interface policy is separate for input and output.

Input policy can be "accept" (accept silently; default), "reject"
(reject the request with an error), or "crash" (abort() the process).

Output policy can be "accept" (pass on unchanged), or "hide" (filter
out the deprecated parts).

Policies other than "accept" are implemented later in this series.

For now, the "funny" interfaces are just QMP commands and events with
feature "deprecated".  We'll want to extend this to arguments,
returns, and the command line.  Extending it to experimental
interfaces may make sense.

FIXME Documentation and help need some work

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/common.json             | 48 ++++++++++++++++++++++++++++++++++++
 include/qapi/compat-policy.h | 20 +++++++++++++++
 qapi/qmp-dispatch.c          |  3 +++
 vl.c                         | 17 +++++++++++++
 qemu-options.hx              | 18 ++++++++++++++
 5 files changed, 106 insertions(+)
 create mode 100644 include/qapi/compat-policy.h

diff --git a/qapi/common.json b/qapi/common.json
index 7b9cbcd97b..9fc3e6400c 100644
--- a/qapi/common.json
+++ b/qapi/common.json
@@ -144,3 +144,51 @@
 ##
 { 'enum': 'PCIELinkWidth',
   'data': [ '1', '2', '4', '8', '12', '16', '32' ] }
+
+##
+# @CompatPolicyInput:
+#
+# Policy for handling "funny" input.
+#
+# @accept: Accept silently
+# TODO @reject: Reject with an error
+# TODO @crash: abort() the process
+#
+# FIXME Guidance on intended use.
+#
+# Since: 4.2
+##
+{ 'enum': 'CompatPolicyInput',
+  'data': [ 'accept' ] }
+
+##
+# @CompatPolicyOutput:
+#
+# Policy for handling "funny" output.
+#
+# @accept: Pass on unchanged
+# TODO @hide: Filter out
+#
+# FIXME Guidance on intended use.
+#
+# Since: 4.2
+##
+{ 'enum': 'CompatPolicyOutput',
+  'data': [ 'accept' ] }
+
+##
+# @CompatPolicy:
+#
+# Policy for handling "funny" management interfaces.
+#
+# Limitation: covers only QMP commands and events.  Argument support
+# is not yet implemented.  CLI is not yet implemented.
+#
+# @deprecated-input: how to handle deprecated input (default 'accept')
+# @deprecated-output: how to handle deprecated output (default 'accept')
+##
+{ 'struct': 'CompatPolicy',
+  'data': { '*deprecated-input': 'CompatPolicyInput',
+            '*deprecated-output': 'CompatPolicyOutput' } }
+
+# FIXME CompatPolicy & friends don't belong here
diff --git a/include/qapi/compat-policy.h b/include/qapi/compat-policy.h
new file mode 100644
index 0000000000..c491d74aac
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
+#include "qapi/qapi-types-common.h"
+
+extern CompatPolicy qapi_compat_policy;
+
+#endif
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 55bc224c61..8fe59cf54d 100644
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
+CompatPolicy qapi_compat_policy;
+
 static QDict *qmp_dispatch_check_obj(const QObject *request, bool allow_oo=
b,
                                      QObject **id, Error **errp)
 {
diff --git a/vl.c b/vl.c
index 4489cfb2bb..300f2a01de 100644
--- a/vl.c
+++ b/vl.c
@@ -26,6 +26,7 @@
 #include "qemu-common.h"
 #include "qemu/units.h"
 #include "hw/qdev-properties.h"
+#include "qapi/compat-policy.h"
 #include "qapi/error.h"
 #include "qemu-version.h"
 #include "qemu/cutils.h"
@@ -3783,6 +3784,22 @@ int main(int argc, char **argv, char **envp)
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
+                    QAPI_CLONE_MEMBERS(CompatPolicy, &qapi_compat_policy,
+                                       opts);
+
+                    qapi_free_CompatPolicy(opts);
+                    visit_free(v);
+                    break;
+                }
             case QEMU_OPTION_msg:
                 opts =3D qemu_opts_parse_noisily(qemu_find_opts("msg"), op=
targ,
                                                false);
diff --git a/qemu-options.hx b/qemu-options.hx
index 996b6fba74..c43f768a15 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3319,6 +3319,24 @@ STEXI
 @table @option
 ETEXI
=20
+DEF("compat", HAS_ARG, QEMU_OPTION_compat,
+    "-compat [deprecated-input=3Daccept][,deprecated-output=3Daccept]\n"
+    "                Policy for handling deprecated management interfaces\=
n",
+    QEMU_ARCH_ALL)
+STEXI
+@item -compat [deprecated-input=3D@var{input-policy}][,deprecated-output=
=3D@var{output-policy}]
+@findex -compat
+
+Set policy for handling deprecated management interfaces:
+@table @option
+@item deprecated-input=3Daccept (default)
+Accept deprecated commands
+@item deprecated-output=3Daccept (default)
+Emit deprecated events
+@end table
+FIXME Guidance on intended use
+ETEXI
+
 DEF("fw_cfg", HAS_ARG, QEMU_OPTION_fwcfg,
     "-fw_cfg [name=3D]<name>,file=3D<file>\n"
     "                add named fw_cfg entry with contents from file\n"
--=20
2.21.0


