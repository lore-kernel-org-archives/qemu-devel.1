Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714E8C282DD
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 15:48:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35FB720721
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 15:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AdpBziaO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35FB720721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipwWl-0003QU-Rk
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 10:48:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34985)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ipwJj-0002Y7-3h
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:35:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ipwJh-0007X4-TD
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:35:18 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59556
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ipwJh-0007Ul-OL
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:35:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578670517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FSlWle5nklKvXaquZcWIb8L0jGyrRDSOs2lUS9icmbo=;
 b=AdpBziaOfkLHX6SrquuET3JhpHmGXDSSWR2fG0T4FjtpETDQPmifcvr5IsyEEiJ72q0YzJ
 9OWYRP2/dL/AlBSyvBwnD12AJq+C4zYPwtLdKy7KqRGB2vzKAecjsTaaSw8qCDudk1YFqI
 NftrbC7ReBERodNGQoM5pKiaGkf72Bw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-7oOLeE30MGe89D1etkKZnA-1; Fri, 10 Jan 2020 10:35:14 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C3D5800A02
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 15:35:13 +0000 (UTC)
Received: from localhost (ovpn-112-59.ams2.redhat.com [10.36.112.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CC8FC1084194;
 Fri, 10 Jan 2020 15:35:06 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 22/26] vl: print default value in object help
Date: Fri, 10 Jan 2020 19:30:35 +0400
Message-Id: <20200110153039.1379601-23-marcandre.lureau@redhat.com>
In-Reply-To: <20200110153039.1379601-1-marcandre.lureau@redhat.com>
References: <20200110153039.1379601-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 7oOLeE30MGe89D1etkKZnA-1
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
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
2.25.0.rc1.20.g2443f3f80d.dirty


