Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD167C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:28:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4C61233CF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N/7BOUoU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4C61233CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7h3p-0005Ht-0G
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 11:28:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42380)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k7gK6-0002I8-3e
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:41:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40028
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k7gK4-0006ot-0C
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:41:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597675275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x350yu0iiIWdawy91SCA3LKUTDwTaxSjcoiN5Aj2s1w=;
 b=N/7BOUoUuC69DVs13ZhDBa3bylJJ2On29HOnEhAFw64Xzj+hKXCmVEQ7PuBAUt1DIfLWEx
 CHRQCOACIl2sr/rC5KRsXWQgldHokTVvyXQrkPS/Dyk6PmYO/UQlrYOoXxxcEAxgW0jW3Q
 4ideQmKxlZEcOIXdte7KkzeWtDDWR/I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-559-xAkDPUX9PZ6GP87DkLNLkQ-1; Mon, 17 Aug 2020 10:41:13 -0400
X-MC-Unique: xAkDPUX9PZ6GP87DkLNLkQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0818D185E521
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 14:41:13 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-113-20.ams2.redhat.com
 [10.36.113.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2412A70C3D;
 Mon, 17 Aug 2020 14:41:09 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 105/150] meson: convert hw/rdma
Date: Mon, 17 Aug 2020 16:40:08 +0200
Message-Id: <20200817144053.345107-10-pbonzini@redhat.com>
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 00:24:04
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
 hw/Makefile.objs      |  1 -
 hw/meson.build        |  1 +
 hw/rdma/Makefile.objs |  3 ---
 hw/rdma/meson.build   | 10 ++++++++++
 4 files changed, 11 insertions(+), 4 deletions(-)
 delete mode 100644 hw/rdma/Makefile.objs
 create mode 100644 hw/rdma/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 78860ae9c7..748a718b0f 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -19,7 +19,6 @@ devices-dirs-$(CONFIG_IPMI) += ipmi/
 devices-dirs-y += isa/
 devices-dirs-y += misc/
 devices-dirs-y += net/
-devices-dirs-y += rdma/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/meson.build b/hw/meson.build
index 0bdd6a2613..f704e51361 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -6,6 +6,7 @@ subdir('pci')
 subdir('pci-bridge')
 subdir('pci-host')
 subdir('pcmcia')
+subdir('rdma')
 subdir('rtc')
 subdir('scsi')
 subdir('sd')
diff --git a/hw/rdma/Makefile.objs b/hw/rdma/Makefile.objs
deleted file mode 100644
index 819bb12a35..0000000000
--- a/hw/rdma/Makefile.objs
+++ /dev/null
@@ -1,3 +0,0 @@
-obj-$(CONFIG_VMW_PVRDMA) += rdma_utils.o rdma_backend.o rdma_rm.o rdma.o
-obj-$(CONFIG_VMW_PVRDMA) += vmw/pvrdma_dev_ring.o vmw/pvrdma_cmd.o \
-                     vmw/pvrdma_qp_ops.o vmw/pvrdma_main.o
diff --git a/hw/rdma/meson.build b/hw/rdma/meson.build
new file mode 100644
index 0000000000..7325f40c32
--- /dev/null
+++ b/hw/rdma/meson.build
@@ -0,0 +1,10 @@
+specific_ss.add(when: 'CONFIG_VMW_PVRDMA', if_true: files(
+  'rdma.c',
+  'rdma_backend.c',
+  'rdma_rm.c',
+  'rdma_utils.c',
+  'vmw/pvrdma_cmd.c',
+  'vmw/pvrdma_dev_ring.c',
+  'vmw/pvrdma_main.c',
+  'vmw/pvrdma_qp_ops.c',
+))
-- 
2.26.2



