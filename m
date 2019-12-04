Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BAE0C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 10:46:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05A51207DD
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 10:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fAbN+Wu8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05A51207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icSBG-00032I-5Q
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 05:46:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38920)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1icR5W-0007FB-R0
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 04:36:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1icR5L-0000Yg-E8
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 04:36:42 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33316
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1icR5L-0000BO-9X
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 04:36:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575452193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xptOCNnsIHKHFrFX5zqteF/m5AlNBeqPE8IAUUchUhE=;
 b=fAbN+Wu89nVoghJF+/Q2v8NrzxCZNVAGN9rVUmmRLQf6F69O3BV9IuBkfpyw0zPnXlxAf8
 laP3u7mPppUy5FIQBKEFWh2U4/Wjtac6K1oNZlIwBOnZkp8N7bxImP6fpUh9nFuxDsybol
 elWCD0VAfN6wu35lB/VgsG2Lz9JIRtM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-agi402gYNLGVclUIkciM9A-1; Wed, 04 Dec 2019 04:36:31 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 240F7800D54
 for <qemu-devel@nongnu.org>; Wed,  4 Dec 2019 09:36:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 813511001925;
 Wed,  4 Dec 2019 09:36:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A58C511366F2; Wed,  4 Dec 2019 10:36:25 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 11/18] s390x/event-facility: Fix realize() error API
 violations
Date: Wed,  4 Dec 2019 10:36:18 +0100
Message-Id: <20191204093625.14836-12-armbru@redhat.com>
In-Reply-To: <20191204093625.14836-1-armbru@redhat.com>
References: <20191204093625.14836-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: agi402gYNLGVclUIkciM9A-1
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

sclp_events_bus_realize() dereferences @errp when
object_property_set_bool() fails.  That's wrong; see the big comment
in error.h.  Introduced in commit f6102c329c "s390/sclp: rework sclp
event facility initialization + device realization".

No caller actually passes null.

Fix anyway: splice in a local Error *err, and error_propagate().

Cc: David Hildenbrand <david@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/event-facility.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
index 66205697ae..cdcf9154c4 100644
--- a/hw/s390x/event-facility.c
+++ b/hw/s390x/event-facility.c
@@ -339,14 +339,16 @@ out:
=20
 static void sclp_events_bus_realize(BusState *bus, Error **errp)
 {
+    Error *err =3D NULL;
     BusChild *kid;
=20
     /* TODO: recursive realization has to be done in common code */
     QTAILQ_FOREACH(kid, &bus->children, sibling) {
         DeviceState *dev =3D kid->child;
=20
-        object_property_set_bool(OBJECT(dev), true, "realized", errp);
-        if (*errp) {
+        object_property_set_bool(OBJECT(dev), true, "realized", &err);
+        if (errp) {
+            error_propagate(errp, err);
             return;
         }
     }
--=20
2.21.0


