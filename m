Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26AE0C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:03:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E261220775
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RlYJKwJt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E261220775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtIAU-00069S-5u
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:03:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jtHhq-00084m-VM
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:34:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46095
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jtHhp-0002sI-06
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:34:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594244056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qUbtKDxMezpvsHsjFD/6GnFbc0z81+lRlZV+mupFL9E=;
 b=RlYJKwJtWFaPnaBFcisi2aD+hUKXlZOvyix2M7mku/ob5QEtF5Iz8D/umP/T5cN/VEgTLx
 nNF5y9oumoZaOKEEq6kI+48CqSo1bpidafmwSkd2D0GubQuQShBV5SeJqBtH14SEm0/aeY
 BpH6kGz5XOY688pSJr/EHkslEfi6lJg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-A36qbLZINLageehqeLA1hQ-1; Tue, 07 Jul 2020 17:31:03 -0400
X-MC-Unique: A36qbLZINLageehqeLA1hQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 85028800D5C;
 Tue,  7 Jul 2020 21:31:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1702A73FEA;
 Tue,  7 Jul 2020 21:31:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CB03110C4AED; Tue,  7 Jul 2020 23:25:04 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 48/53] sd: Use ERRP_GUARD()
Date: Tue,  7 Jul 2020 23:24:58 +0200
Message-Id: <20200707212503.1495927-49-armbru@redhat.com>
In-Reply-To: <20200707212503.1495927-1-armbru@redhat.com>
References: <20200707212503.1495927-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

If we want to check error after errp-function call, we need to
introduce local_err and then propagate it to errp. Instead, use
the ERRP_GUARD() macro, benefits are:
1. No need of explicit error_propagate call
2. No need of explicit local_err variable: use errp directly
3. ERRP_GUARD() leaves errp as is if it's not NULL or
   &error_fatal, this means that we don't break error_abort
   (we'll abort on error_set, not on error_propagate)

If we want to add some info to errp (by error_prepend() or
error_append_hint()), we must use the ERRP_GUARD() macro.
Otherwise, this info will not be added when errp == &error_fatal
(the program will exit prior to the error_append_hint() or
error_prepend() call).  No such cases are being fixed here.

This commit is generated by command

    sed -n '/^SD (Secure Card)$/,/^$/{s/^F: //p}' \
        MAINTAINERS | \
    xargs git ls-files | grep '\.[hc]$' | \
    xargs spatch \
        --sp-file scripts/coccinelle/errp-guard.cocci \
        --macro-file scripts/cocci-macro-file.h \
        --in-place --no-show-diff --max-width 80

Reported-by: Kevin Wolf <kwolf@redhat.com>
Reported-by: Greg Kurz <groug@kaod.org>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
[Commit message tweaked]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20200707165037.1026246-4-armbru@redhat.com>
[ERRP_AUTO_PROPAGATE() renamed to ERRP_GUARD(), and
auto-propagated-errp.cocci to errp-guard.cocci.  Commit message
tweaked again.]
---
 hw/sd/sdhci-pci.c |  7 +++----
 hw/sd/sdhci.c     | 21 +++++++++------------
 hw/sd/ssi-sd.c    | 10 +++++-----
 3 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/hw/sd/sdhci-pci.c b/hw/sd/sdhci-pci.c
index 4f5977d487..c737c8b930 100644
--- a/hw/sd/sdhci-pci.c
+++ b/hw/sd/sdhci-pci.c
@@ -29,13 +29,12 @@ static Property sdhci_pci_properties[] = {
 
 static void sdhci_pci_realize(PCIDevice *dev, Error **errp)
 {
+    ERRP_GUARD();
     SDHCIState *s = PCI_SDHCI(dev);
-    Error *local_err = NULL;
 
     sdhci_initfn(s);
-    sdhci_common_realize(s, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    sdhci_common_realize(s, errp);
+    if (*errp) {
         return;
     }
 
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index eb2be6529e..deac181865 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1288,7 +1288,7 @@ static const MemoryRegionOps sdhci_mmio_ops = {
 
 static void sdhci_init_readonly_registers(SDHCIState *s, Error **errp)
 {
-    Error *local_err = NULL;
+    ERRP_GUARD();
 
     switch (s->sd_spec_version) {
     case 2 ... 3:
@@ -1299,9 +1299,8 @@ static void sdhci_init_readonly_registers(SDHCIState *s, Error **errp)
     }
     s->version = (SDHC_HCVER_VENDOR << 8) | (s->sd_spec_version - 1);
 
-    sdhci_check_capareg(s, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    sdhci_check_capareg(s, errp);
+    if (*errp) {
         return;
     }
 }
@@ -1332,11 +1331,10 @@ void sdhci_uninitfn(SDHCIState *s)
 
 void sdhci_common_realize(SDHCIState *s, Error **errp)
 {
-    Error *local_err = NULL;
+    ERRP_GUARD();
 
-    sdhci_init_readonly_registers(s, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    sdhci_init_readonly_registers(s, errp);
+    if (*errp) {
         return;
     }
     s->buf_maxsz = sdhci_get_fifolen(s);
@@ -1456,13 +1454,12 @@ static void sdhci_sysbus_finalize(Object *obj)
 
 static void sdhci_sysbus_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_GUARD();
     SDHCIState *s = SYSBUS_SDHCI(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
-    Error *local_err = NULL;
 
-    sdhci_common_realize(s, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    sdhci_common_realize(s, errp);
+    if (*errp) {
         return;
     }
 
diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
index 3717b2e721..9210ef567f 100644
--- a/hw/sd/ssi-sd.c
+++ b/hw/sd/ssi-sd.c
@@ -241,10 +241,10 @@ static const VMStateDescription vmstate_ssi_sd = {
 
 static void ssi_sd_realize(SSISlave *d, Error **errp)
 {
+    ERRP_GUARD();
     ssi_sd_state *s = SSI_SD(d);
     DeviceState *carddev;
     DriveInfo *dinfo;
-    Error *err = NULL;
 
     qbus_create_inplace(&s->sdbus, sizeof(s->sdbus), TYPE_SD_BUS,
                         DEVICE(d), "sd-bus");
@@ -255,23 +255,23 @@ static void ssi_sd_realize(SSISlave *d, Error **errp)
     carddev = qdev_new(TYPE_SD_CARD);
     if (dinfo) {
         if (!qdev_prop_set_drive_err(carddev, "drive",
-                                     blk_by_legacy_dinfo(dinfo), &err)) {
+                                     blk_by_legacy_dinfo(dinfo), errp)) {
             goto fail;
         }
     }
 
-    if (!object_property_set_bool(OBJECT(carddev), "spi", true, &err)) {
+    if (!object_property_set_bool(OBJECT(carddev), "spi", true, errp)) {
         goto fail;
     }
 
-    if (!qdev_realize_and_unref(carddev, BUS(&s->sdbus), &err)) {
+    if (!qdev_realize_and_unref(carddev, BUS(&s->sdbus), errp)) {
         goto fail;
     }
 
     return;
 
 fail:
-    error_propagate_prepend(errp, err, "failed to init SD card: ");
+    error_prepend(errp, "failed to init SD card: ");
 }
 
 static void ssi_sd_reset(DeviceState *dev)
-- 
2.26.2


