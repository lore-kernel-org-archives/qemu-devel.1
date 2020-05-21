Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54D4C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 15:12:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 690B1207D8
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 15:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g7qzrH9T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 690B1207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbmrz-0007HG-Mp
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 11:12:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38252)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbmqH-0005DI-Js
 for qemu-devel@nongnu.org; Thu, 21 May 2020 11:10:41 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27324
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbmqG-000888-IJ
 for qemu-devel@nongnu.org; Thu, 21 May 2020 11:10:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590073839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H9IjhlJKW962USl0MBaj5HFBlzIdj2BbUixPMqc3I5A=;
 b=g7qzrH9TwdzNeNE0lFyUMM1AzSlGLJOQ7dcCXQ4eJG7hrmf6mUsvEwCqfH/XOxxb5+cSgT
 ArHIPb0juS5DrjHaPECWDKwIOaf94BxjirlFhff8t2NWH744EyDijvSz6Z9l+EFDuaQTp/
 ig+4HoIcWHOO5Z7zbMwSmPstioxO5Q0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-iMxXiMKsP6eIjcxNTI3epA-1; Thu, 21 May 2020 11:10:37 -0400
X-MC-Unique: iMxXiMKsP6eIjcxNTI3epA-1
Received: by mail-wr1-f72.google.com with SMTP id g10so3039940wrr.10
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 08:10:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=H9IjhlJKW962USl0MBaj5HFBlzIdj2BbUixPMqc3I5A=;
 b=HWGoXRNMADKoEFHHOezjfXbo/z2oBHUetCtTCbxyF9FddaNCNttPccnWfjBPYqF+3C
 xjpHs1PifAGxfFrupfaMmY87ZGpyxqgqf9aKuvShPLCvFgV7UX7pt375we1fmtWscmgg
 ilxs6MRFuwkIIM1EHF2n/y0whxJlD9WfTg1p+F45sn4DXhkJvmtNyr8aUwrTIOH4w+QD
 4aE2tpKUGbgKp92Coz0RSYwiCYvXFxaKKCR0eeZ7Dmvj687fFbqrqlk5Q/X+uj7MPuOT
 fPwkdKxvSJAL0XSiFUhdDqmV0kI6d5cnUxzferpv2uXgZqLrfvivuT4hzwYxihn+nRZ8
 B1aw==
X-Gm-Message-State: AOAM532VeT4TBamM2RFyx3YJmWEzmjhq6T6dy8oaqmu8Gr8Wq5FPgBmw
 8fEm9qKAbKuXmdf8m89c56b/eBJVltdnG1UfBzhXRKRtPM2wuMMcf2SjJZaQ7c0e3P46fyjkist
 g2nsCY+YshB94H5g=
X-Received: by 2002:a7b:c4cc:: with SMTP id g12mr9128478wmk.168.1590073836456; 
 Thu, 21 May 2020 08:10:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw3g2m49T4eLZkLmPLh1XAuhnst5+JIeu3ZBAvvssU1OV5PDX+MUdFzcte5JwI7u/FyJAqQPQ==
X-Received: by 2002:a7b:c4cc:: with SMTP id g12mr9128459wmk.168.1590073836046; 
 Thu, 21 May 2020 08:10:36 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.160.154])
 by smtp.gmail.com with ESMTPSA id 40sm5558041wrc.15.2020.05.21.08.10.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2020 08:10:35 -0700 (PDT)
Subject: Re: [PATCH V2] hax: Dynamic allocate vcpu state structure
To: Colin Xu <colin.xu@intel.com>, philmd@redhat.com
References: <20200509035952.187615-1-colin.xu@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <81aacddd-d046-a6f5-0e5e-f5034cb183b7@redhat.com>
Date: Thu, 21 May 2020 17:10:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200509035952.187615-1-colin.xu@intel.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 04:44:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: bowen.wang@intel.com, qemu-devel@nongnu.org, wenchao.wang@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/05/20 05:59, Colin Xu wrote:
> From: WangBowen <bowen.wang@intel.com>
> 
> Dynamic allocating vcpu state structure according to smp value to be
> more precise and safe. Previously it will alloccate array of fixed size
> HAX_MAX_VCPU.
> 
> This is achieved by using g_new0 to dynamic allocate the array. The
> allocated size is obtained from smp.max_cpus in MachineState. Also, the
> size is compared with HAX_MAX_VCPU when creating the vm. The reason for
> choosing dynamic array over linked list is because the status is visited
> by index all the time.
> 
> This will lead to QEMU checking whether the smp value is larger than the
> HAX_MAX_VCPU when creating vm, if larger, the process will terminate,
> otherwise it will allocate array of size smp to store the status.
> 
> V2: Check max_cpus before open vm. (Philippe)
> 
> Signed-off-by: WangBowen <bowen.wang@intel.com>
> Signed-off-by: Colin Xu <colin.xu@intel.com>
> ---
>  target/i386/hax-all.c  | 25 +++++++++++++++++++------
>  target/i386/hax-i386.h |  5 +++--
>  2 files changed, 22 insertions(+), 8 deletions(-)
> 
> diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
> index f9c83fff2547..c93bb23a446a 100644
> --- a/target/i386/hax-all.c
> +++ b/target/i386/hax-all.c
> @@ -232,10 +232,10 @@ int hax_init_vcpu(CPUState *cpu)
>      return ret;
>  }
>  
> -struct hax_vm *hax_vm_create(struct hax_state *hax)
> +struct hax_vm *hax_vm_create(struct hax_state *hax, int max_cpus)
>  {
>      struct hax_vm *vm;
> -    int vm_id = 0, ret;
> +    int vm_id = 0, ret, i;
>  
>      if (hax_invalid_fd(hax->fd)) {
>          return NULL;
> @@ -245,6 +245,11 @@ struct hax_vm *hax_vm_create(struct hax_state *hax)
>          return hax->vm;
>      }
>  
> +    if (max_cpus > HAX_MAX_VCPU) {
> +        fprintf(stderr, "Maximum VCPU number QEMU supported is %d\n", HAX_MAX_VCPU);
> +        return NULL;
> +    }
> +
>      vm = g_new0(struct hax_vm, 1);
>  
>      ret = hax_host_create_vm(hax, &vm_id);
> @@ -259,6 +264,12 @@ struct hax_vm *hax_vm_create(struct hax_state *hax)
>          goto error;
>      }
>  
> +    vm->numvcpus = max_cpus;
> +    vm->vcpus = g_new0(struct hax_vcpu_state *, vm->numvcpus);
> +    for (i = 0; i < vm->numvcpus; i++) {
> +        vm->vcpus[i] = NULL;
> +    }
> +
>      hax->vm = vm;
>      return vm;
>  
> @@ -272,12 +283,14 @@ int hax_vm_destroy(struct hax_vm *vm)
>  {
>      int i;
>  
> -    for (i = 0; i < HAX_MAX_VCPU; i++)
> +    for (i = 0; i < vm->numvcpus; i++)
>          if (vm->vcpus[i]) {
>              fprintf(stderr, "VCPU should be cleaned before vm clean\n");
>              return -1;
>          }
>      hax_close_fd(vm->fd);
> +    vm->numvcpus = 0;
> +    g_free(vm->vcpus);
>      g_free(vm);
>      hax_global.vm = NULL;
>      return 0;
> @@ -292,7 +305,7 @@ static void hax_handle_interrupt(CPUState *cpu, int mask)
>      }
>  }
>  
> -static int hax_init(ram_addr_t ram_size)
> +static int hax_init(ram_addr_t ram_size, int max_cpus)
>  {
>      struct hax_state *hax = NULL;
>      struct hax_qemu_version qversion;
> @@ -324,7 +337,7 @@ static int hax_init(ram_addr_t ram_size)
>          goto error;
>      }
>  
> -    hax->vm = hax_vm_create(hax);
> +    hax->vm = hax_vm_create(hax, max_cpus);
>      if (!hax->vm) {
>          fprintf(stderr, "Failed to create HAX VM\n");
>          ret = -EINVAL;
> @@ -352,7 +365,7 @@ static int hax_init(ram_addr_t ram_size)
>  
>  static int hax_accel_init(MachineState *ms)
>  {
> -    int ret = hax_init(ms->ram_size);
> +    int ret = hax_init(ms->ram_size, (int)ms->smp.max_cpus);
>  
>      if (ret && (ret != -ENOSPC)) {
>          fprintf(stderr, "No accelerator found.\n");
> diff --git a/target/i386/hax-i386.h b/target/i386/hax-i386.h
> index 54e9d8b057f3..7d988f81da05 100644
> --- a/target/i386/hax-i386.h
> +++ b/target/i386/hax-i386.h
> @@ -47,7 +47,8 @@ struct hax_state {
>  struct hax_vm {
>      hax_fd fd;
>      int id;
> -    struct hax_vcpu_state *vcpus[HAX_MAX_VCPU];
> +    int numvcpus;
> +    struct hax_vcpu_state **vcpus;
>  };
>  
>  #ifdef NEED_CPU_H
> @@ -58,7 +59,7 @@ int valid_hax_tunnel_size(uint16_t size);
>  /* Host specific functions */
>  int hax_mod_version(struct hax_state *hax, struct hax_module_version *version);
>  int hax_inject_interrupt(CPUArchState *env, int vector);
> -struct hax_vm *hax_vm_create(struct hax_state *hax);
> +struct hax_vm *hax_vm_create(struct hax_state *hax, int max_cpus);
>  int hax_vcpu_run(struct hax_vcpu_state *vcpu);
>  int hax_vcpu_create(int id);
>  int hax_sync_vcpu_state(CPUArchState *env, struct vcpu_state_t *state,
> 

Queued, thanks.

Paolo


