Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CA9C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 17:38:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 528F720885
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 17:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hQ17tfj4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 528F720885
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5Bkw-0006iv-Gv
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 13:38:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BKh-0001Ny-SK
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:11:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30386
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BKf-0003BF-8k
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:11:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597079492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=+QoBbRmjf8OdxvDcrGW1+5fPl77Do9tYK7VCqwlKR3Q=;
 b=hQ17tfj4MMnKotU5wLuAlN8wAXlGAOH/PhvErT1xUdn0T/RnXggKdvBrguKiXRMoRfOVJV
 WYtCqz3LMVLdxqNROx/3nS67YbQZ1a/tPsVcg+4cq9lqMr23TpkFl9r6PvbcYN3gM2Xq7n
 f14XnrN+sAh2YVrcRQMqYP5X6u5PxRs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-BVWG_XI_OGyFK3yN10Kezw-1; Mon, 10 Aug 2020 13:11:31 -0400
X-MC-Unique: BVWG_XI_OGyFK3yN10Kezw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 336D58064D1
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 17:11:30 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 79CB35F1E9
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 17:11:29 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 085/147] meson: convert hw/nubus
Date: Mon, 10 Aug 2020 19:08:03 +0200
Message-Id: <1597079345-42801-86-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
References: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 11:00:11
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/Makefile.objs       | 1 -
 hw/meson.build         | 1 +
 hw/nubus/Makefile.objs | 4 ----
 hw/nubus/meson.build   | 7 +++++++
 4 files changed, 8 insertions(+), 5 deletions(-)
 delete mode 100644 hw/nubus/Makefile.objs
 create mode 100644 hw/nubus/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 6a7ca0f..86bc201 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -35,7 +35,6 @@ devices-dirs-$(CONFIG_VFIO) += vfio/
 devices-dirs-y += virtio/
 devices-dirs-y += watchdog/
 devices-dirs-$(CONFIG_MEM_DEVICE) += mem/
-devices-dirs-$(CONFIG_NUBUS) += nubus/
 devices-dirs-y += smbios/
 endif
 
diff --git a/hw/meson.build b/hw/meson.build
index 66a2f6c..03ef302 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,3 +1,4 @@
 subdir('core')
+subdir('nubus')
 subdir('semihosting')
 subdir('xen')
diff --git a/hw/nubus/Makefile.objs b/hw/nubus/Makefile.objs
deleted file mode 100644
index 135ba78..0000000
--- a/hw/nubus/Makefile.objs
+++ /dev/null
@@ -1,4 +0,0 @@
-common-obj-y += nubus-device.o
-common-obj-y += nubus-bus.o
-common-obj-y += nubus-bridge.o
-common-obj-$(CONFIG_Q800) += mac-nubus-bridge.o
diff --git a/hw/nubus/meson.build b/hw/nubus/meson.build
new file mode 100644
index 0000000..9287c63
--- /dev/null
+++ b/hw/nubus/meson.build
@@ -0,0 +1,7 @@
+nubus_ss = ss.source_set()
+nubus_ss.add(files('nubus-device.c'))
+nubus_ss.add(files('nubus-bus.c'))
+nubus_ss.add(files('nubus-bridge.c'))
+nubus_ss.add(when: 'CONFIG_Q800', if_true: files('mac-nubus-bridge.c'))
+
+softmmu_ss.add_all(when: 'CONFIG_NUBUS', if_true: nubus_ss)
-- 
1.8.3.1



