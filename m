Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02949C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 14:48:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C02BC2053B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 14:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cuV/NtVL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C02BC2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipCcx-0005zZ-RO
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 09:48:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35699)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ipCcA-0005Ye-TG
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 09:47:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ipCc7-0000Cw-Mz
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 09:47:16 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25181
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ipCc7-0000Bq-JT
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 09:47:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578494834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+P64Op5kXdyr44sSYnJhQgsBlxsdA/C1mpZ03+NH/7w=;
 b=cuV/NtVLD64GtRhX8JVwZvmHLNT8BovPgxSFPLAFrYv3TRGLYi6QlzdTgbJ5sXY3WsWxlm
 newZ2bMDgTt3JwMuuQ3sGUvGX8RfuF2NY/sDMtBp3S9ZQ5NMacupBrIn3A1PSY5PhcRSF8
 40I8eWh1OG6Ftz6M4pZXwJikUolNwW4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-SyzEfSkCN_ei8GpX-hasRA-1; Wed, 08 Jan 2020 09:47:13 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D59A100551C
 for <qemu-devel@nongnu.org>; Wed,  8 Jan 2020 14:47:12 +0000 (UTC)
Received: from thuth.com (ovpn-117-114.ams2.redhat.com [10.36.117.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 33B80272D1;
 Wed,  8 Jan 2020 14:47:05 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v3] ui: Print available display backends with '-display help'
Date: Wed,  8 Jan 2020 15:47:02 +0100
Message-Id: <20200108144702.29969-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: SyzEfSkCN_ei8GpX-hasRA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We already print availabled devices with "-device help", or available
backends with "-netdev help" or "-chardev help". Let's provide a way
for the users to query the available display backends, too.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v3: Mention -display help in the qemu-doc, too (as suggested by Philippe)

 include/ui/console.h |  1 +
 qemu-options.hx      |  3 ++-
 ui/console.c         | 15 +++++++++++++++
 vl.c                 |  5 +++++
 4 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 281f9c145b..f35b4fc082 100644
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
diff --git a/qemu-options.hx b/qemu-options.hx
index e9d6231438..d593931664 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1586,7 +1586,8 @@ STEXI
 @item -display @var{type}
 @findex -display
 Select type of display to use. This option is a replacement for the
-old style -sdl/-curses/... options. Valid values for @var{type} are
+old style -sdl/-curses/... options. Use @code{-display help} to list
+the available display types. Valid values for @var{type} are
 @table @option
 @item sdl
 Display video output via SDL (usually in a separate graphics
diff --git a/ui/console.c b/ui/console.c
index ac79d679f5..69339b028b 100644
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
index 86474a55c9..ee15055ba2 100644
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
--=20
2.18.1


