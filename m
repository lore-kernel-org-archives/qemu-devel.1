Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E04C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 09:06:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EB01206C1
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 09:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NtbIhYLI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EB01206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnIPN-0000Ww-QQ
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 05:06:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41270)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jnIJV-0001C9-1W
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 05:00:25 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39810
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jnIJS-00052D-Fa
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 05:00:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592816420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jrZpj4Py1xiLY1rtAnx0jkZgOQgy8t7vHtv5n/ekpGI=;
 b=NtbIhYLIcKg1gC1DHoQRscVE+sRax1JdwBKoEJl4qhiPkDcmIhQQz5+KXZajAWPsSoaass
 LrChC+aMBh1rQByYVSVy3oOP4HIUUb7MtJVJkH2Yb5hyV3H2AYPdIRambKyyjZAv10+bdQ
 v8ezOPHL/KV41BhMNysuC8Xb3XY983Y=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-19htHHhCNbaVmpKMSuuqiw-1; Mon, 22 Jun 2020 05:00:15 -0400
X-MC-Unique: 19htHHhCNbaVmpKMSuuqiw-1
Received: by mail-wr1-f70.google.com with SMTP id e7so10600579wrp.14
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 02:00:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jrZpj4Py1xiLY1rtAnx0jkZgOQgy8t7vHtv5n/ekpGI=;
 b=AJkDMjyef9Ai7N1iBnr01LRwF06w+8s0hxGdABCrVyrFKzGg97b8Uqmy3KuBGueFuA
 UBL8GHaoq+xKZ7w0LkKFrslBBQrMSuj30FOP9XseY0q/S4yRcz1lHMkdBHfnpqoUSDFA
 iRdUjMqNP+j672oPzLNTF2Q1VgWeNCA09i3oIrOIRojAclYKZqcqoRqI1k93bxmFtf1O
 E1pcIqPlsWWRUL1VPKKDafOe8uguEj8gMINYrmrIUmkodFsJ9CQuaMkaMsZHDSzsSNBa
 5kUM/oENZJqe5JKAreC/82rKhQbEO6lbGRAAX3LKPJyeEjSCl7m2dVU0eHu6e2YWoyrC
 RDYA==
X-Gm-Message-State: AOAM531Eewq3LAv0peuEp4fWNwc08i3eGw4blrimdv8SKtnqJWeCZ8iY
 uP8Bf5G8VsXRChYjitul97S4aRA9Yu0VT4W/VyTrkforywEE/w75ECF/07/Q2PtF5vjjnnOisVT
 v7ROMCLwktGjgfoM=
X-Received: by 2002:a1c:2402:: with SMTP id k2mr13254579wmk.138.1592816414090; 
 Mon, 22 Jun 2020 02:00:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx10XWHB101yUbLCFBmWf8v1FxiNXflTQJNkAI5Xov1hBBBnsl5c95DJiU4fAmptgXgMT/qKg==
X-Received: by 2002:a1c:2402:: with SMTP id k2mr13254562wmk.138.1592816413869; 
 Mon, 22 Jun 2020 02:00:13 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id w17sm17588115wra.42.2020.06.22.02.00.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2020 02:00:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 8/8] tests/acceptance: record/replay tests with advcal images
Date: Mon, 22 Jun 2020 10:59:34 +0200
Message-Id: <20200622085934.16441-9-philmd@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

This patch adds more record/replay tests with kernel images.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Tested-by: Philippe Mathieu-Daude <philmd@redhat.com>
Message-Id: <159073592589.20809.5156301499042635614.stgit@pasha-ThinkPad-X280>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
[PMD: Use os.path.join(), add avocado 'cpu' tags]
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 tests/acceptance/replay_kernel.py | 108 ++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/tests/acceptance/replay_kernel.py b/tests/acceptance/replay_kernel.py
index 8ef4e499b7..60621417dd 100644
--- a/tests/acceptance/replay_kernel.py
+++ b/tests/acceptance/replay_kernel.py
@@ -190,3 +190,111 @@ def test_m68k_q800(self):
                                'console=ttyS0 vga=off')
         console_pattern = 'No filesystem could mount root'
         self.run_rr(kernel_path, kernel_command_line, console_pattern)
+
+    def do_test_advcal_2018(self, file_path, kernel_name, args=None):
+        archive.extract(file_path, self.workdir)
+
+        for entry in os.scandir(self.workdir):
+            if entry.name.startswith('day') and entry.is_dir():
+                kernel_path = os.path.join(entry.path, kernel_name)
+                break
+
+        kernel_command_line = ''
+        console_pattern = 'QEMU advent calendar'
+        self.run_rr(kernel_path, kernel_command_line, console_pattern,
+                    args=args)
+
+    def test_arm_vexpressa9(self):
+        """
+        :avocado: tags=arch:arm
+        :avocado: tags=machine:vexpress-a9
+        """
+        tar_hash = '32b7677ce8b6f1471fb0059865f451169934245b'
+        tar_url = ('https://www.qemu-advent-calendar.org'
+                   '/2018/download/day16.tar.xz')
+        file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
+        dtb_path = self.workdir + '/day16/vexpress-v2p-ca9.dtb'
+        self.do_test_advcal_2018(file_path, 'winter.zImage',
+                                 args=('-dtb', dtb_path))
+
+    def test_m68k_mcf5208evb(self):
+        """
+        :avocado: tags=arch:m68k
+        :avocado: tags=machine:mcf5208evb
+        """
+        tar_hash = 'ac688fd00561a2b6ce1359f9ff6aa2b98c9a570c'
+        tar_url = ('https://www.qemu-advent-calendar.org'
+                   '/2018/download/day07.tar.xz')
+        file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
+        self.do_test_advcal_2018(file_path, 'sanity-clause.elf')
+
+    def test_microblaze_s3adsp1800(self):
+        """
+        :avocado: tags=arch:microblaze
+        :avocado: tags=machine:petalogix-s3adsp1800
+        """
+        tar_hash = '08bf3e3bfb6b6c7ce1e54ab65d54e189f2caf13f'
+        tar_url = ('https://www.qemu-advent-calendar.org'
+                   '/2018/download/day17.tar.xz')
+        file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
+        self.do_test_advcal_2018(file_path, 'ballerina.bin')
+
+    def test_ppc64_e500(self):
+        """
+        :avocado: tags=arch:ppc64
+        :avocado: tags=machine:ppce500
+        :avocado: tags=cpu:e5500
+        """
+        tar_hash = '6951d86d644b302898da2fd701739c9406527fe1'
+        tar_url = ('https://www.qemu-advent-calendar.org'
+                   '/2018/download/day19.tar.xz')
+        file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
+        self.do_test_advcal_2018(file_path, 'uImage', ('-cpu', 'e5500'))
+
+    def test_ppc_g3beige(self):
+        """
+        :avocado: tags=arch:ppc
+        :avocado: tags=machine:g3beige
+        """
+        tar_hash = 'e0b872a5eb8fdc5bed19bd43ffe863900ebcedfc'
+        tar_url = ('https://www.qemu-advent-calendar.org'
+                   '/2018/download/day15.tar.xz')
+        file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
+        self.do_test_advcal_2018(file_path, 'invaders.elf',
+                                 args=('-M', 'graphics=off'))
+
+    def test_ppc_mac99(self):
+        """
+        :avocado: tags=arch:ppc
+        :avocado: tags=machine:mac99
+        """
+        tar_hash = 'e0b872a5eb8fdc5bed19bd43ffe863900ebcedfc'
+        tar_url = ('https://www.qemu-advent-calendar.org'
+                   '/2018/download/day15.tar.xz')
+        file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
+        self.do_test_advcal_2018(file_path, 'invaders.elf',
+                                 args=('-M', 'graphics=off'))
+
+    def test_sparc_ss20(self):
+        """
+        :avocado: tags=arch:sparc
+        :avocado: tags=machine:SS-20
+        """
+        tar_hash = 'b18550d5d61c7615d989a06edace051017726a9f'
+        tar_url = ('https://www.qemu-advent-calendar.org'
+                   '/2018/download/day11.tar.xz')
+        file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
+        self.do_test_advcal_2018(file_path, 'zImage.elf')
+
+    def test_xtensa_lx60(self):
+        """
+        :avocado: tags=arch:xtensa
+        :avocado: tags=machine:lx60
+        :avocado: tags=cpu:dc233c
+        """
+        tar_hash = '49e88d9933742f0164b60839886c9739cb7a0d34'
+        tar_url = ('https://www.qemu-advent-calendar.org'
+                   '/2018/download/day02.tar.xz')
+        file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
+        self.do_test_advcal_2018(file_path, 'santas-sleigh-ride.elf',
+                                 args=('-cpu', 'dc233c'))
-- 
2.21.3


