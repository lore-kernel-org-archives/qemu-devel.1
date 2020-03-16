Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76752C10DCE
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 01:23:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3818220663
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 01:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MDSzN5KB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3818220663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDeTg-0002KB-Vf
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 21:23:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57363)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDdM4-0008IG-DL
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 20:11:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDdLz-0004nD-A4
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 20:11:40 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57380
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDdLz-0004ej-5P
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 20:11:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584317493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XIuJH9XweykhZcigkBeWkONlanSTYG2zvlCgRMYIfdo=;
 b=MDSzN5KB7/XjpcXLHR157CxdNbsSqusoRutuGrhgFzeymMU7v50o59mc38PKfzLguu2z4O
 BfAqJYouutEBe8Obo1S6HS/MnbUwD3heakf8CRwr6OGWVTDlzDh6hNuquptc+fw0vm71Ce
 GzflsXzToA731clvq6Ugc2wOPWq/m9c=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-HyX-pBpYPZCJE7WVVb7aQg-1; Sun, 15 Mar 2020 20:11:32 -0400
X-MC-Unique: HyX-pBpYPZCJE7WVVb7aQg-1
Received: by mail-wr1-f69.google.com with SMTP id v6so8067561wrg.22
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 17:11:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=T07f0oxk6PiljPlit4vlu7WFh9/oVHLX+IM98LA5apA=;
 b=VIqOBozc89M61Aa1wskCTmEJAg0CCeQYpOAb42S6ZgFvROt54+mCWGykpQXh1fGt27
 uF9j6zp87aX10CUdjhE2MQsTGuZn82hfhy1SHQAOKeAYuLq17TZfYzCqxcBT45UPK22V
 VXYs+5KT0ymcj+/U7+s4vCC5fnlzooxHZeo/UM9iLTJ6d0YQdvhxhV7hai650IbzibV6
 c4+AgWZL/UVE0bpu+c1gsMip6P9ClSbvFJVmuz0zxvHaEFKLDaGk+n8pxwF03B4CZUAS
 1Re1nBeH2tGyZxZ26o0eiK5C5YILJQ27jves/o5UbES9Cd+iGQ7h5Zpw66KqKty8UixO
 s18g==
X-Gm-Message-State: ANhLgQ0YUg0j6NQC1QDMqHBFuTXdjLIK0ojZgHTspz8K+xFDScT7OGKO
 UnXx2aznCe+x7qPZQ/rkZtToER7ikbvGAyeN4hPsZXmsiqf6ygFJJxZevX/iaMECODiAOQE6fkm
 CqkpDYN5vCTNcLNc=
X-Received: by 2002:a5d:6245:: with SMTP id m5mr32313873wrv.154.1584317490615; 
 Sun, 15 Mar 2020 17:11:30 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtwUJ6968d0frHLgVPd6S8Vf6H9zyITIH0xkdCdyffmSNEg2DYRaM4NprVOT4DPsH2kfw/JQw==
X-Received: by 2002:a5d:6245:: with SMTP id m5mr32313855wrv.154.1584317490453; 
 Sun, 15 Mar 2020 17:11:30 -0700 (PDT)
Received: from localhost.localdomain (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id c23sm28103571wme.39.2020.03.15.17.11.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Mar 2020 17:11:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/9] hw/core/qdev-properties: Fix code style
Date: Mon, 16 Mar 2020 01:11:05 +0100
Message-Id: <20200316001111.31004-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200316001111.31004-1-philmd@redhat.com>
References: <20200316001111.31004-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We will soon move this code, fix its style to avoid checkpatch.pl
to complain.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/core/qdev-properties.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 0e4da655c1..8ef949e3bd 100644
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


