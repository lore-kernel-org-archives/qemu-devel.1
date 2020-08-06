Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2514EC433E1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 20:08:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DEAB221E5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 20:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cYmKAK+m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DEAB221E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3mBF-0006vi-4e
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 16:08:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3lQQ-0001Cn-4m
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 15:19:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20232
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3lQO-0006mV-9H
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 15:19:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596741575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZEckp85hEASX/c9Pi/aHv0+vFvZQymj5t3VUndnI1GA=;
 b=cYmKAK+m2KKbG34atmlWyWclyeAe7RIQOqgsBLD+EoPn24//khlZFpBQCMY0YppQcocbL+
 WpVQdf8wtiXVm/q546/IE56yjOpg1zR6FV0E9+N97B0/n2TXy6M/o92APUKIQ9XxYcq6Ly
 nsdbV+b4DgR+bq0ViOtd/GsulKhu0NA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-_MwL8f7PNF-2R-KsbeTHmw-1; Thu, 06 Aug 2020 15:19:31 -0400
X-MC-Unique: _MwL8f7PNF-2R-KsbeTHmw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3DDA2107BEF6
 for <qemu-devel@nongnu.org>; Thu,  6 Aug 2020 19:19:30 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4F7BA5F9DC;
 Thu,  6 Aug 2020 19:19:29 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 105/143] meson: convert hw/isa
Date: Thu,  6 Aug 2020 21:15:41 +0200
Message-Id: <1596741379-12902-106-git-send-email-pbonzini@redhat.com>
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
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 03:10:56
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
 hw/Makefile.objs     |  1 -
 hw/isa/Makefile.objs | 11 -----------
 hw/isa/meson.build   | 11 +++++++++++
 hw/meson.build       |  1 +
 4 files changed, 12 insertions(+), 12 deletions(-)
 delete mode 100644 hw/isa/Makefile.objs
 create mode 100644 hw/isa/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index ac8278e..a28e211 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -16,7 +16,6 @@ devices-dirs-y += input/
 devices-dirs-y += intc/
 devices-dirs-$(CONFIG_IPACK) += ipack/
 devices-dirs-$(CONFIG_IPMI) += ipmi/
-devices-dirs-y += isa/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/isa/Makefile.objs b/hw/isa/Makefile.objs
deleted file mode 100644
index 8e73960..0000000
--- a/hw/isa/Makefile.objs
+++ /dev/null
@@ -1,11 +0,0 @@
-common-obj-$(CONFIG_ISA_BUS) += isa-bus.o
-common-obj-$(CONFIG_ISA_SUPERIO) += isa-superio.o
-common-obj-$(CONFIG_APM) += apm.o
-common-obj-$(CONFIG_I82378) += i82378.o
-common-obj-$(CONFIG_PC87312) += pc87312.o
-common-obj-$(CONFIG_PIIX3) += piix3.o
-common-obj-$(CONFIG_PIIX4) += piix4.o
-common-obj-$(CONFIG_VT82C686) += vt82c686.o
-common-obj-$(CONFIG_SMC37C669) += smc37c669-superio.o
-
-obj-$(CONFIG_LPC_ICH9) += lpc_ich9.o
diff --git a/hw/isa/meson.build b/hw/isa/meson.build
new file mode 100644
index 0000000..8bf678c
--- /dev/null
+++ b/hw/isa/meson.build
@@ -0,0 +1,11 @@
+softmmu_ss.add(when: 'CONFIG_APM', if_true: files('apm.c'))
+softmmu_ss.add(when: 'CONFIG_I82378', if_true: files('i82378.c'))
+softmmu_ss.add(when: 'CONFIG_ISA_BUS', if_true: files('isa-bus.c'))
+softmmu_ss.add(when: 'CONFIG_ISA_SUPERIO', if_true: files('isa-superio.c'))
+softmmu_ss.add(when: 'CONFIG_PC87312', if_true: files('pc87312.c'))
+softmmu_ss.add(when: 'CONFIG_PIIX3', if_true: files('piix3.c'))
+softmmu_ss.add(when: 'CONFIG_PIIX4', if_true: files('piix4.c'))
+softmmu_ss.add(when: 'CONFIG_SMC37C669', if_true: files('smc37c669-superio.c'))
+softmmu_ss.add(when: 'CONFIG_VT82C686', if_true: files('vt82c686.c'))
+
+specific_ss.add(when: 'CONFIG_LPC_ICH9', if_true: files('lpc_ich9.c'))
diff --git a/hw/meson.build b/hw/meson.build
index 6ca82b0..8659854 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,4 +1,5 @@
 subdir('core')
+subdir('isa')
 subdir('mem')
 subdir('misc')
 subdir('net')
-- 
1.8.3.1



