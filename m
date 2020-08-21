Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C340AC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 16:09:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FE37207DE
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 16:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ou4I0+AQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FE37207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k99bA-0002TN-RK
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 12:09:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55116)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k99aO-00019g-BY
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 12:08:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50897)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k99aM-0003dL-Ft
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 12:08:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598026089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QNLCUycU+nWEXithWdbVY34QeWXma92nS9kZQp9Eokg=;
 b=Ou4I0+AQzxUXDhtYRKdPk0yigzhCflbQRH3Z8P3Ty7k/hwfR4bF+UYMgd+ZwtXxIFtuikE
 sGrMPjAGN0OBCGoUyKb6fRQjHUm42NE+klf/N2AGdT7uouT7d6aYG8xvl0ho8oXRYxyexf
 3VucyQWquaXTW4WrqG+bKO7310Mp08U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-rXkbfj3lPxuhkLm_BUiIOg-1; Fri, 21 Aug 2020 12:08:07 -0400
X-MC-Unique: rXkbfj3lPxuhkLm_BUiIOg-1
Received: by mail-wr1-f70.google.com with SMTP id s23so684123wrb.12
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 09:08:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QNLCUycU+nWEXithWdbVY34QeWXma92nS9kZQp9Eokg=;
 b=KXh+UZOBHW4pNwSiVGb7FpHuw1t3iAXyUmoKx5m2zaBOZWYbvnXtYWgZ1aTCzTH0Ss
 xAwpQe0cEtzeWvoEH7kOq+w3rodIQDCJTNBrOOXzVLFa1zQoWGfYaMNFhqTAvpH9I1NN
 ioCsVO+uM+6vspCM50KHMURXWGkRTFjqjIELlD7JtW1SRMamRfsJOGLgs5TybwUmxrYm
 Oi3KRpSgO+3bU/qNoLyni/VcHy4X68FijC1HgZ8tkKggDD6ZLYN8L2lP3A+OKQCwalWY
 O74SzIJODTFIJ6bHeH2v68ignAqlvHehV/Znq8OGLxxTHdzEDvY+NQcYAhLjw+Qih89j
 pARQ==
X-Gm-Message-State: AOAM5302w9vN0RXSuHR0iPkZO0pVPk3H5MQFaFEilg0RohY/Bp7OCIbo
 bbbJ61FoVXUQWozaGhz8c6BvIn8cxCVOYu5S5lPT87it3hKnLFArZ0UVEgqP0iEpMCCYwdSIV0/
 Cmvhp06aB0JQJT8s=
X-Received: by 2002:adf:df85:: with SMTP id z5mr3244730wrl.267.1598026085648; 
 Fri, 21 Aug 2020 09:08:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJybqY1gGLQxCIOVCTy4zsJkdmERZpYNG0uZJ2XZkMC5DYJEPlK0QBmd9Ywe/7r5THwGFp64pg==
X-Received: by 2002:adf:df85:: with SMTP id z5mr3244718wrl.267.1598026085481; 
 Fri, 21 Aug 2020 09:08:05 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id v7sm5873634wmj.28.2020.08.21.09.08.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 09:08:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/2] meson: Do not consider qemu-keymap a 'tool'
Date: Fri, 21 Aug 2020 18:07:52 +0200
Message-Id: <20200821160752.1254102-3-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200821160752.1254102-1-philmd@redhat.com>
References: <20200821160752.1254102-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 02:43:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
v3: Rebased on Marc-André keymap patch

Paolo feel free to improve the subject if qemu-keymap is a tool :)
---
 meson.build    | 11 ++++++-----
 ui/meson.build |  2 +-
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/meson.build b/meson.build
index 808f50b07ef..dd8016c9da3 100644
--- a/meson.build
+++ b/meson.build
@@ -1062,6 +1062,12 @@ if 'CONFIG_GUEST_AGENT' in config_host
   subdir('qga')
 endif
 
+if 'CONFIG_XKBCOMMON' in config_host
+  # used for the update-keymaps target, so include rules even if !have_tools
+  qemu_keymap = executable('qemu-keymap', files('qemu-keymap.c', 'ui/input-keymap.c') + genh,
+                           dependencies: [qemuutil, xkbcommon], install: have_tools)
+endif
+
 if have_tools
   qemu_img = executable('qemu-img', [files('qemu-img.c'), hxdep],
              dependencies: [authz, block, crypto, io, qom, qemuutil], install: true)
@@ -1078,11 +1084,6 @@ if have_tools
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
diff --git a/ui/meson.build b/ui/meson.build
index 6f74d30ea06..6bf398213f3 100644
--- a/ui/meson.build
+++ b/ui/meson.build
@@ -95,7 +95,7 @@ keymaps = [
   ['osx', 'qcode'],
 ]
 
-if have_system
+if have_system or have_tools
   foreach e : keymaps
     output = 'input-keymap-@0@-to-@1@.c.inc'.format(e[0], e[1])
     genh += custom_target(output,
-- 
2.26.2


