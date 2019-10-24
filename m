Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C272CA9EB9
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 02:50:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37F2220679
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 02:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hqpg/Apn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37F2220679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNTCe-0002Kj-Az
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 22:50:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41470)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iNT9A-00036J-1l
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 22:46:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iNT98-0005nL-Jq
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 22:46:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38505
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iNT98-0005mZ-F0
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 22:46:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571885201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PssP5r9I/AvGQJl5jbf7fQBnA+KBtK6Jd6fBhm1vPWo=;
 b=hqpg/Apn1ccYzqKwlVk5PGsYws13mnKEJvA6Do6f6dyiTPK+/VA6mM8/Cxb5LoFbdARUAt
 g+XgeTSlK6o63pFOtvjpo45FtUumKpeaCJaNgs5GxooNuQuyLFQ96JC3JmRSKJAb0uUCm+
 QnMkGQrRHzQoQIlHb/cgfL1l9ou9Es8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-LYBzm33DNhaTKQZXoveDBA-1; Wed, 23 Oct 2019 22:46:38 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AAA4080183E;
 Thu, 24 Oct 2019 02:46:36 +0000 (UTC)
Received: from localhost (ovpn-116-56.gru2.redhat.com [10.97.116.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6BFA8194BB;
 Thu, 24 Oct 2019 02:46:33 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 3/4] ppc: rs6000_mc: drop usage of
 memory_region_allocate_system_memory()
Date: Wed, 23 Oct 2019 23:46:22 -0300
Message-Id: <20191024024623.18848-4-ehabkost@redhat.com>
In-Reply-To: <20191024024623.18848-1-ehabkost@redhat.com>
References: <20191024024623.18848-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: LYBzm33DNhaTKQZXoveDBA-1
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Mammedov <imammedo@redhat.com>

rs6000mc_realize() violates memory_region_allocate_system_memory() contract
by calling it multiple times which could break -mem-path. Replace it with
plain memory_region_init_ram() instead.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20191008113318.7012-3-imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/ppc/rs6000_mc.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/rs6000_mc.c b/hw/ppc/rs6000_mc.c
index df7c0006fc..66b14db5fa 100644
--- a/hw/ppc/rs6000_mc.c
+++ b/hw/ppc/rs6000_mc.c
@@ -144,6 +144,7 @@ static void rs6000mc_realize(DeviceState *dev, Error **=
errp)
     RS6000MCState *s =3D RS6000MC_DEVICE(dev);
     int socket =3D 0;
     unsigned int ram_size =3D s->ram_size / MiB;
+    Error *local_err =3D NULL;
=20
     while (socket < 6) {
         if (ram_size >=3D 64) {
@@ -165,19 +166,21 @@ static void rs6000mc_realize(DeviceState *dev, Error =
**errp)
         if (s->simm_size[socket]) {
             char name[] =3D "simm.?";
             name[5] =3D socket + '0';
-            memory_region_allocate_system_memory(&s->simm[socket], OBJECT(=
dev),
-                                                 name,
-                                                 s->simm_size[socket] * Mi=
B);
+            memory_region_init_ram(&s->simm[socket], OBJECT(dev), name,
+                                   s->simm_size[socket] * MiB, &local_err)=
;
+            if (local_err) {
+                goto out;
+            }
             memory_region_add_subregion_overlap(get_system_memory(), 0,
                                                 &s->simm[socket], socket);
         }
     }
     if (ram_size) {
         /* unable to push all requested RAM in SIMMs */
-        error_setg(errp, "RAM size incompatible with this board. "
+        error_setg(&local_err, "RAM size incompatible with this board. "
                    "Try again with something else, like %" PRId64 " MB",
                    s->ram_size / MiB - ram_size);
-        return;
+        goto out;
     }
=20
     if (s->autoconfigure) {
@@ -193,6 +196,8 @@ static void rs6000mc_realize(DeviceState *dev, Error **=
errp)
=20
     isa_register_portio_list(ISA_DEVICE(dev), &s->portio, 0x0,
                              rs6000mc_port_list, s, "rs6000mc");
+out:
+    error_propagate(errp, local_err);
 }
=20
 static const VMStateDescription vmstate_rs6000mc =3D {
--=20
2.21.0


