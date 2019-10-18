Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FAE8CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 15:12:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D82A21897
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 15:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="t/JpbLai"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D82A21897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLTv6-00017k-GS
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 11:12:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39121)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1iLTrC-0006kn-Jh
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 11:07:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1iLTrB-0000IN-EZ
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 11:07:58 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:38708)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1iLTr8-0000F9-G2; Fri, 18 Oct 2019 11:07:54 -0400
Received: from crumble.bar.greensocs.com (crumble.bar.greensocs.com
 [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPS id E71AE96F56;
 Fri, 18 Oct 2019 15:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1571411273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wKAieN4stMmjUC4G+xrrQnH6uT0wInwvb/2V4Wkfc+U=;
 b=t/JpbLaiv6mEH12jp92pt87B4PTZjY2iM95fBJW2Kf0dkrq6O4qzHNKlIwovbEt3AkvhVz
 AraTiTB/xQEczOzZFdnZ78DEjUA3RxeGhPBSF8MfcyU+/+CysGIEJltqnrLBJU9015ivx1
 KVBGuGuav4FgeW9vDRMeBGnrw3mguU0=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 07/13] hw/core/qdev: update hotplug reset regarding
 resettable
Date: Fri, 18 Oct 2019 17:06:24 +0200
Message-Id: <20191018150630.31099-8-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191018150630.31099-1-damien.hedde@greensocs.com>
References: <20191018150630.31099-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1571411273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wKAieN4stMmjUC4G+xrrQnH6uT0wInwvb/2V4Wkfc+U=;
 b=DOfavnjmrGE2i3KZzhr1n2LohBZbkDZoaMXwQkJRtxNgqnugTYcjIXqm2nf5BkKD8oPL+S
 Gwxnr0VRX4wt7NbvBsCzODJqSvR03lx6YJ5Y+43zHMTWabAeJU1WtbYUsI+rMBkow/25zy
 OK/rW69WuIyh82Z0Msrl/PHqjN6CYC0=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1571411273; a=rsa-sha256; cv=none;
 b=bI2cHCkU3ZTtOgQXYD2R2ehrrhcvUA+Uf/ug/7ha851RAGTOpVTibBpp6z4O+hrQkUsdC0
 6Zb7BTz27Y1BxoXaOu13IKw+pkYiTILk+lfSaxQf1TEj/vR/Q/Wcc6WU1sLN6CjJ0Y9eqZ
 85rgFmFGP2nHHQ1rj6YJfljaJczxWMc=
ARC-Authentication-Results: i=1;
	beetle.greensocs.com;
	none
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.135.226.135
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
Cc: Damien Hedde <damien.hedde@greensocs.com>, peter.maydell@linaro.org,
 berrange@redhat.com, ehabkost@redhat.com, cohuck@redhat.com,
 mark.burton@greensocs.com, qemu-s390x@nongnu.org, edgari@xilinx.com,
 qemu-arm@nongnu.org, pbonzini@redhat.com, philmd@redhat.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This commit make use of the resettable API to reset the device being
hotplugged during when it is realized. Also it make sure it is put in
a reset state coherent with the parent it is plugged into.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
---

I'm not sure I've done everything that's required here since I do not
understand everything that's behind the hotplug and realize/unrealize.
I'm a bit lost there...

One of the remaining question is: do we need to do things related to
unrealize ?
It seems, a device can be realized, unrealized, and re-realized ? But
is that true also for a hotplugged device ?

Also resettable API is called there, so children if any are reset too.
This was not the case before, this a probably not a big deal, as long
as all children are realized too at this point. I'm not sure we have a
guarantee on this; the recursive realize is not done in the base bus
class so it will go only down to first buses level if it is not
propagated by bus subclasses. Do hotplug devices can have more than
single level bus subtree (ie: more than some child buses with no
devices on them) ?
---
 hw/core/qdev.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 3933f62d0c..c5d107ea4e 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -930,7 +930,14 @@ static void device_set_realized(Object *obj, bool va=
lue, Error **errp)
             }
         }
         if (dev->hotplugged) {
-            device_legacy_reset(dev);
+            /*
+             * Reset the device, as well as its subtree which should be
+             * realized too
+             */
+            resettable_assert_reset(OBJECT(dev), RESET_TYPE_COLD);
+            resettable_change_parent(OBJECT(dev), OBJECT(dev->parent_bus=
),
+                                     NULL);
+            resettable_release_reset(OBJECT(dev), RESET_TYPE_COLD);
         }
         dev->pending_deleted_event =3D false;
=20
--=20
2.23.0


