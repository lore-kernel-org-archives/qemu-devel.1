Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74198C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 10:18:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43A672076B
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 10:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J+d/ILjj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43A672076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5npZ-0000zo-IX
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 06:18:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53040)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1k5noN-0007pz-Uu
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 06:16:48 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49621
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1k5noM-00031I-Ew
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 06:16:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597227405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MnzlaKYNFz3iMfZp5mbtBo4BFRY9OVwtNVkAp9nZtZc=;
 b=J+d/ILjjJtR7MzADa8qNFnwuMt7D+RstKxzzhVDF1XxRMmNYuTg3GKkjvkA0/O8Gcy6rTK
 E0e4qURQRFlAXPP2G7/v+H5HsxqAmPKGjSWAMUjnMKxiUXgyr2lbzDevotl5Hd/A8viEfB
 bv/PA9UCXIu+K9Ijaf9rsicsBTtYeaY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-ryhu08r7PS6tzJ3S7RR1AQ-1; Wed, 12 Aug 2020 06:16:40 -0400
X-MC-Unique: ryhu08r7PS6tzJ3S7RR1AQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A26558017F4;
 Wed, 12 Aug 2020 10:16:39 +0000 (UTC)
Received: from [10.36.113.93] (ovpn-113-93.ams2.redhat.com [10.36.113.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A4FC55D6BD;
 Wed, 12 Aug 2020 10:16:38 +0000 (UTC)
Subject: Re: [PATCH v2 3/5] hw/arm/virt: Move post cpu realize check into its
 own function
To: Andrew Jones <drjones@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20200805091640.11134-1-drjones@redhat.com>
 <20200805091640.11134-4-drjones@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <4b456c14-5eae-aad2-45a2-5e23c5ff47f9@redhat.com>
Date: Wed, 12 Aug 2020 12:16:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200805091640.11134-4-drjones@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eric.auger@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 03:52:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Drew,

On 8/5/20 11:16 AM, Andrew Jones wrote:
> We'll add more to this new function in coming patches so we also
> state the gic must be created and call it below create_gic().
> 
> No functional change intended.
> 
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/arm/virt.c | 43 +++++++++++++++++++++++++++----------------
>  1 file changed, 27 insertions(+), 16 deletions(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index acf9bfbeceaf..2cba21fe3ad9 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1672,6 +1672,31 @@ static void finalize_gic_version(VirtMachineState *vms)
>      }
>  }
>  
> +/*
> + * virt_cpu_post_init() must be called after the CPUs have
> + * been realized and the GIC has been created.
> + */
> +static void virt_cpu_post_init(VirtMachineState *vms)
> +{
> +    bool aarch64;
> +
> +    aarch64 = object_property_get_bool(OBJECT(first_cpu), "aarch64", NULL);
> +
> +    if (!kvm_enabled()) {
> +        if (aarch64 && vms->highmem) {
> +            int requested_pa_size = 64 - clz64(vms->highest_gpa);
> +            int pamax = arm_pamax(ARM_CPU(first_cpu));
> +
> +            if (pamax < requested_pa_size) {
> +                error_report("VCPU supports less PA bits (%d) than "
> +                             "requested by the memory map (%d)",
> +                             pamax, requested_pa_size);
> +                exit(1);
> +            }
> +        }
> +    }
> +}
> +
>  static void machvirt_init(MachineState *machine)
>  {
>      VirtMachineState *vms = VIRT_MACHINE(machine);
> @@ -1886,22 +1911,6 @@ static void machvirt_init(MachineState *machine)
>      fdt_add_timer_nodes(vms);
>      fdt_add_cpu_nodes(vms);
>  
> -   if (!kvm_enabled()) {
> -        ARMCPU *cpu = ARM_CPU(first_cpu);
> -        bool aarch64 = object_property_get_bool(OBJECT(cpu), "aarch64", NULL);
> -
> -        if (aarch64 && vms->highmem) {
> -            int requested_pa_size, pamax = arm_pamax(cpu);
> -
> -            requested_pa_size = 64 - clz64(vms->highest_gpa);
> -            if (pamax < requested_pa_size) {
> -                error_report("VCPU supports less PA bits (%d) than requested "
> -                            "by the memory map (%d)", pamax, requested_pa_size);
> -                exit(1);
> -            }
> -        }
> -    }
> -
>      memory_region_add_subregion(sysmem, vms->memmap[VIRT_MEM].base,
>                                  machine->ram);
>      if (machine->device_memory) {
> @@ -1913,6 +1922,8 @@ static void machvirt_init(MachineState *machine)
>  
>      create_gic(vms);
>  
> +    virt_cpu_post_init(vms);
> +
>      fdt_add_pmu_nodes(vms);
>  
>      create_uart(vms, VIRT_UART, sysmem, serial_hd(0));
> 


