Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60322C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 14:39:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F0602078C
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 14:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bHOPYYFT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F0602078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZbUt-0003iR-EZ
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 10:39:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jZbRB-0004H8-V5
 for qemu-devel@nongnu.org; Fri, 15 May 2020 10:35:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35172
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jZbRA-0007wE-QH
 for qemu-devel@nongnu.org; Fri, 15 May 2020 10:35:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589553344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OmcZB/3f1J5kbTiAqV773hRmE+pXsUs3yHQfmUAD/cw=;
 b=bHOPYYFTjrFhmOXxFivJaHOQ1u1esSxs9OuXdDk7T1pKStybN4YtqXQghzCuYcbd+Wzljg
 L0kQmGxnRA7T1FFV6+yETK2ruFZPomQuCMdfP7eLqCwvLxAGuXnkc30qFoZAQoeGbWsjtG
 STJ5chGtw0URpfB+cY29nx0F7nUoaQQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-j0mp-hdoNM6Z14xENyJvWg-1; Fri, 15 May 2020 10:35:39 -0400
X-MC-Unique: j0mp-hdoNM6Z14xENyJvWg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B2BD9107ACCA
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 14:35:38 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-115-145.ams2.redhat.com
 [10.36.115.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 033265D9F1;
 Fri, 15 May 2020 14:35:29 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id D21231750A; Fri, 15 May 2020 16:35:28 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 02/13] stubs: add pci_create_simple
Date: Fri, 15 May 2020 16:35:17 +0200
Message-Id: <20200515143528.13591-3-kraxel@redhat.com>
In-Reply-To: <20200515143528.13591-1-kraxel@redhat.com>
References: <20200515143528.13591-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 23:27:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: libvir-list@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Needed for -soundhw cleanup.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 stubs/pci-bus.c     | 7 +++++++
 stubs/Makefile.objs | 1 +
 2 files changed, 8 insertions(+)
 create mode 100644 stubs/pci-bus.c

diff --git a/stubs/pci-bus.c b/stubs/pci-bus.c
new file mode 100644
index 000000000000..a8932fa93250
--- /dev/null
+++ b/stubs/pci-bus.c
@@ -0,0 +1,7 @@
+#include "qemu/osdep.h"
+#include "hw/pci/pci.h"
+
+PCIDevice *pci_create_simple(PCIBus *bus, int devfn, const char *name)
+{
+    g_assert_not_reached();
+}
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index c61ff38cc801..5e7f2b3f061e 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -40,6 +40,7 @@ stub-obj-y += target-get-monitor-def.o
 stub-obj-y += vmgenid.o
 stub-obj-y += xen-common.o
 stub-obj-y += xen-hvm.o
+stub-obj-y += pci-bus.o
 stub-obj-y += pci-host-piix.o
 stub-obj-y += ram-block.o
 stub-obj-y += ramfb.o
-- 
2.18.4


