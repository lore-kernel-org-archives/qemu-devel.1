Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EAEFC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 08:54:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E7A920790
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 08:54:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E7A920790
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUQvZ-0001Q3-NR
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 04:54:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38232)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kUQqm-0004Js-CZ
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 04:49:04 -0400
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:56423)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kUQqk-0002vX-Qr
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 04:49:04 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-P7TqVq-NNC2DzU0OemN32g-1; Mon, 19 Oct 2020 04:48:57 -0400
X-MC-Unique: P7TqVq-NNC2DzU0OemN32g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89C4518A0765;
 Mon, 19 Oct 2020 08:48:56 +0000 (UTC)
Received: from bahia.lan (ovpn-112-78.ams2.redhat.com [10.36.112.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BAECB70105;
 Mon, 19 Oct 2020 08:48:42 +0000 (UTC)
Subject: [PATCH 4/5] spapr: Pass &error_abort when getting some PC DIMM
 properties
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 19 Oct 2020 10:48:41 +0200
Message-ID: <160309732180.2739814.7243774674998010907.stgit@bahia.lan>
In-Reply-To: <160309727218.2739814.14722724927730985344.stgit@bahia.lan>
References: <160309727218.2739814.14722724927730985344.stgit@bahia.lan>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=groug@kaod.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: softfail client-ip=205.139.111.44; envelope-from=groug@kaod.org;
 helo=us-smtp-delivery-44.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 04:48:02
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Both PC_DIMM_SLOT_PROP and PC_DIMM_ADDR_PROP are defined in the
default property list of the PC DIMM device class:

    DEFINE_PROP_UINT64(PC_DIMM_ADDR_PROP, PCDIMMDevice, addr, 0),

    DEFINE_PROP_INT32(PC_DIMM_SLOT_PROP, PCDIMMDevice, slot,
                      PC_DIMM_UNASSIGNED_SLOT),

They should thus be always gettable for both PC DIMMs and NVDIMMs.
An error in getting them can only be the result of a programming
error. It doesn't make much sense to propagate the error in this
case. Abort instead.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c |   17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 1b173861152f..62f217a6b914 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3443,19 +3443,13 @@ static void spapr_memory_plug(HotplugHandler *hotpl=
ug_dev, DeviceState *dev,
=20
     if (!is_nvdimm) {
         addr =3D object_property_get_uint(OBJECT(dimm),
-                                        PC_DIMM_ADDR_PROP, &local_err);
-        if (local_err) {
-            goto out_unplug;
-        }
+                                        PC_DIMM_ADDR_PROP, &error_abort);
         spapr_add_lmbs(dev, addr, size,
                        spapr_ovec_test(ms->ov5_cas, OV5_HP_EVT),
                        &local_err);
     } else {
         slot =3D object_property_get_int(OBJECT(dimm),
-                                       PC_DIMM_SLOT_PROP, &local_err);
-        if (local_err) {
-            goto out_unplug;
-        }
+                                       PC_DIMM_SLOT_PROP, &error_abort);
         /* We should have valid slot number at this point */
         g_assert(slot >=3D 0);
         spapr_add_nvdimm(dev, slot, &local_err);
@@ -3634,7 +3628,6 @@ static void spapr_memory_unplug_request(HotplugHandle=
r *hotplug_dev,
                                         DeviceState *dev, Error **errp)
 {
     SpaprMachineState *spapr =3D SPAPR_MACHINE(hotplug_dev);
-    Error *local_err =3D NULL;
     PCDIMMDevice *dimm =3D PC_DIMM(dev);
     uint32_t nr_lmbs;
     uint64_t size, addr_start, addr;
@@ -3650,11 +3643,7 @@ static void spapr_memory_unplug_request(HotplugHandl=
er *hotplug_dev,
     nr_lmbs =3D size / SPAPR_MEMORY_BLOCK_SIZE;
=20
     addr_start =3D object_property_get_uint(OBJECT(dimm), PC_DIMM_ADDR_PRO=
P,
-                                         &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
-    }
+                                          &error_abort);
=20
     /*
      * An existing pending dimm state for this DIMM means that there is an



