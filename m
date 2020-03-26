Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A105C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 09:21:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4411320719
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 09:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FFSUbaKA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4411320719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHOhb-00067z-CU
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 05:21:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44935)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jHOgw-0005i4-M2
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 05:20:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1jHOgt-0005YO-R3
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 05:20:45 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:48267)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1jHOgt-0005Xm-GK
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 05:20:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585214442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MtOWovGTXM9BQE/pyvARWL7/LMfzbUwzlbSZaBIj6sM=;
 b=FFSUbaKAcmU+pGJK2zhMMwXXPcrbo5jyb90fhid1yfIWOaUUFwlMCYDmYrVTvgBQ1aeMAp
 e4YSeX3cH7z2N80izrbXIvfJZu5FKOnhLchGhhqF3q7z4S2UmM0ia9f9f8wVSLO7DinXSF
 MfH79dEkRoSF7JwdAF2hUbkzkm+TMSg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-s_JTECYXN_u8K826qmmXPw-1; Thu, 26 Mar 2020 05:20:40 -0400
X-MC-Unique: s_JTECYXN_u8K826qmmXPw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C8611926DA0;
 Thu, 26 Mar 2020 09:20:38 +0000 (UTC)
Received: from [10.36.113.142] (ovpn-113-142.ams2.redhat.com [10.36.113.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9837B5C1B0;
 Thu, 26 Mar 2020 09:20:33 +0000 (UTC)
Subject: Re: [PULL 006/136] vl.c: move -m parsing after memory backends has
 been processed
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
 <1582631466-13880-6-git-send-email-pbonzini@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <2cc25431-eea0-f81c-9430-56c49f6b61de@redhat.com>
Date: Thu, 26 Mar 2020 10:20:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1582631466-13880-6-git-send-email-pbonzini@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Igor Mammedov <imammedo@redhat.com>, Andrew Jones <drjones@redhat.com>,
 Gavin Shan <gshan@redhat.com>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On 2/25/20 12:48 PM, Paolo Bonzini wrote:
> From: Igor Mammedov <imammedo@redhat.com>
> 
> It will be possible for main RAM to come from memory-backend
> and we should check that size specified in -m matches the size
> of the backend and [MachineState::]ram_size also matches
> backend's size.
> 
> However -m parsing (set_memory_options()) happens before backends
> are intialized (object_create_delayed()) which complicates it.
> Consolidate set_memory_options() and assigning parsed results to
> current_machine after backends are initialized, so it would be
> possible access the initialized backend instance to compare
> sizes.
> 
> This patch only consolidates scattered places touching ram_size
> within vl.c. And follow up patch will integrate backend handling
> to set_memory_options().
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Message-Id: <20200219160953.13771-7-imammedo@redhat.com>

Unfortunately this patch breaks ARM virt memory map setting in KVM mode.
If you launch ARM virt with PCDIMM you now get

qemu-system-aarch64: -device
pc-dimm,memdev=mem1,id=dimm1,driver=pc-dimm: memory devices (e.g. for
memory hotplug) are not supported by the machine

With machvirt/KVM
configure_accelerators() calls ARM virt_kvm_type(). This function
freezes the machine memory map and computes the size of the IPA to be
supported by KVM. See:
c9650222b8 ("hw/arm/virt: Implement kvm_type function for 4.0 machine")

virt_kvm_type() uses machine memory settings. Igor's patch moves those
after the mem backend init, so the virt memory map does not properly
take into account the machine memory settings anymore.

So we need to find a way to rework this.

Thanks

Eric


> ---
>  vl.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/vl.c b/vl.c
> index 2103804..72ffc06 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2655,6 +2655,14 @@ static void set_memory_options(uint64_t *ram_slots, ram_addr_t *maxram_size,
>          exit(EXIT_FAILURE);
>      }
>  
> +    if (!xen_enabled()) {
> +        /* On 32-bit hosts, QEMU is limited by virtual address space */
> +        if (ram_size > (2047 << 20) && HOST_LONG_BITS == 32) {
> +            error_report("at most 2047 MB RAM can be simulated");
> +            exit(1);
> +        }
> +    }
> +
>      loc_pop(&loc);
>  }
>  
> @@ -3819,8 +3827,6 @@ int main(int argc, char **argv, char **envp)
>      machine_class = select_machine();
>      object_set_machine_compat_props(machine_class->compat_props);
>  
> -    set_memory_options(&ram_slots, &maxram_size, machine_class);
> -
>      os_daemonize();
>      rcu_disable_atfork();
>  
> @@ -4122,9 +4128,6 @@ int main(int argc, char **argv, char **envp)
>      machine_opts = qemu_get_machine_opts();
>      qemu_opt_foreach(machine_opts, machine_set_property, current_machine,
>                       &error_fatal);
> -    current_machine->ram_size = ram_size;
> -    current_machine->maxram_size = maxram_size;
> -    current_machine->ram_slots = ram_slots;
>  
>      /*
>       * Note: uses machine properties such as kernel-irqchip, must run
> @@ -4235,14 +4238,6 @@ int main(int argc, char **argv, char **envp)
>  
>      tpm_init();
>  
> -    if (!xen_enabled()) {
> -        /* On 32-bit hosts, QEMU is limited by virtual address space */
> -        if (ram_size > (2047 << 20) && HOST_LONG_BITS == 32) {
> -            error_report("at most 2047 MB RAM can be simulated");
> -            exit(1);
> -        }
> -    }
> -
>      blk_mig_init();
>      ram_mig_init();
>      dirty_bitmap_mig_init();
> @@ -4287,6 +4282,12 @@ int main(int argc, char **argv, char **envp)
>      if (cpu_option) {
>          current_machine->cpu_type = parse_cpu_option(cpu_option);
>      }
> +
> +    set_memory_options(&ram_slots, &maxram_size, machine_class);
> +    current_machine->ram_size = ram_size;
> +    current_machine->maxram_size = maxram_size;
> +    current_machine->ram_slots = ram_slots;
> +
>      parse_numa_opts(current_machine);
>  
>      if (machine_class->default_ram_id && current_machine->ram_size &&
> 


