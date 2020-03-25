Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6A7C54FD0
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 11:09:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78FB620714
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 11:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="igc7A8GK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78FB620714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH3ux-0005Jc-K5
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 07:09:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37966)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jH3kM-0000MR-3A
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:58:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1jH3kJ-0006j2-PP
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:58:53 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:40839)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1jH3kJ-0006iO-Kx
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:58:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585133931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gB4woRW/Nzbg26Mg/GNQXB3WuMZDhaHiX1vwdbRO+tE=;
 b=igc7A8GKoccufNrgXmxpFNZ9FTUHJGGX4IvluM7a+FrAJMeu4WXyS3K0XZVFrO3itVjGOb
 2YDpKEyTHkHWrwwiK5zM139qEqtzWFtCpGBQAVfJWw34LMYCzXRNDFtlXNhKfEyZE0m/DN
 0RWZJFhBNCJQ38R5Offl6DGFnofDbYY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-Bs1AHv8CNrGzuRpjMkw3Eg-1; Wed, 25 Mar 2020 06:58:48 -0400
X-MC-Unique: Bs1AHv8CNrGzuRpjMkw3Eg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E8878018B1
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 10:58:48 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-49.ams2.redhat.com
 [10.36.112.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D1BDF60C18;
 Wed, 25 Mar 2020 10:58:44 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id D87DA9D43; Wed, 25 Mar 2020 11:58:43 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/2] ui/input-linux: Do not ignore ioctl() return value
Date: Wed, 25 Mar 2020 11:58:42 +0100
Message-Id: <20200325105843.17387-2-kraxel@redhat.com>
In-Reply-To: <20200325105843.17387-1-kraxel@redhat.com>
References: <20200325105843.17387-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Fix warnings reported by Clang static code analyzer:

    CC      ui/input-linux.o
      ui/input-linux.c:343:9: warning: Value stored to 'rc' is never read
          rc =3D ioctl(il->fd, EVIOCGBIT(EV_REL, sizeof(relmap)), &relmap);
          ^    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      ui/input-linux.c:351:9: warning: Value stored to 'rc' is never read
          rc =3D ioctl(il->fd, EVIOCGBIT(EV_ABS, sizeof(absmap)), &absmap);
          ^    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      ui/input-linux.c:354:13: warning: Value stored to 'rc' is never read
              rc =3D ioctl(il->fd, EVIOCGABS(ABS_X), &absinfo);
              ^    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      ui/input-linux.c:357:13: warning: Value stored to 'rc' is never read
              rc =3D ioctl(il->fd, EVIOCGABS(ABS_Y), &absinfo);
              ^    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      ui/input-linux.c:365:9: warning: Value stored to 'rc' is never read
          rc =3D ioctl(il->fd, EVIOCGBIT(EV_KEY, sizeof(keymap)), keymap);
          ^    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      ui/input-linux.c:366:9: warning: Value stored to 'rc' is never read
          rc =3D ioctl(il->fd, EVIOCGKEY(sizeof(keystate)), keystate);
          ^    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Message-id: 20200322161219.17757-1-philmd@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/input-linux.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/ui/input-linux.c b/ui/input-linux.c
index a7b280b25b98..ef37b14d6f22 100644
--- a/ui/input-linux.c
+++ b/ui/input-linux.c
@@ -334,13 +334,15 @@ static void input_linux_complete(UserCreatable *uc, E=
rror **errp)
=20
     rc =3D ioctl(il->fd, EVIOCGBIT(0, sizeof(evtmap)), &evtmap);
     if (rc < 0) {
-        error_setg(errp, "%s: failed to read event bits", il->evdev);
-        goto err_close;
+        goto err_read_event_bits;
     }
=20
     if (evtmap & (1 << EV_REL)) {
         relmap =3D 0;
         rc =3D ioctl(il->fd, EVIOCGBIT(EV_REL, sizeof(relmap)), &relmap);
+        if (rc < 0) {
+            goto err_read_event_bits;
+        }
         if (relmap & (1 << REL_X)) {
             il->has_rel_x =3D true;
         }
@@ -349,12 +351,25 @@ static void input_linux_complete(UserCreatable *uc, E=
rror **errp)
     if (evtmap & (1 << EV_ABS)) {
         absmap =3D 0;
         rc =3D ioctl(il->fd, EVIOCGBIT(EV_ABS, sizeof(absmap)), &absmap);
+        if (rc < 0) {
+            goto err_read_event_bits;
+        }
         if (absmap & (1 << ABS_X)) {
             il->has_abs_x =3D true;
             rc =3D ioctl(il->fd, EVIOCGABS(ABS_X), &absinfo);
+            if (rc < 0) {
+                error_setg(errp, "%s: failed to get get absolute X value",
+                           il->evdev);
+                goto err_close;
+            }
             il->abs_x_min =3D absinfo.minimum;
             il->abs_x_max =3D absinfo.maximum;
             rc =3D ioctl(il->fd, EVIOCGABS(ABS_Y), &absinfo);
+            if (rc < 0) {
+                error_setg(errp, "%s: failed to get get absolute Y value",
+                           il->evdev);
+                goto err_close;
+            }
             il->abs_y_min =3D absinfo.minimum;
             il->abs_y_max =3D absinfo.maximum;
         }
@@ -363,7 +378,14 @@ static void input_linux_complete(UserCreatable *uc, Er=
ror **errp)
     if (evtmap & (1 << EV_KEY)) {
         memset(keymap, 0, sizeof(keymap));
         rc =3D ioctl(il->fd, EVIOCGBIT(EV_KEY, sizeof(keymap)), keymap);
+        if (rc < 0) {
+            goto err_read_event_bits;
+        }
         rc =3D ioctl(il->fd, EVIOCGKEY(sizeof(keystate)), keystate);
+        if (rc < 0) {
+            error_setg(errp, "%s: failed to get global key state", il->evd=
ev);
+            goto err_close;
+        }
         for (i =3D 0; i < KEY_CNT; i++) {
             if (keymap[i / 8] & (1 << (i % 8))) {
                 if (linux_is_button(i)) {
@@ -390,6 +412,9 @@ static void input_linux_complete(UserCreatable *uc, Err=
or **errp)
     il->initialized =3D true;
     return;
=20
+err_read_event_bits:
+    error_setg(errp, "%s: failed to read event bits", il->evdev);
+
 err_close:
     close(il->fd);
     return;
--=20
2.18.2


