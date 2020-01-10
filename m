Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1EA9C282DD
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 15:57:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88E9C2080D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 15:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gaW3xFnT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88E9C2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipwfU-0005MI-NT
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 10:57:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36739)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ipwKA-0003Kh-OI
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:35:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ipwK9-00011m-NY
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:35:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25295
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ipwK9-0000zk-IK
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:35:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578670545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ljpXQiRuRg4PYg0kvMoBUIcbQ0SbIuilNFkFQmb/Ms0=;
 b=gaW3xFnTfXKkSfsbOXNxaOL8RUYWD/K6xHegexgmZdS+Q3cO+Sh37PK3/YTNMW2EBukL60
 w1bimH4gi6zSdwDFaoXsyJchi8onIvjFYHXvIwsO84EgI/D0Scl9RaX5NVtwJTBVAGa3fb
 FAfFqGvaZJQHN6OB3t5zAMITocc6HUY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-eu5kR2TDPnWpAkYjHvIwjA-1; Fri, 10 Jan 2020 10:35:44 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 20FEC91223
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 15:35:43 +0000 (UTC)
Received: from localhost (ovpn-112-59.ams2.redhat.com [10.36.112.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 46A5610016E8;
 Fri, 10 Jan 2020 15:35:36 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 25/26] qapi/qmp: add ObjectPropertyInfo.default-value
Date: Fri, 10 Jan 2020 19:30:38 +0400
Message-Id: <20200110153039.1379601-26-marcandre.lureau@redhat.com>
In-Reply-To: <20200110153039.1379601-1-marcandre.lureau@redhat.com>
References: <20200110153039.1379601-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: eu5kR2TDPnWpAkYjHvIwjA-1
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Report the default value associated with a property.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qapi/qom.json      | 7 ++++++-
 qom/qom-qmp-cmds.c | 4 ++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/qapi/qom.json b/qapi/qom.json
index 32db96ffc4..471e4b484b 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -26,10 +26,15 @@
 #
 # @description: if specified, the description of the property.
 #
+# @default-value: the default value, if any (since 5.0)
+#
 # Since: 1.2
 ##
 { 'struct': 'ObjectPropertyInfo',
-  'data': { 'name': 'str', 'type': 'str', '*description': 'str' } }
+  'data': { 'name': 'str',
+            'type': 'str',
+            '*description': 'str',
+            '*default-value': 'str' } }
=20
 ##
 # @qom-list:
diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
index 8785816c1f..68f0a41bca 100644
--- a/qom/qom-qmp-cmds.c
+++ b/qom/qom-qmp-cmds.c
@@ -177,6 +177,10 @@ ObjectPropertyInfoList *qmp_device_list_properties(con=
st char *typename,
         info->type =3D g_strdup(prop->type);
         info->has_description =3D !!prop->description;
         info->description =3D g_strdup(prop->description);
+        if (prop->get_default) {
+            info->default_value =3D prop->get_default(prop);
+            info->has_default_value =3D !!info->default_value;
+        }
=20
         entry =3D g_malloc0(sizeof(*entry));
         entry->value =3D info;
--=20
2.25.0.rc1.20.g2443f3f80d.dirty


