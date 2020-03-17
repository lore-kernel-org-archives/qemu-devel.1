Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF71C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:44:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7A7320724
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dOPR/24r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7A7320724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36747 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEFKc-0005b6-S2
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 12:44:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60628)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jEFA6-0006q4-R7
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 12:33:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jEFA5-0004ik-2W
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 12:33:50 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:53250)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jEFA4-0004fr-Rj
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 12:33:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584462828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PbZ1Lg9jD4KHSPOVX2F6auSxbLWLK378l9yNhpcLhBA=;
 b=dOPR/24rWvkmE60egtOr9+IKZ3JFafOvcMiXjNf2tGo//sYZAIDUEq71kQ8Zp8/9kBheZR
 dlm+GWAaeq8DDbMgdMzb9A+mcaYVfscUi6XsX2GBI8AFrELa5dg8tGzpthFIp5QYLW5mS3
 2u74tiKp3JHwZQyktsIqPB6mn0kpijM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-cVarMCmQPEefaalMvMqsgA-1; Tue, 17 Mar 2020 12:33:46 -0400
X-MC-Unique: cVarMCmQPEefaalMvMqsgA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F28C107ACCD;
 Tue, 17 Mar 2020 16:33:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-130.ams2.redhat.com
 [10.36.112.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2D65160BE0;
 Tue, 17 Mar 2020 16:33:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AD7D311366D1; Tue, 17 Mar 2020 17:33:43 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 4/4] hw/sd/ssi-sd: fix error handling in ssi_sd_realize
Date: Tue, 17 Mar 2020 17:33:43 +0100
Message-Id: <20200317163343.25028-5-armbru@redhat.com>
In-Reply-To: <20200317163343.25028-1-armbru@redhat.com>
References: <20200317163343.25028-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

It's wrong to use same err object as errp parameter for several
function calls without intermediate checking for error: we'll crash if
try to set err object twice. Fix that.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20200317125741.15301-1-vsementsov@virtuozzo.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/sd/ssi-sd.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
index 91db069212..829797b597 100644
--- a/hw/sd/ssi-sd.c
+++ b/hw/sd/ssi-sd.c
@@ -255,13 +255,25 @@ static void ssi_sd_realize(SSISlave *d, Error **errp)
     carddev =3D qdev_create(BUS(&s->sdbus), TYPE_SD_CARD);
     if (dinfo) {
         qdev_prop_set_drive(carddev, "drive", blk_by_legacy_dinfo(dinfo), =
&err);
+        if (err) {
+            goto fail;
+        }
     }
+
     object_property_set_bool(OBJECT(carddev), true, "spi", &err);
+    if (err) {
+        goto fail;
+    }
+
     object_property_set_bool(OBJECT(carddev), true, "realized", &err);
     if (err) {
-        error_setg(errp, "failed to init SD card: %s", error_get_pretty(er=
r));
-        return;
+        goto fail;
     }
+
+    return;
+
+fail:
+    error_propagate_prepend(errp, err, "failed to init SD card: ");
 }
=20
 static void ssi_sd_reset(DeviceState *dev)
--=20
2.21.1


