Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD73EC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 21:24:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B57842311E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 21:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JU4xkN4k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B57842311E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLYiu-0002Uj-Hf
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 17:24:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41708)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1kLYM7-0005TV-5f
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 17:00:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39007)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1kLYM5-0001Gh-5d
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 17:00:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600981238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ufFgUQNsm1SMYsivUN4mRC41fMvuY01sP8Gku0iLFQQ=;
 b=JU4xkN4k4EtWEAbIIE4RsFt4GejptSrW8TtUncYX3bx/lLD+cFVJbdi9+XfcBB1jll8VQi
 Z6mSNIns3J0stKVecvtkr6lo0XtPvQJiIghSbFNfjn2kWbXhIZqTc8zR3/BPth3Wp6I82g
 OM6S4aAdekGeBulLqaaFaBazAGTzR20=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-RreSihutN6yxV_YuSAWsOA-1; Thu, 24 Sep 2020 17:00:33 -0400
X-MC-Unique: RreSihutN6yxV_YuSAWsOA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 21D7810A7AE5
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 21:00:32 +0000 (UTC)
Received: from thinkpad.redhat.com (ovpn-112-16.ams2.redhat.com [10.36.112.16])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 94F7F78828;
 Thu, 24 Sep 2020 21:00:24 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] configure: Fix build dependencies with vhost-vdpa.
Date: Thu, 24 Sep 2020 23:00:23 +0200
Message-Id: <20200924210023.160679-1-lvivier@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lvivier@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, lulu@redhat.com,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 marcandre.lureau@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Following the same logic as for vhost-net-user and vhost-kernel,
enable vhost-net if vhost-net-vdpa is enabled and vhost-net is not
explicitly disabled.
See 299e6f19b3e2 ("vhost-net: revamp configure logic")

Autoselect VHOST if VHOST_VDPA is set
See 21c6b0c87e85 ("configure: simplify vhost condition with Kconfig")
See 2becc36a3e53 ("meson: infrastructure for building emulators"

Problems can be triggered using;
... --enable-vhost-vdpa --disable-vhost-user --disable-vhost-kernel ...

Fixes: 108a64818e69 ("vhost-vdpa: introduce vhost-vdpa backend")
Cc: lulu@redhat.com
Cc: pbonzini@redhat.com
Cc: marcandre.lureau@redhat.com
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 Kconfig.host | 4 ++++
 configure    | 3 ++-
 meson.build  | 1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/Kconfig.host b/Kconfig.host
index 4af19bf70ef9..a9a55a9c315c 100644
--- a/Kconfig.host
+++ b/Kconfig.host
@@ -24,6 +24,10 @@ config VHOST_USER
     bool
     select VHOST
 
+config VHOST_VDPA
+    bool
+    select VHOST
+
 config VHOST_KERNEL
     bool
     select VHOST
diff --git a/configure b/configure
index e8e8e984f245..8ee15810c882 100755
--- a/configure
+++ b/configure
@@ -2494,9 +2494,10 @@ if test "$vhost_net_vdpa" = "yes" && test "$vhost_vdpa" = "no"; then
   error_exit "--enable-vhost-net-vdpa requires --enable-vhost-vdpa"
 fi
 
-# OR the vhost-kernel and vhost-user values for simplicity
+# OR the vhost-kernel, vhost-vdpa and vhost-user values for simplicity
 if test "$vhost_net" = ""; then
   test "$vhost_net_user" = "yes" && vhost_net=yes
+  test "$vhost_net_vdpa" = "yes" && vhost_net=yes
   test "$vhost_kernel" = "yes" && vhost_net=yes
 fi
 
diff --git a/meson.build b/meson.build
index f4d1ab109680..488ca205fad2 100644
--- a/meson.build
+++ b/meson.build
@@ -521,6 +521,7 @@ kconfig_external_symbols = [
   'CONFIG_OPENGL',
   'CONFIG_X11',
   'CONFIG_VHOST_USER',
+  'CONFIG_VHOST_VDPA',
   'CONFIG_VHOST_KERNEL',
   'CONFIG_VIRTFS',
   'CONFIG_LINUX',
-- 
2.26.2


