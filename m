Return-Path: <SRS0=Jz4r=ZX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CC6C432C0
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 11:44:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3ED520833
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 11:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MjPa1X4N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3ED520833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibNeb-0006uw-R3
	for qemu-devel@archiver.kernel.org; Sun, 01 Dec 2019 06:44:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38237)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ibNGg-0003l7-8y
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 06:19:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ibNGf-0002DY-6k
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 06:19:58 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31718
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ibNGf-0002DK-37
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 06:19:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575199196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n/dYvJlEDw+8cI4YP3J98AkaGDE2IgQYRH7K5Wjxh9I=;
 b=MjPa1X4N3nqq1S0Cq+1nHVw67+/rrsIbLbgeXnvrsco0eseeBAfBaZKXaDTVrSCpNoTUS+
 OmGhiZrr9UAOdcDNkl/SQRJchRCY5clGPcIpgePI1/g7n6dXZ5Q0D1LhSt5YVpiU5UdiFa
 sQM6XQIFIWgoo8TtBRkL/vvkoq7t3wQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-LhLa07a-MkWUvc5EQYQm2w-1; Sun, 01 Dec 2019 06:19:55 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7AF94184CABB
 for <qemu-devel@nongnu.org>; Sun,  1 Dec 2019 11:19:54 +0000 (UTC)
Received: from localhost (unknown [10.36.112.15])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1575E60BF7;
 Sun,  1 Dec 2019 11:19:49 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 25/26] qapi/qmp: add ObjectPropertyInfo.default-value
Date: Sun,  1 Dec 2019 15:15:30 +0400
Message-Id: <20191201111531.1136947-26-marcandre.lureau@redhat.com>
In-Reply-To: <20191201111531.1136947-1-marcandre.lureau@redhat.com>
References: <20191201111531.1136947-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: LhLa07a-MkWUvc5EQYQm2w-1
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
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
2.24.0


