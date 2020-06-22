Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF89EC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 09:05:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AF68206E2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 09:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C9K7uvKR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AF68206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnIO4-0006bD-KV
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 05:05:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41186)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jnIJL-00012B-Ma
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 05:00:16 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56274
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jnIJJ-00050V-R2
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 05:00:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592816412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FTqbMuxpMcu2/xrwj2RQe3qWONh3lSFOLVKC3PN0oxk=;
 b=C9K7uvKRD83DxMQSQjSvAQ83TH+D1k8tf8ZfBY6O0s42hbGkKaiCJIXT7dvb5pyDKqWYnp
 EKX5BLmcgNXLpkT8SkXs4iVdvUbZEuvvRTxQkB9hlNWw+tDp3FnIibksN3df1hVzlQOPD6
 sXLcVneHMKYUOWTViHc8pavxPtPa9Wg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-suHbC7ajMQquBOiUp-mwrQ-1; Mon, 22 Jun 2020 05:00:11 -0400
X-MC-Unique: suHbC7ajMQquBOiUp-mwrQ-1
Received: by mail-wm1-f69.google.com with SMTP id t127so7205488wmg.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 02:00:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FTqbMuxpMcu2/xrwj2RQe3qWONh3lSFOLVKC3PN0oxk=;
 b=atJ5Xgq1C/2/6LXrDUJRT9YEz0dJWUFKuGxk7ksOPoCmFFotfC+CsBHtx0L9qHq4qs
 +D0jPe7sXqs84NgtRSMZ0TooenSTU1UdS+c5OcNh1gY7xOHXAXsOFGjeScl7o3HP7cNK
 0kLR+GH1uXLkAgucGtsGbbJLPat/Dgb0i/dzn3bPp+Rmi4Jcqfgz/0HWDKjFJIE1T8+X
 SJGK0Ck9Ghgw9ehMUkI00t3oOi+fHoNhYKbLDjwB9fFA1biJgmOb5MwdvNIdgw55nR9v
 8wU5gkKfoob+hoqtPGA4zN0sFFi6Q/DE2Zv3jT4Yn1ejc0m1JftNf4llbupe6n6s/fGR
 9pIA==
X-Gm-Message-State: AOAM531pyloYKo+cn1beAAzQ9nWVk4ina7QlYZbHZ5seVg+AWfd+zho6
 uFQtCMRuGhUqbnvypT5VC5kHGxbTjhJ5nXxWlvwY+P6dBEvjcY/KAZCoH23WUNv4MRWKsa4zVg7
 IZ1GVNkyQQCtYIwI=
X-Received: by 2002:a5d:4d4d:: with SMTP id a13mr18358040wru.252.1592816409399; 
 Mon, 22 Jun 2020 02:00:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz7Kt6t21MeHhquzrDBNBvtgdHpC+xdfQBX+lBKRXpKSrfNcQhIt3BwGBL4DcDXfhUgfK1DIw==
X-Received: by 2002:a5d:4d4d:: with SMTP id a13mr18358019wru.252.1592816409209; 
 Mon, 22 Jun 2020 02:00:09 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id y16sm17232343wro.71.2020.06.22.02.00.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2020 02:00:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 7/8] tests/acceptance: add record/replay test for m68k
Date: Mon, 22 Jun 2020 10:59:33 +0200
Message-Id: <20200622085934.16441-8-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200622085934.16441-1-philmd@redhat.com>
References: <20200622085934.16441-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 02:57:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Laurent Vivier <laurent@vivier.eu>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>,
 Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>

This patch adds a test for record/replay of the kernel
image boot for m68k platform.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Tested-by: Philippe Mathieu-Daude <philmd@redhat.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <159073592033.20809.1838967871297177313.stgit@pasha-ThinkPad-X280>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 tests/acceptance/replay_kernel.py | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tests/acceptance/replay_kernel.py b/tests/acceptance/replay_kernel.py
index b7acc4bc71..8ef4e499b7 100644
--- a/tests/acceptance/replay_kernel.py
+++ b/tests/acceptance/replay_kernel.py
@@ -172,3 +172,21 @@ def test_ppc64_pseries(self):
         # icount is not good enough for PPC64 for complete boot yet
         console_pattern = 'Kernel command line: %s' % kernel_command_line
         self.run_rr(kernel_path, kernel_command_line, console_pattern)
+
+    def test_m68k_q800(self):
+        """
+        :avocado: tags=arch:m68k
+        :avocado: tags=machine:q800
+        """
+        deb_url = ('https://snapshot.debian.org/archive/debian-ports'
+                   '/20191021T083923Z/pool-m68k/main'
+                   '/l/linux/kernel-image-5.3.0-1-m68k-di_5.3.7-1_m68k.udeb')
+        deb_hash = '044954bb9be4160a3ce81f8bc1b5e856b75cccd1'
+        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
+        kernel_path = self.extract_from_deb(deb_path,
+                                            '/boot/vmlinux-5.3.0-1-m68k')
+
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               'console=ttyS0 vga=off')
+        console_pattern = 'No filesystem could mount root'
+        self.run_rr(kernel_path, kernel_command_line, console_pattern)
-- 
2.21.3


