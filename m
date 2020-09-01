Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13621C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 06:25:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE26D20FC3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 06:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BDeqmTl+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE26D20FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCzjp-00006Q-13
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 02:25:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44406)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kCzei-00067X-Dv
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 02:20:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42909
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kCzee-0000nP-K4
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 02:20:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598941227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VPwMOZku7UBRQhHSdhV1lO2uk4iu6y/xIf7/rYHqH0c=;
 b=BDeqmTl+jRjjYJOAfaoRmWaeG61R1C41FhQdEoQWDdNip6+JOfFhybzHJ12Ohgl6I+ONGv
 3nl3Z71FEcKeuIv427nrrc1u7+55wEf8OFnsnnwz63kSbj6gl7n7eM3SlvQKDUWfqqr/PJ
 MkGNwiZkHU2aeAm4AafEdNd1RXnfsXY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-CzBJ730JOJ-lbBQ9LgPPBA-1; Tue, 01 Sep 2020 02:20:26 -0400
X-MC-Unique: CzBJ730JOJ-lbBQ9LgPPBA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 545FF10066FC;
 Tue,  1 Sep 2020 06:20:25 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1143178B26;
 Tue,  1 Sep 2020 06:20:25 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/13] qemu-bridge-helper: relocate path to default ACL
Date: Tue,  1 Sep 2020 02:20:17 -0400
Message-Id: <20200901062020.26660-11-pbonzini@redhat.com>
In-Reply-To: <20200901062020.26660-1-pbonzini@redhat.com>
References: <20200901062020.26660-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 22:05:54
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
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



