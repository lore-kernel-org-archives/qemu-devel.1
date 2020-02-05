Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87681C35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 11:07:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 574172082E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 11:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ES2YU/Qu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 574172082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izIWX-00017M-He
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 06:07:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45776)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1izITW-0004zk-Pp
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:04:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1izITV-0000Eu-Mt
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:04:06 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30416
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1izITV-00008z-Hu
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:04:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580900645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qlxHxz0zsWQXA64ftvzgeTgLUBZNT7Gc2SdOZ8OYyN8=;
 b=ES2YU/QumkNFPNgQxDj+B2eKuQz9lKo9jcjyEQrJMVpvNfj3DFlD/oRmDA9k+uFwkcHO1p
 oWQ8gpBQ4UA/sBKSZZKtSPuPCYJG2DvTg44Lrsux0S/KTnjS+g13kDX3yLa+kmfAVVRDV+
 y8xcAlLGyhOCSqp8RzR+7oShgKSGvtY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-nCXWEgKiN-2WsxLDsBPnPw-1; Wed, 05 Feb 2020 06:04:03 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 883D61063BA1;
 Wed,  5 Feb 2020 11:04:02 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-112.ams2.redhat.com
 [10.36.116.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 613DB86CCC;
 Wed,  5 Feb 2020 11:03:57 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 880799CAF; Wed,  5 Feb 2020 12:03:56 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/5] ui: add show-cursor option
Date: Wed,  5 Feb 2020 12:03:52 +0100
Message-Id: <20200205110356.3491-2-kraxel@redhat.com>
In-Reply-To: <20200205110356.3491-1-kraxel@redhat.com>
References: <20200205110356.3491-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: nCXWEgKiN-2WsxLDsBPnPw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: libvir-list@redhat.com, Markus Armbruster <armbru@redhat.com>,
 jpewhacker@gmail.com, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When enabled forces showing a the mouse cursor, i.e. do
nowallow the guest to hide it.  Defaults to off.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 qapi/ui.json | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/qapi/ui.json b/qapi/ui.json
index e04525d8b44b..7c516a455631 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -1144,6 +1144,7 @@
 # @type:          Which DisplayType qemu should use.
 # @full-screen:   Start user interface in fullscreen mode (default: off).
 # @window-close:  Allow to quit qemu with window close button (default: on=
).
+# @show-cursor:   Force showing the mouse cursor (default: off).
 # @gl:            Enable OpenGL support (default: off).
 #
 # Since: 2.12
@@ -1153,6 +1154,7 @@
   'base'    : { 'type'           : 'DisplayType',
                 '*full-screen'   : 'bool',
                 '*window-close'  : 'bool',
+                '*show-cursor'   : 'bool',
                 '*gl'            : 'DisplayGLMode' },
   'discriminator' : 'type',
   'data'    : { 'gtk'            : 'DisplayGTK',
--=20
2.18.1


