Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1218C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 15:59:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 681D62071A
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 15:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="arEYgp7y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 681D62071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdFVd-00044I-Jg
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 11:59:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59760)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdFUp-0003Ht-2E
 for qemu-devel@nongnu.org; Mon, 25 May 2020 11:58:35 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27218
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdFUn-000197-U4
 for qemu-devel@nongnu.org; Mon, 25 May 2020 11:58:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590422312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=rRrseoAnbJR0ukjPrBzVp2SnpxDePVZX4bWjCZH11to=;
 b=arEYgp7yWqKzrYTfRJzlU9QJtgJTLhU8IfWJvTgDdLMmk6JW9t5pCcNXaPFmeo24NW6cKx
 FTZLMV3WLtD3H+7qTyFHTDEkENfWp9TVQ82Yo29XAitX1Chrn/I3VB4RjnDGqGkUKX7Otg
 0V/4OPIKaJceSTimJAQMb5Quu357rk0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-3KkScyVZPtK8OyiDGb1AEg-1; Mon, 25 May 2020 11:58:31 -0400
X-MC-Unique: 3KkScyVZPtK8OyiDGb1AEg-1
Received: by mail-ed1-f72.google.com with SMTP id f18so7635806eds.6
 for <qemu-devel@nongnu.org>; Mon, 25 May 2020 08:58:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rRrseoAnbJR0ukjPrBzVp2SnpxDePVZX4bWjCZH11to=;
 b=JWvx9F+ALW8QX4qhuNjt0eUHPtyqlZ15UTTtJY3AUOXg0BeavteaBqQEaOyOizB3mV
 zpZmSl9OrIL2KWwPAKmhd3gX+SjWg5F+WH2fxISU5Bw4Wasd5vSU8G7/zqBiQZ5we9nz
 M7nQB8rMBTCwerL0P1bW7rGHnL1M7uVovlalfyl/FwfoJa/qw8KqeMHxGF+WfiDTZNJ3
 4WKeWh5qSxFbrbvPu5tr2a6omuKe2nyts7gHtDeyOCems6S/GLpKzg039xTGujqfIz40
 cv1j7ycQWfuoLBVl7GSGWB0yPqzf4VGzZsKkEAiwlxsjXRZd4EHXNWPCXKranNUG5676
 KAuQ==
X-Gm-Message-State: AOAM531PYZscnTV+P/3MaOUcuJKbE3j5O1oDLxbU8wAASsewnVM/s1fF
 EykXED66KyjmT66hHUEUjEwv9AV6btylOzpQi4hXwpOMN0ByzyfPW9AXH9hQDvJIR+ossVAdWjH
 OCri5kRdYbfev0Uk=
X-Received: by 2002:a17:906:b4c:: with SMTP id
 v12mr18559752ejg.25.1590422309772; 
 Mon, 25 May 2020 08:58:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwYrBI41qysSi/fEwZAekUm40KpsZETK7kuVO54dxNUtuOurLaucuM8IFBuDX3KOHqp56l63g==
X-Received: by 2002:a17:906:b4c:: with SMTP id
 v12mr18559691ejg.25.1590422308568; 
 Mon, 25 May 2020 08:58:28 -0700 (PDT)
Received: from x1w.redhat.com (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id s19sm13923953edx.92.2020.05.25.08.58.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2020 08:58:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/block/pflash_cfi01: Limit maximum flash size to 256 MiB
Date: Mon, 25 May 2020 17:58:26 +0200
Message-Id: <20200525155826.11333-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 02:40:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Hongbo Zhang <hongbo.zhang@linaro.org>,
 Tanmay Jagdale <tanmay.jagdale@linaro.org>, qemu-block@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Radoslaw Biernacki <radoslaw.biernacki@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Leif Lindholm <leif@nuviainc.com>, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As of this commit, the biggest CFI01 NOR flash documented is
the Micron PC28F00BP33EF. Its size is 2 GiB (256 MiB).

Actually this "2Gb device employs a virtual chip enable feature,
which combines two 1Gb die with a common chip enable".

Since we do not want to model unrealistic hardware, cap the
current model to this maximum. At least we have a datasheet
to refer.

If a bigger flash is provided, the user get this warning:

  qemu-system-aarch64: Initialization of device cfi.pflash01 failed: Maximum supported CFI flash size is 16 MiB.

Note, the sbsa-ref ARM machine introduced in commit 64580903c2b
already uses a pair of 256 MiB flash devices.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/block/pflash_cfi01.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 11922c0f96..40f145dde7 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -37,6 +37,8 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "qemu/cutils.h"
 #include "hw/block/block.h"
 #include "hw/block/flash.h"
 #include "hw/qdev-properties.h"
@@ -68,6 +70,8 @@ do {                                                        \
 #define PFLASH_BE          0
 #define PFLASH_SECURE      1
 
+#define PFLASH_SIZE_MAX     (256 * MiB) /* Micron PC28F00BP33EF */
+
 struct PFlashCFI01 {
     /*< private >*/
     SysBusDevice parent_obj;
@@ -717,6 +721,12 @@ static void pflash_cfi01_realize(DeviceState *dev, Error **errp)
     }
 
     total_len = pfl->sector_len * pfl->nb_blocs;
+    if (total_len > PFLASH_SIZE_MAX) {
+        char *maxsz = size_to_str(PFLASH_SIZE_MAX);
+        error_setg(errp, "Maximum supported CFI flash size is %s.", maxsz);
+        g_free(maxsz);
+        return;
+    }
 
     /* These are only used to expose the parameters of each device
      * in the cfi_table[].
-- 
2.21.3


