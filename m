Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A5CC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 11:11:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C74892088E
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 11:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CAupUln+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C74892088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeGRr-0002pR-TN
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 07:11:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49862)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jeGLO-0005s0-Cv
 for qemu-devel@nongnu.org; Thu, 28 May 2020 07:05:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24487
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jeGLG-0006km-26
 for qemu-devel@nongnu.org; Thu, 28 May 2020 07:05:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590663893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ym/tzzyYr0Jg0PcxIJ4XbQwSpjBNTm298HFLXDlGoPA=;
 b=CAupUln+uFPLXioZGMZvHCygX5wQj9HuiTG9dHHbWjyaRvNiqurwB80VlBJlGfS8tSHiBW
 a/snSUTT8BHTpDqIKX19l2qJTyq2ibGwhXfsBocorNv+QtNQeAC45R/lMnNiz6kp5zV/tl
 DVz0VrlLmeKADa2tmjunKDVu21aPQrw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-GRirs89-PmiaxErvaVea8w-1; Thu, 28 May 2020 07:04:49 -0400
X-MC-Unique: GRirs89-PmiaxErvaVea8w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0CA8A474;
 Thu, 28 May 2020 11:04:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A9BF97A8A6;
 Thu, 28 May 2020 11:04:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C736E113639D; Thu, 28 May 2020 13:04:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 05/24] arm/aspeed: Rework NIC attachment
Date: Thu, 28 May 2020 13:04:25 +0200
Message-Id: <20200528110444.20456-6-armbru@redhat.com>
In-Reply-To: <20200528110444.20456-1-armbru@redhat.com>
References: <20200528110444.20456-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 03:11:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Joel Stanley <joel@jms.id.au>, pbonzini@redhat.com, berrange@redhat.com,
 ehabkost@redhat.com, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Cédric Le Goater <clg@kaod.org>

The number of MACs supported by an Aspeed SoC is defined by "macs_num"
under the SoC model, that is two for the AST2400 and AST2500 and four
for the AST2600. The model initializes the maximum number of supported
MACs but the number of realized devices is capped by the number of
network device back-ends defined on the command line. This can leave
unrealized devices hanging around in the QOM composition tree.

To get virtual hardware that matches the physical hardware, you have
to pass exactly as many -nic options as there are MACs, and some of
them must be -nic none:

* Machines ast2500-evb, palmetto-bmc, romulus-bmc, sonorapass-bmc,
  swift-bmc, and witherspoon-bmc: two -nic, and the second one must be
  -nic none.

* Machine ast2600-evb: four -nic, the first one must be -nic none.

* Machine tacoma-bmc: four nic, the first two and the last one must be
  -nic none.

Modify the machine initialization to define which MACs are attached to
a network device back-end using a bit-field property "macs-mask" and
let the SoC realize all network devices.

The default setting of "macs-mask" is "use MAC0" only, which works for
all our AST2400 and AST2500 machines. The AST2600 machines have
different configurations. The AST2600 EVB machine activates MAC1, MAC2
and MAC3 and the Tacoma BMC machine activates MAC2.

Incompatible CLI change: -nic options now apply to *active* MACs:
MAC1, MAC2, MAC3 for ast2600-evb, MAC2 for tacoma-bmc, and MAC0 for
all the others.

The machines now always get all MACs as they should. Visible in "info
qom-tree", here's the change for tacoma-bmc:

     /machine (tacoma-bmc-machine)
       /peripheral (container)
       /peripheral-anon (container)
       /soc (ast2600-a1)
         [...]
         /ftgmac100[0] (ftgmac100)
           /ftgmac100[0] (qemu:memory-region)
         /ftgmac100[1] (ftgmac100)
    +      /ftgmac100[0] (qemu:memory-region)
         /ftgmac100[2] (ftgmac100)
    +      /ftgmac100[0] (qemu:memory-region)
         /ftgmac100[3] (ftgmac100)
    +      /ftgmac100[0] (qemu:memory-region)
         [...]
         /mii[0] (aspeed-mmi)
           /aspeed-mmi[0] (qemu:memory-region)
         /mii[1] (aspeed-mmi)
    +      /aspeed-mmi[0] (qemu:memory-region)
         /mii[2] (aspeed-mmi)
    +      /aspeed-mmi[0] (qemu:memory-region)
         /mii[3] (aspeed-mmi)
    +      /aspeed-mmi[0] (qemu:memory-region)

Also visible in "info qtree"; here's the change for tacoma-bmc:

       dev: ftgmac100, id ""
         gpio-out "sysbus-irq" 1
         aspeed = true
    -    mac = "52:54:00:12:34:56"
    -    netdev = "hub0port0"
    +    mac = "52:54:00:12:34:57"
    +    netdev = ""
         mmio 000000001e660000/0000000000002000
       dev: ftgmac100, id ""
    -    aspeed = false
    -    mac = "00:00:00:00:00:00"
    +    gpio-out "sysbus-irq" 1
    +    aspeed = true
    +    mac = "52:54:00:12:34:58"
         netdev = ""
    +    mmio 000000001e680000/0000000000002000
       dev: ftgmac100, id ""
    -    aspeed = false
    -    mac = "00:00:00:00:00:00"
    -    netdev = ""
    +    gpio-out "sysbus-irq" 1
    +    aspeed = true
    +    mac = "52:54:00:12:34:56"
    +    netdev = "hub0port0"
    +    mmio 000000001e670000/0000000000002000
       dev: ftgmac100, id ""
    -    aspeed = false
    -    mac = "00:00:00:00:00:00"
    +    gpio-out "sysbus-irq" 1
    +    aspeed = true
    +    mac = "52:54:00:12:34:59"
         netdev = ""
    +    mmio 000000001e690000/0000000000002000
       [...]
       dev: aspeed-mmi, id ""
         mmio 000000001e650000/0000000000000008
       dev: aspeed-mmi, id ""
    +    mmio 000000001e650008/0000000000000008
       dev: aspeed-mmi, id ""
    +    mmio 000000001e650010/0000000000000008
       dev: aspeed-mmi, id ""
    +    mmio 000000001e650018/0000000000000008

Inactive MACs will have no peer and QEMU may warn the user with :

    qemu-system-arm: warning: nic ftgmac100.0 has no peer
    qemu-system-arm: warning: nic ftgmac100.1 has no peer
    qemu-system-arm: warning: nic ftgmac100.3 has no peer

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20200527124406.329503-1-clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
[Commit message expanded]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/hw/arm/aspeed.h |  6 ++++++
 hw/arm/aspeed.c         | 13 +++++++++++++
 hw/arm/aspeed_ast2600.c |  3 +--
 hw/arm/aspeed_soc.c     |  3 +--
 4 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/include/hw/arm/aspeed.h b/include/hw/arm/aspeed.h
index 18521484b9..95b4daece8 100644
--- a/include/hw/arm/aspeed.h
+++ b/include/hw/arm/aspeed.h
@@ -23,6 +23,11 @@ typedef struct AspeedMachine {
     bool mmio_exec;
 } AspeedMachine;
 
+#define ASPEED_MAC0_ON   (1 << 0)
+#define ASPEED_MAC1_ON   (1 << 1)
+#define ASPEED_MAC2_ON   (1 << 2)
+#define ASPEED_MAC3_ON   (1 << 3)
+
 #define ASPEED_MACHINE_CLASS(klass) \
      OBJECT_CLASS_CHECK(AspeedMachineClass, (klass), TYPE_ASPEED_MACHINE)
 #define ASPEED_MACHINE_GET_CLASS(obj) \
@@ -39,6 +44,7 @@ typedef struct AspeedMachineClass {
     const char *fmc_model;
     const char *spi_model;
     uint32_t num_cs;
+    uint32_t macs_mask;
     void (*i2c_init)(AspeedBoardState *bmc);
 } AspeedMachineClass;
 
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index fd5cc542a5..f8f3ef89d3 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -258,6 +258,7 @@ static void aspeed_machine_init(MachineState *machine)
     DriveInfo *drive0 = drive_get(IF_MTD, 0, 0);
     ram_addr_t max_ram_size;
     int i;
+    NICInfo *nd = &nd_table[0];
 
     bmc = g_new0(AspeedBoardState, 1);
 
@@ -277,6 +278,14 @@ static void aspeed_machine_init(MachineState *machine)
     object_property_set_uint(OBJECT(&bmc->soc), ram_size, "ram-size",
                              &error_fatal);
 
+    for (i = 0; i < sc->macs_num; i++) {
+        if ((amc->macs_mask & (1 << i)) && nd->used) {
+            qemu_check_nic_model(nd, TYPE_FTGMAC100);
+            qdev_set_nic_properties(DEVICE(&bmc->soc.ftgmac100[i]), nd);
+            nd++;
+        }
+    }
+
     object_property_set_int(OBJECT(&bmc->soc), amc->hw_strap1, "hw-strap1",
                             &error_abort);
     object_property_set_int(OBJECT(&bmc->soc), amc->hw_strap2, "hw-strap2",
@@ -556,12 +565,14 @@ static int aspeed_soc_num_cpus(const char *soc_name)
 static void aspeed_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
+    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
 
     mc->init = aspeed_machine_init;
     mc->no_floppy = 1;
     mc->no_cdrom = 1;
     mc->no_parallel = 1;
     mc->default_ram_id = "ram";
+    amc->macs_mask = ASPEED_MAC0_ON;
 
     aspeed_machine_class_props_init(oc);
 }
@@ -680,6 +691,7 @@ static void aspeed_machine_ast2600_evb_class_init(ObjectClass *oc, void *data)
     amc->fmc_model = "w25q512jv";
     amc->spi_model = "mx66u51235f";
     amc->num_cs    = 1;
+    amc->macs_mask  = ASPEED_MAC1_ON | ASPEED_MAC2_ON | ASPEED_MAC3_ON;
     amc->i2c_init  = ast2600_evb_i2c_init;
     mc->default_ram_size = 1 * GiB;
     mc->default_cpus = mc->min_cpus = mc->max_cpus =
@@ -698,6 +710,7 @@ static void aspeed_machine_tacoma_class_init(ObjectClass *oc, void *data)
     amc->fmc_model = "mx66l1g45g";
     amc->spi_model = "mx66l1g45g";
     amc->num_cs    = 2;
+    amc->macs_mask  = ASPEED_MAC2_ON;
     amc->i2c_init  = witherspoon_bmc_i2c_init; /* Same board layout */
     mc->default_ram_size = 1 * GiB;
     mc->default_cpus = mc->min_cpus = mc->max_cpus =
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index c6821b3322..b912d19f80 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -461,8 +461,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     }
 
     /* Net */
-    for (i = 0; i < nb_nics && i < sc->macs_num; i++) {
-        qdev_set_nic_properties(DEVICE(&s->ftgmac100[i]), &nd_table[i]);
+    for (i = 0; i < sc->macs_num; i++) {
         object_property_set_bool(OBJECT(&s->ftgmac100[i]), true, "aspeed",
                                  &err);
         object_property_set_bool(OBJECT(&s->ftgmac100[i]), true, "realized",
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index e6f4b59134..3ec1257c14 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -404,8 +404,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
     }
 
     /* Net */
-    for (i = 0; i < nb_nics && i < sc->macs_num; i++) {
-        qdev_set_nic_properties(DEVICE(&s->ftgmac100[i]), &nd_table[i]);
+    for (i = 0; i < sc->macs_num; i++) {
         object_property_set_bool(OBJECT(&s->ftgmac100[i]), true, "aspeed",
                                  &err);
         object_property_set_bool(OBJECT(&s->ftgmac100[i]), true, "realized",
-- 
2.21.3


