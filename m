Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35557C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 12:15:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F16C820880
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 12:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L7E7Ecgs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F16C820880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaIi2-0008Ik-3f
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 07:15:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47748)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iaIdc-0006Yf-8j
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 07:11:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iaIdX-0001mZ-0Q
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 07:11:08 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51379
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iaIdP-0001gI-Md
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 07:11:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574943056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IcOTShTzNH51K20qkT6gVoOQLU5XDHXi0kWmB4ENlMY=;
 b=L7E7EcgsNL2ne7x+m+MOdrtNXL1DWbIJICVgtVHGMSFPc8M+mg1XwQmeldU5i5LsUTEGKa
 Cer4VkJxowW5mm+CA5OqW2BAtrDDQGjcz1g7RpWFpzl/9PQNLDvTkx7BRWl15QE8aYDP6C
 pv0hM/+J0qR5AeMDqA3v95cWl/bZ92w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-PW0ao81fNqOuwSWmmp9OFw-1; Thu, 28 Nov 2019 07:10:53 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B23C163CC1;
 Thu, 28 Nov 2019 12:10:51 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-114.ams2.redhat.com [10.36.116.114])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C0FBE19C4F;
 Thu, 28 Nov 2019 12:10:46 +0000 (UTC)
Subject: Re: [PATCH v1 1/1] s390x: protvirt: SCLP interpretation
To: Pierre Morel <pmorel@linux.ibm.com>, qemu-s390x@nongnu.org
References: <1574935984-16910-1-git-send-email-pmorel@linux.ibm.com>
 <1574935984-16910-2-git-send-email-pmorel@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e73fcc10-14cd-512e-56c7-ca17bcbefff8@redhat.com>
Date: Thu, 28 Nov 2019 13:10:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1574935984-16910-2-git-send-email-pmorel@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: PW0ao81fNqOuwSWmmp9OFw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com,
 qemu-devel@nongnu.org, borntraeger@de.ibm.com, mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28/11/2019 11.13, Pierre Morel wrote:
> The SCLP protection handle some of the exceptions due to
> mis-constructions of the SCLP Control Block (SCCB) by the guest and
> provides notifications to the host when something gets wrong.
> We currently do not handle these exceptions, letting all the work to the
> firmware therefor, we only need to inject an external interrupt to the
> guest.
> 
> When the SCCB is correct, the S390x virtualisation protection copies
> the SCLP Control Block (SCCB) from the guest inside the kernel to avoid
> opening a direct access to the guest memory.
> When accessing the kernel memory with standard s390_cpu_virt_mem_*
> functions the host opens access to the SCCB shadow at address 0.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>   hw/s390x/sclp.c         | 18 +++++++++++++
>   include/hw/s390x/sclp.h |  2 ++
>   target/s390x/kvm.c      | 56 ++++++++++++++++++++++++++++++++++++++++-
>   3 files changed, 75 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
> index f57ce7b739..02e4e0146f 100644
> --- a/hw/s390x/sclp.c
> +++ b/hw/s390x/sclp.c
> @@ -193,6 +193,24 @@ static void sclp_execute(SCLPDevice *sclp, SCCB *sccb, uint32_t code)
>       }
>   }
>   
> +int sclp_service_call_protected(CPUS390XState *env, uint64_t sccb,
> +                                uint32_t code)
> +{
> +    SCLPDevice *sclp = get_sclp_device();
> +    SCLPDeviceClass *sclp_c = SCLP_GET_CLASS(sclp);
> +    SCCB work_sccb;
> +    hwaddr sccb_len = sizeof(SCCB);
> +
> +    /* Protected guest SCCB is always seen at address 0 */

Well, as far as I've understood it, the address is rather ignored (and 
you can only specify an offset into the 4k page)?

> +    s390_cpu_virt_mem_read(env_archcpu(env), 0, 0, &work_sccb, sccb_len);
> +    sclp_c->execute(sclp, &work_sccb, code);
> +    s390_cpu_virt_mem_write(env_archcpu(env), 0, 0, &work_sccb,
> +                            be16_to_cpu(work_sccb.h.length));
> +
> +    sclp_c->service_interrupt(sclp, (uint64_t)&work_sccb);
> +    return 0;
> +}
> +
>   int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code)
>   {
>       SCLPDevice *sclp = get_sclp_device();
> diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
> index c54413b78c..c0a3faa37d 100644
> --- a/include/hw/s390x/sclp.h
> +++ b/include/hw/s390x/sclp.h
> @@ -217,5 +217,7 @@ void s390_sclp_init(void);
>   void sclp_service_interrupt(uint32_t sccb);
>   void raise_irq_cpu_hotplug(void);
>   int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code);
> +int sclp_service_call_protected(CPUS390XState *env, uint64_t sccb,
> +                                uint32_t code);
>   
>   #endif
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index 0c9d14b4b1..559f470f51 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -1170,7 +1170,14 @@ static int kvm_sclp_service_call(S390CPU *cpu, struct kvm_run *run,
>       sccb = env->regs[ipbh0 & 0xf];
>       code = env->regs[(ipbh0 & 0xf0) >> 4];
>   
> -    r = sclp_service_call(env, sccb, code);
> +    switch (run->s390_sieic.icptcode) {
> +    case ICPT_PV_INSTR:
> +        r = sclp_service_call_protected(env, sccb, code);
> +        break;
> +    default:
> +        r = sclp_service_call(env, sccb, code);
> +        break;
> +    }

Why not simply

     if (run->s390_sieic.icptcode == ICPT_PV_INSTR) {
         r = sclp_service_call_protected(env, sccb, code);
     } else {
         r = sclp_service_call(env, sccb, code);
     }

... that's way short and easier to read. Or do you expect other 
icptcodes in the near future?

>       if (r < 0) {
>           kvm_s390_program_interrupt(cpu, -r);
>       } else {
> @@ -1575,6 +1582,47 @@ static int kvm_s390_handle_sigp(S390CPU *cpu, uint8_t ipa1, uint32_t ipb)
>       return 0;
>   }
>   
> +static int handle_secure_notification(S390CPU *cpu, struct kvm_run *run)
> +{
> +    unsigned int ipa0 = (run->s390_sieic.ipa & 0xff00);
> +    uint8_t ipa1 = run->s390_sieic.ipa & 0x00ff;
> +
> +    switch (ipa0) {
> +    case IPA0_SIGP: /* We get the notification that the guest stop */
> +        kvm_s390_handle_sigp(cpu, ipa1, run->s390_sieic.ipb);
> +        break;
> +    case IPA0_B2: /* We accept but do nothing for B2 notifications */
> +        break;
> +    default: /* We do not expect other instruction's notification */
> +        kvm_s390_program_interrupt(cpu, PGM_OPERATION);

Maybe add a tracepoint or qemu_log_mask(LOG_UNIMP, ...) or CPU_LOG_INT 
here, so we can spot this condition more easily?

> +        break;
> +    }
> +    return 0;
> +}
> +
> +static int handle_secure_instruction(S390CPU *cpu, struct kvm_run *run)
> +{
> +    unsigned int ipa0 = (run->s390_sieic.ipa & 0xff00);
> +    uint8_t ipa1 = run->s390_sieic.ipa & 0x00ff;
> +    int r = -1;
> +
> +    switch (ipa0) {
> +    case IPA0_B2:
> +        r = handle_b2(cpu, run, ipa1);
> +        break;
> +    case IPA0_DIAG:
> +        r = handle_diag(cpu, run, run->s390_sieic.ipb);
> +        break;
> +    }
> +
> +    if (r < 0) {
> +        r = 0;
> +        kvm_s390_program_interrupt(cpu, PGM_OPERATION);
> +    }
> +
> +    return r;
> +}
> +
>   static int handle_instruction(S390CPU *cpu, struct kvm_run *run)
>   {
>       unsigned int ipa0 = (run->s390_sieic.ipa & 0xff00);
> @@ -1665,6 +1713,12 @@ static int handle_intercept(S390CPU *cpu)
>       DPRINTF("intercept: 0x%x (at 0x%lx)\n", icpt_code,
>               (long)cs->kvm_run->psw_addr);
>       switch (icpt_code) {
> +         case ICPT_PV_INSTR_NOT:
> +            r = handle_secure_notification(cpu, run);
> +            break;
> +        case ICPT_PV_INSTR:
> +            r = handle_secure_instruction(cpu, run);
> +            break;
>           case ICPT_INSTRUCTION:
>               r = handle_instruction(cpu, run);
>               break;
> 

  Thomas


