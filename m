Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F92C433E5
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 15:31:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 084642068F
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 15:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gY2dS20s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 084642068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyGic-0000rg-7f
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 11:31:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jyGhg-0000P5-Nz
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 11:30:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26008
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jyGhe-00049A-4K
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 11:30:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595431840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z0hJPSlckdr2oQVhtM/HC5rLpYbYLOhq4A3LagGY30M=;
 b=gY2dS20seXH6enwpQBtboEI/+wqew/Cjs9ZGeauX1T6w+ONi/VHID4Hfsbh+0RNKMkF1zT
 6+pKKyVAKpbc1rKCuBlsybb7KodVzeAuI8eN77i9fu+WKly7rngwHqUr9OfTiz22BvzGGu
 VOt5UYpTS70E/W99amaf7YWB2NxTJNA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-nCpD_ImgNz2sCjf7k5P3jg-1; Wed, 22 Jul 2020 11:30:39 -0400
X-MC-Unique: nCpD_ImgNz2sCjf7k5P3jg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 026EB91294;
 Wed, 22 Jul 2020 15:30:38 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-113-129.ams2.redhat.com
 [10.36.113.129])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C49D388D41;
 Wed, 22 Jul 2020 15:30:36 +0000 (UTC)
Subject: Re: [PATCH 5/6] x68: acpi: trigger SMI before scanning for hotplugged
 CPUs
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200720141610.574308-1-imammedo@redhat.com>
 <20200720141610.574308-6-imammedo@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <04b37460-567b-0d33-b5b9-b476ba3c07ff@redhat.com>
Date: Wed, 22 Jul 2020 17:30:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Firefox/52.0 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200720141610.574308-6-imammedo@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=lersek@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 00:40:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: boris.ostrovsky@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/20/20 16:16, Igor Mammedov wrote:
> In case firmware has negotiated CPU hotplug SMI feature, generate
> AML to describe SMI IO port region and send SMI to firmware
> on each CPU hotplug SCI in case new CPUs were htplugged.

(1) s/htplugged/hotplugged/

>
> Since new CPUs can be hotplugged while CPU_SCAN_METHOD is running
> we can't send SMI before new CPUs are fetched from QEMU as it
> could cause sending Notify to a CPU that firmware hasn't seen yet.
> So fetch new CPUs into local cache first and then send SMI and
> after that sends Notify events to cached CPUs. This should ensure
> that Notify is sent only to CPUs which were processed by firmware
> first.
> Any CPUs that were hotplugged after caching will be process

(2) s/will be process/will be processed/

> by the next CPU_SCAN_METHOD, when pending SCI is handled.

(3) I think that the subject ("trigger SMI before scanning") may no
longer apply, because we do scan before triggering the SMI.

>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> v1:
>  - make sure that Notify is sent only to CPUs seen by FW
>
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
>  hw/acpi/cpu.c          | 50 ++++++++++++++++++++++++++++++++++++++++--
>  hw/i386/acpi-build.c   | 35 ++++++++++++++++++++++++++++-
>  hw/isa/lpc_ich9.c      |  3 +++
>  5 files changed, 88 insertions(+), 3 deletions(-)
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
> diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
> index 3d6a500fb7..a6dd6e252a 100644
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
> @@ -471,8 +474,27 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
>              Aml *dev_chk = aml_int(1);
>              Aml *eject_req = aml_int(3);
>              Aml *next_cpu_cmd = aml_int(CPHP_GET_NEXT_CPU_WITH_EVENT_CMD);
> +            Aml *num_added_cpus = aml_local(1);
> +            Aml *cpu_idx = aml_local(2);
> +            Aml *new_cpus = aml_name(CPU_ADDED_LIST);
>
>              aml_append(method, aml_acquire(ctrl_lock, 0xFFFF));
> +
> +            /* use named package as old Windows don't support it in local var */
> +            if (arch_ids->len <= 256) {
> +                /* For compatibility with Windows Server 2008 (max 256 cpus),
> +                 * use ACPI1.0 PackageOp which can cache max 255 elements.
> +                 * Which is fine for 256 CPUs VM. Max 255 can be hotplugged,
> +                 * sice at least one CPU must be already present.
> +                */
> +                aml_append(method, aml_name_decl(CPU_ADDED_LIST,
> +                    aml_package(arch_ids->len)));
> +            } else {
> +                aml_append(method, aml_name_decl(CPU_ADDED_LIST,
> +                    aml_varpackage(arch_ids->len)));
> +            }
> +
> +            aml_append(method, aml_store(zero, num_added_cpus));
>              aml_append(method, aml_store(one, has_event));
>              while_ctx = aml_while(aml_equal(has_event, one));
>              {
> @@ -483,8 +505,10 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
>                   aml_append(while_ctx, aml_store(next_cpu_cmd, cpu_cmd));
>                   ifctx = aml_if(aml_equal(ins_evt, one));
>                   {
> -                     aml_append(ifctx,
> -                         aml_call2(CPU_NOTIFY_METHOD, cpu_data, dev_chk));
> +                     /* cache added CPUs to Notify/Wakeup later */
> +                     aml_append(ifctx, aml_store(cpu_data,
> +                         aml_index(new_cpus, num_added_cpus)));
> +                     aml_append(ifctx, aml_increment(num_added_cpus));
>                       aml_append(ifctx, aml_store(one, ins_evt));
>                       aml_append(ifctx, aml_store(one, has_event));
>                   }
> @@ -501,6 +525,28 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
>                   aml_append(while_ctx, else_ctx);
>              }
>              aml_append(method, while_ctx);
> +
> +            /* in case FW negotiated ICH9_LPC_SMI_F_CPU_HOTPLUG_BIT,
> +             * make upcall to FW, so it can pull in new CPUs before
> +             * OS is notified and wakes them up */
> +            if (opts.smi_path) {
> +                ifctx = aml_if(aml_lnot(aml_equal(num_added_cpus, zero)));
> +                {
> +                    aml_append(ifctx, aml_store(aml_int(OVMF_CPUHP_SMI_CMD),
> +                        aml_name("%s", opts.smi_path)));
> +                }
> +                aml_append(method, ifctx);
> +            }
> +
> +            aml_append(method, aml_store(zero, cpu_idx));
> +            while_ctx = aml_while(aml_lless(cpu_idx, num_added_cpus));
> +            {
> +                aml_append(while_ctx, aml_call2(CPU_NOTIFY_METHOD,
> +                    aml_derefof(aml_index(new_cpus, cpu_idx)), dev_chk));
> +                aml_append(while_ctx, aml_increment(cpu_idx));
> +            }
> +            aml_append(method, while_ctx);
> +
>              aml_append(method, aml_release(ctrl_lock));
>          }
>          aml_append(cpus_dev, method);

(4) This version addresses all my requests from the previous version,
but the above method changes unfortunately break the hot-plugging of a
single CPU even.

Here's the decompiled method (using a topology with 4 possible CPUs):

   1  Method (CSCN, 0, Serialized)
   2  {
   3      Acquire (\_SB.PCI0.PRES.CPLK, 0xFFFF)
   4      Name (CNEW, Package (0x04){})
   5      Local1 = Zero
   6      Local0 = One
   7      While ((Local0 == One))
   8      {
   9          Local0 = Zero
  10          \_SB.PCI0.PRES.CCMD = Zero
  11          If ((\_SB.PCI0.PRES.CINS == One))
  12          {
  13              CNEW [Local1] = \_SB.PCI0.PRES.CDAT
  14              Local1++
  15              \_SB.PCI0.PRES.CINS = One
  16              Local0 = One
  17          }
  18          ElseIf ((\_SB.PCI0.PRES.CRMV == One))
  19          {
  20              CTFY (\_SB.PCI0.PRES.CDAT, 0x03)
  21              \_SB.PCI0.PRES.CRMV = One
  22              Local0 = One
  23          }
  24      }
  25
  26      If ((Local1 != Zero))
  27      {
  28          \_SB.PCI0.SMI0.SMIC = 0x04
  29      }
  30
  31      Local2 = Zero
  32      While ((Local2 < Local1))
  33      {
  34          CTFY (DerefOf (CNEW [Local2]), One)
  35          Local2++
  36      }
  37
  38      Release (\_SB.PCI0.PRES.CPLK)
  39  }

The problem is on line 15. When you write 1 to \_SB.PCI0.PRES.CINS, the
following happens (quoting "docs/specs/acpi_cpu_hotplug.txt"):

> write access:
>     offset:
> [...]
>     [0x4] CPU device control fields: (1 byte access)
>         bits:
>             0: [...]
>             1: if set to 1 clears device insert event, set by OSPM
>                after it has emitted device check event for the
>                selected CPU device

Because of this, by the time the SMI is raised on line 28, the firmware
will see no pending events.

The scanning (= collection into the package) has to be implemented such
that the pending events never change.

This is possible to do; the firmware already does it. The idea is to
advance the "get next CPU with event" command by manually incrementing
the CPU selector past the CPU that has a pending event, rather than by
clearing the events for the currently selected CPU. Here's the
pseudo-code:

    bool scan;
    uint32_t current_selector;
    uint32_t pending_selector;
    uint32_t event_count;
    uint32_t plug_count;
    uint32_t event;

    scan = true;
    current_selector = 0;
    event_count = 0;
    plug_count = 0;

    while (scan) {
        scan = false;

        /* the "get next CPU with pending event" command starts scanning
         * at the currently selected CPU, *inclusive*
         */
        CSEL = current_selector;
        CCMD = 0;
        pending_selector = CDAT;

        /* the "get next CPU with pending event" command may cause the
         * current selector to wrap around; in which case we're done
         */
        if (pending_selector >= current_selector) {
            current_selector = pending_selector;

            /* if there's no pending event for the currently selected
             * CPU, we're done
             */
            if (CINS) {
                /* record INSERT event for currently selected CPU, and
                 * continue scanning
                 */
                CNEW[event_count] = current_selector;
                CEVT[event_count] = 1;
                event_count++;
                plug_count++;
                scan = true;
            } else if (CRMV) {
                /* record REMOVE event for currently selected CPU, and
                 * continue scanning
                 */
                CNEW[event_count] = current_selector;
                CEVT[event_count] = 3;
                event_count++;
                scan = true;
            }

            if (scan) {
                scan = false;
                /* advance past this CPU manually (as we must not clear
                 * events pending for this CPU)
                 */
                current_selector++;
                if (current_selector < possible_cpu_count) {
                    scan = true;
                }
            }
        }
    }

    /* raise "hotplug SMI" now if at least one INSERT event has been
     * collected
     */
    if (plug_count > 0) {
        SMIC = 0x04;
    }

    /* notify the OS about all events, and clear pending events (same
     * order as before)
     */
    event = 0;
    while (event < event_count) {
        CTFY(CNEW[event], CEVT[event]);

        CSEL = CNEW[event];
        if (CEVT[event] == 1) {
            CINS = 1;
        } else if (CEVT[event] == 3) {
            CRMV = 1;
        }

        event++;
    }


Thanks
Laszlo


