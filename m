Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61439C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 14:01:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE1C420738
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 14:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dQBCA7qz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE1C420738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnN0R-0002oi-QT
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 10:01:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57276)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jnMvr-0005SD-4n
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 09:56:19 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33079
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jnMvn-0007j6-VA
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 09:56:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592834175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=W8gbI8KRCrUVM0ZRjcx8SDNrJaT9c2nnHM26ICBr8o0=;
 b=dQBCA7qzAlPuavxwhOq5XbQZK5qROZc7786SGjISW4a4gwFC5YuLBwuloGNwbKhHmlBKD/
 uT0O2zda3ASG5ITVyQoVQFzvoL86ygqshYd2U0g/OgMgg+NSkULQeHZvSs4IUjboDYyHX0
 vhP2h+4gGN3+9nyG2uFEo3vE+kj2ZV8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-9_fskh8xOfK4C5PiMNF_ow-1; Mon, 22 Jun 2020 09:56:10 -0400
X-MC-Unique: 9_fskh8xOfK4C5PiMNF_ow-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B77757097
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 13:56:09 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-67.ams2.redhat.com
 [10.36.112.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4BC0B5C1BD;
 Mon, 22 Jun 2020 13:56:03 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 519CE9D8F; Mon, 22 Jun 2020 15:56:01 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 4/7] usb: build usb-redir as module
Date: Mon, 22 Jun 2020 15:55:58 +0200
Message-Id: <20200622135601.12433-5-kraxel@redhat.com>
In-Reply-To: <20200622135601.12433-1-kraxel@redhat.com>
References: <20200622135601.12433-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 02:57:26
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
Cc: dinechin@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
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
index d6459e4aa8e8..e77f40db675c 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -174,6 +174,7 @@ static struct {
 } const hwmodules[] = {
     { .type = "ccid-card-passthru",    .mod = "usb-smartcard"         },
     { .type = "ccid-card-emulated",    .mod = "usb-smartcard"         },
+    { .type = "usb-redir",             .mod = "usb-redirect"          },
 };
 
 static bool qdev_module_loaded_all;
diff --git a/hw/usb/Makefile.objs b/hw/usb/Makefile.objs
index 3c5b3d4fadd3..3bb8dd53421a 100644
--- a/hw/usb/Makefile.objs
+++ b/hw/usb/Makefile.objs
@@ -43,9 +43,12 @@ endif
 
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


