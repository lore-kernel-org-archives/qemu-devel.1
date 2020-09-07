Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16EB9C2BC11
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 15:19:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68C0021481
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 15:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DmqB4O9i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68C0021481
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFIvI-0007WU-Fb
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 11:19:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58064)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kFIuD-0006n7-Nn
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 11:18:05 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29573
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kFIuB-0005wU-03
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 11:18:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599491881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XRrn5btWqdeXuKCzK97qxDgwQws16QWtQ34EsF2m50s=;
 b=DmqB4O9iUrrD9mBmhX3RQZr8N/+d80YgtCm0ILnuNuDDH6G9hJLFI5WIH7yYMGKAmNYHpB
 NFxo/AIz816T2Dz175IIpdmu+kgV9HPFFFQlyLG0ZlHlj7ri8hO5R31FXBQt7zuXWwI9Ao
 kqVEyIGfIymC3PxOQ8TEvhlzQ0g6NYM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-ovYo_ZEBMm2eN96Nmy7EiA-1; Mon, 07 Sep 2020 11:17:56 -0400
X-MC-Unique: ovYo_ZEBMm2eN96Nmy7EiA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4660A801AF8;
 Mon,  7 Sep 2020 15:17:55 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-115-56.ams2.redhat.com
 [10.36.115.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BB30C5D9E2;
 Mon,  7 Sep 2020 15:17:53 +0000 (UTC)
Subject: Re: [PATCH v5 09/10] x68: acpi: trigger SMI before sending hotplug
 Notify event to OSPM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200907112348.530921-1-imammedo@redhat.com>
 <20200907112348.530921-10-imammedo@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <cb3f326a-97ec-7b88-729d-eb11ed7aeb5e@redhat.com>
Date: Mon, 7 Sep 2020 17:17:52 +0200
MIME-Version: 1.0
In-Reply-To: <20200907112348.530921-10-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lersek@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/06 22:29:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: boris.ostrovsky@oracle.com, aaron.young@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Igor,

On 09/07/20 13:23, Igor Mammedov wrote:
> In case firmware has negotiated CPU hotplug SMI feature, generate
> AML to describe SMI IO port region and send SMI to firmware
> on each CPU hotplug SCI in case new CPUs were hotplugged.
>
> Since new CPUs can be hotplugged while CPU_SCAN_METHOD is running
> we can't send SMI before new CPUs are fetched from QEMU as it
> could cause sending Notify to a CPU that firmware hasn't seen yet.
> So fetch new CPUs into local cache first, then send SMI and
> after that send Notify events to cached CPUs. This should ensure
> that Notify is sent only to CPUs which were processed by firmware
> first.
> Any CPUs that were hotplugged after caching will be processed
> by the next CPU_SCAN_METHOD, when pending SCI is handled.
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> v5:
>  - fix hotplug on Windows when there is more than 256 possible CPUs
>    (Windows isn't able to handle VarPackage over 255 elements
>     so process CPUs in batches)
>  - (Laszlo Ersek <lersek@redhat.com>)
>    - fix off-by-one in package length
>    - fix not selecting CPU before clearing insert event
>    - use aml_lgreater() instead of aml_lnot(aml_equal(num_added_cpus,
>      zero)
>    - split off in separate patches:
>      - making smi_negotiated_features a property
>      - introduction of AcpiPmInfo.smi_on_cpuhp
>      - introduction of PCI0.SMI0 ACPI device
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
>    /fixes Windows BSOD, on nonsense value/ (Laszlo Ersek
>    <lersek@redhat.com>)
>  - put SMI device under PCI0 like the rest of hotplug IO port
>  - do not generate SMI AML if CPU hotplug SMI feature hasn't been
>    negotiated
> ---
>  hw/acpi/cpu.c | 156 +++++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 129 insertions(+), 27 deletions(-)
>
> diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
> index 3d6a500fb7..1283972001 100644
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
> @@ -465,42 +468,141 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
>
>          method = aml_method(CPU_SCAN_METHOD, 0, AML_SERIALIZED);
>          {
> +            const uint8_t max_cpus_per_pass = 255;
>              Aml *else_ctx;
> -            Aml *while_ctx;
> +            Aml *while_ctx, *while_ctx2;
>              Aml *has_event = aml_local(0);
>              Aml *dev_chk = aml_int(1);
>              Aml *eject_req = aml_int(3);
>              Aml *next_cpu_cmd = aml_int(CPHP_GET_NEXT_CPU_WITH_EVENT_CMD);
> +            Aml *num_added_cpus = aml_local(1);
> +            Aml *cpu_idx = aml_local(2);
> +            Aml *uid = aml_local(3);
> +            Aml *has_job = aml_local(4);
> +            Aml *new_cpus = aml_name(CPU_ADDED_LIST);
>
>              aml_append(method, aml_acquire(ctrl_lock, 0xFFFF));
> -            aml_append(method, aml_store(one, has_event));
> -            while_ctx = aml_while(aml_equal(has_event, one));
> +
> +            /*
> +             * Windows versions newer than XP (including Windows 10/Windows
> +             * Server 2019), do support* VarPackageOp but, it is cripled to hold
> +             * the same elements number as old PackageOp.
> +             * For compatibility with Windows XP (so it won't crash) use ACPI1.0
> +             * PackageOp which can hold max 255 elements.
> +             *
> +             * use named package as old Windows don't support it in local var
> +             */
> +            aml_append(method, aml_name_decl(CPU_ADDED_LIST,
> +                                             aml_package(max_cpus_per_pass)));
> +
> +            aml_append(method, aml_store(zero, uid));
> +            aml_append(method, aml_store(one, has_job));
> +            /*
> +             * CPU_ADDED_LIST can hold limited number of elements, outer loop
> +             * allows to process CPUs in batches which let us to handle more
> +             * CPUs than CPU_ADDED_LIST can hold.
> +             */
> +            while_ctx2 = aml_while(aml_equal(has_job, one));
>              {
> -                 /* clear loop exit condition, ins_evt/rm_evt checks
> -                  * will set it to 1 while next_cpu_cmd returns a CPU
> -                  * with events */
> -                 aml_append(while_ctx, aml_store(zero, has_event));
> -                 aml_append(while_ctx, aml_store(next_cpu_cmd, cpu_cmd));
> -                 ifctx = aml_if(aml_equal(ins_evt, one));
> -                 {
> -                     aml_append(ifctx,
> -                         aml_call2(CPU_NOTIFY_METHOD, cpu_data, dev_chk));
> -                     aml_append(ifctx, aml_store(one, ins_evt));
> -                     aml_append(ifctx, aml_store(one, has_event));
> -                 }
> -                 aml_append(while_ctx, ifctx);
> -                 else_ctx = aml_else();
> -                 ifctx = aml_if(aml_equal(rm_evt, one));
> -                 {
> -                     aml_append(ifctx,
> -                         aml_call2(CPU_NOTIFY_METHOD, cpu_data, eject_req));
> -                     aml_append(ifctx, aml_store(one, rm_evt));
> -                     aml_append(ifctx, aml_store(one, has_event));
> -                 }
> -                 aml_append(else_ctx, ifctx);
> -                 aml_append(while_ctx, else_ctx);
> +                aml_append(while_ctx2, aml_store(zero, has_job));
> +
> +                aml_append(while_ctx2, aml_store(one, has_event));
> +                aml_append(while_ctx2, aml_store(zero, num_added_cpus));
> +
> +                /*
> +                 * Scan CPUs, till there are CPUs with events or
> +                 * CPU_ADDED_LIST capacity is exhausted
> +                 */
> +                while_ctx = aml_while(aml_land(aml_equal(has_event, one),
> +                                      aml_lless(uid, aml_int(arch_ids->len))));
> +                {
> +                     /*
> +                      * clear loop exit condition, ins_evt/rm_evt checks will
> +                      * set it to 1 while next_cpu_cmd returns a CPU with events
> +                      */
> +                     aml_append(while_ctx, aml_store(zero, has_event));
> +
> +                     aml_append(while_ctx, aml_store(uid, cpu_selector));
> +                     aml_append(while_ctx, aml_store(next_cpu_cmd, cpu_cmd));
> +
> +                     /*
> +                      * wrap around case, scan is complete, exit loop.
> +                      * It happens since events are not cleared in scan loop,
> +                      * so next_cpu_cmd continues to find already processed CPUs
> +                      */
> +                     ifctx = aml_if(aml_lless(cpu_data, uid));
> +                     {
> +                         aml_append(ifctx, aml_break());
> +                     }
> +                     aml_append(while_ctx, ifctx);
> +
> +                     /*
> +                      * if CPU_ADDED_LIST is full, exit inner loop and process
> +                      * collected CPUs
> +                      */
> +                     ifctx = aml_if(
> +                         aml_equal(num_added_cpus, aml_int(max_cpus_per_pass)));
> +                     {
> +                         aml_append(ifctx, aml_store(one, has_job));
> +                         aml_append(ifctx, aml_break());
> +                     }
> +                     aml_append(while_ctx, ifctx);
> +
> +                     aml_append(while_ctx, aml_store(cpu_data, uid));
> +                     ifctx = aml_if(aml_equal(ins_evt, one));
> +                     {
> +                         /* cache added CPUs to Notify/Wakeup later */
> +                         aml_append(ifctx, aml_store(uid,
> +                             aml_index(new_cpus, num_added_cpus)));
> +                         aml_append(ifctx, aml_increment(num_added_cpus));
> +                         aml_append(ifctx, aml_store(one, has_event));
> +                     }
> +                     aml_append(while_ctx, ifctx);
> +                     else_ctx = aml_else();
> +                     ifctx = aml_if(aml_equal(rm_evt, one));
> +                     {
> +                         aml_append(ifctx,
> +                             aml_call2(CPU_NOTIFY_METHOD, uid, eject_req));
> +                         aml_append(ifctx, aml_store(one, rm_evt));
> +                         aml_append(ifctx, aml_store(one, has_event));
> +                     }
> +                     aml_append(else_ctx, ifctx);
> +                     aml_append(while_ctx, else_ctx);
> +                     aml_append(while_ctx, aml_increment(uid));
> +                }
> +                aml_append(while_ctx2, while_ctx);
> +
> +                /*
> +                 * in case FW negotiated ICH9_LPC_SMI_F_CPU_HOTPLUG_BIT,
> +                 * make upcall to FW, so it can pull in new CPUs before
> +                 * OS is notified and wakes them up
> +                 */
> +                if (opts.smi_path) {
> +                    ifctx = aml_if(aml_lgreater(num_added_cpus, zero));
> +                    {
> +                        aml_append(ifctx, aml_store(aml_int(OVMF_CPUHP_SMI_CMD),
> +                            aml_name("%s", opts.smi_path)));
> +                    }
> +                    aml_append(while_ctx2, ifctx);
> +                }
> +
> +                /* Notify OSPM about new CPUs and clear insert events */
> +                aml_append(while_ctx2, aml_store(zero, cpu_idx));
> +                while_ctx = aml_while(aml_lless(cpu_idx, num_added_cpus));
> +                {
> +                    aml_append(while_ctx,
> +                        aml_store(aml_derefof(aml_index(new_cpus, cpu_idx)),
> +                                  uid));
> +                    aml_append(while_ctx,
> +                        aml_call2(CPU_NOTIFY_METHOD, uid, dev_chk));
> +                    aml_append(while_ctx, aml_store(uid, aml_debug()));
> +                    aml_append(while_ctx, aml_store(uid, cpu_selector));
> +                    aml_append(while_ctx, aml_store(one, ins_evt));
> +                    aml_append(while_ctx, aml_increment(cpu_idx));
> +                }
> +                aml_append(while_ctx2, while_ctx);
>              }
> -            aml_append(method, while_ctx);
> +            aml_append(method, while_ctx2);
>              aml_append(method, aml_release(ctrl_lock));
>          }
>          aml_append(cpus_dev, method);
>

Here's the ASL decompiled, and using the meaningful local variable names
(and 8 possible VCPUs):

   1              Method (CSCN, 0, Serialized)
   2              {
   3                  Acquire (\_SB.PCI0.PRES.CPLK, 0xFFFF)
   4                  Name (CNEW, Package (0xFF){})
   5                  Local_Uid = Zero
   6                  Local_HasJob = One
   7                  While ((Local_HasJob == One))
   8                  {
   9                      Local_HasJob = Zero
  10                      Local_HasEvent = One
  11                      Local_NumAddedCpus = Zero
  12                      While (((Local_HasEvent == One) && (Local_Uid < 0x08)))
  13                      {
  14                          Local_HasEvent = Zero
  15                          \_SB.PCI0.PRES.CSEL = Local_Uid
  16                          \_SB.PCI0.PRES.CCMD = Zero
  17                          If ((\_SB.PCI0.PRES.CDAT < Local_Uid))
  18                          {
  19                              Break
  20                          }
  21
  22                          If ((Local_NumAddedCpus == 0xFF))
  23                          {
  24                              Local_HasJob = One
  25                              Break
  26                          }
  27
  28                          Local_Uid = \_SB.PCI0.PRES.CDAT
  29                          If ((\_SB.PCI0.PRES.CINS == One))
  30                          {
  31                              CNEW [Local_NumAddedCpus] = Local_Uid
  32                              Local_NumAddedCpus++
  33                              Local_HasEvent = One
  34                          }
  35                          ElseIf ((\_SB.PCI0.PRES.CRMV == One))
  36                          {
  37                              CTFY (Local_Uid, 0x03)
  38                              \_SB.PCI0.PRES.CRMV = One
  39                              Local_HasEvent = One
  40                          }
  41
  42                          Local_Uid++
  43                      }
  44
  45                      If ((Local_NumAddedCpus > Zero))
  46                      {
  47                          \_SB.PCI0.SMI0.SMIC = 0x04
  48                      }
  49
  50                      Local_CpuIdx = Zero
  51                      While ((Local_CpuIdx < Local_NumAddedCpus))
  52                      {
  53                          Local_Uid = DerefOf (CNEW [Local_CpuIdx])
  54                          CTFY (Local_Uid, One)
  55                          Debug = Local_Uid
  56                          \_SB.PCI0.PRES.CSEL = Local_Uid
  57                          \_SB.PCI0.PRES.CINS = One
  58                          Local_CpuIdx++
  59                      }
  60                  }
  61
  62                  Release (\_SB.PCI0.PRES.CPLK)
  63              }

When we take the Break on line 25, then:

(a) on line 25, the following equality holds:

  Local_Uid == CNEW[Local_NumAddedCpus - 1] + 1

(b) on line 60, the following equality holds:

  Local_Uid == CNEW[Local_NumAddedCpus - 1]

This means that, when we write Local_Uid to CSEL on line 15 again, then:

- we effectively re-investigate the last-cached CPU (with selector value
  CNEW[Local_NumAddedCpus - 1])

- rather than resuming the scanning right after it -- that is, with
  selector value (CNEW[Local_NumAddedCpus - 1] + 1) --, in the spirit of
  line 42.

My question is: is this "rewind" intentional?

Now, I don't see a functionality problem with this, as on line 57, we
clear the pending insert event for the last-cached CPU, so when we
re-check it, the "get pending" command will simply seek past it.

But I'd like to understand if this is *precisely* your intent, or if
it's an oversight and it just ends up working OK.

Basically my question is whether we should add, on top:

> --- cscn.v5     2020-09-07 15:02:13.401663487 +0200
> +++ cscn.v5.incr        2020-09-07 16:52:22.133843710 +0200
> @@ -57,6 +57,10 @@
>                          \_SB.PCI0.PRES.CINS = One
>                          Local_CpuIdx++
>                      }
> +
> +                    if ((Local_HasJob == One)) {
> +                        Local_Uid++
> +                    }
>                  }
>
>                  Release (\_SB.PCI0.PRES.CPLK)

If not -- that is, the currently proposed patch is intentional --, then
I think we should add a comment, about the effective "rewind" being
intentional & okay.

(Note: it's certainly valid and necessary to re-write CSEL on line 15
after raising the SMI on line 47; the question is not whether we should
or should not re-write CSEL (we must!), but the specific value that we
write to CSEL.)

So:

- If the outer loop body is entered only once, then the patch looks
  fine, from both the review side, and the testing side (I tested it
  with 4-8 possible VCPUs).

- If the outer loop body is entered twice or more, then from the review
  side, please my question above. From the testing side: do you have an
  environment where I could test this with OVMF?

(I expect it to work OK. Upon the first SMI, the firmware will likely
pick up more VCPUs than what's in CNEW. But edk2 commit 020bb4b46d6f
("OvmfPkg/CpuHotplugSmm: fix CPU hotplug race just before SMI
broadcast", 2020-08-27) should deal with that.)

Hmm, actually, there's no need for a special environment: I can patch
QEMU and lower "max_cpus_per_pass" to something small, such as "3" or
whatever, for testing the outer loop multiple times. But first I'd like
to know your thoughts on the "rewind".

Thanks!
Laszlo


