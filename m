Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67BBC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 17:25:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9250220825
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 17:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LmD3pSJV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9250220825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5BXp-0002WO-JD
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 13:25:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45416)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BJE-0006of-83
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:10:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37845)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BJA-0002mm-Q5
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:10:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597079400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=XkwctKtc+BtvrIZU8YC6grAo912qQ0c4qil4FP1Xuew=;
 b=LmD3pSJVemIw6ga06Wtaee8wmzAf5dTuFP9J1nL4PJtNjsPPqCGFyOKUc5BxryXuhgeHFa
 E5jPRdCJH8UakfidK7rR7FoDM3bx6i9hQ7t6HbNei5S4iKzh2k6O+PwlilwaHyDeSv0WVa
 M1+VNRaGLzJy40z9vRDBMzVcgGswcO8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-563-GeS8bGf8MSugb4NiGgKNiA-1; Mon, 10 Aug 2020 13:09:58 -0400
X-MC-Unique: GeS8bGf8MSugb4NiGgKNiA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5CF858014D7
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 17:09:56 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A54B287D9C
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 17:09:55 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 029/147] contrib/vhost-user-blk: convert to Meson
Date: Mon, 10 Aug 2020 19:07:07 +0200
Message-Id: <1597079345-42801-30-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
References: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 11:11:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

The GLib pkg-config information is extracted from config-host.mak and
used to link vhost-user-blk.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile                             | 3 ---
 Makefile.objs                        | 1 -
 contrib/vhost-user-blk/Makefile.objs | 1 -
 contrib/vhost-user-blk/meson.build   | 5 +++++
 meson.build                          | 1 +
 5 files changed, 6 insertions(+), 5 deletions(-)
 delete mode 100644 contrib/vhost-user-blk/Makefile.objs
 create mode 100644 contrib/vhost-user-blk/meson.build

diff --git a/Makefile b/Makefile
index 6a3dfc4..7317554 100644
--- a/Makefile
+++ b/Makefile
@@ -297,7 +297,6 @@ dummy := $(call unnest-vars,, \
                 ivshmem-server-obj-y \
                 rdmacm-mux-obj-y \
                 vhost-user-scsi-obj-y \
-                vhost-user-blk-obj-y \
                 vhost-user-input-obj-y \
                 vhost-user-gpu-obj-y \
                 qga-vss-dll-obj-y \
@@ -520,8 +519,6 @@ ivshmem-server$(EXESUF): $(ivshmem-server-obj-y) $(COMMON_LDADDS)
 endif
 vhost-user-scsi$(EXESUF): $(vhost-user-scsi-obj-y) contrib/libvhost-user/libvhost-user.a $(COMMON_LDADDS)
 	$(call LINK, $^)
-vhost-user-blk$(EXESUF): $(vhost-user-blk-obj-y) contrib/libvhost-user/libvhost-user.a $(COMMON_LDADDS)
-	$(call LINK, $^)
 
 rdmacm-mux$(EXESUF): LIBS += "-libumad"
 rdmacm-mux$(EXESUF): $(rdmacm-mux-obj-y) $(COMMON_LDADDS)
diff --git a/Makefile.objs b/Makefile.objs
index fee0f71..f69736c 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -109,7 +109,6 @@ ivshmem-server-obj-$(CONFIG_IVSHMEM) = contrib/ivshmem-server/
 vhost-user-scsi.o-cflags := $(LIBISCSI_CFLAGS)
 vhost-user-scsi.o-libs := $(LIBISCSI_LIBS)
 vhost-user-scsi-obj-y = contrib/vhost-user-scsi/
-vhost-user-blk-obj-y = contrib/vhost-user-blk/
 rdmacm-mux-obj-y = contrib/rdmacm-mux/
 vhost-user-input-obj-y = contrib/vhost-user-input/
 vhost-user-gpu-obj-y = contrib/vhost-user-gpu/
diff --git a/contrib/vhost-user-blk/Makefile.objs b/contrib/vhost-user-blk/Makefile.objs
deleted file mode 100644
index 72e2cdc..0000000
--- a/contrib/vhost-user-blk/Makefile.objs
+++ /dev/null
@@ -1 +0,0 @@
-vhost-user-blk-obj-y = vhost-user-blk.o
diff --git a/contrib/vhost-user-blk/meson.build b/contrib/vhost-user-blk/meson.build
new file mode 100644
index 0000000..05cbf81
--- /dev/null
+++ b/contrib/vhost-user-blk/meson.build
@@ -0,0 +1,5 @@
+executable('vhost-user-blk', files('vhost-user-blk.c'),
+           link_with: libvhost_user,
+           dependencies: qemuutil,
+           build_by_default: targetos == 'linux',
+           install: false)
diff --git a/meson.build b/meson.build
index c6b5292..fc1346a 100644
--- a/meson.build
+++ b/meson.build
@@ -253,6 +253,7 @@ qemuutil = declare_dependency(link_with: libqemuutil,
 if have_tools
   if 'CONFIG_VHOST_USER' in config_host
     subdir('contrib/libvhost-user')
+    subdir('contrib/vhost-user-blk')
   endif
 endif
 
-- 
1.8.3.1



