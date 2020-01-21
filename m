Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B504C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 09:58:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 532C224654
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 09:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ONZlPPJW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 532C224654
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itqIx-0007FY-GK
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 04:58:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60862)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1itqFt-0003Lx-7p
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 04:55:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1itqFo-00076U-Mu
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 04:55:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45988
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1itqFo-00076N-Jz
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 04:55:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579600524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JFtQi7X5O9S0H7Cnwdmrnm+saB1n2yEL3XL+Mjc5ZQA=;
 b=ONZlPPJWLcRQlHU+nyY4jezvMTEG34h1fhm3re6CU0YLXyQbWT01fCVBoUHoC9tqQEnSI9
 rWHF5ge77EXKA2XraOQ/zH6rTugLtpdLggcmS+q7ua4oIlaXcxglu3r5Svczf6kriz7s4f
 ifB77+sldfg8M+VSJk+CWzBvj5R+vJY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-69--1AV7HBMNIql8dsbXwtR7Q-1; Tue, 21 Jan 2020 04:55:14 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F2381922960;
 Tue, 21 Jan 2020 09:55:13 +0000 (UTC)
Received: from localhost (dhcp-192-195.str.redhat.com [10.33.192.195])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6E2BE7DB34;
 Tue, 21 Jan 2020 09:55:10 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: qemu-s390x@nongnu.org
Subject: [PATCH] s390x/event-facility: fix error propagation
Date: Tue, 21 Jan 2020 10:55:06 +0100
Message-Id: <20200121095506.8537-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: -1AV7HBMNIql8dsbXwtR7Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We currently check (by error) if the passed-in Error pointer errp
is non-null and return after realizing the first child of the
event facility in that case. Symptom is that 'virsh shutdown'
does not work, as the sclpquiesce device is not realized.

Fix this by (correctly) checking the local Error err.

Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
Fixes: 3d508334dd2c ("s390x/event-facility: Fix realize() error API violati=
ons")
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/event-facility.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
index 8a93b8a1da97..9d6972afa8b3 100644
--- a/hw/s390x/event-facility.c
+++ b/hw/s390x/event-facility.c
@@ -338,7 +338,7 @@ static void sclp_events_bus_realize(BusState *bus, Erro=
r **errp)
         DeviceState *dev =3D kid->child;
=20
         object_property_set_bool(OBJECT(dev), true, "realized", &err);
-        if (errp) {
+        if (err) {
             error_propagate(errp, err);
             return;
         }
--=20
2.21.1


