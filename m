Return-Path: <SRS0=K/vF=5H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0CB4C4332B
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 16:15:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FCD420724
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 16:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MQqyMUIQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FCD420724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jG3GD-0006Hi-OF
	for qemu-devel@archiver.kernel.org; Sun, 22 Mar 2020 12:15:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45105)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jG3DB-0004u6-4d
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 12:12:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jG3D9-00009P-8p
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 12:12:28 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:50470)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jG3D9-00009I-2k
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 12:12:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584893546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Ji4ipok2gvXfKtww6JdtgIfCEym4oZt3Md4BqZnYqnM=;
 b=MQqyMUIQyl7PbRij7c6h5Xrfxdwl+kjpQsZPRnWAaIGXx1D8HC/Vc08s3yHgV26SuzgYT2
 yFPYR+X4VfLnMMh8Q9V+xhTQ4lpCLtI9Xwzia+zTOv4/8CRuBMjZagRPA8EcadGYOwBCTT
 zyHHG/0Uj5HXNzyVfk69gAJJtHBsIX8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-5hyZBY9gOiGNVLT-b5Oi7Q-1; Sun, 22 Mar 2020 12:12:24 -0400
X-MC-Unique: 5hyZBY9gOiGNVLT-b5Oi7Q-1
Received: by mail-wr1-f71.google.com with SMTP id t4so6007563wrr.1
 for <qemu-devel@nongnu.org>; Sun, 22 Mar 2020 09:12:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=yDGS28nvZoUiQCU5JnG8noL5Ya4dg0T5NJrmni0R0iY=;
 b=AfxaIfTCQqYfcOyFXG91ZGkoZlraxUMEfHUR/ukzX0xPhJ1ewrNdDtu73ub/uDvHfQ
 zapBd96Lekja+McU/uQUVpeKS1+joSjyD11k6ed9zQ67AbEsA9TyaoeMUYfa3fqNmRov
 LsJ/L2dQd3L5nrcqjjUtCqMggiY33pmgJG3gcEp3/LvzHhV1w+SZGMEtRbRvgSH3/DVg
 7/iIQTDDYl98JoTrGZpg9o91t+GWw7X6tAJ+OgM9wgzrAw8EUppZOSiz84idlApQ5p3j
 8gH05fwcXk4VLaTBoxCAEYpwknyl9QQ6Dmxa/TXQJs24pwXK/NuzLfYp/hV1huGG5h3D
 BNhQ==
X-Gm-Message-State: ANhLgQ1J8jqAoVHxjNVU97a0fPvX/A9CT/9QJruPKa4ScCgQoCpm505G
 G15c9h7+JaGSm/U+1oT6Yj9AYplw9G2kItpHYREhamZwvjnd6YDsValSzLAr+5BeIA/qFrEXyWf
 HVAzzXmGeYC+Ls/k=
X-Received: by 2002:a05:6000:105:: with SMTP id
 o5mr581699wrx.395.1584893543100; 
 Sun, 22 Mar 2020 09:12:23 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsuKejBF+92qLKR9S9cyzaC24W+xTS0hSQD8O2kT5eVnsh4B5wcJfnbBsuQzpT8Mz9aC0m6Cg==
X-Received: by 2002:a05:6000:105:: with SMTP id
 o5mr581677wrx.395.1584893542844; 
 Sun, 22 Mar 2020 09:12:22 -0700 (PDT)
Received: from localhost.localdomain (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id i2sm342367wrx.22.2020.03.22.09.12.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Mar 2020 09:12:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0] ui/input-linux: Do not ignore ioctl() return value
Date: Sun, 22 Mar 2020 17:12:19 +0100
Message-Id: <20200322161219.17757-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
---
 ui/input-linux.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/ui/input-linux.c b/ui/input-linux.c
index a7b280b25b..ef37b14d6f 100644
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
2.21.1


