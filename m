Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59995C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 08:26:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97DC423977
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 08:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PrL39fyS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97DC423977
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL06d-0007F6-Bx
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 04:26:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kL04y-0005LO-W7
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 04:24:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26873)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kL04x-0004lI-4J
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 04:24:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600849481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mbxw21/Q8oypwLKK8CFJa+DRpxLfbkt3jEGgZ3dc06o=;
 b=PrL39fySOzy5w/wvPvRRVuQ6XbpUAcxpEfN7pL/w7FcA4OEkOvD4OLw+OxD5u6SNaAFo6S
 Ma4LLT0jx2JyraO0ZqTffJiz202VsE1yt7w0e6YmLXXGD4hfrfqrr2BejUE9dioXtDf6oM
 dLLfuCNd4s2OMPMJXgoJ2JNEdTvbm4c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-AiIyC7NHP_aOE-4LouV8VQ-1; Wed, 23 Sep 2020 04:24:39 -0400
X-MC-Unique: AiIyC7NHP_aOE-4LouV8VQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6BE061800D4A;
 Wed, 23 Sep 2020 08:24:38 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-112-233.ams2.redhat.com
 [10.36.112.233])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E8C47100238C;
 Wed, 23 Sep 2020 08:24:33 +0000 (UTC)
Subject: Re: [PATCH] add maximum combined fw size as machine configuration
 option
To: Erich Mcmillan <erich.mcmillan@hp.com>, qemu-devel@nongnu.org
References: <20200923032433.3799-1-erich.mcmillan@hp.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <afd60f6d-d185-7924-ae57-1cd6a3f6bb63@redhat.com>
Date: Wed, 23 Sep 2020 10:24:32 +0200
MIME-Version: 1.0
In-Reply-To: <20200923032433.3799-1-erich.mcmillan@hp.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lersek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 00:53:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
Cc: imammedo@redhat.com, dgilbert@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/23/20 05:24, Erich Mcmillan wrote:
> From: Erich McMillan <erich.mcmillan@hp.com>
> 
> Signed-off-by: Erich McMillan <erich.mcmillan@hp.com>
> ---
>  hw/i386/pc.c         | 50 ++++++++++++++++++++++++++++++++++++++++++++
>  hw/i386/pc_sysfw.c   | 13 ++----------
>  include/hw/i386/pc.h |  2 ++
>  3 files changed, 54 insertions(+), 11 deletions(-)

- The inter-version changelog has completely disappeared. While it is
not supposed to end up in the git history (which is why we keep it out
of the commit message), it does help reviewers perform incremental
reviews, on v2, v3, etc iterations of a patch or series.

- The commit message is still empty. There's no justification given why
this patch is necessary or useful. Your original message stated "We have
a need for increased firmware size". Please include at least that in the
commit message. Possibly formulated as "At HP, we have a need for
increased firmware size". *Something* should be stated about the use case.

- The subject prefix does not contain "v3" (by my count, this is version
3 of the patch). Please pass "-v3" to git-format-patch in such cases;
that option will set the subject prefix automatically to "PATCH v3".

Please post a v4 with at least the commit message updated and the
subject prefix corrected (it should be "PATCH v4"). I'll try to compare
your v4 submission against my v2 feedback.

... actually, here's one more request: please use the following subject
line:

hw/i386/pc: add maximum combined fw size as machine configuration option

QEMU has many subsystems, and it's best to identify the subsystem in the
subject. Apologies for not noticing this before.

Thanks,
Laszlo

> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index d11daacc23..89775e7d5b 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1869,6 +1869,49 @@ static void pc_machine_set_max_ram_below_4g(Object *obj, Visitor *v,
>      pcms->max_ram_below_4g = value;
>  }
>  
> +static void pc_machine_get_max_fw_size(Object *obj, Visitor *v,
> +                                       const char *name, void *opaque,
> +                                       Error **errp)
> +{
> +    PCMachineState *pcms = PC_MACHINE(obj);
> +    uint64_t value = pcms->max_fw_size;
> +
> +    visit_type_size(v, name, &value, errp);
> +}
> +
> +static void pc_machine_set_max_fw_size(Object *obj, Visitor *v,
> +                                       const char *name, void *opaque,
> +                                       Error **errp)
> +{
> +    PCMachineState *pcms = PC_MACHINE(obj);
> +    Error *error = NULL;
> +    uint64_t value;
> +
> +    visit_type_size(v, name, &value, &error);
> +    if (error) {
> +        error_propagate(errp, error);
> +        return;
> +    }
> +
> +    /*
> +    * We don't have a theoretically justifiable exact lower bound on the base
> +    * address of any flash mapping. In practice, the IO-APIC MMIO range is
> +    * [0xFEE00000..0xFEE01000] -- see IO_APIC_DEFAULT_ADDRESS --, leaving free
> +    * only 18MB-4KB below 4G. For now, restrict the cumulative mapping to 8MB in
> +    * size.
> +    */
> +    if (value > 16 * MiB) {
> +        error_setg(errp,
> +                   "User specified max allowed firmware size %" PRIu64 " is "
> +                   "greater than 16MiB. If combined firwmare size exceeds "
> +                   "16MiB the system may not boot, or experience intermittent"
> +                   "stability issues.",
> +                   value);
> +    }
> +
> +    pcms->max_fw_size = value;
> +}
> +
>  static void pc_machine_initfn(Object *obj)
>  {
>      PCMachineState *pcms = PC_MACHINE(obj);
> @@ -1884,6 +1927,7 @@ static void pc_machine_initfn(Object *obj)
>      pcms->smbus_enabled = true;
>      pcms->sata_enabled = true;
>      pcms->pit_enabled = true;
> +    pcms->max_fw_size = 8 * MiB; /* use default */
>  
>      pc_system_flash_create(pcms);
>      pcms->pcspk = isa_new(TYPE_PC_SPEAKER);
> @@ -2004,6 +2048,12 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
>  
>      object_class_property_add_bool(oc, PC_MACHINE_PIT,
>          pc_machine_get_pit, pc_machine_set_pit);
> +
> +    object_class_property_add(oc, PC_MACHINE_MAX_FW_SIZE, "size",
> +        pc_machine_get_max_fw_size, pc_machine_set_max_fw_size,
> +        NULL, NULL);
> +    object_class_property_set_description(oc, PC_MACHINE_MAX_FW_SIZE,
> +        "Maximum combined firmware size");
>  }
>  
>  static const TypeInfo pc_machine_info = {
> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
> index b6c0822fe3..22450ba0ef 100644
> --- a/hw/i386/pc_sysfw.c
> +++ b/hw/i386/pc_sysfw.c
> @@ -39,15 +39,6 @@
>  #include "hw/block/flash.h"
>  #include "sysemu/kvm.h"
>  
> -/*
> - * We don't have a theoretically justifiable exact lower bound on the base
> - * address of any flash mapping. In practice, the IO-APIC MMIO range is
> - * [0xFEE00000..0xFEE01000] -- see IO_APIC_DEFAULT_ADDRESS --, leaving free
> - * only 18MB-4KB below 4G. For now, restrict the cumulative mapping to 8MB in
> - * size.
> - */
> -#define FLASH_SIZE_LIMIT (8 * MiB)
> -
>  #define FLASH_SECTOR_SIZE 4096
>  
>  static void pc_isa_bios_init(MemoryRegion *rom_memory,
> @@ -182,10 +173,10 @@ static void pc_system_flash_map(PCMachineState *pcms,
>          }
>          if ((hwaddr)size != size
>              || total_size > HWADDR_MAX - size
> -            || total_size + size > FLASH_SIZE_LIMIT) {
> +            || total_size + size > pcms->max_fw_size) {
>              error_report("combined size of system firmware exceeds "
>                           "%" PRIu64 " bytes",
> -                         FLASH_SIZE_LIMIT);
> +                         pcms->max_fw_size);
>              exit(1);
>          }
>  
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index fe52e165b2..f7c8e7cbfe 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -43,6 +43,7 @@ struct PCMachineState {
>      bool smbus_enabled;
>      bool sata_enabled;
>      bool pit_enabled;
> +    uint64_t max_fw_size;
>  
>      /* NUMA information: */
>      uint64_t numa_nodes;
> @@ -59,6 +60,7 @@ struct PCMachineState {
>  #define PC_MACHINE_SMBUS            "smbus"
>  #define PC_MACHINE_SATA             "sata"
>  #define PC_MACHINE_PIT              "pit"
> +#define PC_MACHINE_MAX_FW_SIZE      "max-fw-size"
>  
>  /**
>   * PCMachineClass:
> 


