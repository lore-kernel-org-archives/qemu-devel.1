Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB66DC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 15:31:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79C0F2063A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 15:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LNqcL0eU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79C0F2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k990u-0007nK-QI
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 11:31:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44616)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k98z0-0006Qc-Th
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 11:29:34 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27952
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k98yx-00062z-Se
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 11:29:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598023770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=cvnB3su+5AR/IptiEh8NCGepT51dI755gYTFsFKWbp4=;
 b=LNqcL0eUfV3VffY8OW6b7EXE89IWuAHsY17HhwJ0EGQIAmCqDs25mWLL2L0X50ypmd7+XS
 aWPBYXbgCK0gEr3E5GrY7yOjTdkyaREfHZgmvfTylmVC+JvAj6ARtSXtsk3KrsrnCjVXgk
 HIGoIYrpqQXdS+bkGXt6JhCid03HBwU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-R_m_VWr8Moy0cbGo4nVS-A-1; Fri, 21 Aug 2020 11:29:28 -0400
X-MC-Unique: R_m_VWr8Moy0cbGo4nVS-A-1
Received: by mail-wr1-f72.google.com with SMTP id e14so645806wrr.7
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 08:29:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=cvnB3su+5AR/IptiEh8NCGepT51dI755gYTFsFKWbp4=;
 b=e8L5zeQUi5zWrtfc8JyIJ8/M/mK+O+MdPnVk1hwViwcXsg8G8R9SienI/UlNHPAYLQ
 PEdKR5I2wsME25VP7MMNQbF0tcoDT68VYzugUQmwPpVizg86aNJpyr8F9asI30UCZVwS
 5JUdSeD9Kox7t+TQRpPTSSo2NrONDs7XkjIWoE5ndQTRb2G8RBbPLsqU46Gb8NOruHXO
 qKS0uJfrEmRgDGALjVy7oGMW7MvyKmj+6n7iUSkvtEukwWFntuJVetM8wspeWDyOketU
 Zu/3VfWNzwfIma/pDMFNIblzrjQseeXE9KKWd5Z0u9eqxTF1hrq5A8bijxYtsiGr718n
 dTdA==
X-Gm-Message-State: AOAM531CZKE6skNu90IixL5hN059huHdbrkih4uvss/GL69VUyDfthm2
 QAAyNpTFoAcPZ1Dz1Vgs0yOmXu7ycVDBXpiYDGq5G5yktA3hQFzqu6qNKuc29DjmntdPMD/HNEp
 o7zMYroyvEe/2cGY=
X-Received: by 2002:a5d:4947:: with SMTP id r7mr3168996wrs.165.1598023766600; 
 Fri, 21 Aug 2020 08:29:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzN7MZT2eswuXRZiNhQLEaRzZPpu8ejtlyqqeNgiW5I8KF0Wot5wxQKr6XYP3owgrwyMo0I9g==
X-Received: by 2002:a5d:4947:: with SMTP id r7mr3168988wrs.165.1598023766357; 
 Fri, 21 Aug 2020 08:29:26 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id k1sm4876329wrw.91.2020.08.21.08.29.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 08:29:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] meson: Do not consider qemu-keymap a 'tool'
Date: Fri, 21 Aug 2020 17:29:24 +0200
Message-Id: <20200821152924.1246930-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 01:00:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We need qemu-keymap to generate the keymaps.

This fixes when configuring with --disable-tools:

  Compiling C object qemu-keymap.p/qemu-keymap.c.o
  Compiling C object qemu-keymap.p/ui_input-keymap.c.o
  Compiling C object qemu-edid.p/qemu-edid.c.o
  ../ui/input-keymap.c:7:49: fatal error: ui/input-keymap-atset1-to-qcode.c.inc: No such file or directory
  compilation terminated.
  Makefile.ninja:688: recipe for target 'qemu-keymap.p/ui_input-keymap.c.o' failed
  make: *** [qemu-keymap.p/ui_input-keymap.c.o] Error 1

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 meson.build | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/meson.build b/meson.build
index 808f50b07ef..4036af7181c 100644
--- a/meson.build
+++ b/meson.build
@@ -1062,6 +1062,11 @@ if 'CONFIG_GUEST_AGENT' in config_host
   subdir('qga')
 endif
 
+if 'CONFIG_XKBCOMMON' in config_host
+executable('qemu-keymap', files('qemu-keymap.c', 'ui/input-keymap.c'),
+           dependencies: [qemuutil, xkbcommon], install: true)
+endif
+
 if have_tools
   qemu_img = executable('qemu-img', [files('qemu-img.c'), hxdep],
              dependencies: [authz, block, crypto, io, qom, qemuutil], install: true)
@@ -1078,11 +1083,6 @@ if have_tools
   subdir('contrib/rdmacm-mux')
   subdir('contrib/elf2dmp')
 
-  if 'CONFIG_XKBCOMMON' in config_host
-    executable('qemu-keymap', files('qemu-keymap.c', 'ui/input-keymap.c'),
-               dependencies: [qemuutil, xkbcommon], install: true)
-  endif
-
   executable('qemu-edid', files('qemu-edid.c', 'hw/display/edid-generate.c'),
              dependencies: qemuutil,
              install: true)
-- 
2.26.2


