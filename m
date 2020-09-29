Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D439BC4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:41:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67052206DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A6lC5bnx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67052206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNAG7-000578-Gq
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 03:41:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9xr-0003zY-Vm
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:22:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50078)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9xp-0001ju-EL
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:22:19 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601364136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PNUjx48dQuW4OxD6Zh0ZlG4gw5DtpRC3cn0oLI7dAj0=;
 b=A6lC5bnxix7jEwmTB7le4Y0IKG/6tikopBHU93XN+WV+zCSQUnkp4Ohbwsd8y7AhE+O3pb
 Ml99HvkLbXE6E90silZGomXm3tS5bD43lSTCbnFz72zEayzcxGzOqbPFc+YwcCRYoP9/ai
 ZkdKxkno13kobCZQrOJ/ajusWU1FcwU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-7qHvUNRUNZeSp_tjHDa_aQ-1; Tue, 29 Sep 2020 03:22:14 -0400
X-MC-Unique: 7qHvUNRUNZeSp_tjHDa_aQ-1
Received: by mail-wr1-f70.google.com with SMTP id a10so1335388wrw.22
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 00:22:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=PNUjx48dQuW4OxD6Zh0ZlG4gw5DtpRC3cn0oLI7dAj0=;
 b=satPuo61Xa/I7weL1aGbWkETpIfztw+I5bdMuBFbGhNl7PRY0MeL/MMLuLUDO3gbk4
 mC3bRfp1uyj6aRJy5A8rFG/HkIJYFxzq+f0aXABuF8tWCdOtSzyBRsKFOo6pQ+isYNbv
 c3Qu5oACXrZ+u1R0sPa2yRjQUpEHONHVxvAvHh66wOFCy9BNcxzd4BeQeLHDiA+OhZ4U
 43S5x/dfQW1X/LN4GDhCnl8PwBP/P5BOgr5ieAXUnZcn+PuuwddcaNnmmFd5VicgVrNg
 xGMxYa6AmBY4KxKttnCSIVHh1tC+SWRVrSi9mxqy04M/2WT9bhw3qfJxI3w43WwqXBAR
 gLjg==
X-Gm-Message-State: AOAM532YkA7ktd93RQPyw2ymdLr/vOLDmRi7Nx8AfFcpZ89TkTPCGpoR
 3kLvFmVZkyAvoiJxZ5RNppX3nm06fJYwllgWsroHHbBACv51S+74WNrWNSuMfgNzteSa+heVcXi
 LecSnDVDfRq90a4I=
X-Received: by 2002:a5d:660d:: with SMTP id n13mr2617565wru.308.1601364132926; 
 Tue, 29 Sep 2020 00:22:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxND/GfQO2BgHqeNLK2O2TyZLUGx/aId8llODT/6Hszc29jy0l0d7dz9F+S/34toiU5/u8tWA==
X-Received: by 2002:a5d:660d:: with SMTP id n13mr2617534wru.308.1601364132647; 
 Tue, 29 Sep 2020 00:22:12 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id q20sm4168663wmj.5.2020.09.29.00.22.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 00:22:12 -0700 (PDT)
Date: Tue, 29 Sep 2020 03:22:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v4 29/48] x68: acpi: trigger SMI before sending hotplug Notify
 event to OSPM
Message-ID: <20200929071948.281157-30-mst@redhat.com>
References: <20200929071948.281157-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200929071948.281157-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 22:47:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek <lersek@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Mammedov <imammedo@redhat.com>

In case firmware has negotiated CPU hotplug SMI feature, generate
AML to describe SMI IO port region and send SMI to firmware
on each CPU hotplug SCI in case new CPUs were hotplugged.

Since new CPUs can be hotplugged while CPU_SCAN_METHOD is running
we can't send SMI before new CPUs are fetched from QEMU as it
could cause sending Notify to a CPU that firmware hasn't seen yet.
So fetch new CPUs into local cache first, then send SMI and
after that send Notify events to cached CPUs. This should ensure
that Notify is sent only to CPUs which were processed by firmware
first.
Any CPUs that were hotplugged after caching will be processed
by the next CPU_SCAN_METHOD, when pending SCI is handled.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Tested-by: Laszlo Ersek <lersek@redhat.com>
Message-Id: <20200923094650.1301166-10-imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/acpi/cpu.c | 165 +++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 138 insertions(+), 27 deletions(-)

diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
index 3d6a500fb7..8dd4d8ebbf 100644
--- a/hw/acpi/cpu.c
+++ b/hw/acpi/cpu.c
@@ -14,6 +14,8 @@
 #define ACPI_CPU_CMD_DATA_OFFSET_RW 8
 #define ACPI_CPU_CMD_DATA2_OFFSET_R 0
 
+#define OVMF_CPUHP_SMI_CMD 4
+
 enum {
     CPHP_GET_NEXT_CPU_WITH_EVENT_CMD = 0,
     CPHP_OST_EVENT_CMD = 1,
@@ -321,6 +323,7 @@ const VMStateDescription vmstate_cpu_hotplug = {
 #define CPU_NOTIFY_METHOD "CTFY"
 #define CPU_EJECT_METHOD  "CEJ0"
 #define CPU_OST_METHOD    "COST"
+#define CPU_ADDED_LIST    "CNEW"
 
 #define CPU_ENABLED       "CPEN"
 #define CPU_SELECTOR      "CSEL"
@@ -465,42 +468,150 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
 
         method = aml_method(CPU_SCAN_METHOD, 0, AML_SERIALIZED);
         {
+            const uint8_t max_cpus_per_pass = 255;
             Aml *else_ctx;
-            Aml *while_ctx;
+            Aml *while_ctx, *while_ctx2;
             Aml *has_event = aml_local(0);
             Aml *dev_chk = aml_int(1);
             Aml *eject_req = aml_int(3);
             Aml *next_cpu_cmd = aml_int(CPHP_GET_NEXT_CPU_WITH_EVENT_CMD);
+            Aml *num_added_cpus = aml_local(1);
+            Aml *cpu_idx = aml_local(2);
+            Aml *uid = aml_local(3);
+            Aml *has_job = aml_local(4);
+            Aml *new_cpus = aml_name(CPU_ADDED_LIST);
 
             aml_append(method, aml_acquire(ctrl_lock, 0xFFFF));
-            aml_append(method, aml_store(one, has_event));
-            while_ctx = aml_while(aml_equal(has_event, one));
+
+            /*
+             * Windows versions newer than XP (including Windows 10/Windows
+             * Server 2019), do support* VarPackageOp but, it is cripled to hold
+             * the same elements number as old PackageOp.
+             * For compatibility with Windows XP (so it won't crash) use ACPI1.0
+             * PackageOp which can hold max 255 elements.
+             *
+             * use named package as old Windows don't support it in local var
+             */
+            aml_append(method, aml_name_decl(CPU_ADDED_LIST,
+                                             aml_package(max_cpus_per_pass)));
+
+            aml_append(method, aml_store(zero, uid));
+            aml_append(method, aml_store(one, has_job));
+            /*
+             * CPU_ADDED_LIST can hold limited number of elements, outer loop
+             * allows to process CPUs in batches which let us to handle more
+             * CPUs than CPU_ADDED_LIST can hold.
+             */
+            while_ctx2 = aml_while(aml_equal(has_job, one));
             {
-                 /* clear loop exit condition, ins_evt/rm_evt checks
-                  * will set it to 1 while next_cpu_cmd returns a CPU
-                  * with events */
-                 aml_append(while_ctx, aml_store(zero, has_event));
-                 aml_append(while_ctx, aml_store(next_cpu_cmd, cpu_cmd));
-                 ifctx = aml_if(aml_equal(ins_evt, one));
-                 {
-                     aml_append(ifctx,
-                         aml_call2(CPU_NOTIFY_METHOD, cpu_data, dev_chk));
-                     aml_append(ifctx, aml_store(one, ins_evt));
-                     aml_append(ifctx, aml_store(one, has_event));
-                 }
-                 aml_append(while_ctx, ifctx);
-                 else_ctx = aml_else();
-                 ifctx = aml_if(aml_equal(rm_evt, one));
-                 {
-                     aml_append(ifctx,
-                         aml_call2(CPU_NOTIFY_METHOD, cpu_data, eject_req));
-                     aml_append(ifctx, aml_store(one, rm_evt));
-                     aml_append(ifctx, aml_store(one, has_event));
-                 }
-                 aml_append(else_ctx, ifctx);
-                 aml_append(while_ctx, else_ctx);
+                aml_append(while_ctx2, aml_store(zero, has_job));
+
+                aml_append(while_ctx2, aml_store(one, has_event));
+                aml_append(while_ctx2, aml_store(zero, num_added_cpus));
+
+                /*
+                 * Scan CPUs, till there are CPUs with events or
+                 * CPU_ADDED_LIST capacity is exhausted
+                 */
+                while_ctx = aml_while(aml_land(aml_equal(has_event, one),
+                                      aml_lless(uid, aml_int(arch_ids->len))));
+                {
+                     /*
+                      * clear loop exit condition, ins_evt/rm_evt checks will
+                      * set it to 1 while next_cpu_cmd returns a CPU with events
+                      */
+                     aml_append(while_ctx, aml_store(zero, has_event));
+
+                     aml_append(while_ctx, aml_store(uid, cpu_selector));
+                     aml_append(while_ctx, aml_store(next_cpu_cmd, cpu_cmd));
+
+                     /*
+                      * wrap around case, scan is complete, exit loop.
+                      * It happens since events are not cleared in scan loop,
+                      * so next_cpu_cmd continues to find already processed CPUs
+                      */
+                     ifctx = aml_if(aml_lless(cpu_data, uid));
+                     {
+                         aml_append(ifctx, aml_break());
+                     }
+                     aml_append(while_ctx, ifctx);
+
+                     /*
+                      * if CPU_ADDED_LIST is full, exit inner loop and process
+                      * collected CPUs
+                      */
+                     ifctx = aml_if(
+                         aml_equal(num_added_cpus, aml_int(max_cpus_per_pass)));
+                     {
+                         aml_append(ifctx, aml_store(one, has_job));
+                         aml_append(ifctx, aml_break());
+                     }
+                     aml_append(while_ctx, ifctx);
+
+                     aml_append(while_ctx, aml_store(cpu_data, uid));
+                     ifctx = aml_if(aml_equal(ins_evt, one));
+                     {
+                         /* cache added CPUs to Notify/Wakeup later */
+                         aml_append(ifctx, aml_store(uid,
+                             aml_index(new_cpus, num_added_cpus)));
+                         aml_append(ifctx, aml_increment(num_added_cpus));
+                         aml_append(ifctx, aml_store(one, has_event));
+                     }
+                     aml_append(while_ctx, ifctx);
+                     else_ctx = aml_else();
+                     ifctx = aml_if(aml_equal(rm_evt, one));
+                     {
+                         aml_append(ifctx,
+                             aml_call2(CPU_NOTIFY_METHOD, uid, eject_req));
+                         aml_append(ifctx, aml_store(one, rm_evt));
+                         aml_append(ifctx, aml_store(one, has_event));
+                     }
+                     aml_append(else_ctx, ifctx);
+                     aml_append(while_ctx, else_ctx);
+                     aml_append(while_ctx, aml_increment(uid));
+                }
+                aml_append(while_ctx2, while_ctx);
+
+                /*
+                 * in case FW negotiated ICH9_LPC_SMI_F_CPU_HOTPLUG_BIT,
+                 * make upcall to FW, so it can pull in new CPUs before
+                 * OS is notified and wakes them up
+                 */
+                if (opts.smi_path) {
+                    ifctx = aml_if(aml_lgreater(num_added_cpus, zero));
+                    {
+                        aml_append(ifctx, aml_store(aml_int(OVMF_CPUHP_SMI_CMD),
+                            aml_name("%s", opts.smi_path)));
+                    }
+                    aml_append(while_ctx2, ifctx);
+                }
+
+                /* Notify OSPM about new CPUs and clear insert events */
+                aml_append(while_ctx2, aml_store(zero, cpu_idx));
+                while_ctx = aml_while(aml_lless(cpu_idx, num_added_cpus));
+                {
+                    aml_append(while_ctx,
+                        aml_store(aml_derefof(aml_index(new_cpus, cpu_idx)),
+                                  uid));
+                    aml_append(while_ctx,
+                        aml_call2(CPU_NOTIFY_METHOD, uid, dev_chk));
+                    aml_append(while_ctx, aml_store(uid, aml_debug()));
+                    aml_append(while_ctx, aml_store(uid, cpu_selector));
+                    aml_append(while_ctx, aml_store(one, ins_evt));
+                    aml_append(while_ctx, aml_increment(cpu_idx));
+                }
+                aml_append(while_ctx2, while_ctx);
+                /*
+                 * If another batch is needed, then it will resume scanning
+                 * exactly at -- and not after -- the last CPU that's currently
+                 * in CPU_ADDED_LIST. In other words, the last CPU in
+                 * CPU_ADDED_LIST is going to be re-checked. That's OK: we've
+                 * just cleared the insert event for *all* CPUs in
+                 * CPU_ADDED_LIST, including the last one. So the scan will
+                 * simply seek past it.
+                 */
             }
-            aml_append(method, while_ctx);
+            aml_append(method, while_ctx2);
             aml_append(method, aml_release(ctrl_lock));
         }
         aml_append(cpus_dev, method);
-- 
MST


