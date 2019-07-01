Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37843C5B578
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 00:22:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01DEB20652
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 00:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CuMfXgPL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01DEB20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi6Yi-0002or-GT
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 20:22:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35337)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <tcminyard@gmail.com>) id 1hi3ds-000560-WB
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:15:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tcminyard@gmail.com>) id 1hi3dn-0002Ai-IT
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:15:16 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:32770)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1hi3dn-0001q6-As
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:15:11 -0400
Received: by mail-ot1-f66.google.com with SMTP id q20so14962770otl.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 14:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Mz9dF6CfjXk0LN/K2yMNd+TDsCbwVvqlvyyMEh6FyjY=;
 b=CuMfXgPLIQxe5LbD9NopP9IMfzlWQHNUwWCF8lqXABbVS8OCOB65WxodTmu0DDeuuG
 yRuvQ8trdoOCtwJ36ll67Q/NA8fk17bVmtZPZtb+dpozdD/KZu1Hz14KBq3BatcV8vn4
 wvra4BniHI5lbjSrAMoo4+iGei2vuwePKbqF13eSL9LVLLG/IkVYgvttqEdN7gq8ha1J
 8rw0rX+nGyPnReTRKv3gARhuS/q2gta0ASJgklx6A1Rc0fQdzHLtpLhb0m4pdMfmrwa0
 0Y1EnDa8EXcnVbJaqc63ZwUjZgMyxuwBcAahsYY8TNkwQhLrAz7aqF0D1Y/KbyuxNqI6
 dFZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Mz9dF6CfjXk0LN/K2yMNd+TDsCbwVvqlvyyMEh6FyjY=;
 b=hKHh+3mmQo/35I6wYq57LuYdO+8Biz4xIGQQYOsyOyFyKXHO1S2Mcgw+1edprs1LPl
 yLrE3s4Cvz90p+XwgiK6j2emcP75VaNdzOs2afxp92rdqSURi6aJbqnjwfJRVL9O41B0
 eua4XdM2B0Adm0os6CfgW77kJKsQhJCSEJYjW144xvVVzjs58lcIBUbPgm+m6ZW+x/Ms
 oyXvrg+Lr19PgSW8LSKmE+jrAAy+U0xOYq125njn41XZFNPcRnjy/wP8SdYgKh7sZ/xa
 /uwGD6ctJOISYzmG/GWUgThZ4RV2wu9e38Kj7xnyPeTYQJvyYFtJCMFil9YWJ5o2yNuG
 SXvw==
X-Gm-Message-State: APjAAAWRrimvQyJOJg8nNIP52gQQLT8gzioBUWXdmNiamm5bSOzRb2/9
 hOQ0qGORb5BXwot+Zan9A1GbqeE=
X-Google-Smtp-Source: APXvYqzA3YsccTz0nuz686jNu2Y0yWUIswAm7N/FzK5qrTA5YvwU/z3U/fazon0ln4G6iF1B/Jc6mw==
X-Received: by 2002:a9d:4546:: with SMTP id p6mr21625423oti.34.1562005869827; 
 Mon, 01 Jul 2019 11:31:09 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
 by smtp.gmail.com with ESMTPSA id c125sm4156119oif.17.2019.07.01.11.31.08
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 01 Jul 2019 11:31:08 -0700 (PDT)
Received: from t430.minyard.net (t430m.minyard.net [192.168.27.3])
 by serve.minyard.net (Postfix) with ESMTPA id 95E931805A6;
 Mon,  1 Jul 2019 18:31:07 +0000 (UTC)
Received: by t430.minyard.net (Postfix, from userid 1000)
 id 3C75D30042A; Mon,  1 Jul 2019 13:31:07 -0500 (CDT)
From: minyard@acm.org
To: QEMU Developers <qemu-devel@nongnu.org>
Date: Mon,  1 Jul 2019 13:31:00 -0500
Message-Id: <20190701183100.7849-3-minyard@acm.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190701183100.7849-1-minyard@acm.org>
References: <20190701183100.7849-1-minyard@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.66
Subject: [Qemu-devel] [PATCH v2 2/2] ipmi: Add a UUID device property
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
Cc: Corey Minyard <cminyard@mvista.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
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
index 1980536517..007e2c6588 100644
--- a/hw/ipmi/ipmi_bmc_sim.c
+++ b/hw/ipmi/ipmi_bmc_sim.c
@@ -221,7 +221,7 @@ struct IPMIBmcSim {
     uint8_t restart_cause;
 
     uint8_t acpi_power_state[2];
-    uint8_t uuid[16];
+    QemuUUID uuid;
 
     IPMISel sel;
     IPMISdr sdr;
@@ -937,8 +937,19 @@ static void get_device_guid(IPMIBmcSim *ibs,
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
 
@@ -1980,12 +1991,6 @@ static void ipmi_sim_realize(DeviceState *dev, Error **errp)
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
 
@@ -2005,6 +2010,7 @@ static Property ipmi_sim_properties[] = {
     DEFINE_PROP_UINT8("fwrev2", IPMIBmcSim, fwrev2, 0),
     DEFINE_PROP_UINT32("mfg_id", IPMIBmcSim, mfg_id, 0),
     DEFINE_PROP_UINT16("product_id", IPMIBmcSim, product_id, 0),
+    DEFINE_PROP_UUID_NODEFAULT("guid", IPMIBmcSim, uuid),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/qemu-options.hx b/qemu-options.hx
index 0d8beb4afd..ec56ab8f6f 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -700,7 +700,7 @@ possible drivers and properties, use @code{-device help} and
 @code{-device @var{driver},help}.
 
 Some drivers are:
-@item -device ipmi-bmc-sim,id=@var{id}[,slave_addr=@var{val}][,sdrfile=@var{file}][,furareasize=@var{val}][,furdatafile=@var{file}]
+@item -device ipmi-bmc-sim,id=@var{id}[,slave_addr=@var{val}][,sdrfile=@var{file}][,furareasize=@var{val}][,furdatafile=@var{file}][,guid=@var{uuid}]
 
 Add an IPMI BMC.  This is a simulation of a hardware management
 interface processor that normally sits on a system.  It provides
@@ -713,8 +713,8 @@ controllers.  If you don't know what this means, it is safe to ignore
 it.
 
 @table @option
-@item bmc=@var{id}
-The BMC to connect to, one of ipmi-bmc-sim or ipmi-bmc-extern above.
+@item id=@var{id}
+The BMC id for interfaces to use this device.
 @item slave_addr=@var{val}
 Define slave address to use for the BMC.  The default is 0x20.
 @item sdrfile=@var{file}
@@ -723,6 +723,10 @@ file containing raw Sensor Data Records (SDR) data. The default is none.
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


