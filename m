Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB25C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:15:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C0912173E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iE9TqK8c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C0912173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwWKF-0003u2-PG
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 14:15:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38510)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV8c-0005Dq-DG
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:59:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV8b-0001hB-6Y
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:58:58 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:46963)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV8a-0001dX-Vu
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:58:57 -0500
Received: by mail-wr1-x436.google.com with SMTP id z7so17075084wrl.13
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QYcbKtTOWQN6tscZ8svzCC0zSc5UmbArTLbSRd+xFGU=;
 b=iE9TqK8cf/q6v978gXwjZ9B4xjEK4MeAUKB4A9KTZpWUDb5lZwb/04xRoWpSCjIjpM
 VE7SBUhtioqo7munW5F76nFFmCZMO3mxO6jpyejttgULEEJ8wpnk3F/ej7tosXcZvnpD
 Sf3ostpSj/Xboc/SIUpOTXqrxS0jnLo9/WZXxlfVw06l5Ca6JNhwK8RKU/IvHGMr5ssg
 Kh3n3PPXkM8f3yb0zDSms4fU5A0sZCzIGPdYcv6JkvBFqyFwKll4PJ4GOXcl/vms8KFJ
 5Xbo+a2mZSHD3S3vbe1DC1oAyv2pznQvQmNVIBRUjCadrmil9nkg1sCT6vV4bRl6AIMz
 NOvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=QYcbKtTOWQN6tscZ8svzCC0zSc5UmbArTLbSRd+xFGU=;
 b=p3R7RD7PPkS7Ksraosmlp8dH+B+yj1RdN0ngL9ICA6LXW+1T4wWnFdYtxqVJPl7LmS
 0GCEsvEgGh42uJOdvvJSTMUriSujDi6yQk8GaeNQ8MUixg1XBRTyrGYed+rc7ug2x9J2
 do+Gvrd6s3NJbIU7ag+/WqEBTCXo+m2mF7iK3+/jXZ8yE3s6rgVYm/W7+pWWtpbx40sN
 DuUp2AzFkcZoZ3770FKA8duFkWJQFRgQHkEnhTrsNc8O7S5+l5qXGVEtZ3IddGOwvN+Y
 MRN9OCVHZczSVEEo0rtsIWKGAMdN8zEEuIlVqIGckAb+Q6fmieBvY/zEO9ujaoKvYs5I
 4hGg==
X-Gm-Message-State: APjAAAXGGWX9zoHDXTPezMOJP7eWW+KvxqAHbrg442Ju3YHBEamPshN0
 bQuFJssVD8aIpydpJac/9rvTG9OL
X-Google-Smtp-Source: APXvYqwBceKs59FNuDaKjbJQOE1BarDDJTLTBvOtoHF/SmE6qoGvRvhRLvuGQpxYwNZ8iRuGf7dZCA==
X-Received: by 2002:a5d:4dc9:: with SMTP id f9mr29910281wru.297.1580234335736; 
 Tue, 28 Jan 2020 09:58:55 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.58.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:58:55 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 130/142] meson: install edk2 json descriptors
Date: Tue, 28 Jan 2020 18:53:30 +0100
Message-Id: <20200128175342.9066-131-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
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
---
 Makefile                        | 17 -----------------
 pc-bios/descriptors/meson.build | 14 ++++++++++++++
 pc-bios/meson.build             |  2 ++
 3 files changed, 16 insertions(+), 17 deletions(-)
 create mode 100644 pc-bios/descriptors/meson.build

diff --git a/Makefile b/Makefile
index af635a3939..11e87a0c77 100644
--- a/Makefile
+++ b/Makefile
@@ -219,13 +219,6 @@ ar      de     en-us  fi  fr-be  hr     it  lv  nl         pl  ru     th \
 de-ch  es     fo  fr-ca  hu     ja  mk  pt  sl     tr \
 bepo    cz
 
-ifdef INSTALL_BLOBS
-DESCS=50-edk2-i386-secure.json 50-edk2-x86_64-secure.json \
-60-edk2-aarch64.json 60-edk2-arm.json 60-edk2-i386.json 60-edk2-x86_64.json
-else
-DESCS=
-endif
-
 install-datadir:
 	$(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)"
 
@@ -239,16 +232,6 @@ endif
 ICON_SIZES=16x16 24x24 32x32 48x48 64x64 128x128 256x256 512x512
 
 install: all install-datadir install-localstatedir
-ifneq ($(DESCS),)
-	$(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)/firmware"
-	set -e; tmpf=$$(mktemp); trap 'rm -f -- "$$tmpf"' EXIT; \
-	for x in $(DESCS); do \
-		sed -e 's,@DATADIR@,$(qemu_datadir),' \
-			"$(SRC_PATH)/pc-bios/descriptors/$$x" > "$$tmpf"; \
-		$(INSTALL_DATA) "$$tmpf" \
-			"$(DESTDIR)$(qemu_datadir)/firmware/$$x"; \
-	done
-endif
 	for s in $(ICON_SIZES); do \
 		mkdir -p "$(DESTDIR)$(qemu_icondir)/hicolor/$${s}/apps"; \
 		$(INSTALL_DATA) $(SRC_PATH)/ui/icons/qemu_$${s}.png \
diff --git a/pc-bios/descriptors/meson.build b/pc-bios/descriptors/meson.build
new file mode 100644
index 0000000000..7c715bace8
--- /dev/null
+++ b/pc-bios/descriptors/meson.build
@@ -0,0 +1,14 @@
+foreach f: [
+  '50-edk2-i386-secure.json',
+  '50-edk2-x86_64-secure.json',
+  '60-edk2-aarch64.json',
+  '60-edk2-arm.json',
+  '60-edk2-i386.json',
+  '60-edk2-x86_64.json'
+]
+  configure_file(input: files(f),
+                 output: f,
+                 configuration: {'DATADIR': config_host['qemu_datadir']},
+                 install: install_blobs,
+                 install_dir: config_host['qemu_datadir'] / 'firmware')
+endforeach
diff --git a/pc-bios/meson.build b/pc-bios/meson.build
index 6988c81f51..e53a7ae521 100644
--- a/pc-bios/meson.build
+++ b/pc-bios/meson.build
@@ -25,6 +25,8 @@ if 'DECOMPRESS_EDK2_BLOBS' in config_host
   endforeach
 endif
 
+subdir('descriptors')
+
 blobs = files(
   'QEMU,cgthree.bin',
   'QEMU,tcx.bin',
-- 
2.21.0



