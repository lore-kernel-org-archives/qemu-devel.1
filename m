Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0152FC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 10:55:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEE6A20674
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 10:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bxFsMveo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEE6A20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itUir-0007wJ-Ha
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 05:55:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38036)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1itUQP-00077o-OK
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:36:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1itUQL-0002wL-NB
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:36:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22829
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1itUQL-0002wB-JC
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:36:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579516609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Um/ZPRrwSgEty2GoCR0h//BX2713mBeYZe2pvS7jfVI=;
 b=bxFsMveocQXSoBkn3eETnog4h4AdQBsltZf4tNPUsUZFOOug0x6z6DVkijG3/W44uQw1Vr
 7ap6Dfo7J+ukYFpNR4oEPyayau3KdmB5WQANPo1OhNBM+/ngztaN+zvc7xD9JfvSs+FyZu
 uS+DatOe7uDhULAwx/jrt8wS7Unjzgw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-rf_6l2vbNGqC_meg0uNxSw-1; Mon, 20 Jan 2020 05:36:47 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1B68113787E;
 Mon, 20 Jan 2020 10:36:45 +0000 (UTC)
Received: from secure.mitica (ovpn-116-207.ams2.redhat.com [10.36.116.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9C618860E5;
 Mon, 20 Jan 2020 10:36:36 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 20/29] migration/multifd: clean pages after filling packet
Date: Mon, 20 Jan 2020 11:33:31 +0100
Message-Id: <20200120103340.25118-21-quintela@redhat.com>
In-Reply-To: <20200120103340.25118-1-quintela@redhat.com>
References: <20200120103340.25118-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: rf_6l2vbNGqC_meg0uNxSw-1
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
Cc: Laurent Vivier <lvivier@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Stefan Weil <sw@weilnetz.de>,
 Jason Wang <jasowang@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Wei Yang <richardw.yang@linux.intel.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Wei Yang <richardw.yang@linux.intel.com>

This is a preparation for the next patch:

    not use multifd during postcopy.

Without enabling postcopy, everything looks good. While after enabling
postcopy, migration may fail even not use multifd during postcopy. The
reason is the pages is not properly cleared and *old* target page will
continue to be transferred.

After clean pages, migration succeeds.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 5f20c3d15d..a05448c0c9 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -955,10 +955,10 @@ static int multifd_send_pages(RAMState *rs)
         }
         qemu_mutex_unlock(&p->mutex);
     }
-    p->pages->used =3D 0;
+    assert(!p->pages->used);
+    assert(!p->pages->block);
=20
     p->packet_num =3D multifd_send_state->packet_num++;
-    p->pages->block =3D NULL;
     multifd_send_state->pages =3D p->pages;
     p->pages =3D pages;
     transferred =3D ((uint64_t) pages->used) * TARGET_PAGE_SIZE + p->packe=
t_len;
@@ -1154,6 +1154,8 @@ static void *multifd_send_thread(void *opaque)
             p->flags =3D 0;
             p->num_packets++;
             p->num_pages +=3D used;
+            p->pages->used =3D 0;
+            p->pages->block =3D NULL;
             qemu_mutex_unlock(&p->mutex);
=20
             trace_multifd_send(p->id, packet_num, used, flags,
--=20
2.24.1


