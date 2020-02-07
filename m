Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDB3C352A4
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 10:20:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49EE321741
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 10:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D4fSSXFE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49EE321741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j00kR-00040t-GG
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 05:20:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47073)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1j00iB-0007zw-7V
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 05:18:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1j00iA-0008Sz-8r
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 05:18:11 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40773
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1j00iA-0008SY-5h
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 05:18:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581070689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CTQyHIsyqt7g4h/Ul7McZ/o8NU7L021kZi8vKyPQzPs=;
 b=D4fSSXFEKFjl5fbbESqKLxeCG7+qtCR+PALEaRIhIKMyqAr1BXTusyNr4lIhsoAz1qcVuX
 6DsYm1ON82pMOV1O6PaRqJKqiGsl8KD71BXImWrxhKyuik8NzZzdxaNIxG38ABfrj2Wi38
 Ev2r3oxrozCWiNN14mJjRCcy3NHyjOA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-AY8Bv3FDNlOHfiVIuo6WdQ-1; Fri, 07 Feb 2020 05:18:06 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E7B91088388;
 Fri,  7 Feb 2020 10:18:05 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-112.ams2.redhat.com
 [10.36.116.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2C92D1001B07;
 Fri,  7 Feb 2020 10:18:00 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 956F231F06; Fri,  7 Feb 2020 11:17:53 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 5/7] ui/gtk: implement show-cursor option
Date: Fri,  7 Feb 2020 11:17:51 +0100
Message-Id: <20200207101753.25812-6-kraxel@redhat.com>
In-Reply-To: <20200207101753.25812-1-kraxel@redhat.com>
References: <20200207101753.25812-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: AY8Bv3FDNlOHfiVIuo6WdQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Peter Maydell <peter.maydell@linaro.org>, jtomko@redhat.com,
 libvir-list@redhat.com, Markus Armbruster <armbru@redhat.com>,
 jpewhacker@gmail.com, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When specified just set null_cursor to NULL so we get the default
pointer instead of a blank pointer.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/gtk.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index d18892d1de61..a685d1ae0848 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -2243,8 +2243,12 @@ static void gtk_display_init(DisplayState *ds, Displ=
ayOptions *opts)
     textdomain("qemu");
=20
     window_display =3D gtk_widget_get_display(s->window);
-    s->null_cursor =3D gdk_cursor_new_for_display(window_display,
-                                                GDK_BLANK_CURSOR);
+    if (s->opts->has_show_cursor && s->opts->show_cursor) {
+        s->null_cursor =3D NULL; /* default pointer */
+    } else {
+        s->null_cursor =3D gdk_cursor_new_for_display(window_display,
+                                                    GDK_BLANK_CURSOR);
+    }
=20
     s->mouse_mode_notifier.notify =3D gd_mouse_mode_change;
     qemu_add_mouse_mode_change_notifier(&s->mouse_mode_notifier);
--=20
2.18.1


