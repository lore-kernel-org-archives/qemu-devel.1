Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75719C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 08:42:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 435D921D7D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 08:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LZNzSbmy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 435D921D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihUuJ-000699-6r
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 03:42:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35976)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ihUWZ-000660-CS
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 03:17:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ihUWX-0002Zr-0M
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 03:17:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40347
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ihUWW-0002Xf-DG
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 03:17:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576657055;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qRKfYDk0ubnQO6U4DC9O3vj4IfjkD4+ks4HjQEmHCHQ=;
 b=LZNzSbmy49BuMFRITKk+O+nnJ3bO7YfzAisWRLiTDdv/doczyBAzN30Z72zugZnZna0/WP
 ga7kbpFy9wwZchqoPie3dtyw9AJHKMI093/uo1Q8zZlE/6BtTIh9Tp5DOKL+ewKc2huJGn
 n4blzC7MkCL27YMrdssYPJik7rJDKbk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-op8Xn19HP4e4yAwnGRbwoA-1; Wed, 18 Dec 2019 03:17:31 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8282107ACC5;
 Wed, 18 Dec 2019 08:17:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-42.ams2.redhat.com
 [10.36.116.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 22A601000329;
 Wed, 18 Dec 2019 08:17:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C30C3113642C; Wed, 18 Dec 2019 09:17:21 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 28/35] hw/s390x: rename Error ** parameter to more common
 errp
Date: Wed, 18 Dec 2019 09:17:14 +0100
Message-Id: <20191218081721.23520-29-armbru@redhat.com>
In-Reply-To: <20191218081721.23520-1-armbru@redhat.com>
References: <20191218081721.23520-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: op8Xn19HP4e4yAwnGRbwoA-1
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
Cc: David Hildenbrand <david@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20191205174635.18758-15-vsementsov@virtuozzo.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/s390x/event-facility.c | 2 +-
 hw/s390x/s390-stattrib.c  | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
index cdcf9154c4..6afe278cad 100644
--- a/hw/s390x/event-facility.c
+++ b/hw/s390x/event-facility.c
@@ -441,7 +441,7 @@ static void sclp_event_set_allow_all_mask_sizes(Object =
*obj, bool value,
     ef->allow_all_mask_sizes =3D value;
 }
=20
-static bool sclp_event_get_allow_all_mask_sizes(Object *obj, Error **e)
+static bool sclp_event_get_allow_all_mask_sizes(Object *obj, Error **errp)
 {
     SCLPEventFacility *ef =3D (SCLPEventFacility *)obj;
=20
diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
index bf5ac014c4..58121b9f68 100644
--- a/hw/s390x/s390-stattrib.c
+++ b/hw/s390x/s390-stattrib.c
@@ -352,7 +352,8 @@ static void s390_stattrib_class_init(ObjectClass *oc, v=
oid *data)
     dc->realize =3D s390_stattrib_realize;
 }
=20
-static inline bool s390_stattrib_get_migration_enabled(Object *obj, Error =
**e)
+static inline bool s390_stattrib_get_migration_enabled(Object *obj,
+                                                       Error **errp)
 {
     S390StAttribState *s =3D S390_STATTRIB(obj);
=20
--=20
2.21.0


