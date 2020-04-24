Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C1AC54FCB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 19:26:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67F3E20857
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 19:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ShJ8l4AW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67F3E20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jS3xX-0007ir-Io
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 15:25:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52984)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jS3sN-0003Te-I3
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 15:20:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jS3sL-00044p-CZ
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 15:20:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26624
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jS3sK-00043w-UL
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 15:20:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587756036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ASZZZIyyvkJvNdyEC2tSEUSDsRRjQZ96na7DykDkrV8=;
 b=ShJ8l4AWk8gqnnDen0eh30yFy665gAKmJFxUqZeaHO3DPNdrKqmB54/qquawiZGcik4McE
 bJeCefpulCS+RjHiFp8EizvGbQpBcGm7mu/9RsXzqZXHaVzfwMOH8YoQRXzudyyQpy+uNX
 JNwRUZwPFMkUiiY0FK6hd2Er61IBf38=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-t3fgFY72N3ismHaVcMdNuQ-1; Fri, 24 Apr 2020 15:20:34 -0400
X-MC-Unique: t3fgFY72N3ismHaVcMdNuQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EAE291800D42;
 Fri, 24 Apr 2020 19:20:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C2B2F196AE;
 Fri, 24 Apr 2020 19:20:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 416DA11358C4; Fri, 24 Apr 2020 21:20:27 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/11] mips/boston: Fix boston_mach_init() error handling
Date: Fri, 24 Apr 2020 21:20:24 +0200
Message-Id: <20200424192027.11404-9-armbru@redhat.com>
In-Reply-To: <20200424192027.11404-1-armbru@redhat.com>
References: <20200424192027.11404-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 13:45:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Paul Burton <pburton@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Error ** argument must be NULL, &error_abort, &error_fatal, or a
pointer to a variable containing NULL.  Passing an argument of the
latter kind twice without clearing it in between is wrong: if the
first call sets an error, it no longer points to NULL for the second

boston_mach_init() is wrong that way.  The last calls treats an error
as fatal.  Do that for the prior ones, too.

Fixes: df1d8a1f29f567567b9d20be685a4241282e7005
Cc: Paul Burton <pburton@wavecomp.com>
Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/mips/boston.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index 98ecd25e8e..2832dfa6ae 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -458,14 +458,11 @@ static void boston_mach_init(MachineState *machine)
     sysbus_init_child_obj(OBJECT(machine), "cps", OBJECT(&s->cps),
                           sizeof(s->cps), TYPE_MIPS_CPS);
     object_property_set_str(OBJECT(&s->cps), machine->cpu_type, "cpu-type"=
,
-                            &err);
-    object_property_set_int(OBJECT(&s->cps), machine->smp.cpus, "num-vp", =
&err);
-    object_property_set_bool(OBJECT(&s->cps), true, "realized", &err);
-
-    if (err !=3D NULL) {
-        error_report("%s", error_get_pretty(err));
-        exit(1);
-    }
+                            &error_fatal);
+    object_property_set_int(OBJECT(&s->cps), machine->smp.cpus, "num-vp",
+                            &error_fatal);
+    object_property_set_bool(OBJECT(&s->cps), true, "realized",
+                             &error_fatal);
=20
     sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->cps), 0, 0, 1);
=20
--=20
2.21.1


