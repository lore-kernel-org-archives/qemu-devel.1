Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E37FBC46466
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 15:42:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DEF020760
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 15:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZjzEZBBz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DEF020760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPp6r-0002gN-Kc
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 11:42:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPp1I-0005oY-Fz
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 11:36:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34026)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPp1E-0007GH-TK
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 11:36:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601998606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A2NhhHmyKoCsBTvmZ7fN8i5on5WUvhiptL/RbfJsOjA=;
 b=ZjzEZBBze5ZrNoq3yk4K7I5bRSqkrisYjbUcq1BZkBX4BE27S0K+NYdqkH7zUitDj5N3rH
 OKC7Joq8hJ7KP7/P8pUauAzEierM2FZ5KvR+2P7xiQpMEvXmH+0BRIaKWNGtEeIXQ/AnRy
 hm36Kd1/aP1z6/ikQTQf6PCK6TPpPsg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-ZY_nWeD8P7anzSoDDGsqjQ-1; Tue, 06 Oct 2020 11:36:45 -0400
X-MC-Unique: ZY_nWeD8P7anzSoDDGsqjQ-1
Received: by mail-wr1-f70.google.com with SMTP id r16so5476665wrm.18
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 08:36:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=A2NhhHmyKoCsBTvmZ7fN8i5on5WUvhiptL/RbfJsOjA=;
 b=nJJdFWSCz+h0Bqxz/w1IfdrwLAQvKTddkJ+QdEXUqOVFq3B7stgHp9WIvUXRydHdgM
 uiw6ZdAMeAxapqXTvMiPqS4UuyoBhN2unNeT7DkwA2pbIX0PupReCY9pjmMCiOvB32UM
 IqP3NwMTohCPKGl5VVebfrTYVDE6m1x90y/UPh7FgnbFOufBvK5oacfruE+SX6NHwTen
 nSc44wIK10TX9jn9H5onQscBGikxx6Sqc5yCm+tBmr7s6vk2NfDII3K2BiQEPl1WWwej
 fqM/8J69N+pourTyBhbBidwuHH5Z7gGUi7R7JcL8miNJx+6tIuMvuacs6N7XCJL02qv9
 HRIg==
X-Gm-Message-State: AOAM532YAHiTV5JO1l50lN/52I3uCIf3tskph7iWSssWvyae6pjVUiaN
 lvtKHhcdl9UzSfNa4NDVxlIbnEg8AIHuo466Xvj74TCz9j/MJkxuLyTQstKALxudNTTbs6wmYCC
 juqj5IzRrZDAF8rU=
X-Received: by 2002:a1c:a444:: with SMTP id n65mr5411397wme.122.1601998603931; 
 Tue, 06 Oct 2020 08:36:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzE1afOkEaLvCyOXRNcmsc2zAsFDK9aCgvWyWFJrqIZKeaSKDJHTn6WL9oI+4kBM3+FLAvbKw==
X-Received: by 2002:a1c:a444:: with SMTP id n65mr5411379wme.122.1601998603674; 
 Tue, 06 Oct 2020 08:36:43 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id x64sm4599526wmg.33.2020.10.06.08.36.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 08:36:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/1] hw/nvram: Always register
 FW_CFG_DATA_GENERATOR_INTERFACE
Date: Tue,  6 Oct 2020 17:36:36 +0200
Message-Id: <20201006153636.2383248-2-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201006153636.2383248-1-philmd@redhat.com>
References: <20201006153636.2383248-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 00:55:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While the FW_CFG_DATA_GENERATOR_INTERFACE is only consumed
by a device only available using system-mode (fw_cfg), it is
implemented by a crypto component (tls-cipher-suites) which
is always available when crypto is used.

Commit 69699f3055 introduced the following error in the
qemu-storage-daemon binary:

  $ echo -e \
    '{"execute": "qmp_capabilities"}\r\n{"execute": "qom-list-types"}\r\n{"execute": "quit"}\r\n' \
    | storage-daemon/qemu-storage-daemon --chardev stdio,id=qmp0  --monitor qmp0
  {"QMP": {"version": {"qemu": {"micro": 50, "minor": 1, "major": 5}, "package": ""}, "capabilities": ["oob"]}}
  {"return": {}}
  missing interface 'fw_cfg-data-generator' for object 'tls-creds'
  Aborted (core dumped)

Since QOM dependencies are resolved at runtime, this issue
could not be triggered at linktime, and we don't have test
running the qemu-storage-daemon binary.

Fix by always registering the QOM interface.

Reported-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Fixes: 69699f3055 ("crypto/tls-cipher-suites: Produce fw_cfg consumable blob")
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/nvram/fw_cfg-interface.c | 15 +++++++++++++++
 hw/nvram/fw_cfg.c           |  7 -------
 MAINTAINERS                 |  2 +-
 hw/nvram/meson.build        |  3 +++
 4 files changed, 19 insertions(+), 8 deletions(-)
 create mode 100644 hw/nvram/fw_cfg-interface.c

diff --git a/hw/nvram/fw_cfg-interface.c b/hw/nvram/fw_cfg-interface.c
new file mode 100644
index 0000000000..bcc7b1edbc
--- /dev/null
+++ b/hw/nvram/fw_cfg-interface.c
@@ -0,0 +1,15 @@
+#include "qemu/osdep.h"
+#include "hw/nvram/fw_cfg.h"
+
+static const TypeInfo fw_cfg_data_generator_interface_info = {
+    .parent = TYPE_INTERFACE,
+    .name = TYPE_FW_CFG_DATA_GENERATOR_INTERFACE,
+    .class_size = sizeof(FWCfgDataGeneratorClass),
+};
+
+static void fw_cfg_register_interfaces(void)
+{
+    type_register_static(&fw_cfg_data_generator_interface_info);
+}
+
+type_init(fw_cfg_register_interfaces)
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 0e95d057fd..08539a1aab 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -1360,18 +1360,11 @@ static const TypeInfo fw_cfg_mem_info = {
     .class_init    = fw_cfg_mem_class_init,
 };
 
-static const TypeInfo fw_cfg_data_generator_interface_info = {
-    .parent = TYPE_INTERFACE,
-    .name = TYPE_FW_CFG_DATA_GENERATOR_INTERFACE,
-    .class_size = sizeof(FWCfgDataGeneratorClass),
-};
-
 static void fw_cfg_register_types(void)
 {
     type_register_static(&fw_cfg_info);
     type_register_static(&fw_cfg_io_info);
     type_register_static(&fw_cfg_mem_info);
-    type_register_static(&fw_cfg_data_generator_interface_info);
 }
 
 type_init(fw_cfg_register_types)
diff --git a/MAINTAINERS b/MAINTAINERS
index b76fb31861..a45d908ebd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2054,7 +2054,7 @@ R: Laszlo Ersek <lersek@redhat.com>
 R: Gerd Hoffmann <kraxel@redhat.com>
 S: Supported
 F: docs/specs/fw_cfg.txt
-F: hw/nvram/fw_cfg.c
+F: hw/nvram/fw_cfg*.c
 F: stubs/fw_cfg.c
 F: include/hw/nvram/fw_cfg.h
 F: include/standard-headers/linux/qemu_fw_cfg.h
diff --git a/hw/nvram/meson.build b/hw/nvram/meson.build
index 1f2ed013b2..fd2951a860 100644
--- a/hw/nvram/meson.build
+++ b/hw/nvram/meson.build
@@ -1,3 +1,6 @@
+# QOM interfaces must be available anytime QOM is used.
+qom_ss.add(files('fw_cfg-interface.c'))
+
 softmmu_ss.add(files('fw_cfg.c'))
 softmmu_ss.add(when: 'CONFIG_CHRP_NVRAM', if_true: files('chrp_nvram.c'))
 softmmu_ss.add(when: 'CONFIG_DS1225Y', if_true: files('ds1225y.c'))
-- 
2.26.2


