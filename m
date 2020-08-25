Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92365C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 17:26:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5308720706
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 17:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SBunxStY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5308720706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAciY-0004f0-Lb
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 13:26:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38036)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kAcht-0003wv-D0
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 13:26:01 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50948
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kAchp-0007jJ-MV
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 13:26:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598376356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B5C9YChF378GKfpbd5a5TN4+KJNXKGUJxO9SMtxlpGo=;
 b=SBunxStYdI00B4Qn/Hy3Y7zMT6fiGC/bbgi10p5rJrPCnnJqUA6Xw6VduOJteDcmsOmMJ9
 65pZRV8kRFRoMBwyznDcFh1qcTmKW141fh3O+wTkLoPtAesHRJSTZgBshLOncncc6hxcns
 Rqj5GmAXbQXZefSGzsH7AqO01nA52Og=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-xnRc7A-2OWGB5eRXmhAnFA-1; Tue, 25 Aug 2020 13:25:51 -0400
X-MC-Unique: xnRc7A-2OWGB5eRXmhAnFA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B619E1DDFD;
 Tue, 25 Aug 2020 17:25:50 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-113-0.ams2.redhat.com
 [10.36.113.0])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2978F60E1C;
 Tue, 25 Aug 2020 17:25:48 +0000 (UTC)
Subject: Re: [PATCH v2 6/7] x68: acpi: trigger SMI before sending hotplug
 Notify event to OSPM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200818122208.1243901-1-imammedo@redhat.com>
 <20200818122208.1243901-7-imammedo@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <382e54cc-1ac0-61e5-bf5d-0653480222a0@redhat.com>
Date: Tue, 25 Aug 2020 19:25:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Firefox/52.0 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200818122208.1243901-7-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lersek@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.61; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 01:35:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.602, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: boris.ostrovsky@oracle.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 aaron.young@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/18/20 14:22, Igor Mammedov wrote:
> In case firmware has negotiated CPU hotplug SMI feature, generate
> AML to describe SMI IO port region and send SMI to firmware
> on each CPU hotplug SCI in case new CPUs were hotplugged.
>
> Since new CPUs can be hotplugged while CPU_SCAN_METHOD is running
> we can't send SMI before new CPUs are fetched from QEMU as it
> could cause sending Notify to a CPU that firmware hasn't seen yet.
> So fetch new CPUs into local cache first and then send SMI and
> after that sends Notify events to cached CPUs. This should ensure
> that Notify is sent only to CPUs which were processed by firmware
> first.
> Any CPUs that were hotplugged after caching will be processed
> by the next CPU_SCAN_METHOD, when pending SCI is handled.
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> v2:
>  - clear insert event after firmware has returned
>    control from SMI. (Laszlo Ersek <lersek@redhat.com>)
> v1:
>  - make sure that Notify is sent only to CPUs seen by FW
>  - (Laszlo Ersek <lersek@redhat.com>)
>     - use macro instead of x-smi-negotiated-features
>     - style fixes
>     - reserve whole SMI block (0xB2, 0xB3)
> v0:
>  - s/aml_string/aml_eisaid/
>    /fixes Windows BSOD, on nonsense value/ (Laszlo Ersek <lersek@redhat.com>)
>  - put SMI device under PCI0 like the rest of hotplug IO port
>  - do not generate SMI AML if CPU hotplug SMI feature hasn't been negotiated
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  include/hw/acpi/cpu.h  |  1 +
>  include/hw/i386/ich9.h |  2 ++
>  hw/acpi/cpu.c          | 80 +++++++++++++++++++++++++++++++++++++++---
>  hw/i386/acpi-build.c   | 35 +++++++++++++++++-
>  hw/isa/lpc_ich9.c      |  3 ++
>  5 files changed, 115 insertions(+), 6 deletions(-)

For easing review, this patch could be split in several patches, I
think. I'm not saying that's a "requirement", just that it would be
possible, and could help review.


* Patch "a":

[subject:]

  x86: ich9: expose "smi_negotiated_features" as a QOM property

[commit message:]

  Expose the "smi_negotiated_features" field of ICH9LPCState as a QOM
  property.

[code extracted from current patch follows]

> diff --git a/include/hw/i386/ich9.h b/include/hw/i386/ich9.h
> index d1bb3f7bf0..0f43ef2481 100644
> --- a/include/hw/i386/ich9.h
> +++ b/include/hw/i386/ich9.h
> @@ -245,6 +245,8 @@ typedef struct ICH9LPCState {
>  #define ICH9_SMB_HST_D1                         0x06
>  #define ICH9_SMB_HOST_BLOCK_DB                  0x07
>
> +#define ICH9_LPC_SMI_NEGOTIATED_FEAT_PROP "x-smi-negotiated-features"
> +
>  /* bit positions used in fw_cfg SMI feature negotiation */
>  #define ICH9_LPC_SMI_F_BROADCAST_BIT            0
>  #define ICH9_LPC_SMI_F_CPU_HOTPLUG_BIT          1
> diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
> index 19f32bed3e..8124d20338 100644
> --- a/hw/isa/lpc_ich9.c
> +++ b/hw/isa/lpc_ich9.c
> @@ -647,6 +647,9 @@ static void ich9_lpc_initfn(Object *obj)
>                                    &acpi_enable_cmd, OBJ_PROP_FLAG_READ);
>      object_property_add_uint8_ptr(OBJECT(lpc), ACPI_PM_PROP_ACPI_DISABLE_CMD,
>                                    &acpi_disable_cmd, OBJ_PROP_FLAG_READ);
> +    object_property_add_uint64_ptr(obj, ICH9_LPC_SMI_NEGOTIATED_FEAT_PROP,
> +                                   &lpc->smi_negotiated_features,
> +                                   OBJ_PROP_FLAG_READ);
>
>      ich9_pm_add_properties(obj, &lpc->pm);
>  }
>

For sub-patch "a":
Reviewed-by: Laszlo Ersek <lersek@redhat.com>


* Patch "b":

[subject:]

  x86: acpi: introduce "AcpiPmInfo.smi_on_cpuhp"

[commit message:]

  Translate the "CPU hotplug with SMI" feature bit, from the property
  added in the last patch, to a dedicated boolean in AcpiPmInfo.

[code extracted from current patch follows]

> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index b7bcbbbb2a..2291c050ba 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -95,6 +95,7 @@ typedef struct AcpiPmInfo {
>      bool s3_disabled;
>      bool s4_disabled;
>      bool pcihp_bridge_en;
> +    bool smi_on_cpuhp;
>      uint8_t s4_val;
>      AcpiFadtData fadt;
>      uint16_t cpu_hp_io_base;
> @@ -194,6 +195,7 @@ static void acpi_get_pm_info(MachineState *machine, AcpiPmInfo *pm)
>      pm->cpu_hp_io_base = 0;
>      pm->pcihp_io_base = 0;
>      pm->pcihp_io_len = 0;
> +    pm->smi_on_cpuhp = false;
>
>      assert(obj);
>      init_common_fadt_data(machine, obj, &pm->fadt);
> @@ -207,12 +209,16 @@ static void acpi_get_pm_info(MachineState *machine, AcpiPmInfo *pm)
>              object_property_get_uint(obj, ACPI_PCIHP_IO_LEN_PROP, NULL);
>      }
>      if (lpc) {
> +        uint64_t smi_features = object_property_get_uint(lpc,
> +            ICH9_LPC_SMI_NEGOTIATED_FEAT_PROP, NULL);
>          struct AcpiGenericAddress r = { .space_id = AML_AS_SYSTEM_IO,
>              .bit_width = 8, .address = ICH9_RST_CNT_IOPORT };
>          pm->fadt.reset_reg = r;
>          pm->fadt.reset_val = 0xf;
>          pm->fadt.flags |= 1 << ACPI_FADT_F_RESET_REG_SUP;
>          pm->cpu_hp_io_base = ICH9_CPU_HOTPLUG_IO_BASE;
> +        pm->smi_on_cpuhp =
> +            !!(smi_features & BIT_ULL(ICH9_LPC_SMI_F_CPU_HOTPLUG_BIT));
>      }
>
>      /* The above need not be conditional on machine type because the reset port

For sub-patch "b":
Reviewed-by: Laszlo Ersek <lersek@redhat.com>


* Patch "c":

[subject:]

  x86: acpi: introduce the "PCI0.SMI0" ACPI device

[commit message:]

  When CPU hotplug with SMI has been negotiated, describe the SMI
  register block in the DSDT. Pass the ACPI name of the SMI control
  register to build_cpus_aml(), so that CPU_SCAN_METHOD can access the
  register in the next patch.

[code extracted from current patch follows]

> diff --git a/include/hw/acpi/cpu.h b/include/hw/acpi/cpu.h
> index 62f0278ba2..0eeedaa491 100644
> --- a/include/hw/acpi/cpu.h
> +++ b/include/hw/acpi/cpu.h
> @@ -50,6 +50,7 @@ void cpu_hotplug_hw_init(MemoryRegion *as, Object *owner,
>  typedef struct CPUHotplugFeatures {
>      bool acpi_1_compatible;
>      bool has_legacy_cphp;
> +    const char *smi_path;
>  } CPUHotplugFeatures;
>
>  void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index b7bcbbbb2a..2291c050ba 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1515,6 +1521,32 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>          aml_append(dev, aml_name_decl("_UID", aml_int(1)));
>          aml_append(dev, build_q35_osc_method());
>          aml_append(sb_scope, dev);
> +
> +        if (pm->smi_on_cpuhp) {
> +            /* reserve SMI block resources, IO ports 0xB2, 0xB3 */
> +            dev = aml_device("PCI0.SMI0");
> +            aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A06")));
> +            aml_append(dev, aml_name_decl("_UID", aml_string("SMI resources")));
> +            crs = aml_resource_template();
> +            aml_append(crs,
> +                aml_io(
> +                       AML_DECODE16,
> +                       ACPI_PORT_SMI_CMD,
> +                       ACPI_PORT_SMI_CMD,
> +                       1,
> +                       2)
> +            );
> +            aml_append(dev, aml_name_decl("_CRS", crs));
> +            aml_append(dev, aml_operation_region("SMIR", AML_SYSTEM_IO,
> +                aml_int(ACPI_PORT_SMI_CMD), 2));
> +            field = aml_field("SMIR", AML_BYTE_ACC, AML_NOLOCK,
> +                              AML_WRITE_AS_ZEROS);
> +            aml_append(field, aml_named_field("SMIC", 8));
> +            aml_append(field, aml_reserved_field(8));
> +            aml_append(dev, field);
> +            aml_append(sb_scope, dev);
> +        }
> +
>          aml_append(dsdt, sb_scope);
>
>          build_hpet_aml(dsdt);
> @@ -1530,7 +1562,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>          build_legacy_cpu_hotplug_aml(dsdt, machine, pm->cpu_hp_io_base);
>      } else {
>          CPUHotplugFeatures opts = {
> -            .acpi_1_compatible = true, .has_legacy_cphp = true
> +            .acpi_1_compatible = true, .has_legacy_cphp = true,
> +            .smi_path = pm->smi_on_cpuhp ? "\\_SB.PCI0.SMI0.SMIC" : NULL,
>          };
>          build_cpus_aml(dsdt, machine, opts, pm->cpu_hp_io_base,
>                         "\\_SB.PCI0", "\\_GPE._E02");

For sub-patch "c":
Reviewed-by: Laszlo Ersek <lersek@redhat.com>


* Patch "d":

[subject: copy from current (large) patch]

[commit message: copy from current (large) patch]

[code extracted from current patch follows, with my comments]

> diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
> index 3d6a500fb7..4864c3b396 100644
> --- a/hw/acpi/cpu.c
> +++ b/hw/acpi/cpu.c
> @@ -14,6 +14,8 @@
>  #define ACPI_CPU_CMD_DATA_OFFSET_RW 8
>  #define ACPI_CPU_CMD_DATA2_OFFSET_R 0
>
> +#define OVMF_CPUHP_SMI_CMD 4
> +
>  enum {
>      CPHP_GET_NEXT_CPU_WITH_EVENT_CMD = 0,
>      CPHP_OST_EVENT_CMD = 1,
> @@ -321,6 +323,7 @@ const VMStateDescription vmstate_cpu_hotplug = {
>  #define CPU_NOTIFY_METHOD "CTFY"
>  #define CPU_EJECT_METHOD  "CEJ0"
>  #define CPU_OST_METHOD    "COST"
> +#define CPU_ADDED_LIST    "CNEW"
>
>  #define CPU_ENABLED       "CPEN"
>  #define CPU_SELECTOR      "CSEL"
> @@ -471,21 +474,61 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
>              Aml *dev_chk = aml_int(1);
>              Aml *eject_req = aml_int(3);
>              Aml *next_cpu_cmd = aml_int(CPHP_GET_NEXT_CPU_WITH_EVENT_CMD);
> +            Aml *num_added_cpus = aml_local(1);
> +            Aml *cpu_idx = aml_local(2);
> +            Aml *uid = aml_local(3);
> +            Aml *new_cpus = aml_name(CPU_ADDED_LIST);
>
>              aml_append(method, aml_acquire(ctrl_lock, 0xFFFF));
> +
> +            /* use named package as old Windows don't support it in local var */
> +            if (arch_ids->len <= 256) {
> +                /*
> +                 * For compatibility with Windows Server 2008 (max 256 cpus),
> +                 * use ACPI1.0 PackageOp which can cache max 255 elements.
> +                 * Which is fine for 256 CPUs VM. Max 255 can be hotplugged,
> +                 * sice at least one CPU must be already present.
> +                 */
> +                aml_append(method, aml_name_decl(CPU_ADDED_LIST,
> +                    aml_package(arch_ids->len)));
> +            } else {
> +                aml_append(method, aml_name_decl(CPU_ADDED_LIST,
> +                    aml_varpackage(arch_ids->len)));
> +            }

(1) Both package sizes are off-by-one. We only need room for the CPUs
that have events pending, and that excludes CPU#0.

In particular, in the compatibility case, when "arch_ids->len" is
exactly 256, then we pass 256 to aml_package(). However, aml_package()
-- correctly! -- takes:

  uint8_t num_elements

So with 256 VCPUs, we'd pass a zero "num_elements".

The comparison (<= 256) is correct, we just need to pass

  arch_ids->len - 1

to both aml_package() and aml_varpackage().


> +
> +            aml_append(method, aml_store(zero, num_added_cpus));
>              aml_append(method, aml_store(one, has_event));
> -            while_ctx = aml_while(aml_equal(has_event, one));
> +            /* start scan from the 1st CPU */
> +            aml_append(method, aml_store(zero, uid));
> +            while_ctx = aml_while(aml_land(aml_equal(has_event, one),
> +                                  aml_lless(uid, aml_int(arch_ids->len))));
>              {
>                   /* clear loop exit condition, ins_evt/rm_evt checks
>                    * will set it to 1 while next_cpu_cmd returns a CPU
>                    * with events */
>                   aml_append(while_ctx, aml_store(zero, has_event));
> +
> +                 aml_append(while_ctx, aml_store(uid, cpu_selector));
>                   aml_append(while_ctx, aml_store(next_cpu_cmd, cpu_cmd));
> +
> +                 /*
> +                  * wrap around case, scan is complete, exit loop.
> +                  * It happens since events are not cleared in scan loop,
> +                  * so next_cpu_cmd continues to find already processed CPUs.
> +                  */
> +                 ifctx = aml_if(aml_lless(cpu_data, uid));
> +                 {
> +                     aml_append(ifctx, aml_break());
> +                 }
> +                 aml_append(while_ctx, ifctx);
> +
> +                 aml_append(while_ctx, aml_store(cpu_data, uid));
>                   ifctx = aml_if(aml_equal(ins_evt, one));
>                   {
> -                     aml_append(ifctx,
> -                         aml_call2(CPU_NOTIFY_METHOD, cpu_data, dev_chk));
> -                     aml_append(ifctx, aml_store(one, ins_evt));
> +                     /* cache added CPUs to Notify/Wakeup later */
> +                     aml_append(ifctx, aml_store(uid,
> +                         aml_index(new_cpus, num_added_cpus)));
> +                     aml_append(ifctx, aml_increment(num_added_cpus));
>                       aml_append(ifctx, aml_store(one, has_event));
>                   }
>                   aml_append(while_ctx, ifctx);
> @@ -493,14 +536,41 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
>                   ifctx = aml_if(aml_equal(rm_evt, one));
>                   {
>                       aml_append(ifctx,
> -                         aml_call2(CPU_NOTIFY_METHOD, cpu_data, eject_req));
> +                         aml_call2(CPU_NOTIFY_METHOD, uid, eject_req));
>                       aml_append(ifctx, aml_store(one, rm_evt));
>                       aml_append(ifctx, aml_store(one, has_event));
>                   }
>                   aml_append(else_ctx, ifctx);
>                   aml_append(while_ctx, else_ctx);
> +                 aml_append(while_ctx, aml_increment(uid));
> +            }
> +            aml_append(method, while_ctx);
> +
> +            /*
> +             * in case FW negotiated ICH9_LPC_SMI_F_CPU_HOTPLUG_BIT,
> +             * make upcall to FW, so it can pull in new CPUs before
> +             * OS is notified and wakes them up
> +             */
> +            if (opts.smi_path) {
> +                ifctx = aml_if(aml_lnot(aml_equal(num_added_cpus, zero)));

(2) The composed "aml_lnot(aml_equal())" is not wrong, but I think
aml_lgreater() would be simpler (for the QEMU source code anyway).

Feel free to ignore.

> +                {
> +                    aml_append(ifctx, aml_store(aml_int(OVMF_CPUHP_SMI_CMD),
> +                        aml_name("%s", opts.smi_path)));
> +                }
> +                aml_append(method, ifctx);
> +            }
> +
> +            /* Notify OSPM about new CPUs and clear insert events */
> +            aml_append(method, aml_store(zero, cpu_idx));
> +            while_ctx = aml_while(aml_lless(cpu_idx, num_added_cpus));
> +            {
> +                aml_append(while_ctx, aml_call2(CPU_NOTIFY_METHOD,
> +                    aml_derefof(aml_index(new_cpus, cpu_idx)), dev_chk));
> +                aml_append(while_ctx, aml_store(one, ins_evt));

(3) Before writing 1 to CINS, you need to set CSEL as well.

This bug is masked if the loop finds *at most* one added CPU. To see
why, here's the decompiled method, with a possible CPUs count of 4, and
the local variable names substituted:

   1  Method (CSCN, 0, Serialized)
   2  {
   3      Acquire (\_SB.PCI0.PRES.CPLK, 0xFFFF)
   4      Name (CNEW, Package (0x04){})
   5
   6      Local_NumAddedCpus = Zero
   7      Local_HasEvent = One
   8      Local_Uid = Zero
   9
  10      While (((Local_HasEvent == One) && (Local_Uid < 0x04)))
  11      {
  12          Local_HasEvent = Zero
  13          \_SB.PCI0.PRES.CSEL = Local_Uid
  14          \_SB.PCI0.PRES.CCMD = Zero
  15          If ((\_SB.PCI0.PRES.CDAT < Local_Uid))
  16          {
  17              Break
  18          }
  19
  20          Local_Uid = \_SB.PCI0.PRES.CDAT
  21          If ((\_SB.PCI0.PRES.CINS == One))
  22          {
  23              CNEW [Local_NumAddedCpus] = Local_Uid
  24              Local_NumAddedCpus++
  25              Local_HasEvent = One
  26          }
  27          ElseIf ((\_SB.PCI0.PRES.CRMV == One))
  28          {
  29              CTFY (Local_Uid, 0x03)
  30              \_SB.PCI0.PRES.CRMV = One
  31              Local_HasEvent = One
  32          }
  33
  34          Local_Uid++
  35      }
  36
  37      If ((Local_NumAddedCpus != Zero))
  38      {
  39          \_SB.PCI0.SMI0.SMIC = 0x04
  40      }
  41
  42      Local_CpuIdx = Zero
  43      While ((Local_CpuIdx < Local_NumAddedCpus))
  44      {
  45          CTFY (DerefOf (CNEW [Local_CpuIdx]), One)
  46          \_SB.PCI0.PRES.CINS = One
  47          Local_CpuIdx++
  48      }
  49
  50      Release (\_SB.PCI0.PRES.CPLK)
  51  }

If the loop has found exactly one VCPU with a pending event, then we
must have exited the loop in one of two ways:

- The UID of the VCPU with the pending event was maximal, and so the
  Local_Uid limit in the While fired on the next iteration (line 10).

- Otherwise, the search wrapped on the next iteration (line 17).

In either case, the loop leaves the "right" CPU selector in place:

- In the first case, when we exit on line 10, we never write to CSEL
  again (line 13).

- In the second case, we wrap back to the *one and only* VCPU with
  pending events, on line 14, before we exit on line 17.

And so when we reach the *one and only* write to CINS on line 46, the
CPU selector happens to be correct.

Because of this, I happened to test this patch successfully with e.g.

  virsh setvcpu DOMAIN 3 --enable --live

(note: "setvcpu", singular).

However, the bug can be triggered when plugging multiple VCPUs in quick
succession, with e.g.

  virsh setvcpus DOMAIN 8 --live

(note "setvcpus", plural).

So I would suggest fetching the CNEW array element back into "uid"
first, then using "uid" for both the NOTIFY call, and the (currently
missing) restoration of CSEL. Then we can write 1 to CINS.

Expressed as a patch on top of yours:

> diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
> index 4864c3b39694..2bea6144fd5e 100644
> --- a/hw/acpi/cpu.c
> +++ b/hw/acpi/cpu.c
> @@ -564,8 +564,11 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
>              aml_append(method, aml_store(zero, cpu_idx));
>              while_ctx = aml_while(aml_lless(cpu_idx, num_added_cpus));
>              {
> -                aml_append(while_ctx, aml_call2(CPU_NOTIFY_METHOD,
> -                    aml_derefof(aml_index(new_cpus, cpu_idx)), dev_chk));
> +                aml_append(while_ctx,
> +                    aml_store(aml_derefof(aml_index(new_cpus, cpu_idx)), uid));
> +                aml_append(while_ctx,
> +                    aml_call2(CPU_NOTIFY_METHOD, uid, dev_chk));
> +                aml_append(while_ctx, aml_store(uid, cpu_selector));
>                  aml_append(while_ctx, aml_store(one, ins_evt));
>                  aml_append(while_ctx, aml_increment(cpu_idx));
>              }

This effects the following change, in the decompiled method:

> @@ -37,15 +37,17 @@
>      If ((Local_NumAddedCpus != Zero))
>      {
>          \_SB.PCI0.SMI0.SMIC = 0x04
>      }
>
>      Local_CpuIdx = Zero
>      While ((Local_CpuIdx < Local_NumAddedCpus))
>      {
> -        CTFY (DerefOf (CNEW [Local_CpuIdx]), One)
> +        Local_Uid = DerefOf (CNEW [Local_CpuIdx])
> +        CTFY (Local_Uid, One)
> +        \_SB.PCI0.PRES.CSEL = Local_Uid
>          \_SB.PCI0.PRES.CINS = One
>          Local_CpuIdx++
>      }
>
>      Release (\_SB.PCI0.PRES.CPLK)
>  }

With this change, the

  virsh setvcpus DOMAIN 8 --live

command works for me. The topology in my test domain has CPU#0 and CPU#2
cold-plugged, so the command adds 6 VCPUs. Viewed from the firmware
side, the 6 "device_add" commands, issued in close succession by
libvirtd, coalesce into 4 "batches". (And of course the firmware sees
the 4 batches back-to-back.)

Note the "PluggedCount" message, which reports the size of each batch:

- Batch#1 adds CPU#1:

> QemuCpuhpCollectApicIds: CurrentSelector=1: insert
> QemuCpuhpCollectApicIds: ApicId=0x00000001
> QemuCpuhpCollectApicIds: CurrentSelector=2 PendingSelector=1: wrap-around
> QemuCpuhpCollectApicIds: PluggedCount=1 ToUnplugCount=0
> CpuHotplugMmi: hot-added APIC ID 0x00000001, SMBASE 0x7FF7A000, EFI_SMM_CPU_SERVICE_PROTOCOL assigned number 2

- Batch#2 adds CPU#3:

> QemuCpuhpCollectApicIds: CurrentSelector=3: insert
> QemuCpuhpCollectApicIds: ApicId=0x00000003
> QemuCpuhpCollectApicIds: CurrentSelector=4 PendingSelector=3: wrap-around
> QemuCpuhpCollectApicIds: PluggedCount=1 ToUnplugCount=0
> CpuHotplugMmi: hot-added APIC ID 0x00000003, SMBASE 0x7FF7C000, EFI_SMM_CPU_SERVICE_PROTOCOL assigned number 3

- Batch#3 adds CPU#4, CPU#5, CPU#6:

> QemuCpuhpCollectApicIds: CurrentSelector=4: insert
> QemuCpuhpCollectApicIds: ApicId=0x00000004
> QemuCpuhpCollectApicIds: CurrentSelector=5: insert
> QemuCpuhpCollectApicIds: ApicId=0x00000005
> QemuCpuhpCollectApicIds: CurrentSelector=6: insert
> QemuCpuhpCollectApicIds: ApicId=0x00000006
> QemuCpuhpCollectApicIds: CurrentSelector=7 PendingSelector=4: wrap-around
> QemuCpuhpCollectApicIds: PluggedCount=3 ToUnplugCount=0
> CpuHotplugMmi: hot-added APIC ID 0x00000004, SMBASE 0x7FF7E000, EFI_SMM_CPU_SERVICE_PROTOCOL assigned number 4
> CpuHotplugMmi: hot-added APIC ID 0x00000005, SMBASE 0x7FF80000, EFI_SMM_CPU_SERVICE_PROTOCOL assigned number 5
> CpuHotplugMmi: hot-added APIC ID 0x00000006, SMBASE 0x7FF82000, EFI_SMM_CPU_SERVICE_PROTOCOL assigned number 6

- Batch#4 adds CPU#7:

> QemuCpuhpCollectApicIds: CurrentSelector=7: insert
> QemuCpuhpCollectApicIds: ApicId=0x00000007
> QemuCpuhpCollectApicIds: PluggedCount=1 ToUnplugCount=0
> CpuHotplugMmi: hot-added APIC ID 0x00000007, SMBASE 0x7FF84000, EFI_SMM_CPU_SERVICE_PROTOCOL assigned number 7

Thanks,
Laszlo

On 08/18/20 14:22, Igor Mammedov wrote:
> +                aml_append(while_ctx, aml_increment(cpu_idx));
>              }
>              aml_append(method, while_ctx);
> +
>              aml_append(method, aml_release(ctrl_lock));
>          }
>          aml_append(cpus_dev, method);


