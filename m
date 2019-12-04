Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA4AC43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 12:34:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A987C20833
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 12:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DKithmq4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A987C20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icTr6-0004HC-L8
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 07:34:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47393)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1icTIv-0006lJ-CJ
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 06:58:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1icTIq-0002tj-Fx
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 06:58:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43213
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1icTIp-0002T7-Ni
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 06:58:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575460720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=CYqdhrrb0OdwKJApQJ0Y0ftnHadkCXjJeQ98p024fK0=;
 b=DKithmq4gFaQAvvhPTdjqBENOwEnqTATV2boeb75Pz4AkNIONzviPo/agkO1I+kzxSq9an
 8aRdqpgHAU02lzn56undMkviPkSvdSnscIvNqa2HLe8RuTAcPVjgTzBgk0fAv6d8UJVK33
 NK/kPeMB+A527DcAjuSOdM/hpuya0ok=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-SbzfMQDwPyGGeXsGuU0ETQ-1; Wed, 04 Dec 2019 06:58:39 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E47EB801E53;
 Wed,  4 Dec 2019 11:58:37 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-117-39.ams2.redhat.com [10.36.117.39])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 497CD19C69;
 Wed,  4 Dec 2019 11:58:33 +0000 (UTC)
Subject: Re: [PATCH v2 08/13] s390x: protvirt: Add new VCPU reset functions
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <20191129094809.26684-1-frankja@linux.ibm.com>
 <20191129094809.26684-9-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <942e3aaa-e79a-ac02-4152-eb160e487865@redhat.com>
Date: Wed, 4 Dec 2019 12:58:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191129094809.26684-9-frankja@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: SbzfMQDwPyGGeXsGuU0ETQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: pmorel@linux.ibm.com, david@redhat.com, cohuck@redhat.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/11/2019 10.48, Janosch Frank wrote:
> CPU resets for protected guests need to be done via Ultravisor
> calls. Hence we need a way to issue these calls for each reset.
> 
> As we formerly had only one reset function and it was called for
> initial, as well as for the clear reset, we now need a new interface.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
[...]
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index b802d02ff5..5b1ed3acb4 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -154,6 +154,7 @@ static int cap_ri;
>  static int cap_gs;
>  static int cap_hpage_1m;
>  static int cap_protvirt;
> +static int cap_vcpu_resets;
>  
>  static int active_cmma;
>  
> @@ -346,6 +347,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>      cap_mem_op = kvm_check_extension(s, KVM_CAP_S390_MEM_OP);
>      cap_s390_irq = kvm_check_extension(s, KVM_CAP_S390_INJECT_IRQ);
>      cap_protvirt = kvm_check_extension(s, KVM_CAP_S390_PROTECTED);
> +    cap_vcpu_resets = kvm_check_extension(s, KVM_CAP_S390_VCPU_RESETS);
>  
>      if (!kvm_check_extension(s, KVM_CAP_S390_GMAP)
>          || !kvm_check_extension(s, KVM_CAP_S390_COW)) {
> @@ -407,20 +409,44 @@ int kvm_arch_destroy_vcpu(CPUState *cs)
>      return 0;
>  }
>  
> -void kvm_s390_reset_vcpu(S390CPU *cpu)
> +static void kvm_s390_reset_vcpu(S390CPU *cpu, unsigned long type)
>  {
>      CPUState *cs = CPU(cpu);
>  
> -    /* The initial reset call is needed here to reset in-kernel
> -     * vcpu data that we can't access directly from QEMU
> -     * (i.e. with older kernels which don't support sync_regs/ONE_REG).
> -     * Before this ioctl cpu_synchronize_state() is called in common kvm
> -     * code (kvm-all) */
> +    /*
> +     * The reset call is needed here to reset in-kernel vcpu data that
> +     * we can't access directly from QEMU (i.e. with older kernels
> +     * which don't support sync_regs/ONE_REG).  Before this ioctl
> +     * cpu_synchronize_state() is called in common kvm code
> +     * (kvm-all).
> +     */
> +    if (cap_vcpu_resets) {
> +        if (kvm_vcpu_ioctl(cs, KVM_S390_VCPU_RESET, type)) {
> +            error_report("CPU reset type %ld failed on CPU %i",
> +                         type, cs->cpu_index);
> +        }
> +        return;
> +    }
>      if (kvm_vcpu_ioctl(cs, KVM_S390_INITIAL_RESET, NULL)) {
>          error_report("Initial CPU reset failed on CPU %i", cs->cpu_index);
>      }

Don't you want to check for type != KVM_S390_VCPU_RESET_NORMAL before
doing the INITIAL_RESET here?

>  }
>  
> +void kvm_s390_reset_vcpu_initial(S390CPU *cpu)
> +{
> +    kvm_s390_reset_vcpu(cpu, KVM_S390_VCPU_RESET_INITIAL);
> +}
> +
> +void kvm_s390_reset_vcpu_clear(S390CPU *cpu)
> +{
> +    kvm_s390_reset_vcpu(cpu, KVM_S390_VCPU_RESET_CLEAR);
> +}
> +
> +void kvm_s390_reset_vcpu_normal(S390CPU *cpu)
> +{
> +    kvm_s390_reset_vcpu(cpu, KVM_S390_VCPU_RESET_NORMAL);
> +}

... otherwise this might reset more things than expected?

Or do I miss something here?

 Thomas


