Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2FFC34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 14:31:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAE3F208C4
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 14:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NXr4TWMJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAE3F208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j43ug-0004Yr-2p
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 09:31:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55513)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j43jh-0007Y0-Fk
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:20:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j43jg-0007fz-9G
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:20:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51505
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j43jg-0007fR-4W
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:20:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582035627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gOoP8VRND0jE6HGodG2Np7TGVAtqn30AOrgnhHcwDKc=;
 b=NXr4TWMJrO8hFgRRV3DxC4jQf19dZzkfCD/uV3AlJSMgZ+zsrb70czUg9L1KDSujFLdu86
 j8dYlIJy83XbykobIncriEvkay4cAYBTfJy79hMukJUr8+zNnN8ZedJJdMbMrTYunx8YgI
 DsQTj1eVMSo+05YIB0LDpCGOO6kj8s4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-VuKtf0wvNoO3l2jpKYPjRg-1; Tue, 18 Feb 2020 09:20:25 -0500
Received: by mail-wr1-f72.google.com with SMTP id d8so10832507wrq.12
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 06:20:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Kq+GM31M5XuX6yXAuJKuOmf7Fr5o9Y+CePmE0Wk7alg=;
 b=iO6MLp+gr6l8q1bEM0kc19kUZ7M/xV1+nawuD6FubeDQLzIbIYP8FJtBHyQKV/VXI8
 CtcPcqBEg6AEnfk/5E1QkrEAEjw7JSD5Yv9nuvPY7Szyhzecrp/3uVliMV1Ue2g2dcwv
 MgyW5CJY+Rlp7mql4er5YRvWrxBFIkJCDMOqXyq+4A/EA13rXYO5uhCTkq4mDx5RYDXz
 Am9sxnU9ipA6eDus2Z6SEsJLsTurJTU9O/CXfh4ZVvrmHWcaijYQN3Zgf4rg9pkQ6zTd
 4ri6bvzsfWgnsLX4TWc32iD3b17UKm/Y7f2O22eLC7+nSADTHoJhkvSoLNhl3T2NomZC
 4jJA==
X-Gm-Message-State: APjAAAX0EPWHSV6JVvKtyeZpaRwOiiBnbGn7FSZ5BvcdU/QN/n/WOiRf
 xQ7dMsaNIlDhs6YbtcERqmRMftEJSSZa5bEuhMthonScaOEq4dEDY/618tQqAPckpNzRV6Tu/dI
 GurAA5kumRLtOugw=
X-Received: by 2002:a5d:6a88:: with SMTP id s8mr29144281wru.173.1582035624130; 
 Tue, 18 Feb 2020 06:20:24 -0800 (PST)
X-Google-Smtp-Source: APXvYqxeYSNjpg8UL/4G1D0CbJ1dlMclLpxDvDVj0OwEHqsJp+Otfkzqq+ZtAUpXhR4AP+pNviJkxw==
X-Received: by 2002:a5d:6a88:: with SMTP id s8mr29144264wru.173.1582035623925; 
 Tue, 18 Feb 2020 06:20:23 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id l6sm3775204wmg.42.2020.02.18.06.20.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2020 06:20:23 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND 3/3] .travis.yml: Test building with Xcode 11.3
Date: Tue, 18 Feb 2020 15:20:18 +0100
Message-Id: <20200218142018.7224-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200218142018.7224-1-philmd@redhat.com>
References: <20200218142018.7224-1-philmd@redhat.com>
MIME-Version: 1.0
X-MC-Unique: VuKtf0wvNoO3l2jpKYPjRg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We currently run a CI job on macOS Mojave with Xcode 10.

QEMU policy is to support the two last major OS releases.
Add a job building on macOS Catalina, which comes with Xcode 11.

Split the target list in two, as we don't need to cover twice the
same targets.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 .travis.yml | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index a2a7fd0dd1..d02a477623 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -269,9 +269,10 @@ matrix:
=20
     # MacOSX builds - cirrus.yml also tests some MacOS builds including la=
test Xcode
=20
+    # On macOS Mojave, the SDK comes bundled with Xcode 10.
     - name: "OSX Xcode 10.3"
       env:
-        - CONFIG=3D"--target-list=3Di386-softmmu,ppc-softmmu,ppc64-softmmu=
,m68k-softmmu,x86_64-softmmu --extra-cflags=3D-I/usr/local/opt/ncurses/incl=
ude --extra-ldflags=3D-L/usr/local/opt/ncurses/lib"
+        - CONFIG=3D"--target-list=3Di386-softmmu,ppc-softmmu,ppc64-softmmu=
,m68k-softmmu --extra-cflags=3D-I/usr/local/opt/ncurses/include --extra-ldf=
lags=3D-L/usr/local/opt/ncurses/lib"
       os: osx
       osx_image: xcode10.3
       compiler: clang
@@ -301,6 +302,39 @@ matrix:
         - ${SRC_DIR}/configure ${BASE_CONFIG} ${CONFIG} || { cat config.lo=
g && exit 1; }
=20
=20
+    # On macOS Catalina, the SDK comes bundled with Xcode 11.
+    - name: "OSX Xcode 11.3"
+      env:
+        - CONFIG=3D"--target-list=3Darm-softmmu,ppc64-softmmu,x86_64-softm=
mu --extra-cflags=3D-I/usr/local/opt/ncurses/include --extra-ldflags=3D-L/u=
sr/local/opt/ncurses/lib"
+      os: osx
+      osx_image: xcode11.3
+      compiler: clang
+      addons:
+        homebrew:
+          packages:
+            - ccache
+            - libgcrypt
+            - libiscsi
+            - libssh2
+            - libusb
+            - lzfse
+            - lzo
+            - gettext
+            - glib
+            - gnu-sed
+            - ncurses
+            - pixman
+            - python
+            - snappy
+            - vde
+          update: true
+      before_script:
+        - brew link --overwrite python
+        - export PATH=3D"/usr/local/opt/ccache/libexec:$PATH"
+        - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
+        - ${SRC_DIR}/configure ${BASE_CONFIG} ${CONFIG} || { cat config.lo=
g && exit 1; }
+
+
     # Python builds
     - name: "GCC Python 3.5 (x86_64-softmmu)"
       env:
--=20
2.21.1


