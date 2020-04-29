Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280ABC83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 11:09:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E57DC2072A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 11:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eWa/3s/S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E57DC2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTkb7-0005ty-2q
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 07:09:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44814)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jTkUu-0005BC-1f
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 07:03:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jTkTw-0003qF-4w
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 07:03:23 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38665
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jTkTv-0003n2-JO
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 07:02:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588158142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CGI6929XT3WDPTBfh8WRGmzTNqGkYLrFczKvF3RsMAk=;
 b=eWa/3s/SUb+J6nrwCLE+8xZixl13teP2jMM3TLvsqv9/HZEpmWsyJOP6K9hYssQCiA1EwV
 f2X+6IEtPQmMQDIYipt5938SW6FaU/1xURwL9bJQxGouUEmo5jfU96ZQudg1zT0HZ/yq+Y
 VTYTjKKF/yVzlehH4xh+4fNDKhe49Xk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-c9qzpF6nNfONNYFYjiQsrA-1; Wed, 29 Apr 2020 07:02:19 -0400
X-MC-Unique: c9qzpF6nNfONNYFYjiQsrA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7C31801504
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 11:02:18 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-193.ams2.redhat.com
 [10.36.113.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0E4EF282E2;
 Wed, 29 Apr 2020 11:02:16 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 0C3009D99; Wed, 29 Apr 2020 13:02:15 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/12] stubs: add isa_create_simple
Date: Wed, 29 Apr 2020 13:02:03 +0200
Message-Id: <20200429110214.29037-2-kraxel@redhat.com>
In-Reply-To: <20200429110214.29037-1-kraxel@redhat.com>
References: <20200429110214.29037-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 00:53:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
 stubs/isa-bus.c     | 7 +++++++
 stubs/Makefile.objs | 1 +
 2 files changed, 8 insertions(+)
 create mode 100644 stubs/isa-bus.c

diff --git a/stubs/isa-bus.c b/stubs/isa-bus.c
new file mode 100644
index 000000000000..cbebaed4ad04
--- /dev/null
+++ b/stubs/isa-bus.c
@@ -0,0 +1,7 @@
+#include "qemu/osdep.h"
+#include "hw/isa/isa.h"
+
+ISADevice *isa_create_simple(ISABus *bus, const char *name)
+{
+    return NULL;
+}
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 45be5dc0ed78..c61ff38cc801 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -13,6 +13,7 @@ stub-obj-y +=3D get-vm-name.o
 stub-obj-y +=3D iothread.o
 stub-obj-y +=3D iothread-lock.o
 stub-obj-y +=3D is-daemonized.o
+stub-obj-y +=3D isa-bus.o
 stub-obj-$(CONFIG_LINUX_AIO) +=3D linux-aio.o
 stub-obj-$(CONFIG_LINUX_IO_URING) +=3D io_uring.o
 stub-obj-y +=3D machine-init-done.o
--=20
2.18.2


