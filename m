Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C026C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:19:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 149EB20674
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QyN+4o0m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 149EB20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDvGo-0008E8-9P
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 15:19:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37453)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDuom-00072n-QI
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:50:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDuol-0006Pl-M6
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:50:28 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:27619)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDuol-0006NI-I4
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:50:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584384627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aOssGK0wEGA9lwDtDnb83pypbPpNOihgV6a6aZtmUvE=;
 b=QyN+4o0musM+1MnwoqQpqew0EtSsO32tGBKvlHGUdwjLvEx7yXu3n6AZfC/JB+AAlcyEpk
 DHcGbBAnLud9ZNQspiuDpJZv8IZQspe4OHN7ywkw6tM6PjKxmAI1JMZ1pHanEfZNIwIQyN
 LR3v+xHmuEGqalK9SKRu5Lkb411rrN4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-rwAKA0HSMre9RyNpOgamLw-1; Mon, 16 Mar 2020 14:50:25 -0400
X-MC-Unique: rwAKA0HSMre9RyNpOgamLw-1
Received: by mail-wr1-f71.google.com with SMTP id w11so9464132wrp.20
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 11:50:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6B9O1gJSAeC5+USb9YJATMdkhOfRccXcmwPvQFdVhw4=;
 b=LEvcfVmS9IhpY2uYyAw86M2c5+H5y8Odh8bbs1/oQvPrxbW812M7R7GjMsaDHspBV+
 n5872IDZslD4GCR5+py0gl3e54HvRd55qPSlHl7ap09Xli7RUFsMBMmRQsxXohgS5wVg
 EnLWEyoG0y01C20oaOXI4FaxYWJo5qt6U/CqEx4XkA5FFlH19h0Qu4HCxKyfhX40Qbey
 cU/hVIczY4CsQNwBGvg7d/EjMXhvA61QgfJrBqTccDc4FSWSbzE3N/1NyWog0qedHb4c
 cqPiKXHSxpmLIFQK6Spjoyxh1gXLsJhNPtQmD7KXFxemNr1mpG5TduCxE58E/pwz9us+
 ZcQA==
X-Gm-Message-State: ANhLgQ2BtZr+GG/88nRkBIWfbqrijlKmBppnL6Bl14/NDi7iQX1b2YtB
 nbUt6tpcbCAaQgca+AHyaWDTM4PQdCAW7B19mH5YWRZMqRpyCdH1XCwqhh3s4aAgd75bj1OA22B
 M2Z+3jhqDfSxIR4A=
X-Received: by 2002:a1c:e341:: with SMTP id a62mr506373wmh.121.1584384624244; 
 Mon, 16 Mar 2020 11:50:24 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsM3AleS9xV+8VbIyS0A3n+inDidCwOindr1HQys0CBWm0sqQaL2XS+8KRSCBoBeJegDF7H2Q==
X-Received: by 2002:a1c:e341:: with SMTP id a62mr506345wmh.121.1584384623970; 
 Mon, 16 Mar 2020 11:50:23 -0700 (PDT)
Received: from localhost.localdomain (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id i21sm730035wmb.23.2020.03.16.11.50.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 11:50:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 03/25] scripts/cocci: Rename memory-region-{init-ram ->
 housekeeping}
Date: Mon, 16 Mar 2020 19:49:44 +0100
Message-Id: <20200316185006.576-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200316185006.576-1-philmd@redhat.com>
References: <20200316185006.576-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As we are going to add various semantic changes related to the memory
region API, rename this script to be more generic.
Add a 'usage' header, and an entry in MAINTAINERS to avoid checkpatch
warning.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 ...t-ram.cocci =3D> memory-region-housekeeping.cocci} | 13 +++++++++++++
 MAINTAINERS                                         |  1 +
 2 files changed, 14 insertions(+)
 rename scripts/coccinelle/{memory-region-init-ram.cocci =3D> memory-region=
-housekeeping.cocci} (84%)

diff --git a/scripts/coccinelle/memory-region-init-ram.cocci b/scripts/cocc=
inelle/memory-region-housekeeping.cocci
similarity index 84%
rename from scripts/coccinelle/memory-region-init-ram.cocci
rename to scripts/coccinelle/memory-region-housekeeping.cocci
index d290150872..3699c1017e 100644
--- a/scripts/coccinelle/memory-region-init-ram.cocci
+++ b/scripts/coccinelle/memory-region-housekeeping.cocci
@@ -1,3 +1,16 @@
+/*
+  Usage:
+
+    spatch \
+        --macro-file scripts/cocci-macro-file.h \
+        --sp-file scripts/coccinelle/memory-region-housekeeping.cocci \
+        --keep-comments \
+        --in-place \
+        --dir .
+
+*/
+
+
 // Replace by-hand memory_region_init_ram_nomigrate/vmstate_register_ram
 // code sequences with use of the new memory_region_init_ram function.
 // Similarly for the _rom and _rom_device functions.
diff --git a/MAINTAINERS b/MAINTAINERS
index 32867bc636..e06ef9bb56 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2036,6 +2036,7 @@ F: include/exec/ramblock.h
 F: memory.c
 F: include/exec/memory-internal.h
 F: exec.c
+F: scripts/coccinelle/memory-region-housekeeping.cocci
=20
 SPICE
 M: Gerd Hoffmann <kraxel@redhat.com>
--=20
2.21.1


