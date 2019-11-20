Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224D6C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 18:30:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE76F206DA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 18:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cmRNBGGG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE76F206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXUjx-0000SR-Un
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 13:30:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37079)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iXUfy-0003FQ-Dh
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 13:26:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iXUfx-000851-55
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 13:26:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23364
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iXUfx-00084o-1y
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 13:26:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574274360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Oo6ZH6HF0fjI91RI0XYoZKoqx5AnaVzoYOqrgEhtq4g=;
 b=cmRNBGGGs8D2YHfx8yqDVesESM3LRD8c1WOB3v5Qf9B8kuJ7pToKsP4eSjpGJzP1QQ6gSV
 AUe+rgnpnDMrYSFVODK7TdnjeoYaSxBLzFw3o85YookmZjWJPmNJhnjOz3kDqzQ5lJbt8/
 GONOCDzr0B9HWw7Netc7PMIpaeqVC3Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-f-wx5KViPW6l0QYN6giuCA-1; Wed, 20 Nov 2019 13:25:56 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 63CA9107ACC4;
 Wed, 20 Nov 2019 18:25:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.163])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CB38963647;
 Wed, 20 Nov 2019 18:25:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 575F511385C7; Wed, 20 Nov 2019 19:25:51 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/6] qapi: Tweak "command returns a nice type" check for
 clarity
Date: Wed, 20 Nov 2019 19:25:46 +0100
Message-Id: <20191120182551.23795-2-armbru@redhat.com>
In-Reply-To: <20191120182551.23795-1-armbru@redhat.com>
References: <20191120182551.23795-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: f-wx5KViPW6l0QYN6giuCA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: mdroth@linux.vnet.ibm.com, kwolf@pond.sub.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/schema.py | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index cf0045f34e..cfb574c85d 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -711,10 +711,11 @@ class QAPISchemaCommand(QAPISchemaEntity):
             self.ret_type =3D schema.resolve_type(
                 self._ret_type_name, self.info, "command's 'returns'")
             if self.name not in self.info.pragma.returns_whitelist:
-                if not (isinstance(self.ret_type, QAPISchemaObjectType)
-                        or (isinstance(self.ret_type, QAPISchemaArrayType)
-                            and isinstance(self.ret_type.element_type,
-                                           QAPISchemaObjectType))):
+                typ =3D self.ret_type
+                if isinstance(typ, QAPISchemaArrayType):
+                    typ =3D self.ret_type.element_type
+                    assert typ
+                if not isinstance(typ, QAPISchemaObjectType):
                     raise QAPISemError(
                         self.info,
                         "command's 'returns' cannot take %s"
--=20
2.21.0


