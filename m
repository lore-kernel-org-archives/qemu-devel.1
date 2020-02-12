Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F6CC352A4
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 16:21:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6640020714
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 16:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LEPJcDxC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6640020714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1ulh-00078D-Hl
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 11:21:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33493)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1j1uix-0001gk-Q2
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:18:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1j1uiw-0004a0-PS
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:18:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42158
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1j1uiw-0004ZJ-Lz
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:18:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581524330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PfQTOmWOlDzI/+7N6tPThzcwKfX1cEBhIh686otkctY=;
 b=LEPJcDxCfJbFzKbkGqX13q1eOJbLaI2Dnvxf49pCnSiH4O5dBfoBCRGY/vWeAMz0X3O85m
 l/kRj6msbQr9RbUtVOhinhdZFHaIDqsQ+uFaFal3//dIaK4EInUs4znStk+fNbTK/VpOAg
 FBIN/RistL9bNSjVbCkGggiM48oQ2iY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-eoJH4TZ5O4CNvVY87NlP3g-1; Wed, 12 Feb 2020 11:18:46 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7CBC88010F3;
 Wed, 12 Feb 2020 16:18:45 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-39.ams2.redhat.com
 [10.36.117.39])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 527245C1B2;
 Wed, 12 Feb 2020 16:18:44 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 0865931E32; Wed, 12 Feb 2020 17:18:36 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/10] ui/cocoa: switch to new show-cursor option
Date: Wed, 12 Feb 2020 17:18:31 +0100
Message-Id: <20200212161835.28576-7-kraxel@redhat.com>
In-Reply-To: <20200212161835.28576-1-kraxel@redhat.com>
References: <20200212161835.28576-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: eoJH4TZ5O4CNvVY87NlP3g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>, libvir-list@redhat.com,
 Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use DisplayOpts settings to set the new file-global cursor_hide
variable, stop using the qemu-global cursor_hide variable.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: J=C3=A1n Tomko <jtomko@redhat.com>
---
 ui/cocoa.m | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index fbb5b1b45f81..f7b323044582 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -125,6 +125,7 @@ typedef struct {
 NSWindow *normalWindow, *about_window;
 static DisplayChangeListener *dcl;
 static int last_buttons;
+static int cursor_hide =3D 1;
=20
 int gArgc;
 char **gArgv;
@@ -1918,6 +1919,9 @@ static void cocoa_display_init(DisplayState *ds, Disp=
layOptions *opts)
             [(QemuCocoaAppController *)[[NSApplication sharedApplication] =
delegate] toggleFullScreen: nil];
         });
     }
+    if (opts->has_show_cursor && opts->show_cursor) {
+        cursor_hide =3D 0;
+    }
=20
     dcl =3D g_malloc0(sizeof(DisplayChangeListener));
=20
--=20
2.18.2


