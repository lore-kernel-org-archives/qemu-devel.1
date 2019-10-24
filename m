Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D964CA9EBC
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 13:33:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CE0A21906
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 13:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="atCgNN3R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CE0A21906
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNdEw-00050Z-RZ
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 09:33:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47741)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iNcKi-0003v9-U7
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:35:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iNcKh-0006BD-K3
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:35:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37315
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iNcKh-0006Ai-Eq
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:35:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571920514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w68YnewbiPS7fEui1YXuGwai5ALcO+GSjwBTz6xGpog=;
 b=atCgNN3R6+PgzHwhO5l+tkywNUCbFnsd/HfhwVD5CYKhbbCbyHwSSkb7bJOzQs0dGXXn5v
 hy/nAn9oc33n4v2JkjvgvTT3BlLuFPm8jOsGerm/teh+trjg5Xnh1hZpLfpRvtSTa2p3cu
 sqjSVoeD4kRra/aDeQTpPbkAJbFpJHs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-YQRnQqtCMby0P_1f6FrmPg-1; Thu, 24 Oct 2019 08:35:10 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB671107AD33;
 Thu, 24 Oct 2019 12:35:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 944645D9CA;
 Thu, 24 Oct 2019 12:35:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 317951130348; Thu, 24 Oct 2019 14:34:59 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 17/19] qapi: Implement -compat deprecated-input=crash for
 commands
Date: Thu, 24 Oct 2019 14:34:56 +0200
Message-Id: <20191024123458.13505-18-armbru@redhat.com>
In-Reply-To: <20191024123458.13505-1-armbru@redhat.com>
References: <20191024123458.13505-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: YQRnQqtCMby0P_1f6FrmPg-1
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

This policy calls abort() when a deprecated command is received.

Crashing should reliably[*] fail existing integration tests with very
little additional work (just pass the option).

[*] Bugs in tests can conceivably mask even crashes, but that seems
unlikely.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/common.json    | 4 ++--
 qapi/qmp-dispatch.c | 1 +
 qemu-options.hx     | 4 +++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/qapi/common.json b/qapi/common.json
index 3e9d12c90f..06e54642bb 100644
--- a/qapi/common.json
+++ b/qapi/common.json
@@ -152,14 +152,14 @@
 #
 # @accept: Accept silently
 # @reject: Reject with an error
-# TODO @crash: abort() the process
+# @crash: abort() the process
 #
 # FIXME Guidance on intended use.
 #
 # Since: 4.2
 ##
 { 'enum': 'CompatPolicyInput',
-  'data': [ 'accept', 'reject' ] }
+  'data': [ 'accept', 'reject', 'crash' ] }
=20
 ##
 # @CompatPolicyOutput:
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index b079db85d2..6436417844 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -141,6 +141,7 @@ QDict *qmp_dispatch(QmpCommandList *cmds, QObject *requ=
est,
                       "Deprecated command %s disabled by policy",
                       command);
             goto out;
+        case COMPAT_POLICY_INPUT_CRASH:
         default:
             abort();
         }
diff --git a/qemu-options.hx b/qemu-options.hx
index f107a57c81..3a740ea7b1 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3320,7 +3320,7 @@ STEXI
 ETEXI
=20
 DEF("compat", HAS_ARG, QEMU_OPTION_compat,
-    "-compat [deprecated-input=3Daccept|reject][,deprecated-output=3Daccep=
t]\n"
+    "-compat [deprecated-input=3Daccept|reject|crash][,deprecated-output=
=3Daccept]\n"
     "                Policy for handling deprecated management interfaces\=
n",
     QEMU_ARCH_ALL)
 STEXI
@@ -3333,6 +3333,8 @@ Set policy for handling deprecated management interfa=
ces:
 Accept deprecated commands
 @item deprecated-input=3Dreject
 Reject deprecated commands
+@item deprecated-input=3Dcrash
+Crash on deprecated command
 @item deprecated-output=3Daccept (default)
 Emit deprecated events
 @end table
--=20
2.21.0


