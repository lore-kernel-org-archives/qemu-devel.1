Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D425C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 13:16:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E099920720
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 13:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="APLgU+dz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E099920720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo5GN-0002LQ-WD
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 09:16:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jo5BB-0002Ms-92
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 09:11:05 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54572
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jo5B9-0001UG-Fa
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 09:11:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593004262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=REtVIWqECp2RF/bhZhco8JE7WwVgyZrlNd3wZE3Hf70=;
 b=APLgU+dzJt5gccn8okYK+ngKEzNr8Po0cF3WNdOwd6Ax+1zktxd9yGAejNXjo1ri197uh5
 sMln6Dtof0eggB915Yx2QJraXoOdnCUQCbPqAnIB3DYtpoBsNSCOJp2VM4yE5kLQ7NkiZF
 VKUT7pv4YlNKd8687tbph1ad+15/Zho=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-sq4IGbjyM36kvOsl7w-C2Q-1; Wed, 24 Jun 2020 09:10:56 -0400
X-MC-Unique: sq4IGbjyM36kvOsl7w-C2Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A290805EE1
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 13:10:56 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-67.ams2.redhat.com
 [10.36.112.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C47885C660;
 Wed, 24 Jun 2020 13:10:55 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id D577859D8; Wed, 24 Jun 2020 15:10:45 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 06/10] usb: build usb-redir as module
Date: Wed, 24 Jun 2020 15:10:41 +0200
Message-Id: <20200624131045.14512-7-kraxel@redhat.com>
In-Reply-To: <20200624131045.14512-1-kraxel@redhat.com>
References: <20200624131045.14512-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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

Drops libusbredirparser.so dependency from core qemu.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 util/module.c        | 1 +
 hw/usb/Makefile.objs | 9 ++++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/util/module.c b/util/module.c
index 89da9a3cce05..e3226165e91c 100644
--- a/util/module.c
+++ b/util/module.c
@@ -263,6 +263,7 @@ static struct {
 } const qom_modules[] = {
     { "ccid-card-passthru",    "hw-", "usb-smartcard"         },
     { "ccid-card-emulated",    "hw-", "usb-smartcard"         },
+    { "usb-redir",             "hw-", "usb-redirect"          },
 };
 
 static bool module_loaded_qom_all;
diff --git a/hw/usb/Makefile.objs b/hw/usb/Makefile.objs
index 3c5b3d4fadd3..e342ff59fab0 100644
--- a/hw/usb/Makefile.objs
+++ b/hw/usb/Makefile.objs
@@ -43,9 +43,12 @@ endif
 
 # usb redirection
 ifeq ($(CONFIG_USB),y)
-common-obj-$(CONFIG_USB_REDIR) += redirect.o quirks.o
-redirect.o-cflags = $(USB_REDIR_CFLAGS)
-redirect.o-libs = $(USB_REDIR_LIBS)
+ifeq ($(CONFIG_USB_REDIR),y)
+common-obj-m += redirect.mo
+redirect.mo-objs = redirect.o quirks.o
+redirect.mo-cflags = $(USB_REDIR_CFLAGS)
+redirect.mo-libs = $(USB_REDIR_LIBS)
+endif
 endif
 
 # usb pass-through
-- 
2.18.4


