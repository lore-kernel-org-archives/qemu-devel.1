Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4638DC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 17:09:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 114B72076C
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 17:09:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 114B72076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5uGB-0004ps-Bz
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 13:09:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53516)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1k5uFR-0003wi-4l
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 13:09:09 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47237
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1k5uFP-00088z-IJ
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 13:09:08 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-4hfQ8wHJOsebyP-8nl8H1Q-1; Wed, 12 Aug 2020 13:09:01 -0400
X-MC-Unique: 4hfQ8wHJOsebyP-8nl8H1Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B2A051902EA1;
 Wed, 12 Aug 2020 17:08:59 +0000 (UTC)
Received: from bahia.lan (ovpn-112-216.ams2.redhat.com [10.36.112.216])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5A9DE19D71;
 Wed, 12 Aug 2020 17:08:58 +0000 (UTC)
Subject: [PATCH v2 2/2] spapr/nvram: Error out if NVRAM cannot contain all
 -prom-env data
From: Greg Kurz <groug@kaod.org>
To: Thomas Huth <thuth@redhat.com>
Date: Wed, 12 Aug 2020 19:08:57 +0200
Message-ID: <159725213748.104309.14834084670144632611.stgit@bahia.lan>
In-Reply-To: <159725212173.104309.6136813383848717434.stgit@bahia.lan>
References: <159725212173.104309.6136813383848717434.stgit@bahia.lan>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=groug@kaod.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: softfail client-ip=205.139.110.61; envelope-from=groug@kaod.org;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 04:50:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=ham autolearn_force=no
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 John Snow <jsnow@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since commit 61f20b9dc5b7 ("spapr_nvram: Pre-initialize the NVRAM to
support the -prom-env parameter"), pseries machines can pre-initialize
the "system" partition in the NVRAM with the data passed to all -prom-env
parameters on the QEMU command line.

In this cases it is assumed that all the data fits in 64 KiB, but the user
can easily pass more and crash QEMU:

$ qemu-system-ppc64 -M pseries $(for ((x=3D0;x<128;x++)); do \
  echo -n " -prom-env "$(for ((y=3D0;y<1024;y++)); do echo -n x ; done) ; \
  done) # this requires ~128 Kib
malloc(): corrupted top size
Aborted (core dumped)

Call chrp_nvram_create_system_partition() first, with its recently added
parameter dry_run set to true, in order to know the required size and fail
gracefully if it's too small.

Reported-by: John Snow <jsnow@redhat.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/nvram/spapr_nvram.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/nvram/spapr_nvram.c b/hw/nvram/spapr_nvram.c
index 992b818d34e7..c29d797ae1f0 100644
--- a/hw/nvram/spapr_nvram.c
+++ b/hw/nvram/spapr_nvram.c
@@ -145,6 +145,7 @@ static void rtas_nvram_store(PowerPCCPU *cpu, SpaprMach=
ineState *spapr,
=20
 static void spapr_nvram_realize(SpaprVioDevice *dev, Error **errp)
 {
+    ERRP_GUARD();
     SpaprNvram *nvram =3D VIO_SPAPR_NVRAM(dev);
     int ret;
=20
@@ -187,6 +188,20 @@ static void spapr_nvram_realize(SpaprVioDevice *dev, E=
rror **errp)
             return;
         }
     } else if (nb_prom_envs > 0) {
+        int len =3D chrp_nvram_create_system_partition(nvram->buf,
+                                                     MIN_NVRAM_SIZE / 4,
+                                                     true);
+
+        /* Check the partition is large enough for all the -prom-env data =
*/
+        if (nvram->size < len) {
+            error_setg(errp, "-prom-env data requires %d bytes but spapr-n=
vram "
+                       "is only %d bytes in size", len, nvram->size);
+            error_append_hint(errp,
+                              "Try to pass %d less bytes to -prom-env.\n",
+                              len - nvram->size);
+            return;
+        }
+
         /* Create a system partition to pass the -prom-env variables */
         chrp_nvram_create_system_partition(nvram->buf, MIN_NVRAM_SIZE / 4,
                                            false);



