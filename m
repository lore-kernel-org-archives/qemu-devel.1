Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F57C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 14:36:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4487820671
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 14:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J+A7XBcG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4487820671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZbSE-00061U-EI
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 10:36:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42010)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jZbRB-0004Gg-J3
 for qemu-devel@nongnu.org; Fri, 15 May 2020 10:35:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55256
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jZbR9-0007vt-Vd
 for qemu-devel@nongnu.org; Fri, 15 May 2020 10:35:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589553343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=cp/2ui0tlH8lhPnT5RA7r+CowqQM6Y0K53DWdoQXRic=;
 b=J+A7XBcGrTeNFWaOXv8OinQ3WAXsj8m9KMiGUtd2k4KkB6UDc70CtUkyQ6ufFe/9sBYhqv
 mSsgynwj76LsrSdhlBNp7lD4fxwUlaSrqFzYIRbkBSkWIQ68w1jJ23F+MOozHDSc0MTAE1
 Q1G014Cm8uJw0ygzSZRIslzXpylo+HE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-rIzGOjXhOxuxWtKI6oGiXQ-1; Fri, 15 May 2020 10:35:41 -0400
X-MC-Unique: rIzGOjXhOxuxWtKI6oGiXQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C6DE8005AD
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 14:35:40 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-115-145.ams2.redhat.com
 [10.36.115.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 238162E16D;
 Fri, 15 May 2020 14:35:38 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 056D99DAF; Fri, 15 May 2020 16:35:29 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 06/13] audio: deprecate -soundhw adlib
Date: Fri, 15 May 2020 16:35:21 +0200
Message-Id: <20200515143528.13591-7-kraxel@redhat.com>
In-Reply-To: <20200515143528.13591-1-kraxel@redhat.com>
References: <20200515143528.13591-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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

Switch to deprecated_register_soundhw().
Remove the now obsolete init function.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/audio/adlib.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/hw/audio/adlib.c b/hw/audio/adlib.c
index 7c3b67dcfb8c..65dff5b6fca4 100644
--- a/hw/audio/adlib.c
+++ b/hw/audio/adlib.c
@@ -319,16 +319,10 @@ static const TypeInfo adlib_info = {
     .class_init    = adlib_class_initfn,
 };
 
-static int Adlib_init (ISABus *bus)
-{
-    isa_create_simple (bus, TYPE_ADLIB);
-    return 0;
-}
-
 static void adlib_register_types (void)
 {
     type_register_static (&adlib_info);
-    isa_register_soundhw("adlib", ADLIB_DESC, Adlib_init);
+    deprecated_register_soundhw("adlib", ADLIB_DESC, 1, TYPE_ADLIB);
 }
 
 type_init (adlib_register_types)
-- 
2.18.4


