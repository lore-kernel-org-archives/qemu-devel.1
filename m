Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2445C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 14:09:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D82920838
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 14:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xdrhr3GK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D82920838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJHZp-0006GS-II
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 10:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47899)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jJHXd-0002N5-U6
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:06:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jJHXc-0007hR-P4
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:06:57 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24099
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jJHXc-0007h5-LD
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:06:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585663616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zkNtSCtIYbWxg0wZGTTo9fxfXzvj4QaHwWA1k8gShSk=;
 b=Xdrhr3GKGQZnCKh3zTcc9Lry10E88sCtW3cOJUVql37/iF1JIGFFTVC2d2tZ2MBfw9iIt0
 wcMNaiZXMWDynOqz0bl92JRTzCqXlt407ezD7QlP1Tz2A6395bGl71P5VaG99vIptnc1En
 uE+sbq946wwX9InQXeK6nvs3+pvtz4w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-geFL6d9LMbCL2LEf6lwwxw-1; Tue, 31 Mar 2020 10:06:54 -0400
X-MC-Unique: geFL6d9LMbCL2LEf6lwwxw-1
Received: by mail-wm1-f70.google.com with SMTP id w9so741520wmi.2
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 07:06:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KJ4Xx0iYJ5ZjT+1t9JtBr+h6MON+xROPqbtySIMxmOo=;
 b=fD6l6AZpf+9Bw1PvBCfQNkdiq9rZX4jQWgAyA1dV2PZKzBrx5CJdbbMhx0Lpk/gSFr
 v5PAhkhQfNgBi6H6bkuUVOtJJH/I09cAzVT2TsoWKSK3ahk2Fq/EkkupuZsm5igaPp2d
 wbnq+9WOIZI+G1D3I+ft5fIfqRhfFyl6dkh6VacCsPkgcgxJv3fX70U2jqnSbaXuM+CK
 Ti/qTt5h/arMFo5JsLSOOhGeilY+QuHSru5FrRsPUtPOEAbJulJo3Md37V5DZ6Jhc6vf
 SQIEMALt4XJbh1VMqvmU7kXc7i1yd0eTi/yEWv1CLLndqlk04fmrdIqLEJj1OKzkyxu1
 IYMQ==
X-Gm-Message-State: ANhLgQ2wtJRcJ1edGhRp6U9BeBBIDRLTOOlJHTe2bB9Gnw0AS8tZwVzm
 vJfbGcOymLlpu64O1znuP7A+zA3jIm4kB8/Cb6gBeqn8AAX/cw4DueTwemqAC/S33MkgCLyJ/gt
 vj9DttCd0GF5TDGo=
X-Received: by 2002:a1c:3281:: with SMTP id y123mr3532552wmy.140.1585663613094; 
 Tue, 31 Mar 2020 07:06:53 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvGPEGcY23cYxAh+NtbwxCtHyglDNiRuqbwSnDN7q0NZj8RIfNTqguEjMRR6Tr322n1siC98A==
X-Received: by 2002:a1c:3281:: with SMTP id y123mr3532533wmy.140.1585663612822; 
 Tue, 31 Mar 2020 07:06:52 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id f25sm4037019wml.11.2020.03.31.07.06.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2020 07:06:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 v2 2/4] qga: Extract guest_file_handle_find() to
 commands-common.h
Date: Tue, 31 Mar 2020 16:06:36 +0200
Message-Id: <20200331140638.16464-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200331140638.16464-1-philmd@redhat.com>
References: <20200331140638.16464-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
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
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Fakhri Zulkifli <mohdfakhrizulkifli@gmail.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Sameeh Jubran <sjubran@redhat.com>, Basil Salman <basil@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Dietmar Maurer <dietmar@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As we are going to reuse this method, declare it in common
header.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 qga/commands-common.h | 18 ++++++++++++++++++
 qga/commands-posix.c  |  7 ++++---
 qga/commands-win32.c  |  7 ++++---
 3 files changed, 26 insertions(+), 6 deletions(-)
 create mode 100644 qga/commands-common.h

diff --git a/qga/commands-common.h b/qga/commands-common.h
new file mode 100644
index 0000000000..af90e5481e
--- /dev/null
+++ b/qga/commands-common.h
@@ -0,0 +1,18 @@
+/*
+ * QEMU Guest Agent common/cross-platform common commands
+ *
+ * Copyright (c) 2020 Red Hat, Inc.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or late=
r.
+ * See the COPYING file in the top-level directory.
+ */
+#ifndef QGA_COMMANDS_COMMON_H
+#define QGA_COMMANDS_COMMON_H
+
+#include "qga-qapi-types.h"
+
+typedef struct GuestFileHandle GuestFileHandle;
+
+GuestFileHandle *guest_file_handle_find(int64_t id, Error **errp);
+
+#endif
diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 93474ff770..2199b3b6d9 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -26,6 +26,7 @@
 #include "qemu/sockets.h"
 #include "qemu/base64.h"
 #include "qemu/cutils.h"
+#include "commands-common.h"
=20
 #ifdef HAVE_UTMPX
 #include <utmpx.h>
@@ -237,12 +238,12 @@ typedef enum {
     RW_STATE_WRITING,
 } RwState;
=20
-typedef struct GuestFileHandle {
+struct GuestFileHandle {
     uint64_t id;
     FILE *fh;
     RwState state;
     QTAILQ_ENTRY(GuestFileHandle) next;
-} GuestFileHandle;
+};
=20
 static struct {
     QTAILQ_HEAD(, GuestFileHandle) filehandles;
@@ -268,7 +269,7 @@ static int64_t guest_file_handle_add(FILE *fh, Error **=
errp)
     return handle;
 }
=20
-static GuestFileHandle *guest_file_handle_find(int64_t id, Error **errp)
+GuestFileHandle *guest_file_handle_find(int64_t id, Error **errp)
 {
     GuestFileHandle *gfh;
=20
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 46cea7d1d9..cfaf6b84b8 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -37,6 +37,7 @@
 #include "qemu/queue.h"
 #include "qemu/host-utils.h"
 #include "qemu/base64.h"
+#include "commands-common.h"
=20
 #ifndef SHTDN_REASON_FLAG_PLANNED
 #define SHTDN_REASON_FLAG_PLANNED 0x80000000
@@ -50,11 +51,11 @@
=20
 #define INVALID_SET_FILE_POINTER ((DWORD)-1)
=20
-typedef struct GuestFileHandle {
+struct GuestFileHandle {
     int64_t id;
     HANDLE fh;
     QTAILQ_ENTRY(GuestFileHandle) next;
-} GuestFileHandle;
+};
=20
 static struct {
     QTAILQ_HEAD(, GuestFileHandle) filehandles;
@@ -126,7 +127,7 @@ static int64_t guest_file_handle_add(HANDLE fh, Error *=
*errp)
     return handle;
 }
=20
-static GuestFileHandle *guest_file_handle_find(int64_t id, Error **errp)
+GuestFileHandle *guest_file_handle_find(int64_t id, Error **errp)
 {
     GuestFileHandle *gfh;
     QTAILQ_FOREACH(gfh, &guest_file_state.filehandles, next) {
--=20
2.21.1


