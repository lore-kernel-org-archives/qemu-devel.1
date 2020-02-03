Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E153C35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 18:41:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E36720721
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 18:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d9SIO80U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E36720721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iygeu-00039i-87
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 13:41:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59945)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iygWN-0008FV-IB
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 13:32:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iygWM-00023p-FE
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 13:32:31 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37319
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1iygWM-00023B-9S
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 13:32:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580754749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=31XOYPT0uBnH+X75iJWU6zJ+I/jmJ21OKKjKlfz8Quo=;
 b=d9SIO80UYwz8c2GIKlEzRDhcZ955mQPpPPg2+O6xtQ3yYIX9YSP1FfrtcN8Syn/YH672Me
 YLTkcoJ4gsj5vdiIbeQfmuDgvK3hz1vGVWd/UaeyTcbsVVITcEvNAktY/3m25wrEI7snZ+
 9p4Yo6ziCkTSXPB1UN9Sr0/wO1OeB+A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-83nBqtnxPUKyle1h-hBmHQ-1; Mon, 03 Feb 2020 13:32:25 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62D511005502;
 Mon,  3 Feb 2020 18:32:24 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-117-77.ams2.redhat.com [10.36.117.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 229B45DA83;
 Mon,  3 Feb 2020 18:32:19 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 11/13] util: vfio-helpers: Implement ram_block_resized()
Date: Mon,  3 Feb 2020 19:31:23 +0100
Message-Id: <20200203183125.164879-12-david@redhat.com>
In-Reply-To: <20200203183125.164879-1-david@redhat.com>
References: <20200203183125.164879-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 83nBqtnxPUKyle1h-hBmHQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let's implement ram_block_resized().

Note: Resizing is currently only allowed during reboot or when migration
starts.

Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 util/vfio-helpers.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index 71e02e7f35..57d77e9480 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -395,11 +395,24 @@ static void qemu_vfio_ram_block_removed(RAMBlockNotif=
ier *n,
     }
 }
=20
+static void qemu_vfio_ram_block_resized(RAMBlockNotifier *n, void *host,
+                                        size_t oldsize, size_t newsize)
+{
+    QEMUVFIOState *s =3D container_of(n, QEMUVFIOState, ram_notifier);
+    if (host) {
+        trace_qemu_vfio_ram_block_resized(s, host, oldsize, newsize);
+        /* Note: Not atomic - we need a new ioctl for that. */
+        qemu_vfio_ram_block_removed(n, host, oldsize);
+        qemu_vfio_ram_block_added(n, host, newsize);
+    }
+}
+
 static void qemu_vfio_open_common(QEMUVFIOState *s)
 {
     qemu_mutex_init(&s->lock);
     s->ram_notifier.ram_block_added =3D qemu_vfio_ram_block_added;
     s->ram_notifier.ram_block_removed =3D qemu_vfio_ram_block_removed;
+    s->ram_notifier.ram_block_resized =3D qemu_vfio_ram_block_resized;
     s->low_water_mark =3D QEMU_VFIO_IOVA_MIN;
     s->high_water_mark =3D QEMU_VFIO_IOVA_MAX;
     ram_block_notifier_add(&s->ram_notifier);
--=20
2.24.1


