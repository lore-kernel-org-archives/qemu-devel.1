Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E40CC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 12:44:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB5F320771
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 12:44:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB5F320771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHnq3-0005bL-W8
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 08:44:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37782)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kHnhy-0006w9-Tw
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 08:35:46 -0400
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:58037)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kHnhw-0000ll-Va
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 08:35:46 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-535-jEntAfBRPde7mp1nNt0Egg-1; Mon, 14 Sep 2020 08:35:42 -0400
X-MC-Unique: jEntAfBRPde7mp1nNt0Egg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5ACF764086;
 Mon, 14 Sep 2020 12:35:41 +0000 (UTC)
Received: from bahia.redhat.com (ovpn-112-218.ams2.redhat.com [10.36.112.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0714D1002D4E;
 Mon, 14 Sep 2020 12:35:39 +0000 (UTC)
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 15/15] spapr: Simplify error handling in
 spapr_memory_unplug_request()
Date: Mon, 14 Sep 2020 14:35:05 +0200
Message-Id: <20200914123505.612812-16-groug@kaod.org>
In-Reply-To: <20200914123505.612812-1-groug@kaod.org>
References: <20200914123505.612812-1-groug@kaod.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=groug@kaod.org
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Received-SPF: softfail client-ip=207.211.30.44; envelope-from=groug@kaod.org;
 helo=us-smtp-delivery-44.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 08:35:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: Greg Kurz <groug@kaod.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-ppc@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since object_property_get_uint() only returns 0 on failure, use
that instead of local_err, and get rid of the error propagation
overhead.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index d6b4de6a1c53..2eca9dc26668 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3609,7 +3609,6 @@ static void spapr_memory_unplug_request(HotplugHandle=
r *hotplug_dev,
                                         DeviceState *dev, Error **errp)
 {
     SpaprMachineState *spapr =3D SPAPR_MACHINE(hotplug_dev);
-    Error *local_err =3D NULL;
     PCDIMMDevice *dimm =3D PC_DIMM(dev);
     uint32_t nr_lmbs;
     uint64_t size, addr_start, addr;
@@ -3625,9 +3624,8 @@ static void spapr_memory_unplug_request(HotplugHandle=
r *hotplug_dev,
     nr_lmbs =3D size / SPAPR_MEMORY_BLOCK_SIZE;
=20
     addr_start =3D object_property_get_uint(OBJECT(dimm), PC_DIMM_ADDR_PRO=
P,
-                                         &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+                                          errp);
+    if (!addr_start) {
         return;
     }
=20
--=20
2.26.2


