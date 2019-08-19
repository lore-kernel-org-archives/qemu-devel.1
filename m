Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7495AC3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 20:19:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F15F206C1
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 20:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ueKnuAux"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F15F206C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzo7n-0001CX-1F
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 16:19:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45554)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tcminyard@gmail.com>) id 1hzo5r-0007jI-KR
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 16:17:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tcminyard@gmail.com>) id 1hzo5k-0003Nk-Ie
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 16:17:31 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:40348)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1hzo5k-0003NU-Dr
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 16:17:24 -0400
Received: by mail-ot1-x344.google.com with SMTP id c34so2881901otb.7
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 13:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=pj7Gc7TY1hWb2Vay0SQtf3pTVgcm4YVS5TFdWn8LG1s=;
 b=ueKnuAux1SnpHP45LvnmPwXZJ7sTdIpIAQCjskY9wxaLvSzy4IT8CLaACnhE2KwsUq
 ebeRg+1y76Zas4E/NzPcfhAvsbrVIOad/UtgaL+xCwo8LGDfC+9jv7NS3C6n8GEdIsWw
 mAgIt/d6gHGHjSeny7BENfMBxNCnaKj5KvWSG5IkAwY3KmwRxoOqV1tLse1H6gIlwTGZ
 lX1wvIi+VhrVmMfrAUs9nAdW/TdaTI6hu/r93fO7AW191TTKazz9sAC4R4pZbYppCuuD
 mdvsgcLIHSrRXEYOL2R/q/R7tW8VHJNq5fKuIWdqvz6s3j4jozSZwvKedK+ddQ9SO5uC
 xFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=pj7Gc7TY1hWb2Vay0SQtf3pTVgcm4YVS5TFdWn8LG1s=;
 b=Uo5ezftJOUz1kxCG9YC0uXLa00fmEdTQGTS6v8DqQ0kBUUUA5R8IK+AG/QysucsQO6
 982vPmzXwnk8ZJ4LS2RGshWyfdxG9QPrViNEklpBG2P0os/Q63M29FCda/Dt20ry//z6
 M7YKqhrv325WcKT+HwolkUyN5uW28+16oZRaGqAYwzdQwTEIs7Ln7zvJxXHrDup5a0KO
 9tknuRKpOambk1zQCPs0RfPaaYFqNGynCtwjfZDMWIaIpzuYSgDJXeXrSCBdNDnMdHJU
 9AwALrUQueL/O+BkvLNDGnPQnbOOGdiufBJ6q2VOYwJYqnCLtSf0Xm2sS6E+JBNW7O6X
 cPUA==
X-Gm-Message-State: APjAAAX75EOKPvm3tEgSPVgYdPfcFeEZ44UeFmbGHUfY7eXdo7t8RPuq
 YE4kQvZw9pFGsDj9IPOu44DEOr0=
X-Google-Smtp-Source: APXvYqyhVRn2PuTAKa8g4vHQ+dglE5w3nQ4JX/bh1tKNir4FQ1EFcH+ACaLCd524/K0YGR8WJ63LwQ==
X-Received: by 2002:a05:6830:1411:: with SMTP id
 v17mr19202604otp.108.1566245843629; 
 Mon, 19 Aug 2019 13:17:23 -0700 (PDT)
Received: from serve.minyard.net ([47.184.134.43])
 by smtp.gmail.com with ESMTPSA id v5sm5805897otk.64.2019.08.19.13.17.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 13:17:22 -0700 (PDT)
Received: from t430.minyard.net (t430m.minyard.net [192.168.27.3])
 by serve.minyard.net (Postfix) with ESMTPA id 770CE1800D4;
 Mon, 19 Aug 2019 20:17:19 +0000 (UTC)
Received: by t430.minyard.net (Postfix, from userid 1000)
 id 51EE1301220; Mon, 19 Aug 2019 15:17:18 -0500 (CDT)
From: minyard@acm.org
To: QEMU Developers <qemu-devel@nongnu.org>
Date: Mon, 19 Aug 2019 15:17:04 -0500
Message-Id: <20190819201705.31633-15-minyard@acm.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819201705.31633-1-minyard@acm.org>
References: <20190819201705.31633-1-minyard@acm.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: [Qemu-devel] [PATCH 14/15] ipmi: Fix SSIF ACPI handling to use the
 right CRS
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
Cc: Corey Minyard <cminyard@mvista.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Corey Minyard <cminyard@mvista.com>

Pass in the CRS so that it can be set to the SMBus for IPMI later.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 hw/acpi/ipmi-stub.c    |  2 +-
 hw/acpi/ipmi.c         | 13 +++++++------
 hw/i386/acpi-build.c   |  2 +-
 include/hw/acpi/ipmi.h |  2 +-
 4 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/hw/acpi/ipmi-stub.c b/hw/acpi/ipmi-stub.c
index f525f71c2d..8634fb325c 100644
--- a/hw/acpi/ipmi-stub.c
+++ b/hw/acpi/ipmi-stub.c
@@ -10,6 +10,6 @@
 #include "qemu/osdep.h"
 #include "hw/acpi/ipmi.h"
 
-void build_acpi_ipmi_devices(Aml *table, BusState *bus)
+void build_acpi_ipmi_devices(Aml *table, BusState *bus, const char *resource)
 {
 }
diff --git a/hw/acpi/ipmi.c b/hw/acpi/ipmi.c
index 651e2e94ea..96e48eba15 100644
--- a/hw/acpi/ipmi.c
+++ b/hw/acpi/ipmi.c
@@ -13,7 +13,7 @@
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/ipmi.h"
 
-static Aml *aml_ipmi_crs(IPMIFwInfo *info)
+static Aml *aml_ipmi_crs(IPMIFwInfo *info, const char *resource)
 {
     Aml *crs = aml_resource_template();
 
@@ -48,7 +48,8 @@ static Aml *aml_ipmi_crs(IPMIFwInfo *info)
                             info->register_spacing, info->register_length));
         break;
     case IPMI_MEMSPACE_SMBUS:
-        aml_append(crs, aml_return(aml_int(info->base_address)));
+        aml_append(crs, aml_i2c_serial_bus_device(info->base_address,
+                                                  resource));
         break;
     default:
         abort();
@@ -61,7 +62,7 @@ static Aml *aml_ipmi_crs(IPMIFwInfo *info)
     return crs;
 }
 
-static Aml *aml_ipmi_device(IPMIFwInfo *info)
+static Aml *aml_ipmi_device(IPMIFwInfo *info, const char *resource)
 {
     Aml *dev;
     uint16_t version = ((info->ipmi_spec_major_revision << 8)
@@ -74,14 +75,14 @@ static Aml *aml_ipmi_device(IPMIFwInfo *info)
     aml_append(dev, aml_name_decl("_STR", aml_string("ipmi_%s",
                                                      info->interface_name)));
     aml_append(dev, aml_name_decl("_UID", aml_int(info->uuid)));
-    aml_append(dev, aml_name_decl("_CRS", aml_ipmi_crs(info)));
+    aml_append(dev, aml_name_decl("_CRS", aml_ipmi_crs(info, resource)));
     aml_append(dev, aml_name_decl("_IFT", aml_int(info->interface_type)));
     aml_append(dev, aml_name_decl("_SRV", aml_int(version)));
 
     return dev;
 }
 
-void build_acpi_ipmi_devices(Aml *scope, BusState *bus)
+void build_acpi_ipmi_devices(Aml *scope, BusState *bus, const char *resource)
 {
 
     BusChild *kid;
@@ -101,6 +102,6 @@ void build_acpi_ipmi_devices(Aml *scope, BusState *bus)
         iic = IPMI_INTERFACE_GET_CLASS(obj);
         memset(&info, 0, sizeof(info));
         iic->get_fwinfo(ii, &info);
-        aml_append(scope, aml_ipmi_device(&info));
+        aml_append(scope, aml_ipmi_device(&info, resource));
     }
 }
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 5b0ec1b89e..0c94e21a1a 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1290,7 +1290,7 @@ static void build_isa_devices_aml(Aml *table)
     } else if (!obj) {
         error_report("No ISA bus, unable to define IPMI ACPI data");
     } else {
-        build_acpi_ipmi_devices(scope, BUS(obj));
+        build_acpi_ipmi_devices(scope, BUS(obj), "\\_SB.PCI0.ISA");
     }
 
     aml_append(table, scope);
diff --git a/include/hw/acpi/ipmi.h b/include/hw/acpi/ipmi.h
index c38483565c..c14ad682ac 100644
--- a/include/hw/acpi/ipmi.h
+++ b/include/hw/acpi/ipmi.h
@@ -16,6 +16,6 @@
  * bus matches the given bus.  The resource is the ACPI resource that
  * contains the IPMI device, this is required for the I2C CRS.
  */
-void build_acpi_ipmi_devices(Aml *table, BusState *bus);
+void build_acpi_ipmi_devices(Aml *table, BusState *bus, const char *resource);
 
 #endif /* HW_ACPI_IPMI_H */
-- 
2.17.1


