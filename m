Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70CCC2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:35:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FA84207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gzT9igiI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FA84207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwVi9-0004Tn-LJ
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:35:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60550)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV5Z-0000Sv-Ks
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV5X-0002pl-Cr
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:49 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:39943)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV5X-0002o6-62
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:47 -0500
Received: by mail-wr1-x42c.google.com with SMTP id j104so1197302wrj.7
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=V06jb0oNvKodZSVl3PYzNlA6Bxf6AgWYz/eG3NgAVIA=;
 b=gzT9igiIz0kvCoWK1JfRgU/LYwz+ZAW+5yg7Wm65s3WlM4hhx4AcZl+1oVkd8gVMhZ
 ayh0oeID+FIuqo6l3ujRs9KFboLXXVkoBpUeIZUxIMPc0LJl9RDXjpA/MB5MdxzL6FWs
 f07TVRpWtllTSvuFs+zKSIRhBA0Ez+d5B272MYsqcXK92aaJolXjspgwpnfmTM5ad8fz
 q2fE8YurFkAaVd1d/c3ZYXzs9KIZLcX8/4PBzfwB4Nz/OGxakyzYhGlvgndPhti71cF5
 TVj0/+CMZqrQRpP2ryrReJg7sQ3AJ5MmfHK7WpV6SZi//cakMLlqrQhFHZgNTa0yEIfG
 a6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=V06jb0oNvKodZSVl3PYzNlA6Bxf6AgWYz/eG3NgAVIA=;
 b=JVx5mmegigzyLy7JGRfK4jSdGdvd7ZSXtQUMqPVQUt7QPBUwDU+95Pk5h53ZW9pVVY
 wPNpf2M9irlFQHcpJgElVbnF6b+YDUQ21rvkGMdBwP9UmZxGXPq50z7SxBHN8frN6rFm
 B3TN1vEvpf9LIke7QVeZbrz0lIN4Xt4wahYUvMzrDlEOs8+vBUeU1q0uE94mvsjSkUth
 8qJTXw/g2E/QdpWP+T+/un2ZXocK05zWtimyMTQHDfq3MQHet7AeaNspEPTadXV+LTzp
 nR/bw414ZZPtGR+ZR7Phd2VliuxtcRtTp2L1FOrR1pxPeVPzW90ZodbwQYb9SmbjRBXt
 i+eg==
X-Gm-Message-State: APjAAAXZiEDKhf3rTehzCRQa5GwvdChqhong3sI1sSoq2Ruhjs3cBqUu
 eRAhp2rNH2RIz4t4u9bQeLPOKgYc
X-Google-Smtp-Source: APXvYqzMW6mrJ63k1oBINcQJJAwpcplIp22KtX+kV1X76nqPWFbq7ozB1mBL0WP/YdeSubzmREC+vw==
X-Received: by 2002:a5d:678e:: with SMTP id v14mr1650111wru.101.1580234146039; 
 Tue, 28 Jan 2020 09:55:46 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.55.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:55:45 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 049/142] meson: qemu-{img,io,nbd}
Date: Tue, 28 Jan 2020 18:52:09 +0100
Message-Id: <20200128175342.9066-50-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile    |  6 ------
 configure   |  6 ------
 meson.build | 11 ++++++++++-
 3 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/Makefile b/Makefile
index 292d2e46f3..a9454f6ff1 100644
--- a/Makefile
+++ b/Makefile
@@ -257,12 +257,6 @@ Makefile: $(version-obj-y)
 
 COMMON_LDADDS = libqemuutil.a
 
-qemu-img.o: qemu-img-cmds.h
-
-qemu-img$(EXESUF): qemu-img.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
-qemu-nbd$(EXESUF): qemu-nbd.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
-qemu-io$(EXESUF): qemu-io.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
-
 scsi/qemu-pr-helper$(EXESUF): scsi/qemu-pr-helper.o scsi/utils.o $(authz-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
 ifdef CONFIG_MPATH
 scsi/qemu-pr-helper$(EXESUF): LIBS += -ludev -lmultipath -lmpathpersist
diff --git a/configure b/configure
index a475268ed0..6fbc9e0ad8 100755
--- a/configure
+++ b/configure
@@ -6204,12 +6204,6 @@ if [ "$eventfd" = "yes" ]; then
 fi
 
 tools=""
-if test "$want_tools" = "yes" ; then
-  tools="qemu-img\$(EXESUF) qemu-io\$(EXESUF) $tools"
-  if [ "$linux" = "yes" -o "$bsd" = "yes" -o "$solaris" = "yes" ] ; then
-    tools="qemu-nbd\$(EXESUF) $tools"
-  fi
-fi
 if test "$softmmu" = yes ; then
   if test "$linux" = yes; then
     if test "$virtfs" != no && test "$cap_ng" = yes && test "$attr" = yes ; then
diff --git a/meson.build b/meson.build
index 7ea4413f9d..215c123a1f 100644
--- a/meson.build
+++ b/meson.build
@@ -294,7 +294,7 @@ if have_system
   ]
 endif
 foreach d : hx_headers
-  custom_target(d[1],
+  hxdep += custom_target(d[1],
                 input: files(d[0]),
                 output: d[1],
                 capture: true,
@@ -587,6 +587,15 @@ if 'CONFIG_GUEST_AGENT' in config_host
 endif
 
 if have_tools
+  qemu_img = executable('qemu-img', [files('qemu-img.c'), hxdep],
+             dependencies: [authz, block, crypto, io, qom, qemuutil], install: true)
+  if host_machine.system() == 'linux' or host_machine.system() == 'sunos' or host_machine.system().endswith('bsd')
+    qemu_nbd = executable('qemu-nbd', files('qemu-nbd.c'),
+               dependencies: [authz, block, crypto, io, qom, qemuutil], install: true)
+  endif
+  qemu_io = executable('qemu-io', files('qemu-io.c'),
+             dependencies: [authz, block, crypto, io, qom, qemuutil], install: true)
+
   subdir('contrib/rdmacm-mux')
   subdir('contrib/elf2dmp')
 
-- 
2.21.0



