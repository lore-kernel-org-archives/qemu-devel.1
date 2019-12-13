Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40ACDC2D0C9
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:23:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B132321655
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PSBzwFGY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B132321655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifnzx-0001eX-3t
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 11:41:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42921)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1ifnfW-0000x4-8I
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 11:19:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1ifnfV-0002KW-8h
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 11:19:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37443
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ifnfV-0002JR-4K
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 11:19:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576253992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NUXGDBlQgXoYfeFlI09A6bJOwoS+zELlXbUsMOsd9hg=;
 b=PSBzwFGYNdC9ED3GYd1704PkmV2AsisO9BotvWuLTWpN9H7wC9HI9r9slYJZpk+nBERZzz
 x2PmH6p8GH5oSDAZ6r5vNx+zeS8AMd9G8pPG2/0WWPyKF4gqaZ1GGkyGanCe59ltcTFeEY
 MLEfca31n+1+2apx5MgxvjlB12fsEJQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-ZJPq1ky7PXyi8f5Mt83kOA-1; Fri, 13 Dec 2019 11:19:51 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A20F1856A67;
 Fri, 13 Dec 2019 16:19:50 +0000 (UTC)
Received: from localhost (ovpn-116-226.ams2.redhat.com [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8386C10013D9;
 Fri, 13 Dec 2019 16:19:47 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 14/16] s390x/cpumodel: Fix query-cpu-definitions error API
 violations
Date: Fri, 13 Dec 2019 17:18:49 +0100
Message-Id: <20191213161851.24687-15-cohuck@redhat.com>
In-Reply-To: <20191213161851.24687-1-cohuck@redhat.com>
References: <20191213161851.24687-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: ZJPq1ky7PXyi8f5Mt83kOA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Markus Armbruster <armbru@redhat.com>

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
Message-Id: <20191204093625.14836-16-armbru@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/cpu_models.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 3ed301b5e509..547bab8ac392 100644
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


