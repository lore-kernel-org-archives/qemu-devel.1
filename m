Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3322C433E4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:33:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F9022332F
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fp4kjd6I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F9022332F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7h8V-0005ho-Sq
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 11:33:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42584)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k7gKT-0002t2-Er
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:41:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41673)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k7gKO-0006qf-Jf
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:41:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597675295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yaNJ6IuIrRUXWAqx7sgSBGNyDiIOBarS60pmB3FgTrg=;
 b=Fp4kjd6I3fk/3g+hqZ2eDOAcQXUtvxUr5bYalokSLNA9tCcOoqcnunVdNLDVGkRzXc/MuD
 aKywb271EQWnS6CjHq53AMK0cVLwGzdm5T2zBo/d6n7o+L5wSJo4Fkvv+RMFM+m7zxfQ4P
 ivY3ldROmDk5x98nMVscvnxoMfnOLiQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-W7Wo5Z5wNJeBUr6n2ANvUw-1; Mon, 17 Aug 2020 10:41:33 -0400
X-MC-Unique: W7Wo5Z5wNJeBUr6n2ANvUw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 005D6100CEC4
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 14:41:33 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-113-20.ams2.redhat.com
 [10.36.113.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 27074756AC;
 Mon, 17 Aug 2020 14:41:31 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 115/150] meson: convert hw/hyperv
Date: Mon, 17 Aug 2020 16:40:18 +0200
Message-Id: <20200817144053.345107-20-pbonzini@redhat.com>
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 02:47:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
 hw/Makefile.objs        | 1 -
 hw/hyperv/Makefile.objs | 3 ---
 hw/hyperv/meson.build   | 3 +++
 hw/meson.build          | 1 +
 4 files changed, 4 insertions(+), 4 deletions(-)
 delete mode 100644 hw/hyperv/Makefile.objs
 create mode 100644 hw/hyperv/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 22eb804730..a2c2f6d1de 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -9,7 +9,6 @@ devices-dirs-y += cpu/
 devices-dirs-y += display/
 devices-dirs-y += dma/
 devices-dirs-y += gpio/
-devices-dirs-$(CONFIG_HYPERV) += hyperv/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/hyperv/Makefile.objs b/hw/hyperv/Makefile.objs
deleted file mode 100644
index 5b614e040c..0000000000
--- a/hw/hyperv/Makefile.objs
+++ /dev/null
@@ -1,3 +0,0 @@
-obj-y += hyperv.o
-obj-$(CONFIG_HYPERV_TESTDEV) += hyperv_testdev.o
-obj-$(CONFIG_VMBUS) += vmbus.o
diff --git a/hw/hyperv/meson.build b/hw/hyperv/meson.build
new file mode 100644
index 0000000000..1367e2994f
--- /dev/null
+++ b/hw/hyperv/meson.build
@@ -0,0 +1,3 @@
+specific_ss.add(when: 'CONFIG_HYPERV', if_true: files('hyperv.c'))
+specific_ss.add(when: 'CONFIG_HYPERV_TESTDEV', if_true: files('hyperv_testdev.c'))
+specific_ss.add(when: 'CONFIG_VMBUS', if_true: files('vmbus.c'))
diff --git a/hw/meson.build b/hw/meson.build
index 983edc1d47..f9e5adfb48 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,4 +1,5 @@
 subdir('core')
+subdir('hyperv')
 subdir('i2c')
 subdir('ide')
 subdir('input')
-- 
2.26.2



