Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99006C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:24:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6460220772
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XMnxCyzv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6460220772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtIUZ-0007ij-Ip
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:24:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41186)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jtI20-0000A9-K8
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:55:08 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54372
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jtI1x-0005UM-Fh
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:55:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594245304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rcafPjRvEVBYTvh/1XUotPpX1jNArExjkeQuEBRmt4o=;
 b=XMnxCyzvxTph8Q4Y9JJcS0T2CTqP1g8g2+fLca+HXhRgB4TWLaffGll19EyBuGQRHGwTzs
 /s8rWiNfavHvtRwYlGkObU6K2b6DbiRhf/vJdxyz2JwMjVagdD85Iro6i1kjWz5vJv34Mc
 S78eiZtyZNUWCV8Ng8qaU26ptES3g+k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-OslK0BGwOZyh-rqU5eTu1g-1; Tue, 07 Jul 2020 17:49:19 -0400
X-MC-Unique: OslK0BGwOZyh-rqU5eTu1g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3210D107ACCA;
 Tue,  7 Jul 2020 21:49:18 +0000 (UTC)
Received: from localhost (ovpn-116-140.rdu2.redhat.com [10.10.116.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B61345D9F3;
 Tue,  7 Jul 2020 21:49:17 +0000 (UTC)
Date: Tue, 7 Jul 2020 17:49:17 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH] cpu: Add starts_halted() method
Message-ID: <20200707214917.GX7276@habkost.net>
References: <20200707204333.261506-1-bauerman@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20200707204333.261506-1-bauerman@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 07, 2020 at 05:43:33PM -0300, Thiago Jung Bauermann wrote:
> PowerPC sPAPRs CPUs start in the halted state, but generic QEMU code
> assumes that CPUs start in the non-halted state. spapr_reset_vcpu()
> attempts to rectify this by setting CPUState::halted to 1. But that's too
> late for hotplugged CPUs in a machine configured with 2 or mor threads per
> core.
> 
> By then, other parts of QEMU have already caused the vCPU to run in an
> unitialized state a couple of times. For example, ppc_cpu_reset() calls
> ppc_tlb_invalidate_all(), which ends up calling async_run_on_cpu(). This
> kicks the new vCPU while it has CPUState::halted = 0, causing QEMU to issue
> a KVM_RUN ioctl on the new vCPU before the guest is able to make the
> start-cpu RTAS call to initialize its register state.
> 
> This doesn't seem to cause visible issues for regular guests, but on a
> secure guest running under the Ultravisor it does. The Ultravisor relies on
> being able to snoop on the start-cpu RTAS call to map vCPUs to guests, and
> this issue causes it to see a stray vCPU that doesn't belong to any guest.
> 
> Fix by adding a starts_halted() method to the CPUState class, and making it
> return 1 if the machine is an sPAPR guest.
> 
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
[...]
> +static uint32_t ppc_cpu_starts_halted(void)
> +{
> +    SpaprMachineState *spapr =
> +        (SpaprMachineState *) object_dynamic_cast(qdev_get_machine(),
> +                                                  TYPE_SPAPR_MACHINE);

Wouldn't it be simpler to just implement this as a MachineClass
boolean field?  e.g.:

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 426ce5f625..ffadc7a17d 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -215,6 +215,7 @@ struct MachineClass {
     bool nvdimm_supported;
     bool numa_mem_supported;
     bool auto_enable_numa;
+    bool cpu_starts_halted;
     const char *default_ram_id;
 
     HotplugHandler *(*get_hotplug_handler)(MachineState *machine,
diff --git a/hw/core/cpu.c b/hw/core/cpu.c
index 0f23409f1d..08dd504034 100644
--- a/hw/core/cpu.c
+++ b/hw/core/cpu.c
@@ -252,6 +252,7 @@ static void cpu_common_reset(DeviceState *dev)
 {
     CPUState *cpu = CPU(dev);
     CPUClass *cc = CPU_GET_CLASS(cpu);
+    MachineState *machine = object_dynamic_cast(qdev_get_machine(), TYPE_MACHINE);
 
     if (qemu_loglevel_mask(CPU_LOG_RESET)) {
         qemu_log("CPU Reset (CPU %d)\n", cpu->cpu_index);
@@ -259,7 +260,7 @@ static void cpu_common_reset(DeviceState *dev)
     }
 
     cpu->interrupt_request = 0;
-    cpu->halted = 0;
+    cpu->halted = machine ? MACHINE_GET_CLASS(machine)->cpu_starts_halted : 0;
     cpu->mem_io_pc = 0;
     cpu->icount_extra = 0;
     atomic_set(&cpu->icount_decr_ptr->u32, 0);
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index f6f034d039..d16ec33033 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4487,6 +4487,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power9_v2.0");
     mc->has_hotpluggable_cpus = true;
     mc->nvdimm_supported = true;
+    mc->cpu_starts_halted = true;
     smc->resize_hpt_default = SPAPR_RESIZE_HPT_ENABLED;
     fwc->get_dev_path = spapr_get_fw_dev_path;
     nc->nmi_monitor_handler = spapr_nmi;

> +
> +    /*
> +     * In sPAPR, all CPUs start halted. CPU0 is unhalted from the machine level
> +     * reset code and the rest are explicitly started up by the guest using an
> +     * RTAS call.
> +     */
> +    return spapr != NULL;
> +}
> +

-- 
Eduardo


