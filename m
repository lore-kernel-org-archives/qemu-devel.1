Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4F0CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 07:55:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B23B321897
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 07:55:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B23B321897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLN6z-0004u4-GO
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 03:55:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59285)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iLMta-0006KU-JO
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 03:42:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iLMtV-00073c-BL
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 03:41:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51388)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iLMtV-00071n-3t
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 03:41:53 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C70B9C05AA6C;
 Fri, 18 Oct 2019 07:41:50 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-43.ams2.redhat.com
 [10.36.116.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D1F6C60925;
 Fri, 18 Oct 2019 07:41:44 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 1ECF79D26; Fri, 18 Oct 2019 09:41:44 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/13] audio: paaudio: fix connection and stream name
Date: Fri, 18 Oct 2019 09:41:33 +0200
Message-Id: <20191018074144.24071-3-kraxel@redhat.com>
In-Reply-To: <20191018074144.24071-1-kraxel@redhat.com>
References: <20191018074144.24071-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Fri, 18 Oct 2019 07:41:50 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kővágó@redhat.com, =?UTF-8?q?Zolt=C3=A1n?= <DirtY.iCE.hu@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <dirty.ice.hu@gmail.com>

Connection name was previously erroneously set to the server socket
path, while connection names were simply "qemu".  After this patch, the
connection name will be the vm name (falling back to "qemu" if not
specified), while stream names will be the audiodev's id.

Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail.com=
>
Message-id: 3d139426031a400a68d440608ba5e43f0e116cd8.1568157545.git.DirtY=
.iCE.hu@gmail.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/paaudio.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/audio/paaudio.c b/audio/paaudio.c
index ed31f863f7fe..3e6580a5ee50 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -2,6 +2,7 @@
=20
 #include "qemu/osdep.h"
 #include "qemu/module.h"
+#include "qemu-common.h"
 #include "audio.h"
 #include "qapi/opts-visitor.h"
=20
@@ -338,7 +339,7 @@ static int qpa_init_out(HWVoiceOut *hw, struct audset=
tings *as,
=20
     pa->stream =3D qpa_simple_new (
         c,
-        "qemu",
+        g->dev->id,
         PA_STREAM_PLAYBACK,
         ppdo->has_name ? ppdo->name : NULL,
         &ss,
@@ -387,7 +388,7 @@ static int qpa_init_in(HWVoiceIn *hw, struct audsetti=
ngs *as, void *drv_opaque)
=20
     pa->stream =3D qpa_simple_new (
         c,
-        "qemu",
+        g->dev->id,
         PA_STREAM_RECORD,
         ppdo->has_name ? ppdo->name : NULL,
         &ss,
@@ -549,6 +550,7 @@ static int qpa_validate_per_direction_opts(Audiodev *=
dev,
 /* common */
 static void *qpa_conn_init(const char *server)
 {
+    const char *vm_name;
     PAConnection *c =3D g_malloc0(sizeof(PAConnection));
     QTAILQ_INSERT_TAIL(&pa_conns, c, list);
=20
@@ -557,8 +559,9 @@ static void *qpa_conn_init(const char *server)
         goto fail;
     }
=20
+    vm_name =3D qemu_get_vm_name();
     c->context =3D pa_context_new(pa_threaded_mainloop_get_api(c->mainlo=
op),
-                                server);
+                                vm_name ? vm_name : "qemu");
     if (!c->context) {
         goto fail;
     }
--=20
2.18.1


