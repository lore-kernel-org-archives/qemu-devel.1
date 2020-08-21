Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3767FC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 11:16:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06DB52072D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 11:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PKAsgZpz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06DB52072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k952O-00058p-8y
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 07:16:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k94EY-0003RT-2g
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:25:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43340)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k94EO-0001mw-AE
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:25:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598005502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NfyB9OFP3NC+XP2rys2fAFHGh1rpKodm28QmEjGLxY8=;
 b=PKAsgZpzbzOOKi6TrLqXB76Kdw0tdoZrOC7UncnIj5iaPStSGcDkmf8O4C9ONKp4sx7vUe
 5q2R0Uy0yvhUwLtPlSFyQQg1YGnN9O1/ia5huVN4yVT7PWwLK89GB+07cCRB+OBeg2/RT0
 6PKi17hnysuDFsEQ7n/uMyQ2iRuEcLU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-a2MtuIigPAekIUCj-b4foQ-1; Fri, 21 Aug 2020 06:25:01 -0400
X-MC-Unique: a2MtuIigPAekIUCj-b4foQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 61C12191E2A1
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 10:25:00 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1B90960BF1;
 Fri, 21 Aug 2020 10:25:00 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v8 112/152] meson: convert hw/ipack
Date: Fri, 21 Aug 2020 06:22:49 -0400
Message-Id: <20200821102329.29777-113-pbonzini@redhat.com>
In-Reply-To: <20200821102329.29777-1-pbonzini@redhat.com>
References: <20200821102329.29777-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 04:26:32
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
 hw/Makefile.objs       | 1 -
 hw/ipack/Makefile.objs | 2 --
 hw/ipack/meson.build   | 1 +
 hw/meson.build         | 1 +
 4 files changed, 2 insertions(+), 3 deletions(-)
 delete mode 100644 hw/ipack/Makefile.objs
 create mode 100644 hw/ipack/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index f136377866..76d9305959 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -14,7 +14,6 @@ devices-dirs-$(CONFIG_I2C) += i2c/
 devices-dirs-y += ide/
 devices-dirs-y += input/
 devices-dirs-y += intc/
-devices-dirs-$(CONFIG_IPACK) += ipack/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/ipack/Makefile.objs b/hw/ipack/Makefile.objs
deleted file mode 100644
index 8b9bdcb549..0000000000
--- a/hw/ipack/Makefile.objs
+++ /dev/null
@@ -1,2 +0,0 @@
-common-obj-$(CONFIG_IPACK) += ipack.o
-common-obj-$(CONFIG_IPACK) += tpci200.o
diff --git a/hw/ipack/meson.build b/hw/ipack/meson.build
new file mode 100644
index 0000000000..3f8138b6f2
--- /dev/null
+++ b/hw/ipack/meson.build
@@ -0,0 +1 @@
+softmmu_ss.add(when: 'CONFIG_IPACK', if_true: files('ipack.c', 'tpci200.c'))
diff --git a/hw/meson.build b/hw/meson.build
index 9796f95e5c..ec4bb48a0f 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,4 +1,5 @@
 subdir('core')
+subdir('ipack')
 subdir('ipmi')
 subdir('isa')
 subdir('mem')
-- 
2.26.2



