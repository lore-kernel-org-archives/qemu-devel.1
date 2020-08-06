Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA344C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 19:53:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43F3C2173E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 19:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="APvAxMew"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43F3C2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3lwu-0003Ba-QB
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 15:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3lPg-0007kU-Ii
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 15:18:52 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38643
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3lPe-0006gl-PU
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 15:18:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596741530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XJ9OVokfJnGAhtD/lxsDsJtm9yPBxnkQ0IWINN8PfuI=;
 b=APvAxMewVqJkmFu+9CdQcaC4mGSigtqA8YXsXZ8mnh1nyIg4LC3giMXq+QM8MqHwyBBEYb
 AppHAkC6jlNH/sjuNl/L3QPysRnBuOQJyuMV/3LnJZLmm8oTRaTy78byKrvrMVbT1oopmk
 f00+tA758r8vaK7XbB5+JDaWj6Ef+b4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-v_5Q0BRqPamrTBbpNP3L2w-1; Thu, 06 Aug 2020 15:18:46 -0400
X-MC-Unique: v_5Q0BRqPamrTBbpNP3L2w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D2F7B100AA21
 for <qemu-devel@nongnu.org>; Thu,  6 Aug 2020 19:18:45 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E3C745FC3B;
 Thu,  6 Aug 2020 19:18:44 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 083/143] meson: convert hw/semihosting
Date: Thu,  6 Aug 2020 21:15:19 +0200
Message-Id: <1596741379-12902-84-git-send-email-pbonzini@redhat.com>
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/Makefile.objs             | 1 -
 hw/meson.build               | 1 +
 hw/semihosting/Makefile.objs | 2 --
 hw/semihosting/meson.build   | 4 ++++
 4 files changed, 5 insertions(+), 3 deletions(-)
 delete mode 100644 hw/semihosting/Makefile.objs
 create mode 100644 hw/semihosting/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index bdf8bdf..6a7ca0f 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -36,7 +36,6 @@ devices-dirs-y += virtio/
 devices-dirs-y += watchdog/
 devices-dirs-$(CONFIG_MEM_DEVICE) += mem/
 devices-dirs-$(CONFIG_NUBUS) += nubus/
-devices-dirs-y += semihosting/
 devices-dirs-y += smbios/
 endif
 
diff --git a/hw/meson.build b/hw/meson.build
index fe7c466..66a2f6c 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,2 +1,3 @@
 subdir('core')
+subdir('semihosting')
 subdir('xen')
diff --git a/hw/semihosting/Makefile.objs b/hw/semihosting/Makefile.objs
deleted file mode 100644
index 4ad47c0..0000000
--- a/hw/semihosting/Makefile.objs
+++ /dev/null
@@ -1,2 +0,0 @@
-obj-$(CONFIG_SEMIHOSTING) += config.o
-obj-$(CONFIG_SEMIHOSTING) += console.o
diff --git a/hw/semihosting/meson.build b/hw/semihosting/meson.build
new file mode 100644
index 0000000..f40ac57
--- /dev/null
+++ b/hw/semihosting/meson.build
@@ -0,0 +1,4 @@
+specific_ss.add(when: 'CONFIG_SEMIHOSTING', if_true: files(
+  'config.c',
+  'console.c',
+))
-- 
1.8.3.1



