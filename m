Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F5BC83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 11:06:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFD8F206C0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 11:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZNsPueYr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFD8F206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTkXu-00019v-Rw
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 07:06:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44794)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jTkUs-0005Ae-1u
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 07:03:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jTkTv-0003ma-0p
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 07:03:21 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29027
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jTkTu-0003lo-KC
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 07:02:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588158141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VAdLDhz6Qh7ovRYkXWjD79W/T/Cg9GrR3PS+WxGbdoI=;
 b=ZNsPueYret6nECkNEw/RpFCtx9mHlI1s2hR4bojqr68jLZGre8o+84qLN73X6NiVqqYsQy
 ZprvpjKUv+PnmHv0IcBQ55nCAMmvVjfExpRIDqTvmnS3m82dbBlH+TnujLOU4ldPa8b+1G
 wctf+x8tvW5govJb4mB9TyMIYwli92w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-jG_COuaRPuOiLYmqc5px7Q-1; Wed, 29 Apr 2020 07:02:19 -0400
X-MC-Unique: jG_COuaRPuOiLYmqc5px7Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB802108C30D
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 11:02:18 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-193.ams2.redhat.com
 [10.36.113.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 046AF5C1C8;
 Wed, 29 Apr 2020 11:02:16 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 164689D9B; Wed, 29 Apr 2020 13:02:15 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/12] stubs: add pci_create_simple
Date: Wed, 29 Apr 2020 13:02:04 +0200
Message-Id: <20200429110214.29037-3-kraxel@redhat.com>
In-Reply-To: <20200429110214.29037-1-kraxel@redhat.com>
References: <20200429110214.29037-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:28:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Needed for -soundhw cleanup.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 stubs/pci-bus.c     | 7 +++++++
 stubs/Makefile.objs | 1 +
 2 files changed, 8 insertions(+)
 create mode 100644 stubs/pci-bus.c

diff --git a/stubs/pci-bus.c b/stubs/pci-bus.c
new file mode 100644
index 000000000000..e833947f1f41
--- /dev/null
+++ b/stubs/pci-bus.c
@@ -0,0 +1,7 @@
+#include "qemu/osdep.h"
+#include "hw/pci/pci.h"
+
+PCIDevice *pci_create_simple(PCIBus *bus, int devfn, const char *name)
+{
+    return NULL;
+}
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index c61ff38cc801..5e7f2b3f061e 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -40,6 +40,7 @@ stub-obj-y +=3D target-get-monitor-def.o
 stub-obj-y +=3D vmgenid.o
 stub-obj-y +=3D xen-common.o
 stub-obj-y +=3D xen-hvm.o
+stub-obj-y +=3D pci-bus.o
 stub-obj-y +=3D pci-host-piix.o
 stub-obj-y +=3D ram-block.o
 stub-obj-y +=3D ramfb.o
--=20
2.18.2


