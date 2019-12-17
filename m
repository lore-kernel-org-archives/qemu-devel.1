Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D698BC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 06:52:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99804206D8
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 06:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AVVs3oFR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99804206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih6iy-0000mq-Lb
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 01:52:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49192)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ih6K3-0000rh-9I
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 01:27:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ih6K1-0001ZO-TH
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 01:27:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57254
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ih6K1-0001Vn-PR
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 01:27:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576564025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qRKfYDk0ubnQO6U4DC9O3vj4IfjkD4+ks4HjQEmHCHQ=;
 b=AVVs3oFRYD72dJxPgOOgScHBn5e8o05IiQuJMYJHtZm3mA2W6s67XnUxQpLVHLPloLE4tp
 qJKiPA/Y6Tzmdy82I1nt6Ym2ILUj/rv87KsBgjyPhEvDhPsOOpjiiVYcWUIp80pd597kGr
 PoduljvxHSPDCj4C0lyvaMTZCql0YEw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-KJ_VDKJCOc6oFDQo9nGMtQ-1; Tue, 17 Dec 2019 01:27:01 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CE17C1883520;
 Tue, 17 Dec 2019 06:27:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-42.ams2.redhat.com
 [10.36.116.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 25FD01001281;
 Tue, 17 Dec 2019 06:26:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9DE62113642B; Tue, 17 Dec 2019 07:26:51 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 27/34] hw/s390x: rename Error ** parameter to more common errp
Date: Tue, 17 Dec 2019 07:26:44 +0100
Message-Id: <20191217062651.9687-28-armbru@redhat.com>
In-Reply-To: <20191217062651.9687-1-armbru@redhat.com>
References: <20191217062651.9687-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: KJ_VDKJCOc6oFDQo9nGMtQ-1
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


