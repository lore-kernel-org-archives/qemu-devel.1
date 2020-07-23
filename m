Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1991C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 19:00:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CB22206F4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 19:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FrTud4LQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CB22206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jygRq-0004EL-PL
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 15:00:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jygRE-0003nO-Bf
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 14:59:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22231
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jygRC-0005IH-IX
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 14:59:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595530766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4n75smUzC+LB5Y8IihJGE5dRwoQ1tbhaRyRp8rWR51Y=;
 b=FrTud4LQJK1c4iArNxnNdpkct9VjxmkUZsrZlW4TUcrjJqII+uNCtSqKOuFIH/BZ9Aet6t
 ot6FGDeZ9P34CHjAlATRXqKbs0o7/lBeGpt7WnZcfng8YN5QT8IQmF4W3AJvG7tPpjgCyd
 QFxHFedSMcyo2EVoxAwfChdMSXyZ2sM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-reUJeZ9lOfuIzKIJurPVZQ-1; Thu, 23 Jul 2020 14:59:24 -0400
X-MC-Unique: reUJeZ9lOfuIzKIJurPVZQ-1
Received: by mail-wr1-f72.google.com with SMTP id z1so1643928wrn.18
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 11:59:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4n75smUzC+LB5Y8IihJGE5dRwoQ1tbhaRyRp8rWR51Y=;
 b=I0q7mEjeuXjHnwWX4cBforbw68EIKLBhVwzMHWvVXfb2iEgUEir/KJ+aivyzBrmPfy
 oooO3Ajv0fkavt7qwl4/tnhpg5KCFVHLxDNAaRyLdMdgHXtGLYx3bSfwOvYo+5NYBhg8
 sxtMe7uI9C2rkkWNvO8f5CRnJP+yorShoyGh4FM0SHy05dt8c1zJ1UU82iHmTtM+u1ws
 1xnLG8jNF3LfcXUzDZTxHDh7Bd8vo6eUNKAZStN0uzUTFBG0kJwULhK2Mi1ElXHSn7/8
 t91eMvXDoKwx2Ar22/ECx9WnQUb+WlX3B0fVWPTnVBY8MJlk3bUJb0l9JhyWWahKyDQo
 GeqQ==
X-Gm-Message-State: AOAM53391++zq8Ld1vvZUC4E624eXMmBbj6VZlEY8vxH6sWVIlWWZ/rO
 D/yT7yHaEOc3tAWi7+XG6GW7PZApcqYPCrdz6OH2nps9NQVeoH2/1vyP3csMpQqD9EaGD7nB5K2
 faQKQBhsAjqZEbAI=
X-Received: by 2002:adf:bb83:: with SMTP id q3mr5715788wrg.58.1595530763203;
 Thu, 23 Jul 2020 11:59:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyX88uKSzhFLwl1Q2QVAGttK+KJ4b+z+R7GfGH76oUSobn1Dxw1YlXPMKkv+mNwtRpGMhNvvg==
X-Received: by 2002:adf:bb83:: with SMTP id q3mr5715764wrg.58.1595530762883;
 Thu, 23 Jul 2020 11:59:22 -0700 (PDT)
Received: from [192.168.1.36] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id f15sm4507708wrx.91.2020.07.23.11.59.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2020 11:59:22 -0700 (PDT)
Subject: Re: [PATCH] kvm: kvm_init_vcpu take Error pointer
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, pbonzini@redhat.com
References: <20200723160915.129069-1-dgilbert@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <66fa8c6d-8ca5-95c5-ff3e-fe6865e6cbf5@redhat.com>
Date: Thu, 23 Jul 2020 20:59:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200723160915.129069-1-dgilbert@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 22:13:02
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/23/20 6:09 PM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Clean up the error handling in kvm_init_vcpu so we can see what went
> wrong more easily.
> 
> Make it take an Error ** and fill it out with what failed, including
> the cpu id, so you can tell if it only fails at a given ID.
> 
> Replace the remaining DPRINTF by a trace.
> 
> This turns a:
> kvm_init_vcpu failed: Invalid argument
> 
> into:
> kvm_init_vcpu: kvm_get_vcpu failed (256): Invalid argument
> 
> and with the trace you then get to see:
> 
> 19049@1595520414.310107:kvm_init_vcpu index: 169 id: 212
> 19050@1595520414.310635:kvm_init_vcpu index: 170 id: 256
> qemu-system-x86_64: kvm_init_vcpu: kvm_get_vcpu failed (256): Invalid argument
> 
> which makes stuff a lot more obvious.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  accel/kvm/kvm-all.c    | 19 ++++++++++++++-----
>  accel/kvm/trace-events |  1 +
>  accel/stubs/kvm-stub.c |  2 +-
>  include/sysemu/kvm.h   |  2 +-
>  softmmu/cpus.c         |  6 +-----
>  5 files changed, 18 insertions(+), 12 deletions(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 63ef6af9a1c..0fbece977c7 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -430,17 +430,18 @@ static int kvm_get_vcpu(KVMState *s, unsigned long vcpu_id)
>      return kvm_vm_ioctl(s, KVM_CREATE_VCPU, (void *)vcpu_id);
>  }
>  
> -int kvm_init_vcpu(CPUState *cpu)
> +int kvm_init_vcpu(CPUState *cpu, Error **errp)
>  {
>      KVMState *s = kvm_state;
>      long mmap_size;
>      int ret;
>  
> -    DPRINTF("kvm_init_vcpu\n");
> +    trace_kvm_init_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
>  
>      ret = kvm_get_vcpu(s, kvm_arch_vcpu_id(cpu));
>      if (ret < 0) {
> -        DPRINTF("kvm_create_vcpu failed\n");
> +        error_setg_errno(errp, -ret, "kvm_init_vcpu: kvm_get_vcpu failed (%lu)",
> +                         kvm_arch_vcpu_id(cpu));
>          goto err;
>      }
>  
> @@ -451,7 +452,8 @@ int kvm_init_vcpu(CPUState *cpu)
>      mmap_size = kvm_ioctl(s, KVM_GET_VCPU_MMAP_SIZE, 0);
>      if (mmap_size < 0) {
>          ret = mmap_size;
> -        DPRINTF("KVM_GET_VCPU_MMAP_SIZE failed\n");
> +        error_setg_errno(errp, -mmap_size,
> +                         "kvm_init_vcpu: KVM_GET_VCPU_MMAP_SIZE failed");
>          goto err;
>      }
>  
> @@ -459,7 +461,9 @@ int kvm_init_vcpu(CPUState *cpu)
>                          cpu->kvm_fd, 0);
>      if (cpu->kvm_run == MAP_FAILED) {
>          ret = -errno;
> -        DPRINTF("mmap'ing vcpu state failed\n");
> +        error_setg_errno(errp, ret,
> +                         "kvm_init_vcpu: mmap'ing vcpu state failed (%lu)",
> +                         kvm_arch_vcpu_id(cpu));
>          goto err;
>      }
>  
> @@ -469,6 +473,11 @@ int kvm_init_vcpu(CPUState *cpu)
>      }
>  
>      ret = kvm_arch_init_vcpu(cpu);
> +    if (ret < 0) {
> +        error_setg_errno(errp, -ret,
> +                         "kvm_init_vcpu: kvm_arch_init_vcpu failed (%lu)",
> +                         kvm_arch_vcpu_id(cpu));
> +    }
>  err:
>      return ret;
>  }
> diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events
> index a68eb665343..e15ae8980d3 100644
> --- a/accel/kvm/trace-events
> +++ b/accel/kvm/trace-events
> @@ -8,6 +8,7 @@ kvm_run_exit(int cpu_index, uint32_t reason) "cpu_index %d, reason %d"
>  kvm_device_ioctl(int fd, int type, void *arg) "dev fd %d, type 0x%x, arg %p"
>  kvm_failed_reg_get(uint64_t id, const char *msg) "Warning: Unable to retrieve ONEREG %" PRIu64 " from KVM: %s"
>  kvm_failed_reg_set(uint64_t id, const char *msg) "Warning: Unable to set ONEREG %" PRIu64 " to KVM: %s"
> +kvm_init_vcpu(int cpu_index, unsigned long arch_cpu_id) "index: %d id: %lu"
>  kvm_irqchip_commit_routes(void) ""
>  kvm_irqchip_add_msi_route(char *name, int vector, int virq) "dev %s vector %d virq %d"
>  kvm_irqchip_update_msi_route(int virq) "Updating MSI route virq=%d"
> diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
> index 82f118d2df9..cd573bfe3d9 100644
> --- a/accel/stubs/kvm-stub.c
> +++ b/accel/stubs/kvm-stub.c
> @@ -37,7 +37,7 @@ int kvm_destroy_vcpu(CPUState *cpu)
>      return -ENOSYS;
>  }
>  
> -int kvm_init_vcpu(CPUState *cpu)
> +int kvm_init_vcpu(CPUState *cpu, Error **errp)
>  {
>      return -ENOSYS;
>  }
> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> index b4174d941c2..410848af514 100644
> --- a/include/sysemu/kvm.h
> +++ b/include/sysemu/kvm.h
> @@ -216,7 +216,7 @@ int kvm_has_many_ioeventfds(void);
>  int kvm_has_gsi_routing(void);
>  int kvm_has_intx_set_mask(void);
>  
> -int kvm_init_vcpu(CPUState *cpu);
> +int kvm_init_vcpu(CPUState *cpu, Error **errp);
>  int kvm_cpu_exec(CPUState *cpu);
>  int kvm_destroy_vcpu(CPUState *cpu);
>  
> diff --git a/softmmu/cpus.c b/softmmu/cpus.c
> index a802e899abb..9725fd9951f 100644
> --- a/softmmu/cpus.c
> +++ b/softmmu/cpus.c
> @@ -1170,11 +1170,7 @@ static void *qemu_kvm_cpu_thread_fn(void *arg)
>      cpu->can_do_io = 1;
>      current_cpu = cpu;
>  
> -    r = kvm_init_vcpu(cpu);
> -    if (r < 0) {
> -        error_report("kvm_init_vcpu failed: %s", strerror(-r));
> -        exit(1);
> -    }
> +    kvm_init_vcpu(cpu, &error_fatal);
>  
>      kvm_init_cpu_signals(cpu);
>  
> 


