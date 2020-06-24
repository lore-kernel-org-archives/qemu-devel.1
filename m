Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260CCC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 11:40:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9F4320706
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 11:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OnkSivII"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9F4320706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo3lt-0006oZ-4K
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 07:40:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jo3cC-0004H1-HL
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 07:30:52 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44504
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jo3c2-0007yO-Mh
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 07:30:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592998241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fxo3dbFBxieNlMytfnHAQZ3LI1U1CwPdO9VU35QwSe8=;
 b=OnkSivIIWe2hHmn1+Z09m12jtCG6Il2/dLYjDmhs3fp3CabaTiJFqR4cEvvQglkflHR5Nq
 Ezg8V+Fi348+RuFiBO+wGlhOsYfhJhEs2W7BbxiWsiouLDtBOwKI7UYPo74OAoLkATWU6b
 t9TeVHpzWgGvcdP+Yva0ZPrvT9bWxM8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-j3SZwzFhNm26N3k5datTPg-1; Wed, 24 Jun 2020 07:30:38 -0400
X-MC-Unique: j3SZwzFhNm26N3k5datTPg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD7A518A8220;
 Wed, 24 Jun 2020 11:30:36 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-67.ams2.redhat.com
 [10.36.112.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7BA695C240;
 Wed, 24 Jun 2020 11:30:27 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id AB7CF97DC; Wed, 24 Jun 2020 13:30:26 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 02/20] stubs: add pci_create_simple
Date: Wed, 24 Jun 2020 13:30:08 +0200
Message-Id: <20200624113026.13343-3-kraxel@redhat.com>
In-Reply-To: <20200624113026.13343-1-kraxel@redhat.com>
References: <20200624113026.13343-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 01:59:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-ppc@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 libvir-list@redhat.com,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
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
index 869204668231..5d61e0d0da5b 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -12,6 +12,7 @@ stub-obj-$(CONFIG_LINUX_AIO) += linux-aio.o
 stub-obj-$(CONFIG_LINUX_IO_URING) += io_uring.o
 stub-obj-y += monitor-core.o
 stub-obj-y += notify-event.o
+stub-obj-y += pci-bus.o
 stub-obj-y += qmp_memory_device.o
 stub-obj-y += qtest.o
 stub-obj-y += ramfb.o
-- 
2.18.4


