Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351F3C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:58:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E840320658
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QiBggcQv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E840320658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCpWC-0006j0-2a
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 14:58:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35265)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jCpKF-0000bN-Qf
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:46:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jCpKE-0006C1-Q9
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:46:27 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39039
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jCpKE-0006Bb-MQ
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:46:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584125186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7ePwDiPezVxzhZndwtlliE7S2n1c8J46GHqyq2ygKco=;
 b=QiBggcQvUVzyZJgvJXUvqVYcbSUWModvCd0fo5aZXHyOkWdfhWdq80qWv7gDWnGSjjqdCQ
 gkrWjC6YV5BS+ST3wvYQpb6lwv1WXK4rBmBK3uXzbXqDqdntmebxERoNGsl3QA2T4ClolP
 XPFA/MYMF1Apq5KybJC4T7SNzxuZiOg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-dTfyB8BqNZm797ZwjhwncQ-1; Fri, 13 Mar 2020 14:46:24 -0400
X-MC-Unique: dTfyB8BqNZm797ZwjhwncQ-1
Received: by mail-wm1-f69.google.com with SMTP id a23so3787965wmm.8
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 11:46:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aagp4FgW5GbSTsX+knMwFtcu7+CAaAgGVA0SldYLyYM=;
 b=B/clf4zLtBXZVus2xoPhgcEL8gcHy2iqedEm+UvAszT1buWVw5685Q9JMTL0rclPFq
 1UsPrGVsFbDSaVrbJ4QQZOsYrYOWabWh5afEtR5BSK5WEO1J3rgxZ/9fGaypswOWq7XC
 HPotJdPk3cIjQ3NiWfWSxDugbMDJkuNUCInprYwZwWQKWBNuq6DwUgSR7om+34fSw0RB
 9CHPkg78hCKAjDXGohdquAUj6gIaR7COqyWDOyRnKj0HavZUuCg42dPaV87v5gejcOrl
 NbYH+WnRAVh58V8jmiAV42p0/YOQ6Yqj4HZTqHUAF/Avj8Rd4ZWt8ucvxzxa34q6fVUs
 D7jw==
X-Gm-Message-State: ANhLgQ3REeJrr1AI7Zhpx6PNiZKdGBwZuOMBWjEK0Ve9LEDKTIhnJcQF
 MPuZOQfU1qI9jkeHmp3O/bFB3JcrEXL9UcUtCT7lZj0jzUxdea8uslEBbOUYSLR5V+JYWN6an5F
 vR/72Yf9dJIM42fw=
X-Received: by 2002:a05:600c:286:: with SMTP id
 6mr12088983wmk.101.1584125183300; 
 Fri, 13 Mar 2020 11:46:23 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvF1BMGo+77M+we3FvRHaJw5i0bl459XoKtFcg7YViGqq2pDke43I1PipqK22R0ouRmbju9KQ==
X-Received: by 2002:a05:600c:286:: with SMTP id
 6mr12088972wmk.101.1584125183117; 
 Fri, 13 Mar 2020 11:46:23 -0700 (PDT)
Received: from x1w.redhat.com (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id u25sm17646168wml.17.2020.03.13.11.46.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2020 11:46:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/9] hw/core/qdev-properties: Fix code style
Date: Fri, 13 Mar 2020 19:46:01 +0100
Message-Id: <20200313184607.11792-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200313184607.11792-1-philmd@redhat.com>
References: <20200313184607.11792-1-philmd@redhat.com>
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We will soon move this code, fix its style to avoid checkpatch.pl
to complain.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/core/qdev-properties.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index e1cefcaa61..ea5b59d5c5 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -553,15 +553,15 @@ static void set_mac(Object *obj, Visitor *v, const ch=
ar *name, void *opaque,
         if (!qemu_isxdigit(str[pos])) {
             goto inval;
         }
-        if (!qemu_isxdigit(str[pos+1])) {
+        if (!qemu_isxdigit(str[pos + 1])) {
             goto inval;
         }
         if (i =3D=3D 5) {
-            if (str[pos+2] !=3D '\0') {
+            if (str[pos + 2] !=3D '\0') {
                 goto inval;
             }
         } else {
-            if (str[pos+2] !=3D ':' && str[pos+2] !=3D '-') {
+            if (str[pos + 2] !=3D ':' && str[pos + 2] !=3D '-') {
                 goto inval;
             }
         }
@@ -767,8 +767,8 @@ static void set_blocksize(Object *obj, Visitor *v, cons=
t char *name,
     /* We rely on power-of-2 blocksizes for bitmasks */
     if ((value & (value - 1)) !=3D 0) {
         error_setg(errp,
-                  "Property %s.%s doesn't take value '%" PRId64 "', it's n=
ot a power of 2",
-                  dev->id ?: "", name, (int64_t)value);
+                  "Property %s.%s doesn't take value '%" PRId64 "', "
+                  "it's not a power of 2", dev->id ?: "", name, (int64_t)v=
alue);
         return;
     }
=20
--=20
2.21.1


