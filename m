Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922CFC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 09:03:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E2B22465A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 09:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MW4jDKK7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E2B22465A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBan4-0006Jo-Kw
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 05:03:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34016)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1jBali-0004lp-1M
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:01:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1jBalg-0008G1-KR
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:01:41 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38814
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1jBalg-0008Dz-F1
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:01:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583830899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gy3KmrA/CdFiSBc35JdnMIAR9x3Ci7yBj3/GpetLvAk=;
 b=MW4jDKK7UtzNkog5OilWQ92kKTVw3BmLEndm8IB3icwoOqR1iS4EWprY9uxRkP4g7MwleG
 +RXKRr73c/+df7ZAeaDAMhR3K84283tZDIqF2Jwe6yxpIH8nu2BtEy4r++dHJj1phiu96y
 h6B4EO5reHZz0Cn1sTNJcJfG/nQI980=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-7vBssEyJPGayVjFMIry5cQ-1; Tue, 10 Mar 2020 05:01:38 -0400
X-MC-Unique: 7vBssEyJPGayVjFMIry5cQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07BFF801E6D;
 Tue, 10 Mar 2020 09:01:37 +0000 (UTC)
Received: from [10.36.118.8] (unknown [10.36.118.8])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CC22719C58;
 Tue, 10 Mar 2020 09:01:35 +0000 (UTC)
Subject: Re: [PATCH v8] s390x: protvirt: SCLP interpretation
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <6b57a6b8-f864-c5f6-f53f-1ac09e95e271@redhat.com>
 <20200310084245.30954-1-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <3378680f-3dd0-1a82-68aa-c47854e2fe02@redhat.com>
Date: Tue, 10 Mar 2020 10:01:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200310084245.30954-1-frankja@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10.03.20 09:42, Janosch Frank wrote:
> SCLP for a protected guest is done over the SIDAD, so we need to use
> the s390_cpu_pv_mem_* functions to access the SIDAD instead of guest
> memory when reading/writing SCBs.
> 
> To not confuse the sclp emulation, we set 0x4000 as the SCCB address,
> since the function that injects the sclp external interrupt would
> reject a zero sccb address.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  hw/s390x/sclp.c         | 30 ++++++++++++++++++++++++++++++
>  include/hw/s390x/sclp.h |  2 ++
>  target/s390x/kvm.c      | 24 +++++++++++++++++++-----
>  3 files changed, 51 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
> index af0bfbc2ec..15dd15099c 100644
> --- a/hw/s390x/sclp.c
> +++ b/hw/s390x/sclp.c
> @@ -193,6 +193,36 @@ static void sclp_execute(SCLPDevice *sclp, SCCB *sccb, uint32_t code)
>      }
>  }
>  
> +/*
> +* We only need the address to have something valid for the
> +* service_interrupt call.
> +*/
> +#define SCLP_PV_DUMMY_ADDR 0x4000
> +int sclp_service_call_protected(CPUS390XState *env, uint64_t sccb,
> +                                uint32_t code)
> +{
> +    SCLPDevice *sclp = get_sclp_device();
> +    SCLPDeviceClass *sclp_c = SCLP_GET_CLASS(sclp);
> +    SCCB work_sccb;
> +    hwaddr sccb_len = sizeof(SCCB);
> +
> +    /*
> +     * Only a very limited amount of calls is permitted by the
> +     * Ultravisor and we support all of them, so we don't check for
> +     * them. All other specification exceptions are also interpreted
> +     * by the Ultravisor and hence never cause an exit we need to
> +     * handle.
> +     *
> +     * Setting the CC is also done by the Ultravisor.
> +     */
> +    s390_cpu_pv_mem_read(env_archcpu(env), 0, &work_sccb, sccb_len);
> +    sclp_c->execute(sclp, &work_sccb, code);
> +    s390_cpu_pv_mem_write(env_archcpu(env), 0, &work_sccb,
> +                          be16_to_cpu(work_sccb.h.length));
> +    sclp_c->service_interrupt(sclp, SCLP_PV_DUMMY_ADDR);
> +    return 0;
> +}
> +
>  int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code)
>  {
>      SCLPDevice *sclp = get_sclp_device();
> diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
> index c54413b78c..c0a3faa37d 100644
> --- a/include/hw/s390x/sclp.h
> +++ b/include/hw/s390x/sclp.h
> @@ -217,5 +217,7 @@ void s390_sclp_init(void);
>  void sclp_service_interrupt(uint32_t sccb);
>  void raise_irq_cpu_hotplug(void);
>  int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code);
> +int sclp_service_call_protected(CPUS390XState *env, uint64_t sccb,
> +                                uint32_t code);
>  
>  #endif
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index 295ed12a38..78e1b34ad5 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -1226,12 +1226,26 @@ static void kvm_sclp_service_call(S390CPU *cpu, struct kvm_run *run,
>      sccb = env->regs[ipbh0 & 0xf];
>      code = env->regs[(ipbh0 & 0xf0) >> 4];
>  
> -    r = sclp_service_call(env, sccb, code);
> -    if (r < 0) {
> -        kvm_s390_program_interrupt(cpu, -r);
> -        return;
> +    switch (run->s390_sieic.icptcode) {
> +    case ICPT_PV_INSTR_NOTIFICATION:
> +        g_assert(env->pv);
> +        /* The notification intercepts are currently handled by KVM */
> +        error_report("unexpected SCLP PV notification\n");
> +        exit(1);
> +        break;
> +    case ICPT_PV_INSTR:
> +        g_assert(env->pv);
> +        sclp_service_call_protected(env, sccb, code);
> +        break;
> +    case ICPT_INSTRUCTION:
> +        g_assert(!env->pv);
> +        r = sclp_service_call(env, sccb, code);
> +        if (r < 0) {
> +            kvm_s390_program_interrupt(cpu, -r);
> +            return;
> +        }
> +        setcc(cpu, r);
>      }
> -    setcc(cpu, r);
>  }
>  
>  static int handle_b2(S390CPU *cpu, struct kvm_run *run, uint8_t ipa1)
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb


