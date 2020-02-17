Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D215BC34021
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 17:36:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F2CB20718
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 17:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XqiaVdp5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F2CB20718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3kJo-0002wx-QI
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 12:36:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38039)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j3kIb-0000xH-VW
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:35:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j3kIa-0001h2-Vr
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:35:13 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34632
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j3kIa-0001fP-Rm
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:35:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581960912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dLTFw+CktQgSrej1IbjHdt27BnydF2v1oUhwoWTHQFY=;
 b=XqiaVdp5ln9QzAXIC3SnhF0JfZcEfIKGljIyR+gTN0a0RLFrnz5PXFZZSaUxyke+axpCl6
 Bx/i8GyiDFTQJig1zwP0f96Xnl+JQ4BA34jydgcUom3ywhQnkmiE+/ISz9SinMgqQqWS47
 Bd2GCqXiI8nHvo8F2xb7Ch9ZMNJ5W/k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-CHF08h0PP2OI3kvAKQfrdg-1; Mon, 17 Feb 2020 12:35:10 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 497D31800D42;
 Mon, 17 Feb 2020 17:35:09 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6AD7B90526;
 Mon, 17 Feb 2020 17:35:08 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 07/79] vl.c: ensure that ram_size matches size of
 machine.memory-backend
Date: Mon, 17 Feb 2020 12:33:40 -0500
Message-Id: <20200217173452.15243-8-imammedo@redhat.com>
In-Reply-To: <20200217173452.15243-1-imammedo@redhat.com>
References: <20200217173452.15243-1-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: CHF08h0PP2OI3kvAKQfrdg-1
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
Cc: pasic@linux.ibm.com, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Extend set_memory_options() to check that size specified by -m
matches the size of backend pointed by memory-backend.
And in case of -m was omitted adjust ram_size to match that
of explicitly provided backend.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: pasic@linux.ibm.com
CC: pbonzini@redhat.com
---
 vl.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/vl.c b/vl.c
index 72ffc06f2f..a7edcba094 100644
--- a/vl.c
+++ b/vl.c
@@ -2655,6 +2655,21 @@ static void set_memory_options(uint64_t *ram_slots, =
ram_addr_t *maxram_size,
         exit(EXIT_FAILURE);
     }
=20
+    if (current_machine->ram_memdev_id) {
+        Object *backend;
+        ram_addr_t backend_size;
+
+        backend =3D object_resolve_path_type(current_machine->ram_memdev_i=
d,
+                                           TYPE_MEMORY_BACKEND, NULL);
+        backend_size =3D object_property_get_uint(backend, "size",  &error=
_abort);
+        if (mem_str && backend_size !=3D ram_size) {
+                error_report("Size specified by -m option must match size =
of "
+                             "explicitly specified 'memory-backend' proper=
ty");
+                exit(EXIT_FAILURE);
+        }
+        ram_size =3D backend_size;
+    }
+
     if (!xen_enabled()) {
         /* On 32-bit hosts, QEMU is limited by virtual address space */
         if (ram_size > (2047 << 20) && HOST_LONG_BITS =3D=3D 32) {
--=20
2.18.1


