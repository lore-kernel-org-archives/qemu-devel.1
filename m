Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F608C433E4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 12:31:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B2A621D79
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 12:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aqpSB5zu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B2A621D79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvK5S-0001qs-8j
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 08:31:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39738)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jvK33-0008Oj-JL
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 08:28:37 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44749
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jvK31-00089a-EW
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 08:28:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594729714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dzwo62qRFvLaKWeF2OcIJH313hx+BbusdfPGcHo2Uh0=;
 b=aqpSB5zuOEeNQCC245wBn/U1i0ogY0oSXpxNlO7nW4VEmMOW4Wih2XJ6Bk1Kf6XnzFaOa1
 /TPKj4rl0/NN+MI890FsBSNhr/YVFZWu2VYI4vxgS5S9bGif9zbWOGYyskGEPMrAnfnsdU
 RWkGEgMKa8JLJDQQPL8twWZTtpdIsxA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-ckfAUgpCMnCbUlII3vsAaQ-1; Tue, 14 Jul 2020 08:28:32 -0400
X-MC-Unique: ckfAUgpCMnCbUlII3vsAaQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 61359800FED;
 Tue, 14 Jul 2020 12:28:31 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-114-110.ams2.redhat.com
 [10.36.114.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0638860BEC;
 Tue, 14 Jul 2020 12:28:29 +0000 (UTC)
Subject: Re: [RFC 3/3] x68: acpi: trigger SMI before scanning for hotplugged
 CPUs
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200710161704.309824-1-imammedo@redhat.com>
 <20200710161704.309824-4-imammedo@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <515cc231-858a-a626-31a9-d74e1f6b4e38@redhat.com>
Date: Tue, 14 Jul 2020 14:28:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Firefox/52.0 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200710161704.309824-4-imammedo@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 03:57:32
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
Cc: boris.ostrovsky@oracle.com, Peter Krempa <pkrempa@redhat.com>,
 liran.alon@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

(CC'ing Peter Krempa due to virsh setvcpu (singular) / setvcpus (plural)
references)

On 07/10/20 18:17, Igor Mammedov wrote:
> In case firmware has negotiated CPU hotplug SMI feature, generate
> AML to describe SMI IO port region and send SMI to firmware
> on each CPU hotplug SCI.
> 
> It might be not really usable, but should serve as a starting point to
> discuss how better to deal with split hotplug sequence during hot-add
> (
> ex scenario where it will break is:
>    hot-add
>       -> (QEMU) add CPU in hotplug regs
>       -> (QEMU) SCI
>            -1-> (OS) scan
>                -1-> (OS) SMI
>                -1-> (FW) pull in CPU1 ***
>                -1-> (OS) start iterating hotplug regs
>    hot-add
>       -> (QEMU) add CPU in hotplug regs
>       -> (QEMU) SCI
>             -2-> (OS) scan (blocked on mutex till previous scan is finished)
>                -1-> (OS) 1st added CPU1 send device check event -> INIT/SIPI
>                -1-> (OS) 1st added CPU2 send device check event -> INIT/SIPI
>                        that's where it explodes, since FW didn't see CPU2
>                        when SMI was called
> )
> 
> hot remove will throw in yet another set of problems, so lets discuss
> both here and see if we can  really share hotplug registers block between
> FW and AML or we should do something else with it.

This issue is generally triggered by management applications such as
libvirt that issue device_add commands in quick succession. For libvirt,
the command is "virsh setvcpus" (plural) with multiple CPUs specified
for plugging. The singular "virsh setvcpu" command, which is more
friendly towards guest NUMA, does not run into the symptom.

The scope of the scan method lock is not large enough, with SMI in the
picture.

I suggest that we not uproot the existing AML code or the hotplug
register block. Instead, I suggest that we add serialization at a higher
level, with sufficient scope.

QEMU:

- introduce a new flag standing for "CPU plug operation in progress"

- if ICH9_LPC_SMI_F_BROADCAST_BIT has been negotiated:

  - "device_add" and "device_del" should enforce
    ICH9_LPC_SMI_F_CPU_HOTPLUG_BIT and
    ICH9_LPC_SMI_F_CPU_HOT_UNPLUG_BIT, respectively

  - both device_add and device_del (for VCPUs) should set check the
    "in progress" flag.

    - If set, reject the request synchronously

    - Otherwise, set the flag, and commence the operation

  - in cpu_hotplug_wr(), where we emit the ACPI_DEVICE_OST event with
    qapi_event_send_acpi_device_ost(), clear the "in-progress" flag.

- If QEMU executes the QMP command processing and the cpu_hotplug_wr()
function on different (host OS) threads, then perhaps we should use an
atomic type for the flag. (Not sure about locking between QEMU threads,
sorry.) I don't really expect race conditions, but in case we ever get
stuck with the flag, we should make sure that the stuck state is "in
progress", and not "not in progress". (The former state can prevent
further plug operations, but cannot cause the guest to lose state.)

libvirtd:

- the above QEMU changes will gracefully prevent "virsh setvcpus"
(plural) from working, so the libvirtd changes should "only" aim at
coping with the new serialization added in QEMU

- introduce a new info channel between qemuDomainSetVcpusLive() and
qemuProcessHandleAcpiOstInfo(). In the former, delay sending the next
"device_add" command until ACPI_DEVICE_OST is queued by
qemuProcessHandleAcpiOstInfo().


My point is that we have 60+ SMI feature bits left, so if we have to
invent something entirely new for unplug, we can still do it later. I'm
unable to foresee the particulars of unplug at this stage, beyond what
I've said already in this thread (i.e. that we should immediately
introduce the unplug feature bit, just so we can reject unplug
gracefully). If the current ACPI stuff, the hotplug register block, etc.
prove *inextensible for unplug*, we can use further feature bits for
something entirely new. But I think we can extend what we have now for
completing plug only. And I think modifying QEMU and libvirtd for that
is fair -- I've just read the _OST method documentation in the ACPI
spec, and _OST was clearly designed for coordinating (un)plug between
agents. For example, my understanding is that memory hotplug can fail,
failure is reported via ACPI_DEVICE_OST to libvirtd, so ACPI_DEVICE_OST
is already used for syncronizing guest operations with management layer
operations.

> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> v0:
>  - s/aml_string/aml_eisaid/
>    /fixes Windows BSOD, on nonsense value/ (Laszlo Ersek <lersek@redhat.com>)
>  - put SMI device under PCI0 like the rest of hotplug IO port
>  - do not generate SMI AML if CPU hotplug SMI feature hasn't been negotiated
> ---
>  include/hw/acpi/cpu.h |  1 +
>  hw/acpi/cpu.c         |  6 ++++++
>  hw/i386/acpi-build.c  | 33 ++++++++++++++++++++++++++++++++-
>  hw/isa/lpc_ich9.c     |  3 +++
>  4 files changed, 42 insertions(+), 1 deletion(-)
> 
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
> diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
> index 3d6a500fb7..6539bc23f6 100644
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
> @@ -473,6 +475,10 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
>              Aml *next_cpu_cmd = aml_int(CPHP_GET_NEXT_CPU_WITH_EVENT_CMD);
>  
>              aml_append(method, aml_acquire(ctrl_lock, 0xFFFF));
> +            if (opts.smi_path) {
> +                aml_append(method, aml_store(aml_int(OVMF_CPUHP_SMI_CMD),
> +                    aml_name("%s", opts.smi_path)));
> +            }
>              aml_append(method, aml_store(one, has_event));
>              while_ctx = aml_while(aml_equal(has_event, one));
>              {
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index b7bcbbbb2a..1e21386f0c 100644
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
> @@ -213,6 +215,9 @@ static void acpi_get_pm_info(MachineState *machine, AcpiPmInfo *pm)
>          pm->fadt.reset_val = 0xf;
>          pm->fadt.flags |= 1 << ACPI_FADT_F_RESET_REG_SUP;
>          pm->cpu_hp_io_base = ICH9_CPU_HOTPLUG_IO_BASE;
> +        pm->smi_on_cpuhp =
> +            !!(object_property_get_uint(lpc, "x-smi-negotiated-features", NULL)
> +               & BIT_ULL(ICH9_LPC_SMI_F_CPU_HOTPLUG_BIT));

(1) style: I think the "&" operator should be placed at the end of the
line, not at the start

(2) style: can we introduce a macro for the new property name?

>      }
>  
>      /* The above need not be conditional on machine type because the reset port
> @@ -1515,6 +1520,31 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>          aml_append(dev, aml_name_decl("_UID", aml_int(1)));
>          aml_append(dev, build_q35_osc_method());
>          aml_append(sb_scope, dev);
> +
> +        if (pm->smi_on_cpuhp) {
> +            /* reserve SMI block resources */
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
> +                       1)
> +            );

(3) Just a thought: I wonder if we should reserve both ports (0xB2 and
0xB3 too). For now we don't have any use for the "data" port, but
arguably it's part of the same register block.

> +            aml_append(dev, aml_name_decl("_CRS", crs));
> +            aml_append(dev, aml_operation_region("SMIR", AML_SYSTEM_IO,
> +                aml_int(0xB2), 1));

(4) Style: we should probably use ACPI_PORT_SMI_CMD rather than 0xB2

(5) Same as (3) -- make the "data" port part of the opregion?

(We'd still make the SMIC field below cover only 0xB2, of course.)

Anyway, feel free to ignore (3) and (5) if they are out of scope.

> +            field = aml_field("SMIR", AML_BYTE_ACC, AML_NOLOCK,
> +                              AML_WRITE_AS_ZEROS);
> +            aml_append(field, aml_named_field("SMIC", 8));
> +            aml_append(dev, field);
> +            aml_append(sb_scope, dev);
> +        }
> +
>          aml_append(dsdt, sb_scope);
>  
>          build_hpet_aml(dsdt);
> @@ -1530,7 +1560,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>          build_legacy_cpu_hotplug_aml(dsdt, machine, pm->cpu_hp_io_base);
>      } else {
>          CPUHotplugFeatures opts = {
> -            .acpi_1_compatible = true, .has_legacy_cphp = true
> +            .acpi_1_compatible = true, .has_legacy_cphp = true,
> +            .smi_path = pm->smi_on_cpuhp ? "\\_SB.PCI0.SMI0.SMIC" : NULL,
>          };
>          build_cpus_aml(dsdt, machine, opts, pm->cpu_hp_io_base,
>                         "\\_SB.PCI0", "\\_GPE._E02");
> diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
> index 83da7346ab..5ebea70a8d 100644
> --- a/hw/isa/lpc_ich9.c
> +++ b/hw/isa/lpc_ich9.c
> @@ -643,6 +643,9 @@ static void ich9_lpc_initfn(Object *obj)
>                                    &acpi_enable_cmd, OBJ_PROP_FLAG_READ);
>      object_property_add_uint8_ptr(OBJECT(lpc), ACPI_PM_PROP_ACPI_DISABLE_CMD,
>                                    &acpi_disable_cmd, OBJ_PROP_FLAG_READ);
> +    object_property_add_uint64_ptr(obj, "x-smi-negotiated-features",


(6) same as (2), we should use a macro for the property name.

> +                                   &lpc->smi_negotiated_features,
> +                                   OBJ_PROP_FLAG_READ);
>  
>      ich9_pm_add_properties(obj, &lpc->pm);
>  }
> 

I'll follow up with test results.

Thanks
Laszlo


