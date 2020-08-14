Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91158C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 10:05:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47BE52074D
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 10:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VTA2j013"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47BE52074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6WaG-0001Al-DZ
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 06:05:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k6VnX-0007Ok-9g
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 05:14:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39561
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k6VnV-00037I-G8
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 05:14:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597396488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jOIdmTH1CYl8LnZvB8zBwKIw7Tiq/rsBYfxJzBvBBYc=;
 b=VTA2j013GSPkH49UKjfNMSC++AAqrc7aSXA0UjSz66KDnBiNlW5E345Fz9laVPgKf00QaR
 Wv8F/nIFzjt0i+/5RysAzfs3rQBYilwVt5jiA5T1xHtELDHG0jW18e29miSvhQd9LBv6qK
 +CQPIKRQC8/+IqkdO0TkM/cyZ8vcDhY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-giPwdbwUPpy_GjTZoneOKw-1; Fri, 14 Aug 2020 05:14:46 -0400
X-MC-Unique: giPwdbwUPpy_GjTZoneOKw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE06D1853DA0;
 Fri, 14 Aug 2020 09:14:44 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 892C5600E4;
 Fri, 14 Aug 2020 09:14:43 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 110/150] meson: convert hw/ipmi
Date: Fri, 14 Aug 2020 05:12:46 -0400
Message-Id: <20200814091326.16173-111-pbonzini@redhat.com>
In-Reply-To: <20200814091326.16173-1-pbonzini@redhat.com>
References: <20200814091326.16173-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 03:37:30
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Corey Minyard <cminyard@mvista.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Corey Minyard <cminyard@mvista.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/Makefile.objs      |  1 -
 hw/ipmi/Makefile.objs |  8 --------
 hw/ipmi/meson.build   | 11 +++++++++++
 hw/meson.build        |  1 +
 4 files changed, 12 insertions(+), 9 deletions(-)
 delete mode 100644 hw/ipmi/Makefile.objs
 create mode 100644 hw/ipmi/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index a28e211e78..f136377866 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -15,7 +15,6 @@ devices-dirs-y += ide/
 devices-dirs-y += input/
 devices-dirs-y += intc/
 devices-dirs-$(CONFIG_IPACK) += ipack/
-devices-dirs-$(CONFIG_IPMI) += ipmi/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/ipmi/Makefile.objs b/hw/ipmi/Makefile.objs
deleted file mode 100644
index 3cca10bc50..0000000000
--- a/hw/ipmi/Makefile.objs
+++ /dev/null
@@ -1,8 +0,0 @@
-common-obj-$(CONFIG_IPMI) += ipmi.o ipmi_kcs.o ipmi_bt.o
-common-obj-$(CONFIG_IPMI_LOCAL) += ipmi_bmc_sim.o
-common-obj-$(CONFIG_IPMI_EXTERN) += ipmi_bmc_extern.o
-common-obj-$(CONFIG_ISA_IPMI_KCS) += isa_ipmi_kcs.o
-common-obj-$(CONFIG_PCI_IPMI_KCS) += pci_ipmi_kcs.o
-common-obj-$(CONFIG_ISA_IPMI_BT) += isa_ipmi_bt.o
-common-obj-$(CONFIG_PCI_IPMI_BT) += pci_ipmi_bt.o
-common-obj-$(CONFIG_IPMI_SSIF) += smbus_ipmi.o
diff --git a/hw/ipmi/meson.build b/hw/ipmi/meson.build
new file mode 100644
index 0000000000..9622ea2a2c
--- /dev/null
+++ b/hw/ipmi/meson.build
@@ -0,0 +1,11 @@
+ipmi_ss = ss.source_set()
+ipmi_ss.add(when: 'CONFIG_IPMI', if_true: files('ipmi.c', 'ipmi_kcs.c', 'ipmi_bt.c'))
+ipmi_ss.add(when: 'CONFIG_IPMI_LOCAL', if_true: files('ipmi_bmc_sim.c'))
+ipmi_ss.add(when: 'CONFIG_IPMI_EXTERN', if_true: files('ipmi_bmc_extern.c'))
+ipmi_ss.add(when: 'CONFIG_ISA_IPMI_KCS', if_true: files('isa_ipmi_kcs.c'))
+ipmi_ss.add(when: 'CONFIG_PCI_IPMI_KCS', if_true: files('pci_ipmi_kcs.c'))
+ipmi_ss.add(when: 'CONFIG_ISA_IPMI_BT', if_true: files('isa_ipmi_bt.c'))
+ipmi_ss.add(when: 'CONFIG_PCI_IPMI_BT', if_true: files('pci_ipmi_bt.c'))
+ipmi_ss.add(when: 'CONFIG_IPMI_SSIF', if_true: files('smbus_ipmi.c'))
+
+softmmu_ss.add_all(when: 'CONFIG_IPMI', if_true: ipmi_ss)
diff --git a/hw/meson.build b/hw/meson.build
index 86598544e6..9796f95e5c 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,4 +1,5 @@
 subdir('core')
+subdir('ipmi')
 subdir('isa')
 subdir('mem')
 subdir('misc')
-- 
2.26.2



