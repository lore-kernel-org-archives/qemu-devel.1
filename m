Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20879C3F2D1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 16:42:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E56C520838
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 16:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HYpt6b1E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E56C520838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9Ad5-0002Fz-4Z
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 11:42:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56926)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j9AVu-0004LH-6E
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 11:35:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j9AVs-00032Q-RL
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 11:35:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39853
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j9AVs-000322-Lw
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 11:35:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583253320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lv+Y3uORPyKTvnxkqiYkWuE9C0PyzcV1+KlOv2igoQI=;
 b=HYpt6b1EXadBYdnev/O5LVYkANgDA+Rf7mlNz5EE8HtuHfMeiAHT5ZcHGCPsc0+XMIPb5Z
 PZC0SbKBzdKEKr1Vp26Z3CSZd2yVi9ZS3UclRTaNzliD6jGBopHdnGw9FrFXQm0jgiInkw
 aUJghnNt3B+8kPg4+YvyiV9uZSS3b6s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-B7V98d0cNGiM_2T2Om8Nyg-1; Tue, 03 Mar 2020 11:35:18 -0500
X-MC-Unique: B7V98d0cNGiM_2T2Om8Nyg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8B96801F7D;
 Tue,  3 Mar 2020 16:35:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-129.ams2.redhat.com
 [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B99B710027B1;
 Tue,  3 Mar 2020 16:35:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 201361130356; Tue,  3 Mar 2020 17:35:06 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 30/30] qapi: New -compat deprecated-input=crash
Date: Tue,  3 Mar 2020 17:35:05 +0100
Message-Id: <20200303163505.32041-31-armbru@redhat.com>
In-Reply-To: <20200303163505.32041-1-armbru@redhat.com>
References: <20200303163505.32041-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: libvir-list@redhat.com, berrange@redhat.com, mdroth@linux.vnet.ibm.com
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
index fd6f8e932c..ec24567639 100644
--- a/qapi/compat.json
+++ b/qapi/compat.json
@@ -11,11 +11,12 @@
 #
 # @accept: Accept silently
 # @reject: Reject with an error
+# @crash: abort() the process
 #
 # Since: 5.0
 ##
 { 'enum': 'CompatPolicyInput',
-  'data': [ 'accept', 'reject' ] }
+  'data': [ 'accept', 'reject', 'crash' ] }
=20
 ##
 # @CompatPolicyOutput:
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 516ee9b0b7..2c8fac02cd 100644
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
diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
index 6ea93f5a7a..a74c901be9 100644
--- a/qapi/qobject-input-visitor.c
+++ b/qapi/qobject-input-visitor.c
@@ -654,6 +654,7 @@ static bool qobject_input_deprecated(Visitor *v, const =
char *name,
         error_setg(errp, "Deprecated parameter '%s' disabled by policy",
                    name);
         return false;
+    case COMPAT_POLICY_INPUT_CRASH:
     default:
         abort();
     }
diff --git a/qemu-options.hx b/qemu-options.hx
index d02d6bfc15..7e49f778f4 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3361,7 +3361,7 @@ STEXI
 ETEXI
=20
 DEF("compat", HAS_ARG, QEMU_OPTION_compat,
-    "-compat [deprecated-input=3Daccept|reject][,deprecated-output=3Daccep=
t|hide]\n"
+    "-compat [deprecated-input=3Daccept|reject|crash][,deprecated-output=
=3Daccept|hide]\n"
     "                Policy for handling deprecated management interfaces\=
n",
     QEMU_ARCH_ALL)
 STEXI
@@ -3373,6 +3373,8 @@ Set policy for handling deprecated management interfa=
ces (experimental):
 Accept deprecated commands and arguments
 @item deprecated-input=3Dreject
 Reject deprecated commands and arguments
+@item deprecated-input=3Dcrash
+Crash on deprecated command
 @item deprecated-output=3Daccept (default)
 Emit deprecated command results and events
 @item deprecated-output=3Dhide
--=20
2.21.1


