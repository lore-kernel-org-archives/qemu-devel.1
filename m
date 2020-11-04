Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D62CC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 05:15:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1A7120BED
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 05:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E73w5zNC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1A7120BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaB8S-0006Kn-Mc
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 00:15:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59694)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaAmr-0008QQ-Ke
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 23:52:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60192)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaAmp-0004zJ-Pn
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 23:52:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604465562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FOR/bv25dGPFB9FnzIFOxW/ObDgDZns8YprwAzRry/Y=;
 b=E73w5zNCZTTquuLAcHSZ0q4UvMlpTaWcwE0V0Aw4iUPmNNn9zVTBol0FqaRDuUDUp6AWAJ
 qQDr7gQSdcrBCApaMWLLnmZflnGVhjQ5wjysxxXflrJU4Z4utheZHUnv1j4sIUvBOxKSTg
 sTcoGnGfHtvVPE5GV2XRnv2GqQB15OQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-A5QjTE7bO--eG2BLY9L3lg-1; Tue, 03 Nov 2020 23:52:01 -0500
X-MC-Unique: A5QjTE7bO--eG2BLY9L3lg-1
Received: by mail-wr1-f69.google.com with SMTP id b6so8660944wrn.17
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 20:52:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=FOR/bv25dGPFB9FnzIFOxW/ObDgDZns8YprwAzRry/Y=;
 b=EYDuxUbowdh3POq0uksVpjWFqN1RS90wXcaQWNdvaL5yhF+6epMuhTO93eXQU6qg63
 cmzLBm4nDLYqk0HTGx1rOl14GQRi1jCXhz6Yn8Kjmy5L6sko5Vm8MR9vDIiCgmiYcQmZ
 zBHGv8WbBgHexQ3Nzvx2mguM01xVbGMkaSlvIZGSxqS3Wor60lrG/VLVHaEwaUVC3FBN
 a/elfhkGdjk9q/ID/zeNF14VmzpbXT8yKNF9RVm6YdxNp8fdtR5MzZGp1FZhLjjmfBHx
 A7zMhEH5er3Zl5YXhfI37MxdgaI+ZgY9FFpPGp7cOTGhrEZHoblJ9pGSIGK3hA3yk/Kv
 Awgg==
X-Gm-Message-State: AOAM531ylvu6bypTzZVq6w6Ix/leXqQkwps7PlpSfQ1Lz5ZFQ2pJ7QcS
 wZBAe+ozFsVPBH9QWkwWmgmvBLBdGmBXtlo2KCNAhsHbDDw2GLV/JK5jFQ0zWUHDrgCVPFAOJxb
 RyyV8aGsxJv0r40o=
X-Received: by 2002:a5d:4c4f:: with SMTP id n15mr28976514wrt.137.1604465519814; 
 Tue, 03 Nov 2020 20:51:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxo6ZnRAG/CyyK5D5ryWKX4pbM4rBmKPi8zswxWO1XEaX2+DS4IM7ZCbRexCfz8IaYmzSMvBQ==
X-Received: by 2002:a5d:4c4f:: with SMTP id n15mr28976509wrt.137.1604465519682; 
 Tue, 03 Nov 2020 20:51:59 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id n8sm810292wmc.11.2020.11.03.20.51.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 20:51:59 -0800 (PST)
Date: Tue, 3 Nov 2020 23:51:57 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 28/38] configure: introduce --enable-vhost-user-blk-server
Message-ID: <20201104044937.226370-29-mst@redhat.com>
References: <20201104044937.226370-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201104044937.226370-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

Make it possible to compile out the vhost-user-blk server. It is enabled
by default on Linux.

Note that vhost-user-server.c depends on libvhost-user, which requires
CONFIG_LINUX. The CONFIG_VHOST_USER dependency was erroneous since that
option controls vhost-user frontends (previously known as "master") and
not device backends (previously known as "slave").

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20201027173528.213464-3-stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 configure                | 15 +++++++++++++++
 block/export/export.c    |  4 ++--
 block/export/meson.build |  2 +-
 util/meson.build         |  2 +-
 4 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/configure b/configure
index 2c3c69f118..b5e8f5f72c 100755
--- a/configure
+++ b/configure
@@ -329,6 +329,7 @@ vhost_crypto=""
 vhost_scsi=""
 vhost_vsock=""
 vhost_user=""
+vhost_user_blk_server=""
 vhost_user_fs=""
 kvm="auto"
 hax="auto"
@@ -1246,6 +1247,10 @@ for opt do
   ;;
   --enable-vhost-vsock) vhost_vsock="yes"
   ;;
+  --disable-vhost-user-blk-server) vhost_user_blk_server="no"
+  ;;
+  --enable-vhost-user-blk-server) vhost_user_blk_server="yes"
+  ;;
   --disable-vhost-user-fs) vhost_user_fs="no"
   ;;
   --enable-vhost-user-fs) vhost_user_fs="yes"
@@ -1791,6 +1796,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   vhost-crypto    vhost-user-crypto backend support
   vhost-kernel    vhost kernel backend support
   vhost-user      vhost-user backend support
+  vhost-user-blk-server    vhost-user-blk server support
   vhost-vdpa      vhost-vdpa kernel backend support
   spice           spice
   rbd             rados block device (rbd)
@@ -2382,6 +2388,12 @@ if test "$vhost_net" = ""; then
   test "$vhost_kernel" = "yes" && vhost_net=yes
 fi
 
+# libvhost-user is Linux-only
+test "$vhost_user_blk_server" = "" && vhost_user_blk_server=$linux
+if test "$vhost_user_blk_server" = "yes" && test "$linux" = "no"; then
+  error_exit "--enable-vhost-user-blk-server is only available on Linux"
+fi
+
 ##########################################
 # pkg-config probe
 
@@ -6275,6 +6287,9 @@ fi
 if test "$vhost_vdpa" = "yes" ; then
   echo "CONFIG_VHOST_VDPA=y" >> $config_host_mak
 fi
+if test "$vhost_user_blk_server" = "yes" ; then
+  echo "CONFIG_VHOST_USER_BLK_SERVER=y" >> $config_host_mak
+fi
 if test "$vhost_user_fs" = "yes" ; then
   echo "CONFIG_VHOST_USER_FS=y" >> $config_host_mak
 fi
diff --git a/block/export/export.c b/block/export/export.c
index c3478c6c97..bad6f21b1c 100644
--- a/block/export/export.c
+++ b/block/export/export.c
@@ -22,13 +22,13 @@
 #include "qapi/qapi-commands-block-export.h"
 #include "qapi/qapi-events-block-export.h"
 #include "qemu/id.h"
-#if defined(CONFIG_LINUX) && defined(CONFIG_VHOST_USER)
+#ifdef CONFIG_VHOST_USER_BLK_SERVER
 #include "vhost-user-blk-server.h"
 #endif
 
 static const BlockExportDriver *blk_exp_drivers[] = {
     &blk_exp_nbd,
-#if defined(CONFIG_LINUX) && defined(CONFIG_VHOST_USER)
+#ifdef CONFIG_VHOST_USER_BLK_SERVER
     &blk_exp_vhost_user_blk,
 #endif
 };
diff --git a/block/export/meson.build b/block/export/meson.build
index 9fb4fbf81d..19526435d8 100644
--- a/block/export/meson.build
+++ b/block/export/meson.build
@@ -1,2 +1,2 @@
 blockdev_ss.add(files('export.c'))
-blockdev_ss.add(when: ['CONFIG_LINUX', 'CONFIG_VHOST_USER'], if_true: files('vhost-user-blk-server.c'))
+blockdev_ss.add(when: 'CONFIG_VHOST_USER_BLK_SERVER', if_true: files('vhost-user-blk-server.c'))
diff --git a/util/meson.build b/util/meson.build
index c5159ad79d..f359af0d46 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -66,7 +66,7 @@ if have_block
   util_ss.add(files('main-loop.c'))
   util_ss.add(files('nvdimm-utils.c'))
   util_ss.add(files('qemu-coroutine.c', 'qemu-coroutine-lock.c', 'qemu-coroutine-io.c'))
-  util_ss.add(when: ['CONFIG_LINUX', 'CONFIG_VHOST_USER'], if_true: [
+  util_ss.add(when: 'CONFIG_LINUX', if_true: [
     files('vhost-user-server.c'), vhost_user
   ])
   util_ss.add(files('block-helpers.c'))
-- 
MST


