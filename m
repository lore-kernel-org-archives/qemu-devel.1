Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE0CC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 08:50:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B98AE20756
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 08:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fu6UTCO5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B98AE20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHkCK-0002ol-Km
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 04:50:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41384)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kHk9l-0006bi-Dg
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 04:48:14 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44246
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kHk9i-0005DM-9u
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 04:48:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600073289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cdSUC5X8U3KAbhNvN5WsmG7xAmx3jtCQw9EdybdTm6k=;
 b=fu6UTCO5o1H8jpedman8tYT/u1U4ib3st2pO5BQ3ooagoADCNt7ofVgm7yxFA0XSX0hlQH
 PpVoiSx7u04Z0J9j5hO+uJ6KeSkffPXqXzAyWMJPhqplm6/OAye3v2Hp8Egd0EsBPR1v40
 sAW+bydG3KXrP/sqTUrXvyNoy4/Ryec=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-qr07o48NMOyL7NpW__Ooaw-1; Mon, 14 Sep 2020 04:48:07 -0400
X-MC-Unique: qr07o48NMOyL7NpW__Ooaw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E106618BA281;
 Mon, 14 Sep 2020 08:48:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B1DDC7E43C;
 Mon, 14 Sep 2020 08:48:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8EB4011420C2; Mon, 14 Sep 2020 10:48:02 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 8/8] qapi: New -compat deprecated-input=crash
Date: Mon, 14 Sep 2020 10:48:02 +0200
Message-Id: <20200914084802.4185028-9-armbru@redhat.com>
In-Reply-To: <20200914084802.4185028-1-armbru@redhat.com>
References: <20200914084802.4185028-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 00:11:19
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

Policy "crash" calls abort() when deprecated input is received.

Bugs in integration tests may mask the error from policy "reject".
Provide a larger hammer: crash outright.  Masking that seems unlikely.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/compat.json             | 3 ++-
 qapi/qmp-dispatch.c          | 1 +
 qapi/qobject-input-visitor.c | 1 +
 qemu-options.hx              | 4 +++-
 4 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/qapi/compat.json b/qapi/compat.json
index d2c02a21aa..936602dcc6 100644
--- a/qapi/compat.json
+++ b/qapi/compat.json
@@ -11,11 +11,12 @@
 #
 # @accept: Accept silently
 # @reject: Reject with an error
+# @crash: abort() the process
 #
 # Since: 5.2
 ##
 { 'enum': 'CompatPolicyInput',
-  'data': [ 'accept', 'reject' ] }
+  'data': [ 'accept', 'reject', 'crash' ] }
 
 ##
 # @CompatPolicyOutput:
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 634e9c0a7d..9954894d95 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -139,6 +139,7 @@ QDict *qmp_dispatch(const QmpCommandList *cmds, QObject *request,
                       "Deprecated command %s disabled by policy",
                       command);
             goto out;
+        case COMPAT_POLICY_INPUT_CRASH:
         default:
             abort();
         }
diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
index 91e2d84ad2..d21ba0db8e 100644
--- a/qapi/qobject-input-visitor.c
+++ b/qapi/qobject-input-visitor.c
@@ -680,6 +680,7 @@ static bool qobject_input_deprecated_accept(Visitor *v, const char *name,
         error_setg(errp, "Deprecated parameter '%s' disabled by policy",
                    name);
         return false;
+    case COMPAT_POLICY_INPUT_CRASH:
     default:
         abort();
     }
diff --git a/qemu-options.hx b/qemu-options.hx
index bb0c6bb70e..f36d2073e5 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3392,7 +3392,7 @@ DEFHEADING()
 DEFHEADING(Debug/Expert options:)
 
 DEF("compat", HAS_ARG, QEMU_OPTION_compat,
-    "-compat [deprecated-input=accept|reject][,deprecated-output=accept|hide]\n"
+    "-compat [deprecated-input=accept|reject|crash][,deprecated-output=accept|hide]\n"
     "                Policy for handling deprecated management interfaces\n",
     QEMU_ARCH_ALL)
 SRST
@@ -3403,6 +3403,8 @@ SRST
         Accept deprecated commands and arguments
     ``deprecated-input=reject``
         Reject deprecated commands and arguments
+    ``deprecated-input=crash``
+        Crash on deprecated command
     ``deprecated-output=accept`` (default)
         Emit deprecated command results and events
     ``deprecated-output=hide``
-- 
2.26.2


