Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42109C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 13:20:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09C40206C3
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 13:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O4WYuxBB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09C40206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgpmr-0005PI-8R
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 09:20:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58790)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jgpkN-0000Io-Nf
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 09:17:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58521
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jgpkM-00027R-9c
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 09:17:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591276645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=v4m2/6tExjydV9qQemlct9DMIRH8OcH+rQj+BKqE29A=;
 b=O4WYuxBBSE0s6tkiP273BARQfnPd4XbdjCAuL9QWr/JdyHlg7SiDBJT+GwRGUhyUrlXSdY
 pbgbb4Tu9qBbIHyi9yGoLo74HnmiR7BOBg8YTP2+kl1EtZ4f87QLWD5zdJ1fYPn1gwNg/U
 /imh2y+qnKKvD56XhxYkG4TmwAOOUfc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-eaWrS5zoOTW1i60dynYKZw-1; Thu, 04 Jun 2020 09:17:21 -0400
X-MC-Unique: eaWrS5zoOTW1i60dynYKZw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CAD58184C5ED
 for <qemu-devel@nongnu.org>; Thu,  4 Jun 2020 13:17:05 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-50.ams2.redhat.com
 [10.36.113.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CE3F219D71;
 Thu,  4 Jun 2020 13:16:44 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 00C7117516; Thu,  4 Jun 2020 15:16:44 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/7] usb: build usb-redir as module
Date: Thu,  4 Jun 2020 15:16:40 +0200
Message-Id: <20200604131643.1776-5-kraxel@redhat.com>
In-Reply-To: <20200604131643.1776-1-kraxel@redhat.com>
References: <20200604131643.1776-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 01:12:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: dinechin@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Drops libusbredirparser.so dependency from core qemu.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/core/qdev.c       | 1 +
 hw/usb/Makefile.objs | 9 ++++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 36c301750c31..cab971758b26 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -158,6 +158,7 @@ static struct {
 } const hwmodules[] = {
     { .type = "ccid-card-passthru",    .mod = "usb-smartcard"         },
     { .type = "ccid-card-emulated",    .mod = "usb-smartcard"         },
+    { .type = "usb-redir",             .mod = "usb-redirect"          },
 };
 
 static bool qdev_module_loaded_all;
diff --git a/hw/usb/Makefile.objs b/hw/usb/Makefile.objs
index d8e340cd0748..5619a3b23981 100644
--- a/hw/usb/Makefile.objs
+++ b/hw/usb/Makefile.objs
@@ -42,9 +42,12 @@ endif
 
 # usb redirection
 ifeq ($(CONFIG_USB),y)
-common-obj-$(CONFIG_USB_REDIR) += redirect.o quirks.o
-redirect.o-cflags = $(USB_REDIR_CFLAGS)
-redirect.o-libs = $(USB_REDIR_LIBS)
+ifeq ($(CONFIG_USB-REDIR),y)
+common-obj-m += redirect.mo
+redirect.mo-objs = redirect.o quirks.o
+redirect.mo-cflags = $(USB_REDIR_CFLAGS)
+redirect.mo-libs = $(USB_REDIR_LIBS)
+endif
 endif
 
 # usb pass-through
-- 
2.18.4


