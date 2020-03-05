Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F6EC3F2CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 14:31:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C62E20732
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 14:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RTgK0QiL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C62E20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9rXQ-0007Tb-9d
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 09:31:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35296)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j9rWJ-0006Kk-Er
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:30:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j9rWH-0001y7-Sq
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:30:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53302
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j9rWH-0001xl-P9
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:30:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583418637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zwsZQQ5MN8MY5ICY0EQq4aovYGXTGBvqIvi5JLhszK0=;
 b=RTgK0QiLfMXBUyx8TO7j4Suv4VK2OgySwoyCt/nPb79ME0zIvJfP+XXehfpmQIvbCceJSC
 DTs4+/qzZLcZEqgov5IcexRLbw3O+edJrRAoXpeowA6/6wFiXMQO63xUceSIlTgdqiWE/A
 y0avn/VH86gOoVXwcxCdtpVmtj+e6+Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-ri2IzFBxMxCRh_TycEN30A-1; Thu, 05 Mar 2020 09:30:36 -0500
X-MC-Unique: ri2IzFBxMxCRh_TycEN30A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F194D80573D;
 Thu,  5 Mar 2020 14:30:34 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-120-166.rdu2.redhat.com [10.10.120.166])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C010690538;
 Thu,  5 Mar 2020 14:30:13 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 01/15] util: vfio-helpers: Fix qemu_vfio_close()
Date: Thu,  5 Mar 2020 15:29:31 +0100
Message-Id: <20200305142945.216465-2-david@redhat.com>
In-Reply-To: <20200305142945.216465-1-david@redhat.com>
References: <20200305142945.216465-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>,
 David Hildenbrand <david@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

qemu_vfio_undo_mapping() will decrement the number of mappings and
reshuffle the array elements to fit into the reduced size.

Iterating over all elements like this does not work as expected, let's make
sure to remove all mappings properly.

Reviewed-by: Peter Xu <peterx@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 util/vfio-helpers.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index 9ec01bfe26..f31aa77ffe 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -695,13 +695,11 @@ static void qemu_vfio_reset(QEMUVFIOState *s)
 /* Close and free the VFIO resources. */
 void qemu_vfio_close(QEMUVFIOState *s)
 {
-    int i;
-
     if (!s) {
         return;
     }
-    for (i =3D 0; i < s->nr_mappings; ++i) {
-        qemu_vfio_undo_mapping(s, &s->mappings[i], NULL);
+    while (s->nr_mappings) {
+        qemu_vfio_undo_mapping(s, &s->mappings[s->nr_mappings - 1], NULL);
     }
     ram_block_notifier_remove(&s->ram_notifier);
     qemu_vfio_reset(s);
--=20
2.24.1


