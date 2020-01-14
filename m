Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9F6C33CB2
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 10:03:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46D592465B
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 10:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KDy8QcML"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46D592465B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irJ2X-0003Km-V4
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 05:03:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36448)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1irJ0x-0001dT-RH
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 05:01:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1irJ0w-0007xq-9V
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 05:01:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22507
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1irJ0w-0007xc-5j
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 05:01:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578996093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kR2nVww05ym0vlHchhoZc7r2HWmOi45mH/ICojPZnUA=;
 b=KDy8QcMLvR4H3Cp/B5VwPJwGEkQy/UeNJeHQmYuHoq1tJ/SO+8ZFNOvCrl1Jgmae8zl5Y5
 aSJoJYo7WAJjzwPgI0xadlJWzlbw4wA5+A/+F6Fv65ooqmDrlKIkFDusazG72YaomTIs3A
 WqqZmEuk2sCP7M0l39bnttdLKN9Kwy4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-wfU8bavKNu-sfIUuM_NkRQ-1; Tue, 14 Jan 2020 05:01:29 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4A82DBA5
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 10:01:28 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-106.ams2.redhat.com
 [10.36.116.106])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EC42C19C5B;
 Tue, 14 Jan 2020 10:01:25 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 275C1784F; Tue, 14 Jan 2020 11:01:25 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/2] ui: Print available display backends with '-display help'
Date: Tue, 14 Jan 2020 11:01:24 +0100
Message-Id: <20200114100125.31604-2-kraxel@redhat.com>
In-Reply-To: <20200114100125.31604-1-kraxel@redhat.com>
References: <20200114100125.31604-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: wfU8bavKNu-sfIUuM_NkRQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

We already print availabled devices with "-device help", or available
backends with "-netdev help" or "-chardev help". Let's provide a way
for the users to query the available display backends, too.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-id: 20200108144702.29969-1-thuth@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/ui/console.h |  1 +
 ui/console.c         | 15 +++++++++++++++
 vl.c                 |  5 +++++
 qemu-options.hx      |  3 ++-
 4 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 281f9c145b58..f35b4fc082b4 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -442,6 +442,7 @@ void qemu_display_register(QemuDisplay *ui);
 bool qemu_display_find_default(DisplayOptions *opts);
 void qemu_display_early_init(DisplayOptions *opts);
 void qemu_display_init(DisplayState *ds, DisplayOptions *opts);
+void qemu_display_help(void);
=20
 /* vnc.c */
 void vnc_display_init(const char *id, Error **errp);
diff --git a/ui/console.c b/ui/console.c
index ac79d679f576..69339b028bb2 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -2333,6 +2333,21 @@ void qemu_display_init(DisplayState *ds, DisplayOpti=
ons *opts)
     dpys[opts->type]->init(ds, opts);
 }
=20
+void qemu_display_help(void)
+{
+    int idx;
+
+    printf("Available display backend types:\n");
+    for (idx =3D DISPLAY_TYPE_NONE; idx < DISPLAY_TYPE__MAX; idx++) {
+        if (!dpys[idx]) {
+            ui_module_load_one(DisplayType_str(idx));
+        }
+        if (dpys[idx]) {
+            printf("%s\n",  DisplayType_str(dpys[idx]->type));
+        }
+    }
+}
+
 void qemu_chr_parse_vc(QemuOpts *opts, ChardevBackend *backend, Error **er=
rp)
 {
     int val;
diff --git a/vl.c b/vl.c
index 158a05ed321c..751401214c80 100644
--- a/vl.c
+++ b/vl.c
@@ -1869,6 +1869,11 @@ static void parse_display(const char *p)
 {
     const char *opts;
=20
+    if (is_help_option(p)) {
+        qemu_display_help();
+        exit(0);
+    }
+
     if (strstart(p, "sdl", &opts)) {
         /*
          * sdl DisplayType needs hand-crafted parser instead of
diff --git a/qemu-options.hx b/qemu-options.hx
index d4b73ef60c1d..709162c159ad 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1669,7 +1669,8 @@ STEXI
 @item -display @var{type}
 @findex -display
 Select type of display to use. This option is a replacement for the
-old style -sdl/-curses/... options. Valid values for @var{type} are
+old style -sdl/-curses/... options. Use @code{-display help} to list
+the available display types. Valid values for @var{type} are
 @table @option
 @item sdl
 Display video output via SDL (usually in a separate graphics
--=20
2.18.1


