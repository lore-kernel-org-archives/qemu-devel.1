Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF5EC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 09:33:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DC9A2063A
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 09:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e2Y6KCwD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DC9A2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k54B8-0002h4-DO
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 05:33:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5491-0000Ey-9u
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 05:31:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38904
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k548z-0000yU-FO
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 05:31:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597051860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AaJDzZzoIVwte++3uI2bRaDB/yIzXgFAP3xm+L9aVQg=;
 b=e2Y6KCwD5hTQnO1YLs26Sw0J8HO1uXQJiZlcj5/i61yuDIxNvX/BsFhf677Fc3+SptxGy8
 qXqpv4H3q3YM3Bc486R7ou1HOMJ7iLJilFIXLkgSJtf7hsvXRMdY6jYc7+U9DgIE2Z+ZWI
 z6CMuYf5ZpkWY+JNEoA7A0BYTy+5qRA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-WUJV0E0lMby5VirOuvt0ZQ-1; Mon, 10 Aug 2020 05:30:58 -0400
X-MC-Unique: WUJV0E0lMby5VirOuvt0ZQ-1
Received: by mail-wr1-f69.google.com with SMTP id z1so3970068wrn.18
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 02:30:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AaJDzZzoIVwte++3uI2bRaDB/yIzXgFAP3xm+L9aVQg=;
 b=A7F3WtooCwdN9fwyEG2ziglrxXw6EFfH8JxTapO3UXNj7b0jyc1B51MZwblrwXrX9F
 Vvrw0szUP0FAJMmfIT1n6aMBcoCBDQVC8pVgD38dE9IGi9HHlWr08bANgaBPYXU5fbil
 CSFRbPyyKdKObLkq4ExXqC3AqIZ5H5oKOzQN4QS3Oro0rzJwD2+/HhugeJVf1YyC9jfZ
 G2HtX2b1fK1QVYpTfssFWlYq3QBDCNL6Gg5uFlPgqKSbP+96r/7R78PD2pIqxmVmliw/
 An3YY3yJ6xpIxgIVSG0UznSVXhVyM9NiVApVvsS9Vg7ML6Sk8NKtYPFtgf/jQR96Hybe
 5RbA==
X-Gm-Message-State: AOAM533MCMYqtVYORcPWJVes7AZRDonAYBwFD9iC4j5h4rBqyVMl1h4B
 F5wZIYFIsNpNg6pXpm+pSuzMqdlfgTokw/mwGIWxGfasLjBtoP99x3Nw/JFOZLXUVpJ+GUW0Dgg
 WFp+HymqNWBu5DPo=
X-Received: by 2002:a5d:550e:: with SMTP id b14mr25368856wrv.392.1597051857771; 
 Mon, 10 Aug 2020 02:30:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJyegALW59UyQxxoX+oysjctzX8y4kOtqpznyxpATh+2QA2zuntqR2TsJ+9FHgY8vKZuq7TQ==
X-Received: by 2002:a5d:550e:: with SMTP id b14mr25368841wrv.392.1597051857590; 
 Mon, 10 Aug 2020 02:30:57 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id 130sm20173989wme.26.2020.08.10.02.30.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2020 02:30:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] tests/acceptance/boot_linux: Extract common URL from
 xlnx-versal test
Date: Mon, 10 Aug 2020 11:30:49 +0200
Message-Id: <20200810093050.28744-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200810093050.28744-1-philmd@redhat.com>
References: <20200810093050.28744-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 03:31:01
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


