Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0DEBC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 17:32:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 817CF206EB
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 17:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ti0B+3JE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 817CF206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnmmO-0003gZ-RL
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 13:32:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36854)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jnmi8-0005gW-6Y
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 13:27:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21155
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jnmi6-0003kg-H8
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 13:27:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592933269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gWgKZYj6cuVtbKXzjFGd74SB2pAgnguDqOC2Xe3Mx+s=;
 b=Ti0B+3JE14rLltcAlV6+SlIfOGYjCe37cD6S0ud5Hj3Xmy9ZVuuh6boxtybK/gJzQlHz2e
 X6IlyETTVcByF5VDvkaqAHbFE70NcINL+tBBRc/rUKJDNte5sPo6FGBsKtECET1iqLXc2L
 JipzgzAugoaGpksdasu8jNkGAl0shUg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-B3Q5oa1JM7y8JX4oSvvCeg-1; Tue, 23 Jun 2020 13:27:48 -0400
X-MC-Unique: B3Q5oa1JM7y8JX4oSvvCeg-1
Received: by mail-wr1-f69.google.com with SMTP id j5so13936866wro.6
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 10:27:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gWgKZYj6cuVtbKXzjFGd74SB2pAgnguDqOC2Xe3Mx+s=;
 b=gXzGVZwghcoMS2Im9O3HPUV0KL9CqlcVxJJMi5s8R1YacM8WfKu38v01rYWwIYbaoZ
 nHfnP2nmG0ljQ6LRv0jUWOPX4jwcpx9L9qDdwFuYJAarY8lGvh2Ex9Pv7oV2iD+ZWzkd
 hvnG39180WBged273hWYiLX6m2VRSdFqe1957Pe26mgq3UsbPReIFYCH6g+Zr8PsW9b1
 jz+BH66whM6opX6v+YOr+iqvgtmDtPUP8zp10kHerYvLmpFgsQ/rt43H02YQpWut2Nud
 WA1Se4GbUy1D6zcrP7r805euKGJWkrVhZmNs07AVIBqkqVoRaWZdAv951lAm5yJ1pfo7
 BIwQ==
X-Gm-Message-State: AOAM530HTS3PV/uDsQkxdMevYJQUrUiD79b2YjQtlKhQS13yrkMz6bGc
 W8v/S62Rjku4JQlOlKnSOUfTtNAmuaTan0b6aGDieuLV23le5IHRRxepDuscgaR9A2N/K2wHPz9
 CLCx3Xg0QB7EKtyg=
X-Received: by 2002:a1c:4c0d:: with SMTP id z13mr24005044wmf.97.1592933266762; 
 Tue, 23 Jun 2020 10:27:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxGja2LFQ9PLn+M7uCUD6oJylvUjeO5NAnm9qImOUH1O2T7lOcDG7b9EpWIHcXCospfIGeWFg==
X-Received: by 2002:a1c:4c0d:: with SMTP id z13mr24005032wmf.97.1592933266509; 
 Tue, 23 Jun 2020 10:27:46 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id v20sm23921818wrb.51.2020.06.23.10.27.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 10:27:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 4/5] softmmu/vl: Allow -fw_cfg 'gen_id' option to use the
 'etc/' namespace
Date: Tue, 23 Jun 2020 19:27:25 +0200
Message-Id: <20200623172726.21040-5-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200623172726.21040-1-philmd@redhat.com>
References: <20200623172726.21040-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 01:53:54
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
 Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
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
index a587261f34..4d0c2c9038 100644
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


