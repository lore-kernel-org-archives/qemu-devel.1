Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA743C433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 17:03:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A405206F0
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 17:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h17+7r66"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A405206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAFsM-0008IF-RQ
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 13:03:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36104)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kAFrZ-0007Pe-IA
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 13:02:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57963
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kAFrX-0003Lu-9Y
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 13:02:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598288546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1+/IkwGNPcgmpVMqqB9rombZb0jmGPK8fNZSA1FEHUk=;
 b=h17+7r66Y0GkGcKcq5FHs3wwpbSkHNdUv6t7DHX264FjFDOI9obhxbFlggyswAjb2tXR9p
 z0LRxY+PsdgR5FzCwtKsfgd9dGJxNG3AEWeUtos3rh9ge0Le0wCuN5OK2BxujhH+2sjTN5
 FcQuwpAQ1Ya8XtRH5eMsbeRKe9pe4ws=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-44M6DdDNPlqxdEfGfhwVSw-1; Mon, 24 Aug 2020 13:02:24 -0400
X-MC-Unique: 44M6DdDNPlqxdEfGfhwVSw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 63CAA801ADE;
 Mon, 24 Aug 2020 17:02:23 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-114-223.ams2.redhat.com
 [10.36.114.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D1D405C1BB;
 Mon, 24 Aug 2020 17:02:21 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] block: add missing socket_init() calls to tools
Date: Mon, 24 Aug 2020 18:02:17 +0100
Message-Id: <20200824170218.106255-2-berrange@redhat.com>
In-Reply-To: <20200824170218.106255-1-berrange@redhat.com>
References: <20200824170218.106255-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 06:40:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Any tool that uses sockets needs to call socket_init() in order to work
on the Windows platform.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qemu-img.c | 2 ++
 qemu-io.c  | 2 ++
 qemu-nbd.c | 1 +
 3 files changed, 5 insertions(+)

diff --git a/qemu-img.c b/qemu-img.c
index 5308773811..eb2fc1f862 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -41,6 +41,7 @@
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
+#include "qemu/sockets.h"
 #include "qemu/units.h"
 #include "qom/object_interfaces.h"
 #include "sysemu/block-backend.h"
@@ -5410,6 +5411,7 @@ int main(int argc, char **argv)
     signal(SIGPIPE, SIG_IGN);
 #endif
 
+    socket_init();
     error_init(argv[0]);
     module_call_init(MODULE_INIT_TRACE);
     qemu_init_exec_dir(argv[0]);
diff --git a/qemu-io.c b/qemu-io.c
index 3adc5a7d0d..7cc832b3d6 100644
--- a/qemu-io.c
+++ b/qemu-io.c
@@ -25,6 +25,7 @@
 #include "qemu/config-file.h"
 #include "qemu/readline.h"
 #include "qemu/log.h"
+#include "qemu/sockets.h"
 #include "qapi/qmp/qstring.h"
 #include "qapi/qmp/qdict.h"
 #include "qom/object_interfaces.h"
@@ -542,6 +543,7 @@ int main(int argc, char **argv)
     signal(SIGPIPE, SIG_IGN);
 #endif
 
+    socket_init();
     error_init(argv[0]);
     module_call_init(MODULE_INIT_TRACE);
     qemu_init_exec_dir(argv[0]);
diff --git a/qemu-nbd.c b/qemu-nbd.c
index d2657b8db5..b102874f0f 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -599,6 +599,7 @@ int main(int argc, char **argv)
     signal(SIGPIPE, SIG_IGN);
 #endif
 
+    socket_init();
     error_init(argv[0]);
     module_call_init(MODULE_INIT_TRACE);
     qcrypto_init(&error_fatal);
-- 
2.26.2


