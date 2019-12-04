Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A7DC43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 10:36:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01334206DB
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 10:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tk0e5Kap"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01334206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icS0u-0004ZZ-J5
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 05:36:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38718)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1icR5g-0007Ds-FA
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 04:37:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1icR5J-0000QU-Dl
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 04:36:39 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38344
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1icR5J-0000Fy-6U
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 04:36:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575452194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aryLVqd6aYkbTJUrzzMomPXJEC6cSDvsxwWZWhAo3dg=;
 b=Tk0e5KapxgBxpVekpRBpaoEkFRUXin7VUe/1Pb14ZhJkkJFmWIZRtvsd8uNB2KUol/TKJv
 rEaGIx12xxfw7sHT9Fcvo/ibVW6CUcHw03CUxHf4NPyRh9q/gh6XgTpWyVbZa331yAREZq
 czTM7slq6++Kmmuc6+f7RKo3oQtasKM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-dpMq_yWmNpm6VQh-vTUPNg-1; Wed, 04 Dec 2019 04:36:33 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C79B310054E3
 for <qemu-devel@nongnu.org>; Wed,  4 Dec 2019 09:36:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DF17F5C1B5;
 Wed,  4 Dec 2019 09:36:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B28D41135A56; Wed,  4 Dec 2019 10:36:25 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 15/18] s390x/cpumodel: Fix query-cpu-definitions error API
 violations
Date: Wed,  4 Dec 2019 10:36:22 +0100
Message-Id: <20191204093625.14836-16-armbru@redhat.com>
In-Reply-To: <20191204093625.14836-1-armbru@redhat.com>
References: <20191204093625.14836-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: dpMq_yWmNpm6VQh-vTUPNg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
Cc: Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

qmp_query_cpu_definitions() passes @errp to get_max_cpu_model(), then
frees any error it gets back.  This effectively ignores errors.
Dereferencing @errp is wrong; see the big comment in error.h.  Passing
@errp is also wrong, because it works only as long as @errp is neither
@error_fatal nor @error_abort.  Introduced in commit 38cba1f4d8
"s390x: return unavailable features via query-cpu-definitions".

No caller actually passes such @errp values.

Fix anyway: simply pass NULL to get_max_cpu_model().

Cc: David Hildenbrand <david@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu_models.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 3ed301b5e5..547bab8ac3 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -462,11 +462,7 @@ CpuDefinitionInfoList *qmp_query_cpu_definitions(Error=
 **errp)
         .list =3D NULL,
     };
=20
-    list_data.model =3D get_max_cpu_model(errp);
-    if (*errp) {
-        error_free(*errp);
-        *errp =3D NULL;
-    }
+    list_data.model =3D get_max_cpu_model(NULL);
=20
     object_class_foreach(create_cpu_model_list, TYPE_S390_CPU, false,
                          &list_data);
--=20
2.21.0


