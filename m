Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD438C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 16:53:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC9A2206D7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 16:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MwX6jkIE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC9A2206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igtcH-0000NA-7t
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 11:53:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57021)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtFL-0005Mq-8X
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtFK-0007yu-3n
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:23 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38269)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1igtFJ-0007w6-Tz
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:22 -0500
Received: by mail-wr1-x444.google.com with SMTP id y17so8050674wrh.5
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 08:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8QhwqaPFLSp6FHYlalgsR7gbeayOVVyGZFS6tWZHxJo=;
 b=MwX6jkIEC6wEDHV1SZ1+JcP8fX/ZK1HD01hDXjtivjvRCQgmPlS8hIi2mYJvHUAMEE
 u/yu7k8KSqxOg+okHX/I8O6d47aqNm7XlXwX4p6f2UjodncGxuJey3NPbNlMJsWzAr+p
 jCtcyLQpjuRk/zo98FyUCjxQBcgIITwtdsPGG35DWrvVecOeMrPPXIMo8OmFaNCT7DRN
 JaogPei/zE8odMl4otlibktabWkbdmIzVPX6BhtmJGyn0eHB92n8vkExF/HiIkvVdEEq
 v7fgtO1SSBQrKIYcfXqrwFjk9cukmynUbV2SwLfPr/cSbIYv4+rs5UEp+Ybs4u4XBmi7
 DdNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=8QhwqaPFLSp6FHYlalgsR7gbeayOVVyGZFS6tWZHxJo=;
 b=E7AQJLv7AvR6k7k/7v+JrHJMMoYIkmQu7lgauFsIdlywcydP6pMZPsQdGms8LBXKbQ
 5XDD6Jp/hbCZS6Yl+L1erTHuDST7TjIsiFKZRCyjjJKBekO+F+n8vJxbE4HT/DpZhu54
 fbzqsAV/vHqw4eYVYZSXdrDr2MRO92yy22cQrbIIAAOEXts9zm4zohlZvyX0qnSOF0G6
 RM3oGn2CFp4bwr8610XaOZMfhUY0jfhAgEUkVBsfBA9FIdpF5S3xkFJNygkMjcqHGWsO
 4qwE+2vJKmtepuO93557MH/imDiBKtr5ZBd4tdFX5ZqB9Hs/S8bgZbo4Js6pnfIxAdMa
 nBBQ==
X-Gm-Message-State: APjAAAUqbI1q7wtVuahvU5PYBzdn1FJDqyMpvlPP5ApCFbVrT0IKTJtZ
 NljThe3quDQpo/FAYQ+YncrniAvj
X-Google-Smtp-Source: APXvYqySCjL49ZgAn9Kr7jjPGkGQ+PI4drR8P4MR42F2QP9MQONbb5OP5iuWZSOuhGjzUj7saunEWg==
X-Received: by 2002:a5d:6a52:: with SMTP id t18mr30171598wrw.391.1576513760786; 
 Mon, 16 Dec 2019 08:29:20 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id q68sm19962334wme.14.2019.12.16.08.29.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Dec 2019 08:29:19 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 33/62] build-sys: do not include Windows SLIRP dependencies in
 $LIBS
Date: Mon, 16 Dec 2019 17:28:17 +0100
Message-Id: <1576513726-53700-34-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
References: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When including the internal SLIRP library, we should add all the libraries that
it needs for the build.  Right now they are all included by QEMU, but -liphlpapi
is not needed without slirp.  Move it from LIBS to slirp_libs.

Based on a patch by Marc-André Lureau.

Acked-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 2c72e04..8fb26ad 100755
--- a/configure
+++ b/configure
@@ -926,7 +926,7 @@ if test "$mingw32" = "yes" ; then
   DSOSUF=".dll"
   # MinGW needs -mthreads for TLS and macro _MT.
   QEMU_CFLAGS="-mthreads $QEMU_CFLAGS"
-  LIBS="-lwinmm -lws2_32 -liphlpapi $LIBS"
+  LIBS="-lwinmm -lws2_32 $LIBS"
   write_c_skeleton;
   if compile_prog "" "-liberty" ; then
     LIBS="-liberty $LIBS"
@@ -6053,6 +6053,9 @@ case "$slirp" in
     mkdir -p slirp
     slirp_cflags="-I\$(SRC_PATH)/slirp/src -I\$(BUILD_DIR)/slirp/src"
     slirp_libs="-L\$(BUILD_DIR)/slirp -lslirp"
+    if test "$mingw32" = "yes" ; then
+      slirp_libs="$slirp_libs -lws2_32 -liphlpapi"
+    fi
     ;;
 
   system)
-- 
1.8.3.1



