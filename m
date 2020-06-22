Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFFAC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 09:04:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58D6B2071A
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 09:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ODl2UkT5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58D6B2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnINn-0005w6-Gv
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 05:04:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jnIJ7-0000lD-MF
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 05:00:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43160
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jnIJ5-0004wy-OH
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 05:00:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592816399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qvzPrjknpHhvnClu+pyh7kfIagFIHhbvIfdKUMdjTJU=;
 b=ODl2UkT5NNPkV01bCY5/Q7ejBI5yEE9fTPEtSirt71J8d8Z7INrGEGFWQ4VObVu9/U/HNs
 Darm+guXId69F27GUWUJujO0aeYRqMJxaEvuLtJrFN0udMiiSWde4KYHAH8JLxHUf12nz1
 LvwnrWnSGRQtq3IWG3Nf4Hzv4rgoY/U=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-VH3zPBDuOr2QU8cwdGFyug-1; Mon, 22 Jun 2020 04:59:56 -0400
X-MC-Unique: VH3zPBDuOr2QU8cwdGFyug-1
Received: by mail-wr1-f69.google.com with SMTP id o25so8684254wro.16
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 01:59:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qvzPrjknpHhvnClu+pyh7kfIagFIHhbvIfdKUMdjTJU=;
 b=IimqgVs2cjx9BPfxQN6pM/v+Xu6nmga2/cZQDvbeR9Ei9j+8YssNPnLxWa3msVKsag
 0l2fVbbi5vvGhMwyu+1TAv9lrdBjzMDHumD4J9H/l+uycBVfHKH0bRdc/2O3whpiyd3i
 VfO6a/aNmqKDLW2N+eeUVU8bAPOlEqKoSn4idDmjl+d+mjRaqNdacwvVXfx8J6iDYpA2
 x8XqzOSvtvVmzYZ+tGnuCqnhWXPFk7BXJuwuUtgBs5srJV6qPqU9iZ1q2eVHjtVExJSv
 RIBOn7Xk2C98uPBPSFaXz1y4D/IvNRj/IF15VyyFQst2PVBzL1zdn1syx5nQtYE0gIqT
 rZVA==
X-Gm-Message-State: AOAM530QG+osbteXz8c71Gk/d3h9Q7mmXMUkToy2iHA/nw6KVGqZvCAL
 VdtDC+Fr2TIgsvINg61OOZ/mCXjAVFITRfO2TuOnFIbVn0IYVvYMWXhg0Bwnty6rpQT8b+iYzv4
 BIts1dmtfcAUVrNo=
X-Received: by 2002:adf:f445:: with SMTP id f5mr9404556wrp.339.1592816395413; 
 Mon, 22 Jun 2020 01:59:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz2tp/8zBlUJ2WvQOpuU8+jKgHNmfs4tsHjNPhC7/gxRUJ9wWHLic6YLwsk7BVnFVidi2u+gg==
X-Received: by 2002:adf:f445:: with SMTP id f5mr9404534wrp.339.1592816395196; 
 Mon, 22 Jun 2020 01:59:55 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id o9sm16835964wrs.1.2020.06.22.01.59.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2020 01:59:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 4/8] tests/acceptance: add record/replay test for aarch64
Date: Mon, 22 Jun 2020 10:59:30 +0200
Message-Id: <20200622085934.16441-5-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200622085934.16441-1-philmd@redhat.com>
References: <20200622085934.16441-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 02:57:26
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
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>,
 Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>

This patch adds a test for record/replay of the kernel
image boot for aarch64 platform.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Tested-by: Philippe Mathieu-Daude <philmd@redhat.com>
Message-Id: <159073590231.20809.9842179251741585482.stgit@pasha-ThinkPad-X280>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 tests/acceptance/replay_kernel.py | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tests/acceptance/replay_kernel.py b/tests/acceptance/replay_kernel.py
index 64956e85f1..60559a13ad 100644
--- a/tests/acceptance/replay_kernel.py
+++ b/tests/acceptance/replay_kernel.py
@@ -89,3 +89,22 @@ def test_x86_64_pc(self):
         console_pattern = 'VFS: Cannot open root device'
 
         self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=5)
+
+    def test_aarch64_virt(self):
+        """
+        :avocado: tags=arch:aarch64
+        :avocado: tags=machine:virt
+        :avocado: tags=cpu:cortex-a53
+        """
+        kernel_url = ('https://archives.fedoraproject.org/pub/archive/fedora'
+                      '/linux/releases/29/Everything/aarch64/os/images/pxeboot'
+                      '/vmlinuz')
+        kernel_hash = '8c73e469fc6ea06a58dc83a628fc695b693b8493'
+        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
+
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               'console=ttyAMA0')
+        console_pattern = 'VFS: Cannot open root device'
+
+        self.run_rr(kernel_path, kernel_command_line, console_pattern,
+                    args=('-cpu', 'cortex-a53'))
-- 
2.21.3


