Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4D3C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 17:51:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91F5F20866
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 17:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gnw4+PrQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91F5F20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5Bxa-0006iK-O9
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 13:51:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BKv-0001km-28
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:11:49 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45396
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BKt-0003CY-9w
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:11:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597079506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FeJr7xGjJhKpS36/pmB6exc5b/mrhwqIzGTHcaw4KUY=;
 b=Gnw4+PrQJ3lDktBbHQsqmcU2UH9UWLWRBLamUTsC2s78dV/YGK9kNuawHaZOGmcermAql+
 nhM7kftpOXrKUsX9iRbVWLdM36gCW/YS2jZUmg5dkQ0FmG/tWPtxHLv0REg4FJxz+DSfFc
 LaFPeJFNHqxr6mJ5cQP9NLBLG+j08uc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-nfjMpXS4MH2_f5IH0hgDIw-1; Mon, 10 Aug 2020 13:11:44 -0400
X-MC-Unique: nfjMpXS4MH2_f5IH0hgDIw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D76A1005504
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 17:11:44 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1809387D69;
 Mon, 10 Aug 2020 17:11:42 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 092/147] meson: convert hw/tpm
Date: Mon, 10 Aug 2020 19:08:10 +0200
Message-Id: <1597079345-42801-93-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
References: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 03:29:25
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
 hw/Makefile.objs     | 1 -
 hw/meson.build       | 1 +
 hw/tpm/Makefile.objs | 6 ------
 hw/tpm/meson.build   | 8 ++++++++
 4 files changed, 9 insertions(+), 7 deletions(-)
 delete mode 100644 hw/tpm/Makefile.objs
 create mode 100644 hw/tpm/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index c2619bb..f0e5728 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -29,7 +29,6 @@ devices-dirs-$(CONFIG_SCSI) += scsi/
 devices-dirs-y += sd/
 devices-dirs-y += ssi/
 devices-dirs-y += timer/
-devices-dirs-$(CONFIG_TPM) += tpm/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/meson.build b/hw/meson.build
index 89bd6ad..2ddf6ba 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -3,6 +3,7 @@ subdir('mem')
 subdir('nubus')
 subdir('semihosting')
 subdir('smbios')
+subdir('tpm')
 subdir('usb')
 subdir('vfio')
 subdir('virtio')
diff --git a/hw/tpm/Makefile.objs b/hw/tpm/Makefile.objs
deleted file mode 100644
index 6fc05be..0000000
--- a/hw/tpm/Makefile.objs
+++ /dev/null
@@ -1,6 +0,0 @@
-obj-$(call lor,$(CONFIG_TPM_TIS),$(CONFIG_TPM_CRB)) += tpm_ppi.o
-common-obj-$(CONFIG_TPM_TIS_ISA) += tpm_tis_isa.o
-common-obj-$(CONFIG_TPM_TIS_SYSBUS) += tpm_tis_sysbus.o
-common-obj-$(CONFIG_TPM_TIS) += tpm_tis_common.o
-common-obj-$(CONFIG_TPM_CRB) += tpm_crb.o
-obj-$(CONFIG_TPM_SPAPR) += tpm_spapr.o
diff --git a/hw/tpm/meson.build b/hw/tpm/meson.build
new file mode 100644
index 0000000..1c68d81
--- /dev/null
+++ b/hw/tpm/meson.build
@@ -0,0 +1,8 @@
+softmmu_ss.add(when: 'CONFIG_TPM_TIS', if_true: files('tpm_tis_common.c'))
+softmmu_ss.add(when: 'CONFIG_TPM_TIS_ISA', if_true: files('tpm_tis_isa.c'))
+softmmu_ss.add(when: 'CONFIG_TPM_TIS_SYSBUS', if_true: files('tpm_tis_sysbus.c'))
+softmmu_ss.add(when: 'CONFIG_TPM_CRB', if_true: files('tpm_crb.c'))
+
+specific_ss.add(when: ['CONFIG_SOFTMMU', 'CONFIG_TPM_TIS'], if_true: files('tpm_ppi.c'))
+specific_ss.add(when: ['CONFIG_SOFTMMU', 'CONFIG_TPM_CRB'], if_true: files('tpm_ppi.c'))
+specific_ss.add(when: 'CONFIG_TPM_SPAPR', if_true: files('tpm_spapr.c'))
-- 
1.8.3.1



