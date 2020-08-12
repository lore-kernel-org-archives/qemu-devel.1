Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3168C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 13:19:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A009F207DA
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 13:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vd9rjS4+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A009F207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5qf8-0006Yk-Ry
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 09:19:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5qeL-0005TF-Ly
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 09:18:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33398
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5qeK-0001z1-0J
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 09:18:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597238314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8o5eoFN0puLE5pBO6uDx8TnF9KI6NbInN6d4S4lHYoo=;
 b=Vd9rjS4+joHXgJO+9GWYBkVlL/k4F5URLHWuVTmAZIqTKeNr5DAl2O6p5OJIz+ih45rlxG
 FdjEq+ZKt3+NeluUTES8t8jArGjuGK6dWr1WXhOzreYWWi4LWCZbdMmz8SGh4RaK8JN9Yb
 oWNaotm4uQJ25ew69bgxAgkIPy+HIe8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-fNjJBGiePO2Ss0B-U3yjSQ-1; Wed, 12 Aug 2020 09:18:30 -0400
X-MC-Unique: fNjJBGiePO2Ss0B-U3yjSQ-1
Received: by mail-wr1-f71.google.com with SMTP id f7so899299wrs.8
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 06:18:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8o5eoFN0puLE5pBO6uDx8TnF9KI6NbInN6d4S4lHYoo=;
 b=lHiLFTw6Kt4VBP9kASoQUSAKlwb3wtSBfjKf8W7ate3UAyt9Si6ZHZlbm+omjunsV9
 6jYJsN9sWfJz712ShdBi9rt9YmtNw4+rhC9TnQqqy7F8Eb3huEpNbr2WR0olGdDPFUZw
 MKyGQy4LJU5yNUcMJ1VW3uy1tGUVhRjzGsXj1zpyi1ImOSndFeDyJWSQGhL4akMBnBtn
 7JbfxYZkNgl55oSNZePoWefPosYeZcF006CH4bjT0da8vbWuPjBaUdXKPLgwDgvgXpxk
 06BAQzK6bOZgG+cfIVEjEob+7yLYvZJ+S5qD7uVLWR3GUorAkOqgLkqHZTXTsLUoKi51
 1vDA==
X-Gm-Message-State: AOAM532r0y03mUcKNIayddh2yIoeulHgHyq0aErGHyEeQBUvrL9m2odi
 k9XuE2zyEnxPlwFNuRTdKpRSyeK0zgESEJUU11VDilQiyKoL2wvM6uyVBJ+YzfoTlV4cPfvtPyQ
 y368kVA74o3u4gVY=
X-Received: by 2002:a5d:464a:: with SMTP id j10mr35462468wrs.187.1597238309098; 
 Wed, 12 Aug 2020 06:18:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyt4soaSC8MagfxUH1G2NXzbZKKogqxEkxRyj9Busv5tEG2oqhtJjpcGcKynTVjaUpP/YubKw==
X-Received: by 2002:a5d:464a:: with SMTP id j10mr35462454wrs.187.1597238308913; 
 Wed, 12 Aug 2020 06:18:28 -0700 (PDT)
Received: from x1w.redhat.com (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id r3sm3977238wro.1.2020.08.12.06.18.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2020 06:18:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/2] tests/acceptance/boot_linux: Extract common URL from
 xlnx-versal test
Date: Wed, 12 Aug 2020 15:18:21 +0200
Message-Id: <20200812131822.28162-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200812131822.28162-1-philmd@redhat.com>
References: <20200812131822.28162-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 06:16:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Both files refer to the same directory. Store the common part in
a new variable.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200810093050.28744-2-philmd@redhat.com>
---
 tests/acceptance/boot_linux_console.py | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 73cc69c499..2f22eddd0d 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -335,15 +335,14 @@ def test_aarch64_xlnx_versal_virt(self):
         :avocado: tags=device:pl011
         :avocado: tags=device:arm_gicv3
         """
-        kernel_url = ('http://ports.ubuntu.com/ubuntu-ports/dists/'
-                      'bionic-updates/main/installer-arm64/current/images/'
-                      'netboot/ubuntu-installer/arm64/linux')
+        images_url = ('http://ports.ubuntu.com/ubuntu-ports/dists/'
+                      'bionic-updates/main/installer-arm64/'
+                      'current/images/')
+        kernel_url = images_url + 'netboot/ubuntu-installer/arm64/linux'
         kernel_hash = '5bfc54cf7ed8157d93f6e5b0241e727b6dc22c50'
         kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
 
-        initrd_url = ('http://ports.ubuntu.com/ubuntu-ports/dists/'
-                      'bionic-updates/main/installer-arm64/current/images/'
-                      'netboot/ubuntu-installer/arm64/initrd.gz')
+        initrd_url = images_url + 'netboot/ubuntu-installer/arm64/initrd.gz'
         initrd_hash = 'd385d3e88d53e2004c5d43cbe668b458a094f772'
         initrd_path = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
 
-- 
2.21.3


