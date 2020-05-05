Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01040C47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 15:41:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6FF3206B9
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 15:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dUecfpHI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6FF3206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVzgr-0007ml-N8
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 11:41:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jVzVv-0003UM-Tj
 for qemu-devel@nongnu.org; Tue, 05 May 2020 11:29:43 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38228
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jVzVo-0007TF-EE
 for qemu-devel@nongnu.org; Tue, 05 May 2020 11:29:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588692575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y+PHnR57qBTbd2B/WmRXaGvR865UwVJQqPHggRUV1/M=;
 b=dUecfpHILl7lxewxds0HJsIEd8zoaXXEyOoBxbvH5WP2f5mVZ/O6Xxu7Hq9xWJWfqF10de
 4NjAhf3gVaDBhz1B4O1j8/ZKT9KNAzLbjQuG5waEJAd8x3Zp4QW8X7JtdQQiHBAxVaj0u2
 k5sgvR4CYVb1zu/i1KG2104Ii6IFhfM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-nEPwQrdJO1GcS8UNhDApeQ-1; Tue, 05 May 2020 11:29:28 -0400
X-MC-Unique: nEPwQrdJO1GcS8UNhDApeQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E3EFE800687
 for <qemu-devel@nongnu.org>; Tue,  5 May 2020 15:29:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AB33C60BF4;
 Tue,  5 May 2020 15:29:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3734A11358BF; Tue,  5 May 2020 17:29:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 03/18] qom: Drop object_property_del_child()'s unused
 parameter @errp
Date: Tue,  5 May 2020 17:29:11 +0200
Message-Id: <20200505152926.18877-4-armbru@redhat.com>
In-Reply-To: <20200505152926.18877-1-armbru@redhat.com>
References: <20200505152926.18877-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qom/object.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index 07762cc331..3d65658059 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -614,7 +614,7 @@ static void object_property_del_all(Object *obj)
     g_hash_table_unref(obj->properties);
 }
=20
-static void object_property_del_child(Object *obj, Object *child, Error **=
errp)
+static void object_property_del_child(Object *obj, Object *child)
 {
     ObjectProperty *prop;
     GHashTableIter iter;
@@ -644,7 +644,7 @@ static void object_property_del_child(Object *obj, Obje=
ct *child, Error **errp)
 void object_unparent(Object *obj)
 {
     if (obj->parent) {
-        object_property_del_child(obj->parent, obj, NULL);
+        object_property_del_child(obj->parent, obj);
     }
 }
=20
--=20
2.21.1


