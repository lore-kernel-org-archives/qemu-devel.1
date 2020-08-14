Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC30CC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 10:18:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72400206DA
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 10:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cGAlXWoY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72400206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6Wme-0001hz-MX
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 06:18:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44288)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k6Vnt-0008E8-JC
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 05:15:13 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50903
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k6Vno-0003CU-88
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 05:15:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597396507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yfZo79H54pzQVipRAtb2JJt0yDu2gOzh+s+4KLx7ymI=;
 b=cGAlXWoYvKH0gj0pbU/bmMnlBq1y+RT4ZPtQw0mNjSucCzOmQi+SPBNMw9LDSYhlz4uPva
 Xd9DrGFOmttoqIeZdpDnGasNa8tBKtuGqvC/mIeuBbeKnnx0uCTLFuEaMrPXfXBSIkaarC
 Mf0TW38jmVSMJBVCwgWe4Bma5WeB6iU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-LGnHVd3OOV-XmhLX4WdFHQ-1; Fri, 14 Aug 2020 05:15:05 -0400
X-MC-Unique: LGnHVd3OOV-XmhLX4WdFHQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7AAD0802B45
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 09:15:04 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 28E391972B;
 Fri, 14 Aug 2020 09:15:04 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 131/150] meson: bsd-user
Date: Fri, 14 Aug 2020 05:13:07 -0400
Message-Id: <20200814091326.16173-132-pbonzini@redhat.com>
In-Reply-To: <20200814091326.16173-1-pbonzini@redhat.com>
References: <20200814091326.16173-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 05:13:30
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
index a68859d7c2..5c099fa79f 100644
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
index 5e77f57782..0000000000
--- a/bsd-user/Makefile.objs
+++ /dev/null
@@ -1,2 +0,0 @@
-obj-y = main.o bsdload.o elfload.o mmap.o signal.o strace.o syscall.o \
-	        uaccess.o
diff --git a/bsd-user/meson.build b/bsd-user/meson.build
new file mode 100644
index 0000000000..0369549340
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
index 63eed915f8..2329c6eddf 100644
--- a/meson.build
+++ b/meson.build
@@ -701,8 +701,12 @@ subdir('net')
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
2.26.2



