Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7542EC433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 16:43:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 426CA20724
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 16:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vw49s+CT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 426CA20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrlG0-00052p-F7
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 12:43:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52588)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrlCl-000071-V1
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 12:39:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20779
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrlCj-0005SH-Dw
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 12:39:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593880792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uLixvpNJpQxN4tT2DsMy+7dKl6K2fJXcgmydaNhaJeY=;
 b=Vw49s+CTVDI3CEzu23pnI3UL/ak1nQHSRRbi850xyLy4FMC5Tip3pYfEGQzSK43Odrq48Y
 CD6hiRx9k9Zp/xUH21r6FChxUc07XAUeANL4RJgDe4I+Du47niDLvm6BkVkYAKO4eRzhv6
 tZ3Pp/ld2HXrqhVmMJbr9ECkU2IagQY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-E_rAndy4MjSdeuhPIX60Zw-1; Sat, 04 Jul 2020 12:39:50 -0400
X-MC-Unique: E_rAndy4MjSdeuhPIX60Zw-1
Received: by mail-wr1-f72.google.com with SMTP id j3so16494708wrq.9
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 09:39:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uLixvpNJpQxN4tT2DsMy+7dKl6K2fJXcgmydaNhaJeY=;
 b=ZPabgXfiYlPZmNOKRqaRrVLEr75dTt2JATGCpx3FL/1/CFb8aIo7x7JEYZPqQVLKXq
 LR4dy1eoME7euwobFeU+tmZ6ueguBXOorp6KfUjeph4Fapmt9YwYoUukK6Ei505UAg//
 BxQCOHjQcVUo9w9Ho5E6rGOUKrjNMRrMXDtH07lW1WQvC0hTD0Q3Cz6/ANCrhwWEqOx+
 N1JrsVEDmFwO6qWEE1feWCBji0eIiGX0MfU7ba7wanCCy/ifk3MiwnT7ZI2AGwimzRGr
 KFyGXHC61KXpnobWOG8RF00DlBZNK7bc77YV0oNPZSUqwXTB4ncuZwtwossArIYp1hjz
 ak+w==
X-Gm-Message-State: AOAM532o+vMZVsGl1IMIl2du+wuASmy/XfKwlxYg9uXZ5VswdQ+sKzOJ
 IINrxV6aORsyjdgho5l5Ttg5fruXA5lVCWCC45NLFshe+XP706dzRdVAZyt4ja1xjeAEjHJYrbF
 YvLJ2wLlhkkKUXzA=
X-Received: by 2002:adf:8168:: with SMTP id 95mr42230307wrm.104.1593880789192; 
 Sat, 04 Jul 2020 09:39:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy/OkON3+vkcSs96FPZYD4K5p222dIH+82xd59DrfBq/WyafmFq0U4r/bOf4qSqal6vtDjLlg==
X-Received: by 2002:adf:8168:: with SMTP id 95mr42230298wrm.104.1593880789034; 
 Sat, 04 Jul 2020 09:39:49 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id l8sm17362051wrq.15.2020.07.04.09.39.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 09:39:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 4/5] softmmu/vl: Allow -fw_cfg 'gen_id' option to use the
 'etc/' namespace
Date: Sat,  4 Jul 2020 18:39:26 +0200
Message-Id: <20200704163927.28188-5-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200704163927.28188-1-philmd@redhat.com>
References: <20200704163927.28188-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 11:39:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Names of user-provided fw_cfg items are supposed to start
with "opt/". However FW_CFG_DATA_GENERATOR items are generated
by QEMU, so allow the "etc/" namespace in this specific case.

Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20200623172726.21040-5-philmd@redhat.com>
---
 docs/specs/fw_cfg.txt | 4 ++++
 softmmu/vl.c          | 8 +++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/docs/specs/fw_cfg.txt b/docs/specs/fw_cfg.txt
index bc16daa38a..3e6d586f66 100644
--- a/docs/specs/fw_cfg.txt
+++ b/docs/specs/fw_cfg.txt
@@ -258,4 +258,8 @@ Prefix "opt/org.qemu/" is reserved for QEMU itself.
 Use of names not beginning with "opt/" is potentially dangerous and
 entirely unsupported.  QEMU will warn if you try.
 
+Use of names not beginning with "opt/" is tolerated with 'gen_id' (that
+is, the warning is suppressed), but you must know exactly what you're
+doing.
+
 All externally provided fw_cfg items are read-only to the guest.
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 13cada39d6..159f0352a9 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -2049,7 +2049,13 @@ static int parse_fw_cfg(void *opaque, QemuOpts *opts, Error **errp)
                    FW_CFG_MAX_FILE_PATH - 1);
         return -1;
     }
-    if (strncmp(name, "opt/", 4) != 0) {
+    if (nonempty_str(gen_id)) {
+        /*
+         * In this particular case where the content is populated
+         * internally, the "etc/" namespace protection is relaxed,
+         * so do not emit a warning.
+         */
+    } else if (strncmp(name, "opt/", 4) != 0) {
         warn_report("externally provided fw_cfg item names "
                     "should be prefixed with \"opt/\"");
     }
-- 
2.21.3


