Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8372FC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 14:46:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FD7E207D3
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 14:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DJ8/cwui"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FD7E207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k82sT-00064a-BJ
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 10:46:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k82LB-0004wO-7G
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 10:11:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36346
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k82L1-0007V1-JM
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 10:11:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597759902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vJYRzFczP3G71nLXPxT7FoelYpxmkicx4WZGHD1y9RM=;
 b=DJ8/cwuiFOqkIut6P4nvdwKqh8OojKeC7H+E9/mJpH58KpR/VpDC1f5f1MCFrXn/1JNVJo
 m7J06T5Gz0jH0xHWvQ3r7UEalyEw96DWYHxu7uqAFS5spQeAibHcBGRg+xpt7zRYO/QcU3
 y6N1j6kQPtfaN0S1E48KCGvXAOyJDt0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-550-zxN3Vrv_NnK-kBrVS5MHsA-1; Tue, 18 Aug 2020 10:11:40 -0400
X-MC-Unique: zxN3Vrv_NnK-kBrVS5MHsA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1AA4186A56D
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 14:11:39 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9B242165D8;
 Tue, 18 Aug 2020 14:11:39 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 084/150] meson: convert qapi-specific to meson
Date: Tue, 18 Aug 2020 10:09:19 -0400
Message-Id: <20200818141025.21608-85-pbonzini@redhat.com>
In-Reply-To: <20200818141025.21608-1-pbonzini@redhat.com>
References: <20200818141025.21608-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 03:19:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile.objs      |  2 --
 Makefile.target    |  1 -
 qapi/Makefile.objs | 15 ---------------
 qapi/meson.build   | 10 +++++++---
 4 files changed, 7 insertions(+), 21 deletions(-)
 delete mode 100644 qapi/Makefile.objs

diff --git a/Makefile.objs b/Makefile.objs
index 3b32a4c9bb..c332323b81 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -64,8 +64,6 @@ common-obj-$(if $(and $(CONFIG_BZIP2),$(CONFIG_DMG)),m) += block-dmg-bz2$(DSOSUF
 common-obj-y += hw/
 common-obj-m += hw/
 
-common-obj-y += qapi/
-
 common-obj-y += libqmp.fa
 
 endif # CONFIG_SOFTMMU
diff --git a/Makefile.target b/Makefile.target
index bf3fda92c1..386378b9c8 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -157,7 +157,6 @@ ifdef CONFIG_SOFTMMU
 obj-y += softmmu/
 obj-y += gdbstub.o
 obj-y += hw/
-obj-y += qapi/
 LIBS := $(libs_softmmu) $(LIBS)
 
 # Temporary until emulators are linked by Meson
diff --git a/qapi/Makefile.objs b/qapi/Makefile.objs
deleted file mode 100644
index c0a31be1a1..0000000000
--- a/qapi/Makefile.objs
+++ /dev/null
@@ -1,15 +0,0 @@
-QAPI_TARGET_MODULES = machine-target misc-target
-
-obj-y = qapi-introspect.o
-obj-y += $(QAPI_TARGET_MODULES:%=qapi-types-%.o)
-obj-y += qapi-types.o
-obj-y += $(QAPI_TARGET_MODULES:%=qapi-visit-%.o)
-obj-y += qapi-visit.o
-obj-y += $(QAPI_TARGET_MODULES:%=qapi-events-%.o)
-obj-y += qapi-events.o
-obj-y += $(QAPI_TARGET_MODULES:%=qapi-commands-%.o)
-obj-y += qapi-commands.o
-obj-y += qapi-init-commands.o
-
-QAPI_MODULES_STORAGE_DAEMON = block-core char common control crypto
-QAPI_MODULES_STORAGE_DAEMON += introspect job qom sockets pragma transaction
diff --git a/qapi/meson.build b/qapi/meson.build
index f45b80bbfa..2b2872a41d 100644
--- a/qapi/meson.build
+++ b/qapi/meson.build
@@ -114,8 +114,12 @@ foreach output : qapi_util_outputs
   i = i + 1
 endforeach
 
-# These are still handled by the Makefile
-i += qapi_nonmodule_outputs.length()
-i += qapi_specific_outputs.length()
+foreach output : qapi_specific_outputs + qapi_nonmodule_outputs
+  if output.endswith('.h')
+    genh += qapi_files[i]
+  endif
+  specific_ss.add(when: 'CONFIG_SOFTMMU', if_true: qapi_files[i])
+  i = i + 1
+endforeach
 
 qapi_doc_texi = qapi_files[i]
-- 
2.26.2



