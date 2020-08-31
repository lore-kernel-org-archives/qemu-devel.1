Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02360C433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 11:07:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD53A2054F
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 11:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MRd1Ye2/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD53A2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kChed-0006BB-S1
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 07:07:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47026)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kChbu-0001CT-Uh
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 07:04:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20049
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kChbs-0008MF-CJ
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 07:04:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598871863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GarPJ/SS+I4xiksXFaevRanhYl5N9gBrHJ/iFNSYCF0=;
 b=MRd1Ye2/GUMmY9qe08tMMuMif9zvWPBfoA1kqa4qol//lKQCLsoQD3nBY3TxjgH+gX6Y5H
 3J8uqJ+uH39AXoan9ihYw7cKkUN5FofHYCqLTt41xt/qMrQgkPj0Dl5JbLW5zI8m56VJ2m
 7P1IralNAHuFtTIoiNeEsVa9AuV3nrs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-jRJJvjcAOvmAsegg2O3ZFw-1; Mon, 31 Aug 2020 07:04:21 -0400
X-MC-Unique: jRJJvjcAOvmAsegg2O3ZFw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C298801F95
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 11:04:20 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-54.ams2.redhat.com
 [10.36.112.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0A0DD7EB78;
 Mon, 31 Aug 2020 11:04:16 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 28C8B204AE; Mon, 31 Aug 2020 13:04:16 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 3/5] meson: fix keymaps witout qemu-keymap
Date: Mon, 31 Aug 2020 13:04:14 +0200
Message-Id: <20200831110416.15176-4-kraxel@redhat.com>
In-Reply-To: <20200831110416.15176-1-kraxel@redhat.com>
References: <20200831110416.15176-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 02:13:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In case the qemu-keymap tool generating them is neither installed on the
system nor built from sources (due to xkbcommon not being available)
qemu will not find the keymaps when started directly from the build
tree,

This happens because commit ddcf607fa3d6 ("meson: drop keymaps symlink")
removed the symlink to the source tree, and the special handling for
install doesn't help in case we do not install qemu.

Lets fix that by simply copying over the file from the source tree as
fallback.

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20200827102617.14448-1-kraxel@redhat.com
---
 pc-bios/keymaps/meson.build | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/pc-bios/keymaps/meson.build b/pc-bios/keymaps/meson.build
index b737c8223031..e102dd56b454 100644
--- a/pc-bios/keymaps/meson.build
+++ b/pc-bios/keymaps/meson.build
@@ -38,19 +38,29 @@ if meson.is_cross_build() or 'CONFIG_XKBCOMMON' not in config_host
 else
   native_qemu_keymap = qemu_keymap
 endif
+
 t = []
 foreach km, args: keymaps
-  t += custom_target(km,
-                     build_by_default: true,
-                     output: km,
-                     command: [native_qemu_keymap, '-f', '@OUTPUT@', args.split()],
-                     install_dir: config_host['qemu_datadir'] / 'keymaps')
+  if native_qemu_keymap.found()
+    # generate with qemu-kvm
+    t += custom_target(km,
+                       build_by_default: true,
+                       output: km,
+                       command: [native_qemu_keymap, '-f', '@OUTPUT@', args.split()],
+                       install_dir: config_host['qemu_datadir'] / 'keymaps')
+  else
+    # copy from source tree
+    t += custom_target(km,
+                       build_by_default: true,
+		       input: km,
+                       output: km,
+                       command: ['cp', '@INPUT@', '@OUTPUT@'],
+                       install_dir: config_host['qemu_datadir'] / 'keymaps')
+  endif
 endforeach
-if t.length() > 0
+
+if native_qemu_keymap.found()
   alias_target('update-keymaps', t)
-else
-  # install from the source tree
-  install_data(keymaps.keys(), install_dir: config_host['qemu_datadir'] / 'keymaps')
 endif
 
 install_data(['sl', 'sv'], install_dir: config_host['qemu_datadir'] / 'keymaps')
-- 
2.27.0


