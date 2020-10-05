Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA988C4727E
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 10:57:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B65B2078E
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 10:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PKpoe5/3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B65B2078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPOBG-0006Hk-EY
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 06:57:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40338)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPO8t-0003Y4-6t
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 06:54:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34903)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPO8r-0001q9-1o
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 06:54:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601895292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S6WO5CjQSd0ltN/dEHJ0VgZWTVaEIexhMUGPC2p0bOQ=;
 b=PKpoe5/3lvAfSVOeel+SzGP+3fEQl/4BBuACLrFEKxHMDttlUamJtN7AGDMyMwsSfyQTeI
 tfyU3ed1VFI0YrFOTvxJlCsiZT8m2WDZLcd48JFHBjGqOpUn9Pocy2gcdTdQysEipBOLdt
 SiykQ5MgABxto7IOwgIFTX8fq7Eyit8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-QqdGT_uVN8CVs-Ow2AQsJg-1; Mon, 05 Oct 2020 06:54:50 -0400
X-MC-Unique: QqdGT_uVN8CVs-Ow2AQsJg-1
Received: by mail-wm1-f72.google.com with SMTP id w23so243871wmi.1
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 03:54:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=S6WO5CjQSd0ltN/dEHJ0VgZWTVaEIexhMUGPC2p0bOQ=;
 b=XuAxg9m2bAezDPudAnd7MPSF/foDBwTuLo0iIGU968cz70m2dnlnCStR/vKd4/0XxK
 yEPP4CHj1fRn8IdSbLEQ7i8jhRncXszX9n17G6Duk4mxUssVQvp92JMLO0qhRqNAZxFk
 SBuUZqbKZ3o4ZS7Gwku8PqvaA0I/G8ZlDHg0cDTXO1ggEGsK+Kzi7N3Ys0ZSlxEWw+wS
 WpFnXsS95S6D++iEBuMa/zhJA6NxGSoQ27bKyQxg88n/Nu6BxMbMd78dnOnS3yBWNUBD
 FNEI34KeiQ1z475rx+3SEykpL4hmgo8U0G+nEj118P7mu17l+ImCsqCA1xBE5SkUv6l4
 3nEQ==
X-Gm-Message-State: AOAM533m5m4n0apEOYE+L0VNcFqUT7GSL2l7V5qs15NlZsPosJN/2oXl
 SfsCbgMocHzGdTbmLPM+xgQYY6V4rVkboYvc5ORiQFovaRp7Q/hXQJp5Kp+JR/XkMPulqJiQCHz
 EA+GcINoYSVbTt9c=
X-Received: by 2002:a5d:468f:: with SMTP id u15mr16771319wrq.336.1601895289411; 
 Mon, 05 Oct 2020 03:54:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz1UoGi9Et5W6FMxnMCa6hx7cXiKRg3yVI532O2fSZTwbnsMAT6RzwE1Gd52qJX6GNzdx5i9w==
X-Received: by 2002:a5d:468f:: with SMTP id u15mr16771298wrq.336.1601895289176; 
 Mon, 05 Oct 2020 03:54:49 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id l3sm12735066wmh.27.2020.10.05.03.54.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 03:54:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>,
 qemu-devel@nongnu.org
Subject: [RFC PATCH 1/3] qom: Always register FW_CFG_DATA_GENERATOR_INTERFACE
Date: Mon,  5 Oct 2020 12:54:40 +0200
Message-Id: <20201005105442.2093105-2-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201005105442.2093105-1-philmd@redhat.com>
References: <20201005105442.2093105-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 01:25:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.745,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
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
Fixes: 69699f3055 ("crypto/tls-cipher-suites: Produce fw_cfg consumable blob")
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
I first used:

+if config_host.has_key('CONFIG_GNUTLS') or have_system
+  qom_ss.add(files('fw_cfg_interface.c'))
+endif

but then realized anything could implement a QOM interface,
so better keep this generic.
---
 hw/nvram/fw_cfg.c      |  7 -------
 qom/fw_cfg_interface.c | 15 +++++++++++++++
 MAINTAINERS            |  1 +
 qom/meson.build        |  5 +++++
 4 files changed, 21 insertions(+), 7 deletions(-)
 create mode 100644 qom/fw_cfg_interface.c

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
diff --git a/qom/fw_cfg_interface.c b/qom/fw_cfg_interface.c
new file mode 100644
index 0000000000..2b19502ffe
--- /dev/null
+++ b/qom/fw_cfg_interface.c
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
+static void fw_cfg_register_types(void)
+{
+    type_register_static(&fw_cfg_data_generator_interface_info);
+}
+
+type_init(fw_cfg_register_types)
diff --git a/MAINTAINERS b/MAINTAINERS
index b76fb31861..9c89d54b41 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2055,6 +2055,7 @@ R: Gerd Hoffmann <kraxel@redhat.com>
 S: Supported
 F: docs/specs/fw_cfg.txt
 F: hw/nvram/fw_cfg.c
+F: qom/fw_cfg_interface.c
 F: stubs/fw_cfg.c
 F: include/hw/nvram/fw_cfg.h
 F: include/standard-headers/linux/qemu_fw_cfg.h
diff --git a/qom/meson.build b/qom/meson.build
index a1cd03c82c..7335f8c8a2 100644
--- a/qom/meson.build
+++ b/qom/meson.build
@@ -7,6 +7,11 @@ qom_ss.add(files(
   'qom-qobject.c',
 ))
 
+# interfaces any object might implement
+qom_ss.add(files(
+  'fw_cfg_interface.c',
+))
+
 qmp_ss.add(files('qom-qmp-cmds.c'))
 softmmu_ss.add(files('qom-hmp-cmds.c'))
 
-- 
2.26.2


