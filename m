Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7195C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 21:56:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE3D420758
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 21:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DxBPdvoq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE3D420758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDakC-0003Nt-UQ
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 17:56:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54200)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kDahp-0007sn-G5
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 17:54:13 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35356
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kDahn-0002aC-Sd
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 17:54:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599083647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dgJoFYMM2RMQrtDwiNxObbgz2MMdgrhssuAOXPQMNMo=;
 b=DxBPdvoq/dUYAAHEeve3f5P4OhDnsmSwSWZsvYxXKQbph741OB5XuGXuFHZTJYiZugsRF0
 DhumWXUqOfPIXe2eQTZhgr0V8ggh/pz4wBMExSylcp4bDl0NcUmVUP0ruPJYdyzY+o5oxp
 Vy/KU6OvaKMXUaadPtPPA+UBa7Ee334=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-0YkFeXWWPDeQ0Ymb5YQcsQ-1; Wed, 02 Sep 2020 17:54:05 -0400
X-MC-Unique: 0YkFeXWWPDeQ0Ymb5YQcsQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C5C761DE02;
 Wed,  2 Sep 2020 21:54:04 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-128.phx2.redhat.com [10.3.113.128])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5CA8076E01;
 Wed,  2 Sep 2020 21:54:04 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 4/6] block: add missing socket_init() calls to tools
Date: Wed,  2 Sep 2020 16:53:58 -0500
Message-Id: <20200902215400.2673028-5-eblake@redhat.com>
In-Reply-To: <20200902215400.2673028-1-eblake@redhat.com>
References: <20200902215400.2673028-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 17:54:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Daniel P. Berrangé <berrange@redhat.com>

Any tool that uses sockets needs to call socket_init() in order to work
on the Windows platform.

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20200825103850.119911-2-berrange@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qemu-img.c | 2 ++
 qemu-io.c  | 2 ++
 qemu-nbd.c | 1 +
 3 files changed, 5 insertions(+)

diff --git a/qemu-img.c b/qemu-img.c
index 5308773811f3..eb2fc1f86243 100644
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
index 3adc5a7d0d3f..7cc832b3d618 100644
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
index d2657b8db50d..b102874f0f46 100644
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
2.28.0


