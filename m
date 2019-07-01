Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB772C0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 12:44:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CFF02053B
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 12:44:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CFF02053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhvf9-0007uA-TI
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 08:44:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58275)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hhvWL-0007vv-QH
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 08:34:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hhvWK-0005ho-Rl
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 08:34:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:24811)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hhvWK-0005gm-MQ; Mon, 01 Jul 2019 08:34:56 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0892C3092649;
 Mon,  1 Jul 2019 12:34:50 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.170])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7DE33196F7;
 Mon,  1 Jul 2019 12:34:43 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 14:34:41 +0200
Message-Id: <20190701123441.13412-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Mon, 01 Jul 2019 12:34:55 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] hw/misc/macio: Add the nvram as child of the
 MacIO south bridge
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Avoid another QOM orphean, link it back to its parent.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/misc/macio/macio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
index 82492096f8..e02882be28 100644
--- a/hw/misc/macio/macio.c
+++ b/hw/misc/macio/macio.c
@@ -243,7 +243,8 @@ static void macio_oldworld_init(Object *obj)
=20
     macio_init_child_obj(s, "cuda", &s->cuda, sizeof(s->cuda), TYPE_CUDA=
);
=20
-    object_initialize(&os->nvram, sizeof(os->nvram), TYPE_MACIO_NVRAM);
+    object_initialize_child(s, "nvram",  &os->nvram, sizeof(os->nvram),
+                            TYPE_MACIO_NVRAM, &error_abort, NULL);
     dev =3D DEVICE(&os->nvram);
     qdev_prop_set_uint32(dev, "size", 0x2000);
     qdev_prop_set_uint32(dev, "it_shift", 4);
--=20
2.20.1


