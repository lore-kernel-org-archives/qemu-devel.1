Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70BAEC4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 16:57:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EFE22085B
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 16:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZUNd6sRz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EFE22085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNfQR-0007Av-2B
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 12:57:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNfJa-0006da-5V
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 12:50:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26977)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNfJV-0007CO-CY
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 12:50:49 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601484644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jKQQNYZ2SLgmhNgWo9hIOt2yqMJ/mPmoThVu67DVxco=;
 b=ZUNd6sRz+RAz14grlljUJte815d04R2QWqOXGM+czAJ7Mu8xvNmWgDH53nAEmB7rsqO9sT
 r9xvGZSPAEGD+GQObCViMdwuYFTQnXqpL+Y4vobmZkx4ywFOTe93Ibr+Rf6Wj5jgKun9XV
 /0K4QDG8xXdM+WbJh3Fw5300exQ7VCg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-555-8nksiz5jOxGVfVsABF-siQ-1; Wed, 30 Sep 2020 12:50:42 -0400
X-MC-Unique: 8nksiz5jOxGVfVsABF-siQ-1
Received: by mail-wr1-f72.google.com with SMTP id 33so822663wrk.12
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 09:50:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jKQQNYZ2SLgmhNgWo9hIOt2yqMJ/mPmoThVu67DVxco=;
 b=bTs6Oxbu1dDt/XLwb1/TzFvn1lwF8SHRcz30wC9MFi6ybcy+PCGjrWNUYfXhNurrxr
 +kKQRFpoLhEbIEfZ4oLhZZuWUKO6OeBSfEqWxg1KlL6tbaAWh81anTQ3Xfd3YP2nrjAk
 BaKamIO+oHiLBOWiQ6pYsUBABWLlNxhrJflFFxU0Bm6WId8arotC4MIbxvRwdNmbVO36
 fe//stw/lDSDiCn5OkLO4YAXlhCigH2zAlSJY+5xE5ALnWY4bIojiOaQHsd9cYfz1pse
 CkPtD5mAknD06t32oZ3QCaN6kH4OXbzaelxBy9Op97NpUuu5OtR/r6DonRz9PXBAPZW+
 jkEg==
X-Gm-Message-State: AOAM530a7G7mCuO+6Z/T991IMgc4nNr03+mLRBDVWe1MiCuZIcOXwgPD
 zju8Boeeh/AQBYJum4kdduAIxW2RTQK2YxbUqmqLmQOoNtcyNLCuC2Ig8kMLq1/NlSfidBScSGK
 hMH2tXNeQ9/OsutE=
X-Received: by 2002:a5d:444e:: with SMTP id x14mr3965084wrr.235.1601484640894; 
 Wed, 30 Sep 2020 09:50:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnLfectrjk5rOG39NVLnIV5g6+m0NSAZsv7bRIwZo2gPt9mWfr/uMfChTftCeAlsvEum05fw==
X-Received: by 2002:a5d:444e:: with SMTP id x14mr3965059wrr.235.1601484640690; 
 Wed, 30 Sep 2020 09:50:40 -0700 (PDT)
Received: from x1w.redhat.com (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id v4sm3563456wml.46.2020.09.30.09.50.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2020 09:50:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v3 09/11] hw/core: Add qdev stub for user-mode
Date: Wed, 30 Sep 2020 18:49:47 +0200
Message-Id: <20200930164949.1425294-10-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200930164949.1425294-1-philmd@redhat.com>
References: <20200930164949.1425294-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:26:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Peter Lieven <pl@kamp.de>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While user-mode does not use peripherals (devices), it uses a
CPU which is a device.
In the next commit we will reduce the QAPI generated code for
user-mode. Since qdev.c calls qapi_event_send_device_deleted()
in device_finalize, let's add a stub for it.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
v3: Meson rebase
---
 stubs/qdev-system.c | 24 ++++++++++++++++++++++++
 stubs/meson.build   |  1 +
 2 files changed, 25 insertions(+)
 create mode 100644 stubs/qdev-system.c

diff --git a/stubs/qdev-system.c b/stubs/qdev-system.c
new file mode 100644
index 0000000000..2b4b54f621
--- /dev/null
+++ b/stubs/qdev-system.c
@@ -0,0 +1,24 @@
+/*
+ * QAPI qdev stubs
+ *
+ * Copyright (c) 2020 Red Hat, Inc.
+ *
+ * Author:
+ *   Philippe Mathieu-Daudé <philmd@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/qapi-events-qdev.h"
+
+void qapi_event_send_device_deleted(bool has_device,
+                                    const char *device, const char *path)
+{
+    /*
+     * Called in user-mode in fork() when a CPUState is qdev::finalize()'d.
+     * Simply ignore the QAPI event there.
+     */
+}
diff --git a/stubs/meson.build b/stubs/meson.build
index 2e231590e1..71d42c34d6 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -25,6 +25,7 @@ stub_ss.add(files('monitor.c'))
 stub_ss.add(files('monitor-core.c'))
 stub_ss.add(files('pci-bus.c'))
 stub_ss.add(files('pci-host-piix.c'))
+stub_ss.add(files('qdev-system.c'))
 stub_ss.add(files('qemu-timer-notify-cb.c'))
 stub_ss.add(files('qmp_memory_device.c'))
 stub_ss.add(files('qtest.c'))
-- 
2.26.2


