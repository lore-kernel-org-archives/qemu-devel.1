Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35ED1C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 18:25:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F375020578
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 18:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YX8smZQK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F375020578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb6w7-0004tf-4O
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 14:25:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41594)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jb6rC-0005eP-AF
 for qemu-devel@nongnu.org; Tue, 19 May 2020 14:20:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42466
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jb6rB-0008SE-CY
 for qemu-devel@nongnu.org; Tue, 19 May 2020 14:20:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589912447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jq7M0GNbAMnwTwtOhCF9XvyRYicoQZiXqGW42a5oD/A=;
 b=YX8smZQKsIzTcUet4vxLzf7gLGb8x638jHnYejJvsUqPQZ35/64dqs0bWsMz/kL0Z5CNw4
 qXwo9HZ34TOMcoCOYB3MHbxJ0yXcBbKUYcpvVXItTli9bMR0G57SQp3XyXfsnz3iVmtrsd
 zw3ypiQE/Mp3DKOqPbzHz1kGdezB6+g=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-URk7aF8NNhe3NcaEviA6pw-1; Tue, 19 May 2020 14:20:45 -0400
X-MC-Unique: URk7aF8NNhe3NcaEviA6pw-1
Received: by mail-wr1-f69.google.com with SMTP id e14so196103wrv.11
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 11:20:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jq7M0GNbAMnwTwtOhCF9XvyRYicoQZiXqGW42a5oD/A=;
 b=BU+3h90rQNiJwM33JxkRCd/pT82XclaPcgyf+PCKGwU9bGwQhfFMvqRQI1xCJqAbXF
 RU4gyOFrodnBLsZMF+HRMMK2yCXgzTwhyHBXsZjJ7mEGiClegKNWhSQVhsryW7gx5PYm
 ivBUGmz/ZPFJwljMajvGDIK7IGD26MS5/7qt46XfoN2xLhhsOabmDsgrC86l6nO9kBaC
 u8fhtmuxHrkoRJfrZMs3d8hcqF6cNqpKpGeFpnhZlKXeG12DUh19Sl3q/Jawaev0gTC1
 IafYS/u6YJrjY9Q6kR2ApTB99YrbTUN+PnYdf3wplZ/Y4R3P+re1sH1kKXkGwlL69tQa
 kcRQ==
X-Gm-Message-State: AOAM532FNT5hgetYOPyq2YegQxakQJ44dWB4/zrAmaTbpPUBkv6CSFlb
 Dm9yBXo9EZarparzFjqQJihqQYmZU7NIgKIjG/1TUohY629WE0H0xjFer+K1LStVy6Pl+q6571y
 U2wG8PFLtSa0emKI=
X-Received: by 2002:adf:f702:: with SMTP id r2mr173874wrp.191.1589912444140;
 Tue, 19 May 2020 11:20:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzq4xfSE71w5ZhKwWI8R11/+g1xtfz/aFvWL6CRdzCbcxXMMOyuVM3CQsJJHsW2UDuNewqOYQ==
X-Received: by 2002:adf:f702:: with SMTP id r2mr173845wrp.191.1589912443903;
 Tue, 19 May 2020 11:20:43 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id h1sm508829wme.42.2020.05.19.11.20.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2020 11:20:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v6 3/5] softmmu/vl: Allow -fw_cfg 'blob_id' option to set
 any file pathname
Date: Tue, 19 May 2020 20:20:22 +0200
Message-Id: <20200519182024.14638-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200519182024.14638-1-philmd@redhat.com>
References: <20200519182024.14638-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 09:19:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 Eduardo Habkost <ehabkost@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is to silent:

  $ qemu-system-x86_64 \
    -object tls-cipher-suites,id=ciphersuite0,priority=@SYSTEM \
    -fw_cfg name=etc/edk2/https/ciphers,blob_id=ciphersuite0
  qemu-system-x86_64: -fw_cfg name=etc/edk2/https/ciphers,blob_id=ciphersuite0: warning: externally provided fw_cfg item names should be prefixed with "opt/"

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 softmmu/vl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/softmmu/vl.c b/softmmu/vl.c
index f76c53ad2e..3b77dcc00d 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -2052,7 +2052,7 @@ static int parse_fw_cfg(void *opaque, QemuOpts *opts, Error **errp)
                    FW_CFG_MAX_FILE_PATH - 1);
         return -1;
     }
-    if (strncmp(name, "opt/", 4) != 0) {
+    if (!nonempty_str(blob_id) && strncmp(name, "opt/", 4) != 0) {
         warn_report("externally provided fw_cfg item names "
                     "should be prefixed with \"opt/\"");
     }
-- 
2.21.3


