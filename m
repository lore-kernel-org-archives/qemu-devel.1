Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1622C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:42:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFAD92074B
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="deINui02"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFAD92074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiiGW-0000li-Vz
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 13:42:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jihj5-0003MQ-8G
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 13:07:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34455
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jihj4-0008SL-BF
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 13:07:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591722469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tIQpxpe6DvDHHDTfBFm1CSFqq0qmGHboXIdj7jaU5XA=;
 b=deINui02va/wQ6DNmn5cEmD3LnK1Gvkh9C73WZtNsTurfNTXFZ9NPpE0LcV9+uIlaJza3W
 Lgm+drEecrXrxAORmGILoyFY5XzTty6sBDQlcIeE+/2k8goGIzz+FgRAdHWLDQ3tFo5rz1
 OeQrYHNm2ZwTJzf5+eYZC5RY4tTzChs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-xHMdnnktP4G9hn0jlng-iA-1; Tue, 09 Jun 2020 13:07:48 -0400
X-MC-Unique: xHMdnnktP4G9hn0jlng-iA-1
Received: by mail-wr1-f69.google.com with SMTP id w16so8832085wru.18
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 10:07:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tIQpxpe6DvDHHDTfBFm1CSFqq0qmGHboXIdj7jaU5XA=;
 b=e4xBa2KwHuLEUkYTSXiLOxxDgOFCsq3/aN+c3mZ2lvQBDzIJEpSa0BBXf7xjTKkpnb
 mi0vfDNzi4nSJTQZ0It4DC3YmpHnRf3iVd7l3CgdVtOMMU14kGZ8POr2NZILG9PRqPLR
 j/7aAeXSQXJ/B4YhpAnmiejrJCvhDFlaeBgjYxaHbdu4DiR2KiKoMk4nsoifFnwtM2CN
 aZ5IZFVCZEmn05iMFM7JmujLq6kFEhNnV6BXToJSAYurhnC52xKXBJCLu65XVEn3TRlE
 QsgDJ9NowDWsxz1jX6snbXOsnGDuikySIHFgaRu2+BCRw98aSdlc4gPqVv+MGBmSD+G5
 n4tg==
X-Gm-Message-State: AOAM533capLz7iR2McnF3Z41U5Qllneo9zNFxme50dqQHtvkqJU6+dKZ
 1POiC+9tRKbCK2/a6lX0FyJ7NRknHNfc0/2WlY9Du+qihiAHbN/+yrVvLkgzCPfkZEFafqn3WvA
 HXB6kFPmQey4RwcM=
X-Received: by 2002:a05:600c:4146:: with SMTP id
 h6mr5235206wmm.170.1591722464097; 
 Tue, 09 Jun 2020 10:07:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyUVj2qwTgNC/gFCv1kkhHdULPNi+F0XiLJjN2AHnrEsGoQeBdeUcue2fX6xjF9pQntt7Ek/Q==
X-Received: by 2002:a05:600c:4146:: with SMTP id
 h6mr5235189wmm.170.1591722463865; 
 Tue, 09 Jun 2020 10:07:43 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id z6sm3874975wrh.79.2020.06.09.10.07.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 10:07:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v8 3/5] softmmu/vl: Allow -fw_cfg 'gen_id' option to use the
 'etc/' namespace
Date: Tue,  9 Jun 2020 19:07:25 +0200
Message-Id: <20200609170727.9977-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200609170727.9977-1-philmd@redhat.com>
References: <20200609170727.9977-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 02:44:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
v8: addressed Laszlo's comments
- reword commit description
- invert nonempty_str() condition
- new comment in docs/specs/fw_cfg.txt
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
index a9bce2a1b1..ff6732d1fb 100644
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


