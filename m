Return-Path: <SRS0=Jz4r=ZX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05BD3C432C0
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 11:38:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAA0320833
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 11:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bOrRamEc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAA0320833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibNYX-0007M0-Pd
	for qemu-devel@archiver.kernel.org; Sun, 01 Dec 2019 06:38:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38159)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ibNGC-00033c-FU
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 06:19:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ibNGB-0001m5-8A
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 06:19:28 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25724
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ibNGA-0001ll-Ns
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 06:19:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575199166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7s1I0AD6OGGP5jqLUdhtW8mOUln9CrXir22eH5j125I=;
 b=bOrRamEcxp05zeXF7/o3gr2PqYM+l7C+SLIxovq6u62u0WTgCZ7I6QHc6c5fbhDQcWCkW7
 K3gFQiHKSAUXZqwcsjRfRg7QSaVipv+p3GIakbdupbpCLBufFQM3L1VRYTdliE7Ogudrkx
 BqZih/5Ym0HW6f2IecKDCE7ekQ0Ge0Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-NUAdGicmPluNKiuyO8a-YA-1; Sun, 01 Dec 2019 06:19:25 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3BAE810054E3
 for <qemu-devel@nongnu.org>; Sun,  1 Dec 2019 11:19:24 +0000 (UTC)
Received: from localhost (unknown [10.36.112.15])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7080D5D9E1;
 Sun,  1 Dec 2019 11:19:20 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 22/26] vl: print default value in object help
Date: Sun,  1 Dec 2019 15:15:27 +0400
Message-Id: <20191201111531.1136947-23-marcandre.lureau@redhat.com>
In-Reply-To: <20191201111531.1136947-1-marcandre.lureau@redhat.com>
References: <20191201111531.1136947-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: NUAdGicmPluNKiuyO8a-YA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qom/object_interfaces.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index 46cd6eab5c..edb4cc4a3d 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -185,6 +185,7 @@ bool user_creatable_print_help(const char *type, QemuOp=
ts *opts)
         object_class_property_iter_init(&iter, klass);
         while ((prop =3D object_property_iter_next(&iter))) {
             GString *str;
+            char *defval;
=20
             if (!prop->set) {
                 continue;
@@ -192,6 +193,11 @@ bool user_creatable_print_help(const char *type, QemuO=
pts *opts)
=20
             str =3D g_string_new(NULL);
             g_string_append_printf(str, "  %s=3D<%s>", prop->name, prop->t=
ype);
+            defval =3D object_property_get_default(prop);
+            if (defval) {
+                g_string_append_printf(str, " (default: %s)", defval);
+                g_free(defval);
+            }
             if (prop->description) {
                 if (str->len < 24) {
                     g_string_append_printf(str, "%*s", 24 - (int)str->len,=
 "");
--=20
2.24.0


