Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2221C33CB6
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:13:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 994DF2071E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qo4BcW6e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 994DF2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuf77-0000lR-58
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 11:13:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53158)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iucud-0001mE-Rw
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:52:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iucuc-0001Q8-Rc
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:52:47 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21382
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iucuc-0001Pw-OK
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:52:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579787566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ktKFvT34rqSSyh//AYVA6ETolJ9M5QOZ8mJHSCkxDDo=;
 b=Qo4BcW6exQsBXw7W+y/Iw6MPSIKVbr9zYHmaYJGJ+VMZ+7luGrBR6ckb1bqRhiFwmL1bT9
 9Gb7JYGOIylWRZqdGj/4pqz4Siuabz/Elx2iRrexzqSxKSxAmiL5iA1pDC8EyWYPb7WLtd
 HULi66qHiSJ3oPTbwCSUmRUux82aXck=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-PUSIkUi5NSeMyFmCLsoYzg-1; Thu, 23 Jan 2020 08:52:44 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AED068024EC
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 13:52:43 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.112.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ADEBD1CB;
 Thu, 23 Jan 2020 13:52:42 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 55/59] qapi/qmp: add ObjectPropertyInfo.default-value
Date: Thu, 23 Jan 2020 14:50:45 +0100
Message-Id: <1579787449-27599-56-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
References: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: PUSIkUi5NSeMyFmCLsoYzg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Report the default value associated with a property.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20200110153039.1379601-26-marcandre.lureau@redhat.com>
[Report it as type "any", not string. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qapi/qom.json      | 7 ++++++-
 qom/qom-qmp-cmds.c | 2 ++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/qapi/qom.json b/qapi/qom.json
index 32db96f..1e3c2ad 100644
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
+            '*default-value': 'any' } }
=20
 ##
 # @qom-list:
diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
index 8785816..6136efe 100644
--- a/qom/qom-qmp-cmds.c
+++ b/qom/qom-qmp-cmds.c
@@ -177,6 +177,8 @@ ObjectPropertyInfoList *qmp_device_list_properties(cons=
t char *typename,
         info->type =3D g_strdup(prop->type);
         info->has_description =3D !!prop->description;
         info->description =3D g_strdup(prop->description);
+        info->default_value =3D qobject_ref(prop->defval);
+        info->has_default_value =3D !!info->default_value;
=20
         entry =3D g_malloc0(sizeof(*entry));
         entry->value =3D info;
--=20
1.8.3.1



