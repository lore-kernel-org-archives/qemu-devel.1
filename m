Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEEB9C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 13:18:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7698E20720
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 13:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bI/Fis5g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7698E20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo5Ht-0004wy-O2
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 09:18:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41130)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jo5BI-0002iU-R2
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 09:11:12 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45474)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jo5BH-0001Wx-2A
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 09:11:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593004270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=RuiijUWj1ZCPXbzPBVaOwDx7Q4COaTIHHfreG3eeExc=;
 b=bI/Fis5gfwDhnX4tY1Aa/Klimd+di1XTUa5ESyfiRBQR7Y7D7Ue/Wju23DT9dyzfw7Apvp
 TKP77ocRFFLDHhDXDxWp7E6cMiqiBOidO2dL6iDdBmmCkm8NKAv8Ru9qgb62Zki+bSfrrn
 KGwgWz2nCYNn+vZ17w+w+8+l1XFHwAM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-io9uhg0VMjCDwX7yjBktyA-1; Wed, 24 Jun 2020 09:11:06 -0400
X-MC-Unique: io9uhg0VMjCDwX7yjBktyA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D3E2810059A0
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 13:11:04 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-67.ams2.redhat.com
 [10.36.112.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BD16610016DA;
 Wed, 24 Jun 2020 13:10:55 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id E11D831E22; Wed, 24 Jun 2020 15:10:45 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 07/10] vga: build qxl as module
Date: Wed, 24 Jun 2020 15:10:42 +0200
Message-Id: <20200624131045.14512-8-kraxel@redhat.com>
In-Reply-To: <20200624131045.14512-1-kraxel@redhat.com>
References: <20200624131045.14512-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 00:34:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 dinechin@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

First step in making spice support modular.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 util/module.c            | 2 ++
 hw/Makefile.objs         | 1 +
 hw/display/Makefile.objs | 5 ++++-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/util/module.c b/util/module.c
index e3226165e91c..7c76d2a84b94 100644
--- a/util/module.c
+++ b/util/module.c
@@ -264,6 +264,8 @@ static struct {
     { "ccid-card-passthru",    "hw-", "usb-smartcard"         },
     { "ccid-card-emulated",    "hw-", "usb-smartcard"         },
     { "usb-redir",             "hw-", "usb-redirect"          },
+    { "qxl-vga",               "hw-", "display-qxl"           },
+    { "qxl",                   "hw-", "display-qxl"           },
 };
 
 static bool module_loaded_qom_all;
diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index af8fd9a510ed..14b7ea4eb62e 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -43,5 +43,6 @@ devices-dirs-y += smbios/
 endif
 
 common-obj-y += $(devices-dirs-y)
+common-obj-m += display/
 common-obj-m += usb/
 obj-y += $(devices-dirs-y)
diff --git a/hw/display/Makefile.objs b/hw/display/Makefile.objs
index 77a7d622bd2d..76b3571e4902 100644
--- a/hw/display/Makefile.objs
+++ b/hw/display/Makefile.objs
@@ -44,7 +44,10 @@ common-obj-$(CONFIG_ARTIST) += artist.o
 
 obj-$(CONFIG_VGA) += vga.o
 
-common-obj-$(CONFIG_QXL) += qxl.o qxl-logger.o qxl-render.o
+ifeq ($(CONFIG_QXL),y)
+common-obj-m += qxl.mo
+qxl.mo-objs = qxl.o qxl-logger.o qxl-render.o
+endif
 
 obj-$(CONFIG_VIRTIO_GPU) += virtio-gpu-base.o virtio-gpu.o virtio-gpu-3d.o
 obj-$(CONFIG_VHOST_USER_GPU) += vhost-user-gpu.o
-- 
2.18.4


