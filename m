Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76569C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 09:43:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FC0C2076B
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 09:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=lse.epita.fr header.i=@lse.epita.fr header.b="Xlvk/cTH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FC0C2076B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lse.epita.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5nIX-0003V1-Dq
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 05:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <srs0=nna4=bw=lse.epita.fr=cesar.belley@cri.epita.fr>)
 id 1k5nHS-00022d-EK
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 05:42:46 -0400
Received: from gate-2.cri.epita.net ([163.5.55.20]:40864
 helo=mail-2.srv.cri.epita.fr)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <srs0=nna4=bw=lse.epita.fr=cesar.belley@cri.epita.fr>)
 id 1k5nHQ-0006kH-BE
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 05:42:46 -0400
Received: from MattGorko-Laptop.localdomain (unknown [78.194.154.81])
 (Authenticated sender: cesar.belley)
 by mail-2.srv.cri.epita.fr (Postfix) with ESMTPSA id 2C5DB4150B;
 Wed, 12 Aug 2020 11:42:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lse.epita.fr; s=cri;
 t=1597225363; bh=mXjkHDuBA2Pelp7FvLqsvotpGAVI+Oj+eqQ5xB79ZVs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Xlvk/cTHYNzxQP3ZauXx6odIb4WJK1dEADQYWb2ITyIx/IFc5D4ykBSfsvlDiCVW9
 oVwhyNA36YMPx2C6hP5DgyD+zt+vB34o89QnPUByTIbKC3D7etpB+CFRN14WQVb5td
 7T3XiDtAgCBFcqD984xK7idOaQiEco/ZlRiXWWT8=
From: =?UTF-8?q?C=C3=A9sar=20Belley?= <cesar.belley@lse.epita.fr>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/13] docs: Add USB U2F key device documentation
Date: Wed, 12 Aug 2020 11:41:24 +0200
Message-Id: <20200812094135.20550-3-cesar.belley@lse.epita.fr>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200812094135.20550-1-cesar.belley@lse.epita.fr>
References: <20200812094135.20550-1-cesar.belley@lse.epita.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=163.5.55.20;
 envelope-from=srs0=nna4=bw=lse.epita.fr=cesar.belley@cri.epita.fr;
 helo=mail-2.srv.cri.epita.fr
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 05:42:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: =?UTF-8?q?C=C3=A9sar=20Belley?= <cesar.belley@lse.epita.fr>,
 kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add USB U2F key device documentation:
- USB U2F key device
- Building
- Using u2f-emulated
- Using u2f-passthru
- Libu2f-emu

Signed-off-by: César Belley <cesar.belley@lse.epita.fr>
---
 docs/u2f.txt | 101 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)
 create mode 100644 docs/u2f.txt

diff --git a/docs/u2f.txt b/docs/u2f.txt
new file mode 100644
index 0000000000..f60052882e
--- /dev/null
+++ b/docs/u2f.txt
@@ -0,0 +1,101 @@
+QEMU U2F Key Device Documentation.
+
+Contents
+1. USB U2F key device
+2. Building
+3. Using u2f-emulated
+4. Using u2f-passthru
+5. Libu2f-emu
+
+1. USB U2F key device
+
+U2F is an open authentication standard that enables relying parties
+exposed to the internet to offer a strong second factor option for end
+user authentication.
+
+The standard brings many advantages to both parties, client and server,
+allowing to reduce over-reliance on passwords, it increases authentication
+security and simplifies passwords.
+
+The second factor is materialized by a device implementing the U2F
+protocol. In case of a USB U2F security key, it is a USB HID device
+that implements the U2F protocol.
+
+In Qemu, the USB U2F key device offers a dedicated support of U2F, allowing
+guest USB FIDO/U2F security keys operating in two possible modes:
+pass-through and emulated.
+
+The pass-through mode consists of passing all requests made from the guest
+to the physical security key connected to the host machine and vice versa.
+In addition, the dedicated pass-through allows to have a U2F security key
+shared on several guests which is not possible with a simple host device
+assignment pass-through.
+
+The emulated mode consists of completely emulating the behavior of an
+U2F device through software part. Libu2f-emu is used for that.
+
+
+2. Building
+
+To ensure the build of the u2f-emulated device variant which depends
+on libu2f-emu: configuring and building:
+
+    ./configure --enable-u2f && make
+
+
+3. Using u2f-emulated
+
+To work, an emulated U2F device must have four elements:
+ * ec x509 certificate
+ * ec private key
+ * counter (four bytes value)
+ * 48 bytes of entropy (random bits)
+
+To use this type of device, this one has to be configured, and these
+four elements must be passed one way or another.
+
+Assuming that you have a working libu2f-emu installed on the host.
+There are three possible ways of configurations:
+ * ephemeral
+ * setup directory
+ * manual
+
+Ephemeral is the simplest way to configure, it lets the device generate
+all the elements it needs for a single use of the lifetime of the device.
+
+    qemu -usb -device u2f-emulated
+
+Setup directory allows to configure the device from a directory containing
+four files:
+ * certificate.pem: ec x509 certificate
+ * private-key.pem: ec private key
+ * counter: counter value
+ * entropy: 48 bytes of entropy
+
+    qemu -usb -device u2f-emulated,dir=$dir
+
+Manual allows to configure the device more finely by specifying each
+of the elements necessary for the device:
+ * cert
+ * priv
+ * counter
+ * entropy
+
+    qemu -usb -device u2f-emulated,cert=$DIR1/$FILE1,priv=$DIR2/$FILE2,counter=$DIR3/$FILE3,entropy=$DIR4/$FILE4
+
+
+4. Using u2f-passthru
+
+On the host specify the u2f-passthru device with a suitable hidraw:
+
+    qemu -usb -device u2f-passthru,hidraw=/dev/hidraw0
+
+
+5. Libu2f-emu
+
+The u2f-emulated device uses libu2f-emu for the U2F key emulation. Libu2f-emu
+implements completely the U2F protocol device part for all specified
+transport given by the FIDO Alliance.
+
+For more information about libu2f-emu see this page:
+https://github.com/MattGorko/libu2f-emu.
-- 
2.28.0


