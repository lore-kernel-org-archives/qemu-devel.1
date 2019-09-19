Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F9EEC3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 21:53:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEA3E208C0
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 21:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MODA8HxX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEA3E208C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB4MS-0006iE-Ep
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 17:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56279)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tcminyard@gmail.com>) id 1iB49b-0001Xl-5v
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:40:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tcminyard@gmail.com>) id 1iB49Q-0006BE-Mw
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:39:51 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:39887)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1iB49Q-0006AJ-5s
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:39:44 -0400
Received: by mail-ot1-x341.google.com with SMTP id s22so4450325otr.6
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 14:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1Pjbx+Wnn2Hez+/RZX8qjdxBLtlG9/L1XOZzyZuYu4E=;
 b=MODA8HxXoAYEdS4G0BA48XGwsbtCnWYQVWR43SedkHgX/TRCQ92Hf6ZUyT7la6IQFn
 dZHdLVF5cBp1IbVFScdVamBB+B9oyuhovd2pHDYNY6pS8niXCWW1uKrrlzNyMT1vlooA
 qj6UOIjipB3FbhE3N1VpxOIUDPD8S3iGHZ9ToPRZRU5hbzbMnF5Tm703SS0uDKTIVMl4
 G24VwjvZ1D9IkWt7+Cgh/6QW1kdm711cLb/8ZnT9mWLudh2VMs1hDylGd1sN6jKOQOU6
 KL6KjL897xls0xwFwNC7lCWJWZ9esvBtBblML4+9h/jdVWUeQ5CAvLUs4N5vufZpdeOC
 Mlsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=1Pjbx+Wnn2Hez+/RZX8qjdxBLtlG9/L1XOZzyZuYu4E=;
 b=MmQSXf+/9Yvsl6356idZLpASoBE4uO1X5zUiwSHHCi0yO9OR46mJRPV7yDPXCrEBPy
 mkCTIxBEy36E2xoWo+ey0ssRlDHUHbhwSqvi6rQAGxaCcvdKEV+sgOT2/NCXyFnch+Od
 jnRLQsUnwdcyW5RF303XKeK3K20eoxsZVK9oUea6t6e1d5cC4tyMyjbiHP+4LDXAtqHL
 AvO9TawynPK/ZizAumWB2pxTyCVDiXkR7Yb456MTNoYWNpOtVfkpuOINjlYY9TcXtuUR
 h/ZWA9aEMU9samqd/MATHL+fmIZlAd2V4kXfZ39oHUGPdTp7TFnZSMubd6CBpXo9U4op
 VSkw==
X-Gm-Message-State: APjAAAUoFbXvLNEhXyOpzEAKYcmDRe5WnYGxVuR4O8Ligs/G29exWcxA
 /EHjZoSM6uiqpponQtPErQ==
X-Google-Smtp-Source: APXvYqy2nMQwTTCAwQR7z41kN7M6OtBeDHlstB/6r5GnC89fgbOiY/G1VwwyHjIC3RRqTq+GuXgt8A==
X-Received: by 2002:a9d:2901:: with SMTP id d1mr8948253otb.285.1568929183379; 
 Thu, 19 Sep 2019 14:39:43 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
 by smtp.gmail.com with ESMTPSA id b4sm33766oiy.30.2019.09.19.14.39.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2019 14:39:40 -0700 (PDT)
Received: from t560.minyard.net (unknown [192.168.27.180])
 by serve.minyard.net (Postfix) with ESMTPA id 5C61B18059F;
 Thu, 19 Sep 2019 21:39:36 +0000 (UTC)
From: minyard@acm.org
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 06/15] ipmi: Add a UUID device property
Date: Thu, 19 Sep 2019 16:39:15 -0500
Message-Id: <20190919213924.31852-7-minyard@acm.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190919213924.31852-1-minyard@acm.org>
References: <20190919213924.31852-1-minyard@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: Corey Minyard <cminyard@mvista.com>, Fam Zheng <famz@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Corey Minyard <cminyard@mvista.com>

Using the UUID that qemu generates probably isn't the best thing
to do, allow it to be passed in via properties, and use QemuUUID
for the type.

If the UUID is not set, return an unsupported command error.  This
way we are not providing an all-zero (or randomly generated) GUID
to the IPMI user.  This lets the host fall back to the other
method of using the get device id command to determind the BMC
being accessed.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Cc: Cédric Le Goater <clg@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/ipmi/ipmi_bmc_sim.c | 22 ++++++++++++++--------
 qemu-options.hx        | 10 +++++++---
 2 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
index 6e6cd1b47d..71e56f3b13 100644
--- a/hw/ipmi/ipmi_bmc_sim.c
+++ b/hw/ipmi/ipmi_bmc_sim.c
@@ -223,7 +223,7 @@ struct IPMIBmcSim {
     uint8_t restart_cause;
 
     uint8_t acpi_power_state[2];
-    uint8_t uuid[16];
+    QemuUUID uuid;
 
     IPMISel sel;
     IPMISdr sdr;
@@ -941,8 +941,19 @@ static void get_device_guid(IPMIBmcSim *ibs,
 {
     unsigned int i;
 
+    /* An uninitialized uuid is all zeros, use that to know if it is set. */
     for (i = 0; i < 16; i++) {
-        rsp_buffer_push(rsp, ibs->uuid[i]);
+        if (ibs->uuid.data[i]) {
+            goto uuid_set;
+        }
+    }
+    /* No uuid is set, return an error. */
+    rsp_buffer_set_error(rsp, IPMI_CC_INVALID_CMD);
+    return;
+
+ uuid_set:
+    for (i = 0; i < 16; i++) {
+        rsp_buffer_push(rsp, ibs->uuid.data[i]);
     }
 }
 
@@ -1986,12 +1997,6 @@ static void ipmi_sim_realize(DeviceState *dev, Error **errp)
     ibs->acpi_power_state[0] = 0;
     ibs->acpi_power_state[1] = 0;
 
-    if (qemu_uuid_set) {
-        memcpy(&ibs->uuid, &qemu_uuid, 16);
-    } else {
-        memset(&ibs->uuid, 0, 16);
-    }
-
     ipmi_init_sensors_from_sdrs(ibs);
     register_cmds(ibs);
 
@@ -2011,6 +2016,7 @@ static Property ipmi_sim_properties[] = {
     DEFINE_PROP_UINT8("fwrev2", IPMIBmcSim, fwrev2, 0),
     DEFINE_PROP_UINT32("mfg_id", IPMIBmcSim, mfg_id, 0),
     DEFINE_PROP_UINT16("product_id", IPMIBmcSim, product_id, 0),
+    DEFINE_PROP_UUID_NODEFAULT("guid", IPMIBmcSim, uuid),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/qemu-options.hx b/qemu-options.hx
index bbfd936d29..ed9292f65e 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -701,7 +701,7 @@ possible drivers and properties, use @code{-device help} and
 @code{-device @var{driver},help}.
 
 Some drivers are:
-@item -device ipmi-bmc-sim,id=@var{id}[,slave_addr=@var{val}][,sdrfile=@var{file}][,furareasize=@var{val}][,furdatafile=@var{file}]
+@item -device ipmi-bmc-sim,id=@var{id}[,slave_addr=@var{val}][,sdrfile=@var{file}][,furareasize=@var{val}][,furdatafile=@var{file}][,guid=@var{uuid}]
 
 Add an IPMI BMC.  This is a simulation of a hardware management
 interface processor that normally sits on a system.  It provides
@@ -714,8 +714,8 @@ controllers.  If you don't know what this means, it is safe to ignore
 it.
 
 @table @option
-@item bmc=@var{id}
-The BMC to connect to, one of ipmi-bmc-sim or ipmi-bmc-extern above.
+@item id=@var{id}
+The BMC id for interfaces to use this device.
 @item slave_addr=@var{val}
 Define slave address to use for the BMC.  The default is 0x20.
 @item sdrfile=@var{file}
@@ -724,6 +724,10 @@ file containing raw Sensor Data Records (SDR) data. The default is none.
 size of a Field Replaceable Unit (FRU) area.  The default is 1024.
 @item frudatafile=@var{file}
 file containing raw Field Replaceable Unit (FRU) inventory data. The default is none.
+@item guid=@var{uuid}
+value for the GUID for the BMC, in standard UUID format.  If this is set,
+get "Get GUID" command to the BMC will return it.  Otherwise "Get GUID"
+will return an error.
 @end table
 
 @item -device ipmi-bmc-extern,id=@var{id},chardev=@var{id}[,slave_addr=@var{val}]
-- 
2.17.1


