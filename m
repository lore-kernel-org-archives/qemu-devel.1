Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A36C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 09:48:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EE442396E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 09:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G0bibakU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EE442396E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLNr6-0000cc-7b
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 05:48:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNTr-0001GS-TM
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:23:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24317)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNTn-00066E-To
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:23:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600939435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pq35pprjY9O0C9/iJtey6JbSoVcKHmRAr2UADQ5C67Q=;
 b=G0bibakUsISx+PnQxNM6lM3fk7NvNIOEsHUGlOmGdrVu6vt5OQlPjAye8xLsuX/li/9UjP
 0PwGCTJsnLBrcKF+RKEfSmScgp5hjnRl2qrWeJWrcwho29PUKXkXAAatNkY6UlkGdzzRDV
 zgSwy75FWtCf08a1JU3ysNbRMM2o+4U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-vK5cOywWMiO47aX_orQL8Q-1; Thu, 24 Sep 2020 05:23:53 -0400
X-MC-Unique: vK5cOywWMiO47aX_orQL8Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E58A800475
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 09:23:52 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5B00860E1C
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 09:23:52 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 49/92] qga: relocate path to default configuration and hook
Date: Thu, 24 Sep 2020 05:22:31 -0400
Message-Id: <20200924092314.1722645-50-pbonzini@redhat.com>
In-Reply-To: <20200924092314.1722645-1-pbonzini@redhat.com>
References: <20200924092314.1722645-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
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
 qga/main.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/qga/main.c b/qga/main.c
index 3febf3b0fd..740f5f7303 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -29,6 +29,7 @@
 #include "qapi/error.h"
 #include "channel.h"
 #include "qemu/bswap.h"
+#include "qemu/cutils.h"
 #include "qemu/help_option.h"
 #include "qemu/sockets.h"
 #include "qemu/systemd.h"
@@ -968,7 +969,7 @@ static void config_load(GAConfig *config)
 {
     GError *gerr = NULL;
     GKeyFile *keyfile;
-    const char *conf = g_getenv("QGA_CONF") ?: QGA_CONF_DEFAULT;
+    g_autofree char *conf = g_strdup(g_getenv("QGA_CONF")) ?: get_relocated_path(QGA_CONF_DEFAULT);
 
     /* read system config */
     keyfile = g_key_file_new();
@@ -1027,7 +1028,7 @@ end:
     if (gerr &&
         !(gerr->domain == G_FILE_ERROR && gerr->code == G_FILE_ERROR_NOENT)) {
         g_critical("error loading configuration from path: %s, %s",
-                   QGA_CONF_DEFAULT, gerr->message);
+                   conf, gerr->message);
         exit(EXIT_FAILURE);
     }
     g_clear_error(&gerr);
@@ -1141,7 +1142,7 @@ static void config_parse(GAConfig *config, int argc, char **argv)
 #ifdef CONFIG_FSFREEZE
         case 'F':
             g_free(config->fsfreeze_hook);
-            config->fsfreeze_hook = g_strdup(optarg ?: QGA_FSFREEZE_HOOK_DEFAULT);
+            config->fsfreeze_hook = optarg ? g_strdup(optarg) : get_relocated_path(QGA_FSFREEZE_HOOK_DEFAULT);
             break;
 #endif
         case 't':
@@ -1463,6 +1464,7 @@ int main(int argc, char **argv)
 
     config->log_level = G_LOG_LEVEL_ERROR | G_LOG_LEVEL_CRITICAL;
 
+    qemu_init_exec_dir(argv[0]);
     qga_qmp_init_marshal(&ga_commands);
 
     init_dfl_pathnames();
-- 
2.26.2



