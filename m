Return-Path: <SRS0=MBD3=C4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F4EC43464
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 16:25:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73C8B207BB
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 16:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yf+IhUSU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73C8B207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJfg1-00034L-IQ
	for qemu-devel@archiver.kernel.org; Sat, 19 Sep 2020 12:25:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51716)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJfHZ-0005gY-Da
 for qemu-devel@nongnu.org; Sat, 19 Sep 2020 12:00:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29524)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJfHM-0007SP-Jm
 for qemu-devel@nongnu.org; Sat, 19 Sep 2020 12:00:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600531195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VPwMOZku7UBRQhHSdhV1lO2uk4iu6y/xIf7/rYHqH0c=;
 b=Yf+IhUSU6ci99EVXlFpoKZ8WrUmPBtNKSMl18vpfP+jtxPnepv7G89AaPNpRLgdt35KsDS
 otFudrswRPWOb8Rs6wrs0QkoWMW7CnX5SYQr5VIYxRcmPKQ3oaXQ1a64pxiqdYwiBoxzNR
 p3UjoxcBnE4LhznGqeWjC0STv8KUonA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-nRK5oXMuMO-1alZS2ANbZQ-1; Sat, 19 Sep 2020 11:59:53 -0400
X-MC-Unique: nRK5oXMuMO-1alZS2ANbZQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E8FD801AAC
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2020 15:59:52 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 437971002388
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2020 15:59:52 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 50/57] qemu-bridge-helper: relocate path to default ACL
Date: Sat, 19 Sep 2020 11:59:09 -0400
Message-Id: <20200919155916.1046398-51-pbonzini@redhat.com>
In-Reply-To: <20200919155916.1046398-1-pbonzini@redhat.com>
References: <20200919155916.1046398-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/19 06:41:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qemu-bridge-helper.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/qemu-bridge-helper.c b/qemu-bridge-helper.c
index 88b26747fc..a26e1663f0 100644
--- a/qemu-bridge-helper.c
+++ b/qemu-bridge-helper.c
@@ -40,6 +40,7 @@
 #endif
 
 #include "qemu/queue.h"
+#include "qemu/cutils.h"
 
 #include "net/tap-linux.h"
 
@@ -245,6 +246,7 @@ int main(int argc, char **argv)
     ACLList acl_list;
     int access_allowed, access_denied;
     int ret = EXIT_SUCCESS;
+    g_autofree char *acl_file = NULL;
 
 #ifdef CONFIG_LIBCAP_NG
     /* if we're run from an suid binary, immediately drop privileges preserving
@@ -257,6 +259,8 @@ int main(int argc, char **argv)
     }
 #endif
 
+    qemu_init_exec_dir(argv[0]);
+
     /* parse arguments */
     for (index = 1; index < argc; index++) {
         if (strcmp(argv[index], "--use-vnet") == 0) {
@@ -282,9 +286,10 @@ int main(int argc, char **argv)
 
     /* parse default acl file */
     QSIMPLEQ_INIT(&acl_list);
-    if (parse_acl_file(DEFAULT_ACL_FILE, &acl_list) == -1) {
+    acl_file = get_relocated_path(DEFAULT_ACL_FILE);
+    if (parse_acl_file(acl_file, &acl_list) == -1) {
         fprintf(stderr, "failed to parse default acl file `%s'\n",
-                DEFAULT_ACL_FILE);
+                acl_file);
         ret = EXIT_FAILURE;
         goto cleanup;
     }
-- 
2.26.2



