Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D777C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 20:11:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65563221E3
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 20:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GChApvAb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65563221E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3mEx-0005n2-GW
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 16:11:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3lR9-0002qa-0B
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 15:20:23 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38183
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3lR6-0006tK-T0
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 15:20:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596741619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IpCi4eicWzIIJfV5PLCWS1/H8uRwNMEo+ueEnvQ7sws=;
 b=GChApvAbeGVVwV69F7GEHQjFgXyGryI3aoPf+W7V1RvVyeczPsYKk4fue17ADlLsX1j9Zi
 JbwLS5v6ETcG+pckQdsvfED7c3k1wrqBrxOGe5gPhynnG332orZhbeidmt2J2ILg1+F/Ce
 kCiZBs0W5dZ7sBqlNxVzLlCmNRf60dQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-tPP6DG3dPoW2TXaAzVx6Yw-1; Thu, 06 Aug 2020 15:20:18 -0400
X-MC-Unique: tPP6DG3dPoW2TXaAzVx6Yw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45203100AA21
 for <qemu-devel@nongnu.org>; Thu,  6 Aug 2020 19:20:17 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AEA5C5F9DC;
 Thu,  6 Aug 2020 19:20:12 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 127/143] meson: bsd-user
Date: Thu,  6 Aug 2020 21:16:03 +0200
Message-Id: <1596741379-12902-128-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 00:07:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile.target        |  3 ---
 bsd-user/Makefile.objs |  2 --
 bsd-user/meson.build   | 10 ++++++++++
 meson.build            |  4 ++++
 4 files changed, 14 insertions(+), 5 deletions(-)
 delete mode 100644 bsd-user/Makefile.objs
 create mode 100644 bsd-user/meson.build

diff --git a/Makefile.target b/Makefile.target
index a68859d..5c099fa 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -141,9 +141,6 @@ ifdef CONFIG_BSD_USER
 QEMU_CFLAGS+=-I$(SRC_PATH)/bsd-user -I$(SRC_PATH)/bsd-user/$(TARGET_ABI_DIR) \
 			 -I$(SRC_PATH)/bsd-user/$(HOST_VARIANT_DIR)
 
-obj-y += bsd-user/
-obj-y += gdbstub.o
-
 endif #CONFIG_BSD_USER
 
 #########################################################
diff --git a/bsd-user/Makefile.objs b/bsd-user/Makefile.objs
deleted file mode 100644
index 5e77f57..0000000
--- a/bsd-user/Makefile.objs
+++ /dev/null
@@ -1,2 +0,0 @@
-obj-y = main.o bsdload.o elfload.o mmap.o signal.o strace.o syscall.o \
-	        uaccess.o
diff --git a/bsd-user/meson.build b/bsd-user/meson.build
new file mode 100644
index 0000000..0369549
--- /dev/null
+++ b/bsd-user/meson.build
@@ -0,0 +1,10 @@
+bsd_user_ss.add(files(
+  'bsdload.c',
+  'elfload.c',
+  'main.c',
+  'mmap.c',
+  'signal.c',
+  'strace.c',
+  'syscall.c',
+  'uaccess.c',
+))
diff --git a/meson.build b/meson.build
index 483e65f..e1d7672 100644
--- a/meson.build
+++ b/meson.build
@@ -678,8 +678,12 @@ subdir('net')
 subdir('replay')
 subdir('hw')
 subdir('accel')
+subdir('bsd-user')
 subdir('linux-user')
 
+bsd_user_ss.add(files('gdbstub.c'))
+specific_ss.add_all(when: 'CONFIG_BSD_USER', if_true: bsd_user_ss)
+
 linux_user_ss.add(files('gdbstub.c', 'thunk.c'))
 specific_ss.add_all(when: 'CONFIG_LINUX_USER', if_true: linux_user_ss)
 
-- 
1.8.3.1



