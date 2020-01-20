Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFFDC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 11:06:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAC322087E
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 11:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WYqlJuS9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAC322087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itUsu-0004WS-EA
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 06:06:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38425)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1itURU-0000Ln-9M
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:38:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1itURS-0003RV-6f
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:38:00 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33313
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1itURS-0003RP-2s
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:37:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579516677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2kN2SVoPx8AG8bWLkP/5pV/dMcwghV+OE39B65cCmDk=;
 b=WYqlJuS9nOKhjOKtl17jc2njHNgWyYn4eiiExLkOdlDk2GRBkwlRWjh6TdpoHS48QXGpw4
 wiafM9CpWP+5OTdcrmsOe2CiG4kjJDuTepTCiwFk1ws4W8Vtwrm312FKdFemFAE7TT2x8t
 f/KF7pG8O3bo8Gn9MBXdUJ+i5ABOtVs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-QQxRjkBYMYGjylSTTr0h_g-1; Mon, 20 Jan 2020 05:37:56 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1FE88C2F20;
 Mon, 20 Jan 2020 10:37:54 +0000 (UTC)
Received: from secure.mitica (ovpn-116-207.ams2.redhat.com [10.36.116.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A2C971BC6D;
 Mon, 20 Jan 2020 10:37:42 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 29/29] multifd: Be consistent about using uint64_t
Date: Mon, 20 Jan 2020 11:33:40 +0100
Message-Id: <20200120103340.25118-30-quintela@redhat.com>
In-Reply-To: <20200120103340.25118-1-quintela@redhat.com>
References: <20200120103340.25118-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: QQxRjkBYMYGjylSTTr0h_g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: Laurent Vivier <lvivier@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Stefan Weil <sw@weilnetz.de>,
 Jason Wang <jasowang@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We transmit ram_addr_t always as uint64_t.  Be consistent in its
use (on 64bit system, it is always uint64_t problem is 32bits).

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/ram.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index d0940387d1..d2208b5534 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -803,7 +803,10 @@ static void multifd_send_fill_packet(MultiFDSendParams=
 *p)
     }
=20
     for (i =3D 0; i < p->pages->used; i++) {
-        packet->offset[i] =3D cpu_to_be64(p->pages->offset[i]);
+        /* there are architectures where ram_addr_t is 32 bit */
+        uint64_t temp =3D p->pages->offset[i];
+
+        packet->offset[i] =3D cpu_to_be64(temp);
     }
 }
=20
@@ -877,10 +880,10 @@ static int multifd_recv_unfill_packet(MultiFDRecvPara=
ms *p, Error **errp)
     }
=20
     for (i =3D 0; i < p->pages->used; i++) {
-        ram_addr_t offset =3D be64_to_cpu(packet->offset[i]);
+        uint64_t offset =3D be64_to_cpu(packet->offset[i]);
=20
         if (offset > (block->used_length - TARGET_PAGE_SIZE)) {
-            error_setg(errp, "multifd: offset too long " RAM_ADDR_FMT
+            error_setg(errp, "multifd: offset too long %" PRIu64
                        " (max " RAM_ADDR_FMT ")",
                        offset, block->max_length);
             return -1;
@@ -1267,7 +1270,7 @@ int multifd_save_setup(void)
         p->id =3D i;
         p->pages =3D multifd_pages_init(page_count);
         p->packet_len =3D sizeof(MultiFDPacket_t)
-                      + sizeof(ram_addr_t) * page_count;
+                      + sizeof(uint64_t) * page_count;
         p->packet =3D g_malloc0(p->packet_len);
         p->packet->magic =3D cpu_to_be32(MULTIFD_MAGIC);
         p->packet->version =3D cpu_to_be32(MULTIFD_VERSION);
@@ -1484,7 +1487,7 @@ int multifd_load_setup(void)
         p->id =3D i;
         p->pages =3D multifd_pages_init(page_count);
         p->packet_len =3D sizeof(MultiFDPacket_t)
-                      + sizeof(ram_addr_t) * page_count;
+                      + sizeof(uint64_t) * page_count;
         p->packet =3D g_malloc0(p->packet_len);
         p->name =3D g_strdup_printf("multifdrecv_%d", i);
     }
--=20
2.24.1


