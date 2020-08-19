Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1827C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 08:40:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B74D120772
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 08:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JMLQWQI2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B74D120772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8Jde-0002me-T5
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 04:40:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33596)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1k8Jd3-0002NA-Rz
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 04:39:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52333
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1k8Jd1-0003D2-QQ
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 04:39:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597826366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aM0Ru58vfWfbk3DA8IX0HxQEM02MfAgJ8iuZf5MoEKs=;
 b=JMLQWQI2zSlILmibNZ+bsucMadKUqZANsXZVGdmhMKliFxnpzoAAVdS4S+HvtNdZHpcan1
 aATYcAr8+by5Ngq0kQLXVlihg3R/ZkLs7zR1XBZ8tJdUGQGVx3ZTXMGxdwOpVFoQXjvjEx
 /2hj/XC7BbWGULTN557XFzL5ghSrz0g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-2cSDXo7IOUOOHCp37yxj4w-1; Wed, 19 Aug 2020 04:39:09 -0400
X-MC-Unique: 2cSDXo7IOUOOHCp37yxj4w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9498E640C9;
 Wed, 19 Aug 2020 08:39:07 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-114-57.ams2.redhat.com
 [10.36.114.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A844450AC5;
 Wed, 19 Aug 2020 08:39:05 +0000 (UTC)
Subject: Re: [PATCH v2 1/7] x86: lpc9: let firmware negotiate 'CPU hotplug
 with SMI' features
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200818122208.1243901-1-imammedo@redhat.com>
 <20200818122208.1243901-2-imammedo@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <f5a7a4a6-f80e-9836-1524-d4ffe896be92@redhat.com>
Date: Wed, 19 Aug 2020 10:39:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Firefox/52.0 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200818122208.1243901-2-imammedo@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lersek@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=lersek@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 23:05:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, aaron.young@oracle.com,
 David Gibson <dgibson@redhat.com>, boris.ostrovsky@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Igor,

(CC'ing Daniel, Cornelia, David, Peter)

On 08/18/20 14:22, Igor Mammedov wrote:
> It will allow firmware to notify QEMU that firmware requires SMI
> being triggered on CPU hot[un]plug, so that it would be able to account
> for hotplugged CPU and relocate it to new SMM base and/or safely remove
> CPU on unplug.
>
> Using negotiated features, follow up patches will insert SMI upcall
> into AML code, to make sure that firmware processes hotplug before
> guest OS would attempt to use new CPU.
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> ---
> v2:
>   - rebase on top of 5.1 (move compat values to 5.1 machine)
>   - make "x-smi-cpu-hotunplug" false by default (Laszlo Ersek <lersek@redhat.com>)
> ---
>  include/hw/i386/ich9.h |  2 ++
>  include/hw/i386/pc.h   |  3 +++
>  hw/i386/pc.c           |  6 +++++-
>  hw/i386/pc_piix.c      |  1 +
>  hw/i386/pc_q35.c       |  1 +
>  hw/isa/lpc_ich9.c      | 13 +++++++++++++
>  6 files changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/include/hw/i386/ich9.h b/include/hw/i386/ich9.h
> index a98d10b252..d1bb3f7bf0 100644
> --- a/include/hw/i386/ich9.h
> +++ b/include/hw/i386/ich9.h
> @@ -247,5 +247,7 @@ typedef struct ICH9LPCState {
>
>  /* bit positions used in fw_cfg SMI feature negotiation */
>  #define ICH9_LPC_SMI_F_BROADCAST_BIT            0
> +#define ICH9_LPC_SMI_F_CPU_HOTPLUG_BIT          1
> +#define ICH9_LPC_SMI_F_CPU_HOT_UNPLUG_BIT       2
>
>  #endif /* HW_ICH9_H */
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 3d7ed3a55e..fe52e165b2 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -193,6 +193,9 @@ void pc_system_firmware_init(PCMachineState *pcms, MemoryRegion *rom_memory);
>  void pc_madt_cpu_entry(AcpiDeviceIf *adev, int uid,
>                         const CPUArchIdList *apic_ids, GArray *entry);
>
> +extern GlobalProperty pc_compat_5_1[];
> +extern const size_t pc_compat_5_1_len;
> +
>  extern GlobalProperty pc_compat_5_0[];
>  extern const size_t pc_compat_5_0_len;
>
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 47c5ca3e34..99c6bdbab4 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -97,8 +97,12 @@
>  #include "fw_cfg.h"
>  #include "trace.h"
>
> -GlobalProperty pc_compat_5_0[] = {
> +GlobalProperty pc_compat_5_1[] = {
> +    { "ICH9-LPC", "x-smi-cpu-hotplug", "off" },
>  };
> +const size_t pc_compat_5_1_len = G_N_ELEMENTS(pc_compat_5_1);
> +
> +GlobalProperty pc_compat_5_0[] = { };
>  const size_t pc_compat_5_0_len = G_N_ELEMENTS(pc_compat_5_0);
>
>  GlobalProperty pc_compat_4_2[] = {
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index b789e83f9a..d56f2e1b96 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -433,6 +433,7 @@ static void pc_i440fx_5_1_machine_options(MachineClass *m)
>      m->alias = "pc";
>      m->is_default = true;
>      pcmc->default_cpu_version = 1;
> +    compat_props_add(m->compat_props, pc_compat_5_1, pc_compat_5_1_len);
>  }
>
>  DEFINE_I440FX_MACHINE(v5_1, "pc-i440fx-5.1", NULL,
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index a3e607a544..0ca1146a59 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -359,6 +359,7 @@ static void pc_q35_5_1_machine_options(MachineClass *m)
>      pc_q35_machine_options(m);
>      m->alias = "q35";
>      pcmc->default_cpu_version = 1;
> +    compat_props_add(m->compat_props, pc_compat_5_1, pc_compat_5_1_len);
>  }
>
>  DEFINE_Q35_MACHINE(v5_1, "pc-q35-5.1", NULL,
> diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
> index cd6e169d47..19f32bed3e 100644
> --- a/hw/isa/lpc_ich9.c
> +++ b/hw/isa/lpc_ich9.c
> @@ -373,6 +373,15 @@ static void smi_features_ok_callback(void *opaque)
>          /* guest requests invalid features, leave @features_ok at zero */
>          return;
>      }
> +    if (!(guest_features & BIT_ULL(ICH9_LPC_SMI_F_BROADCAST_BIT)) &&
> +        guest_features & (BIT_ULL(ICH9_LPC_SMI_F_CPU_HOTPLUG_BIT) |
> +                          BIT_ULL(ICH9_LPC_SMI_F_CPU_HOT_UNPLUG_BIT))) {
> +        /*
> +         * cpu hot-[un]plug with SMI requires SMI broadcast,
> +         * leave @features_ok at zero
> +         */
> +        return;
> +    }
>
>      /* valid feature subset requested, lock it down, report success */
>      lpc->smi_negotiated_features = guest_features;
> @@ -747,6 +756,10 @@ static Property ich9_lpc_properties[] = {
>      DEFINE_PROP_BOOL("noreboot", ICH9LPCState, pin_strap.spkr_hi, true),
>      DEFINE_PROP_BIT64("x-smi-broadcast", ICH9LPCState, smi_host_features,
>                        ICH9_LPC_SMI_F_BROADCAST_BIT, true),
> +    DEFINE_PROP_BIT64("x-smi-cpu-hotplug", ICH9LPCState, smi_host_features,
> +                      ICH9_LPC_SMI_F_CPU_HOTPLUG_BIT, true),
> +    DEFINE_PROP_BIT64("x-smi-cpu-hotunplug", ICH9LPCState, smi_host_features,
> +                      ICH9_LPC_SMI_F_CPU_HOT_UNPLUG_BIT, false),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>
>

this patch does the right thing for the 5.1 PC machine types, but it
does not introduce any 5.2 machine types, so I can't enable the hotplug
feature bit without messing with the x-smi-cpu-hotplug property
manually.

Now... looking at the mailing list, I can see the following patch
pending review (posted by Daniel ~5 days ago):

  [PATCH 01/10] hw: add compat machines for 5.2
  http://mid.mail-archive.com/20200814205424.543857-2-danielhb413@gmail.com

That patch introduces the 5.2 PC machine types.

However, I can't just apply your series on top of that one patch,
because they conflict at least on the "pc_compat_5_1" array.

Given that Daniel's patch was posted before yours, and also that
Daniel's patch introduces 5.2 machine types for arm, ppc and s390x too
(and the "hw_compat_5_1" array in addition to the "pc_compat_5_1"
array), I'd like to request:

- that we please review and/or merge Daniel's patch in isolation (just
  the first patch in the containing series, not the entire series!),

- and that you please rebase your series on top of Daniel's patch.

If Daniel's patch is approved as-is on the list, then I'm OK applying it
locally in isolation from the rest of the containing series, as a basis
for locally applying your v3.

(I could resolve the conflicts myself at once I guess, and proceed with
the review / testing -- but that's not really useful if I want to give a
formal Tested-by. I wouldn't be testing the patches as they were
posted.)

Thanks!
Laszlo


