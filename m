Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84AF0C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 13:08:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C43D23888
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 13:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="dqt8K2jB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C43D23888
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJG7L-0003pv-Fi
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 09:07:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40286)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@citrix.com>)
 id 1kJG5G-0002XW-AS
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 09:05:50 -0400
Received: from esa3.hc3370-68.iphmx.com ([216.71.145.155]:35902)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@citrix.com>)
 id 1kJG5D-0007u5-W7
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 09:05:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1600434348;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=BoGDFpFFYUpaaA9V9Ooztf+Q0Oxwk9qidQhm4hl0oUo=;
 b=dqt8K2jB5mgmNNThFx3mHlkttaoFNHYB+/s7++g/+wF9Dh7JH0ZtCRxX
 MI5c+IJ6a8eNHIPY2waiaPfQWPgNY/R0rt/iIpQTJ/u3e+M5ySquDj4it
 G/c4chx0/9O/a/C0jV/Xs7+A+HLmJheLNlA6VXbeUB/5cQSaXTZio2eeG 8=;
Authentication-Results: esa3.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none
IronPort-SDR: gLSSquyV0jzY8+nFH93+9dmZjBGO0WJzkufAg8J34+5fcvTERGFTBLPFJ6/JFhOytEsL1sH9B4
 +QMdPaJdrnWEk+INzM4dSme8PTC+1slSKhZIim+BhoNCw02mLfGcDPZLNftJh0iNaZoYJ6Rkh9
 19IaUpoawlw0noMIBqg3LzmqyQubMaLDuHIpqitICVDMzNj3Vs0uS5L3hipUeX/ij4WnSirYle
 4UGwQ00Mmtd2vr0CAR/A4MpN8s09z+cAP+0/buxpnY4Fq1PN9gopxEB0OS+Lynv7x9smQQ3a+s
 eEk=
X-SBRS: 2.7
X-MesageID: 26995297
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.77,274,1596513600"; d="scan'208";a="26995297"
To: <qemu-devel@nongnu.org>
CC: Paolo Bonzini <pbonzini@redhat.com>, Anthony PERARD
 <anthony.perard@citrix.com>
Subject: [PATCH] meson: fix installation of keymaps
Date: Fri, 18 Sep 2020 14:03:54 +0100
Message-ID: <20200918130354.1879275-1-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=216.71.145.155;
 envelope-from=anthony.perard@citrix.com; helo=esa3.hc3370-68.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 09:05:42
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: Anthony PERARD <anthony.perard@citrix.com>
From: Anthony PERARD via <qemu-devel@nongnu.org>

Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>

---
I don't know much about meson, but without "install:true" to the
custom_target(), the keymaps files doen't get install when running
`make install`. Only the files "sl" and "sv" are installed.
So "install:true" seems necessary here.

I've tried both with and without `qemu-keymap` (or xkbcommon).
---
 pc-bios/keymaps/meson.build | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/pc-bios/keymaps/meson.build b/pc-bios/keymaps/meson.build
index 2e2e0dfa3b79..05eda6c0d26d 100644
--- a/pc-bios/keymaps/meson.build
+++ b/pc-bios/keymaps/meson.build
@@ -47,6 +47,7 @@ foreach km, args: keymaps
                        build_by_default: true,
                        output: km,
                        command: [native_qemu_keymap, '-f', '@OUTPUT@', args.split()],
+                       install: true,
                        install_dir: qemu_datadir / 'keymaps')
   else
     # copy from source tree
@@ -55,6 +56,7 @@ foreach km, args: keymaps
                        input: km,
                        output: km,
                        command: ['cp', '@INPUT@', '@OUTPUT@'],
+                       install: true,
                        install_dir: qemu_datadir / 'keymaps')
   endif
 endforeach
-- 
Anthony PERARD


