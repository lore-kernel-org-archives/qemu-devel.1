Return-Path: <SRS0=giGJ=6X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE16C28CBC
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 04:05:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD0DD208DB
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 04:05:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD0DD208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXGjh-000152-MF
	for qemu-devel@archiver.kernel.org; Sat, 09 May 2020 00:05:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56796)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Colin.Xu@intel.com>)
 id 1jXGj1-0000e6-3q
 for qemu-devel@nongnu.org; Sat, 09 May 2020 00:04:31 -0400
Received: from mga11.intel.com ([192.55.52.93]:43712)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Colin.Xu@intel.com>)
 id 1jXGiz-00076D-KW
 for qemu-devel@nongnu.org; Sat, 09 May 2020 00:04:30 -0400
IronPort-SDR: Eb9EpJGr3NY/wDUkwxmJAcF9aqgU4YHf3np/AaCy7XeionRVAK6yKD31NQZIzR75UN89b00/3K
 9wwaAGz2gHcg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2020 21:04:26 -0700
IronPort-SDR: IGPcxBE6Skfu4/9Gvg8nFQWlJiLC6l9WgKl3d3ys9eZzLLbzc9jOvjpxQJu3iVup6Plfhh5q4v
 JlKx+te3AYoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,370,1583222400"; d="scan'208";a="462794742"
Received: from unknown (HELO [10.239.160.118]) ([10.239.160.118])
 by fmsmga006.fm.intel.com with ESMTP; 08 May 2020 21:04:24 -0700
Subject: Re: [PATCH V2] hax: Dynamic allocate vcpu state structure
To: philmd@redhat.com, pbonzini@redhat.com
References: <20200509035952.187615-1-colin.xu@intel.com>
From: Colin Xu <Colin.Xu@intel.com>
Message-ID: <d7ab2401-98f3-85a6-fd7e-5aebb27369c7@intel.com>
Date: Sat, 9 May 2020 12:04:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200509035952.187615-1-colin.xu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=192.55.52.93; envelope-from=Colin.Xu@intel.com;
 helo=mga11.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/09 00:04:26
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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
Reply-To: Colin.Xu@intel.com
Cc: bowen.wang@intel.com, qemu-devel@nongnu.org, wenchao.wang@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Bowen is no longer working on the project so continue the revising.

Sorry for the delayed reply.

On 2020-05-09 11:59, Colin Xu wrote:
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
>   target/i386/hax-all.c  | 25 +++++++++++++++++++------
>   target/i386/hax-i386.h |  5 +++--
>   2 files changed, 22 insertions(+), 8 deletions(-)
>
> diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
> index f9c83fff2547..c93bb23a446a 100644
> --- a/target/i386/hax-all.c
> +++ b/target/i386/hax-all.c
> @@ -232,10 +232,10 @@ int hax_init_vcpu(CPUState *cpu)
>       return ret;
>   }
>   
> -struct hax_vm *hax_vm_create(struct hax_state *hax)
> +struct hax_vm *hax_vm_create(struct hax_state *hax, int max_cpus)
>   {
>       struct hax_vm *vm;
> -    int vm_id = 0, ret;
> +    int vm_id = 0, ret, i;
>   
>       if (hax_invalid_fd(hax->fd)) {
>           return NULL;
> @@ -245,6 +245,11 @@ struct hax_vm *hax_vm_create(struct hax_state *hax)
>           return hax->vm;
>       }
>   
> +    if (max_cpus > HAX_MAX_VCPU) {
> +        fprintf(stderr, "Maximum VCPU number QEMU supported is %d\n", HAX_MAX_VCPU);
> +        return NULL;
> +    }
> +
>       vm = g_new0(struct hax_vm, 1);
>   
>       ret = hax_host_create_vm(hax, &vm_id);
> @@ -259,6 +264,12 @@ struct hax_vm *hax_vm_create(struct hax_state *hax)
>           goto error;
>       }
>   
> +    vm->numvcpus = max_cpus;
> +    vm->vcpus = g_new0(struct hax_vcpu_state *, vm->numvcpus);
> +    for (i = 0; i < vm->numvcpus; i++) {
> +        vm->vcpus[i] = NULL;
> +    }
> +
>       hax->vm = vm;
>       return vm;
>   
> @@ -272,12 +283,14 @@ int hax_vm_destroy(struct hax_vm *vm)
>   {
>       int i;
>   
> -    for (i = 0; i < HAX_MAX_VCPU; i++)
> +    for (i = 0; i < vm->numvcpus; i++)
>           if (vm->vcpus[i]) {
>               fprintf(stderr, "VCPU should be cleaned before vm clean\n");
>               return -1;
>           }
>       hax_close_fd(vm->fd);
> +    vm->numvcpus = 0;
> +    g_free(vm->vcpus);
>       g_free(vm);
>       hax_global.vm = NULL;
>       return 0;
> @@ -292,7 +305,7 @@ static void hax_handle_interrupt(CPUState *cpu, int mask)
>       }
>   }
>   
> -static int hax_init(ram_addr_t ram_size)
> +static int hax_init(ram_addr_t ram_size, int max_cpus)
>   {
>       struct hax_state *hax = NULL;
>       struct hax_qemu_version qversion;
> @@ -324,7 +337,7 @@ static int hax_init(ram_addr_t ram_size)
>           goto error;
>       }
>   
> -    hax->vm = hax_vm_create(hax);
> +    hax->vm = hax_vm_create(hax, max_cpus);
>       if (!hax->vm) {
>           fprintf(stderr, "Failed to create HAX VM\n");
>           ret = -EINVAL;
> @@ -352,7 +365,7 @@ static int hax_init(ram_addr_t ram_size)
>   
>   static int hax_accel_init(MachineState *ms)
>   {
> -    int ret = hax_init(ms->ram_size);
> +    int ret = hax_init(ms->ram_size, (int)ms->smp.max_cpus);
>   
>       if (ret && (ret != -ENOSPC)) {
>           fprintf(stderr, "No accelerator found.\n");
> diff --git a/target/i386/hax-i386.h b/target/i386/hax-i386.h
> index 54e9d8b057f3..7d988f81da05 100644
> --- a/target/i386/hax-i386.h
> +++ b/target/i386/hax-i386.h
> @@ -47,7 +47,8 @@ struct hax_state {
>   struct hax_vm {
>       hax_fd fd;
>       int id;
> -    struct hax_vcpu_state *vcpus[HAX_MAX_VCPU];
> +    int numvcpus;
> +    struct hax_vcpu_state **vcpus;
>   };
>   
>   #ifdef NEED_CPU_H
> @@ -58,7 +59,7 @@ int valid_hax_tunnel_size(uint16_t size);
>   /* Host specific functions */
>   int hax_mod_version(struct hax_state *hax, struct hax_module_version *version);
>   int hax_inject_interrupt(CPUArchState *env, int vector);
> -struct hax_vm *hax_vm_create(struct hax_state *hax);
> +struct hax_vm *hax_vm_create(struct hax_state *hax, int max_cpus);
>   int hax_vcpu_run(struct hax_vcpu_state *vcpu);
>   int hax_vcpu_create(int id);
>   int hax_sync_vcpu_state(CPUArchState *env, struct vcpu_state_t *state,

-- 
Best Regards,
Colin Xu


