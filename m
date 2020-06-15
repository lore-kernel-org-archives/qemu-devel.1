Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC83C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 10:39:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A54D620663
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 10:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FBGJf6xF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A54D620663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkmWD-000572-PE
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 06:39:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jkmSg-0007GV-EH
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 06:35:30 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46985
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jkmSe-0007GK-MB
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 06:35:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592217328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yJ6lyDkcyYfNS0QPy5NgFjcVg41SXOpnPaTrA8KdGAA=;
 b=FBGJf6xFFEKS0QxCclPaWAP62apONFrO6eeg1gR/HRKtpnl1/LJ0tysWmPXbPPvINY+Cdu
 XTuW80UBZzLsriW+x3K8O0hmEe/kU114ay37UL7O0rRycKY1+D/UULFAb46uLFNGOumvQp
 o/OpzuZQM4L0QLHWkbF4L09Mm8BksWU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-CmPcL8N0PJ6Mc-i7PlJ4QQ-1; Mon, 15 Jun 2020 06:35:26 -0400
X-MC-Unique: CmPcL8N0PJ6Mc-i7PlJ4QQ-1
Received: by mail-wr1-f71.google.com with SMTP id p9so6896707wrx.10
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 03:35:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yJ6lyDkcyYfNS0QPy5NgFjcVg41SXOpnPaTrA8KdGAA=;
 b=HQL2rdZj73W5p3R9gyr4DgPNf12SjEVtYqO7W8saF+lRLqzyqny/U8sh3Io4zkqRqV
 AqFRBGaeUsETUaBjuxmaQvZM4PtkuQu6oHZLM5tBW3Z9DH+V1KRasbHk2oH+xNjy+7Qv
 ZT34yz9VeUlzwVZn08lf3fxMzgb5jNKfiZ8SJpK2roDJhcZOb0vnNUYUp/R+xCWyKKmf
 1pqChgCjEACVO9yLDQ8+A5kvj21dl1HGii3qPno7Pd0IVdBAPbLY4Nd6ZFv0UZ5ioa3T
 IAZJw/FMWYN8aW/GCuprVl3UxAlpPb1FTjZjbs7IfM6Lv05U5SF+cGcLwjywENKiaRJu
 gysg==
X-Gm-Message-State: AOAM533C/8trlywmhomfz0aHbL8LrWo7WSOAl68P4idX0p4DOwBXaqds
 2T91rsADIsTwGLQkTonnCOnlUfpKC10j/JA0H0I3E7VfbOkaU41gVBEyLI1+v6GDj4LLGiaVTaj
 UoBvhNKB1LBi+kJk=
X-Received: by 2002:adf:a491:: with SMTP id g17mr29888540wrb.132.1592217325286; 
 Mon, 15 Jun 2020 03:35:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwPZ4Y9sEYVgkhNqMK10WxQvgjeT6Nvd9wxrH3xE6inGC3N30tI/IO/ui8wrAFRxrQBa7wgtg==
X-Received: by 2002:adf:a491:: with SMTP id g17mr29888527wrb.132.1592217325065; 
 Mon, 15 Jun 2020 03:35:25 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id p7sm24223705wro.26.2020.06.15.03.35.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2020 03:35:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v9 3/5] softmmu/vl: Allow -fw_cfg 'gen_id' option to use the
 'etc/' namespace
Date: Mon, 15 Jun 2020 12:34:55 +0200
Message-Id: <20200615103457.25282-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200615103457.25282-1-philmd@redhat.com>
References: <20200615103457.25282-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 01:43:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Names of user-provided fw_cfg items are supposed to start
with "opt/". However FW_CFG_DATA_GENERATOR items are generated
by QEMU, so allow the "etc/" namespace in this specific case.

Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
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
index a46fe5c6c9..535f9d4f24 100644
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


