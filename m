Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7888C352A4
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:30:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 782F021741
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CGX/Rqls"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 782F021741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izfMn-0001mS-Jb
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 06:30:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40179)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1izfLV-0008Se-OQ
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:29:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1izfLT-0001yj-EN
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:29:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53358
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1izfLT-0001wN-Ab
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:29:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580988559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZjHJ0Bqyt9dFXRMBUV2U+b5uGLlCm46yUZcuR0/UrW0=;
 b=CGX/Rqls7mMvgrsg93EZqL+umLKsI02iJYB1iRGpizV9iUSuj5xJbWHQnl45VjfP5+SaRu
 YW3a5y/jwZ1VIMOS3tzp95QBmWF3ws7OMez6tX0/jN4EUDheRruaLAA/CmHLW9mjBfB/jE
 qoud37t/cIF7kyuv8BJIuSGJWfXus6c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-LhWjibADNXq5_wgee-ThIQ-1; Thu, 06 Feb 2020 06:29:16 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E97A0101FC6C;
 Thu,  6 Feb 2020 11:29:14 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-112.ams2.redhat.com
 [10.36.116.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D444884DB8;
 Thu,  6 Feb 2020 11:29:09 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 05BEA9D7F; Thu,  6 Feb 2020 12:29:09 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/6] ui: add show-cursor option
Date: Thu,  6 Feb 2020 12:29:03 +0100
Message-Id: <20200206112908.5002-2-kraxel@redhat.com>
In-Reply-To: <20200206112908.5002-1-kraxel@redhat.com>
References: <20200206112908.5002-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: LhWjibADNXq5_wgee-ThIQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>, jtomko@redhat.com,
 libvir-list@redhat.com, Markus Armbruster <armbru@redhat.com>,
 jpewhacker@gmail.com, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When enabled, this forces showing the mouse cursor, i.e. do
not allow the guest to hide it.  Defaults to off.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: J=C3=A1n Tomko <jtomko@redhat.com>
---
 qapi/ui.json | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/qapi/ui.json b/qapi/ui.json
index e04525d8b44b..b9df7fe7b5cb 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -1144,6 +1144,8 @@
 # @type:          Which DisplayType qemu should use.
 # @full-screen:   Start user interface in fullscreen mode (default: off).
 # @window-close:  Allow to quit qemu with window close button (default: on=
).
+# @show-cursor:   Force showing the mouse cursor (default: off).
+#                 Since: 5.0
 # @gl:            Enable OpenGL support (default: off).
 #
 # Since: 2.12
@@ -1153,6 +1155,7 @@
   'base'    : { 'type'           : 'DisplayType',
                 '*full-screen'   : 'bool',
                 '*window-close'  : 'bool',
+                '*show-cursor'   : 'bool',
                 '*gl'            : 'DisplayGLMode' },
   'discriminator' : 'type',
   'data'    : { 'gtk'            : 'DisplayGTK',
--=20
2.18.1


