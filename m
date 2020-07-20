Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9426FC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 08:18:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F5F82080D
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 08:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BZq3Siba"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F5F82080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxR0d-0005N4-KE
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 04:18:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jxR05-0004w0-3a
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 04:18:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23839
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jxR03-0000uD-GD
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 04:18:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595233094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=CAFfgy/pGxBoGxRYhzdwu+v3XGLt5zaQYAOTyXsAM3U=;
 b=BZq3Siba1mTw/+6M1qe0Q6OtLr64uqXqfoWF4cY+DWT9/QoBem/LgNLSQnDSqEP/EKoRu0
 pl9gk0AF0gjHvpvq9UNpAWsWbYCW+ykIYQipvXFvqdHndMreWK+e/6rLYnaUM3NTBaKQSX
 ARyJ98RABiqsc6eXPNI4GRkTNI5amOk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-JQIDuOigPAGold_lI1c9XQ-1; Mon, 20 Jul 2020 04:18:11 -0400
X-MC-Unique: JQIDuOigPAGold_lI1c9XQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 497B1800597;
 Mon, 20 Jul 2020 08:18:09 +0000 (UTC)
Received: from [10.36.114.91] (ovpn-114-91.ams2.redhat.com [10.36.114.91])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 38FB172E45;
 Mon, 20 Jul 2020 08:17:54 +0000 (UTC)
Subject: Re: [PATCH v4 3/8] s390/sclp: rework sclp boundary and length checks
To: Collin Walling <walling@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
References: <20200624202312.28349-1-walling@linux.ibm.com>
 <20200624202312.28349-4-walling@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 WNyWQQ==
Organization: Red Hat GmbH
Message-ID: <89b72ce5-39c7-3080-286a-ab6ed59afb7e@redhat.com>
Date: Mon, 20 Jul 2020 10:17:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200624202312.28349-4-walling@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=david@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 03:17:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: thuth@redhat.com, frankja@linux.ibm.com, mst@redhat.com, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, svens@linux.ibm.com,
 pbonzini@redhat.com, mihajlov@linux.ibm.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24.06.20 22:23, Collin Walling wrote:
> Rework the SCLP boundary check to account for different SCLP commands
> (eventually) allowing different boundary sizes.
> 
> Move the length check code into a separate function, and introduce a
> new function to determine the length of the read SCP data (i.e. the size
> from the start of the struct to where the CPU entries should begin).
> 
> The format of read CPU info is unlikely to change in the future,
> so we do not require a separate function to calculate its length.
> 
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> Acked-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  hw/s390x/sclp.c | 54 ++++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 44 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
> index 181ce04007..5899c1e3b8 100644
> --- a/hw/s390x/sclp.c
> +++ b/hw/s390x/sclp.c
> @@ -49,6 +49,34 @@ static inline bool sclp_command_code_valid(uint32_t code)
>      return false;
>  }
>  
> +static bool sccb_verify_boundary(uint64_t sccb_addr, uint32_t code,
> +                                 SCCBHeader *header)
> +{
> +    uint64_t sccb_max_addr = sccb_addr + be16_to_cpu(header->length) - 1;
> +    uint64_t sccb_boundary = (sccb_addr & PAGE_MASK) + PAGE_SIZE;
> +
> +    switch (code & SCLP_CMD_CODE_MASK) {
> +    default:
> +        if (sccb_max_addr < sccb_boundary) {
> +            return true;
> +        }
> +    }

^ what is that?

    if ((code & SCLP_CMD_CODE_MASK) && sccb_max_addr < sccb_boundary) {
        return true;
    }

> +    header->response_code = cpu_to_be16(SCLP_RC_SCCB_BOUNDARY_VIOLATION);
> +    return false;

So we return "false" on success? At least I consider that weird when
returning the bool type. Maybe make it clearer what the function indicates

"sccb_boundary_is_invalid"

or leave it named as is and switch from return value "bool" to "int",
using "0" on success and "-EINVAL" on error.

> +}
> +
> +/* Calculates sufficient SCCB length to store a full Read SCP/CPU response */
> +static bool sccb_verify_length(SCCB *sccb, int num_cpus, int offset_cpu)
> +{
> +    int required_len = offset_cpu + num_cpus * sizeof(CPUEntry);
> +
> +    if (be16_to_cpu(sccb->h.length) < required_len) {
> +        sccb->h.response_code = cpu_to_be16(SCLP_RC_INSUFFICIENT_SCCB_LENGTH);
> +        return false;
> +    }
> +    return true;
> +}
> +
>  static void prepare_cpu_entries(MachineState *ms, CPUEntry *entry, int *count)
>  {
>      uint8_t features[SCCB_CPU_FEATURE_LEN] = { 0 };
> @@ -66,6 +94,11 @@ static void prepare_cpu_entries(MachineState *ms, CPUEntry *entry, int *count)
>      }
>  }
>  
> +static inline int get_read_scp_info_offset_cpu(void)
> +{
> +    return offsetof(ReadInfo, entries);
> +}
> +
>  /* Provide information about the configuration, CPUs and storage */
>  static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
>  {
> @@ -74,17 +107,16 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
>      int cpu_count;
>      int rnsize, rnmax;
>      IplParameterBlock *ipib = s390_ipl_get_iplb();
> +    int offset_cpu = get_read_scp_info_offset_cpu();
>  
> -    if (be16_to_cpu(sccb->h.length) <
> -          (sizeof(ReadInfo) + machine->possible_cpus->len * sizeof(CPUEntry))) {
> -        sccb->h.response_code = cpu_to_be16(SCLP_RC_INSUFFICIENT_SCCB_LENGTH);
> +    if (!sccb_verify_length(sccb, machine->possible_cpus->len, offset_cpu)) {
>          return;
>      }
>  
>      /* CPU information */
>      prepare_cpu_entries(machine, read_info->entries, &cpu_count);
>      read_info->entries_cpu = cpu_to_be16(cpu_count);
> -    read_info->offset_cpu = cpu_to_be16(offsetof(ReadInfo, entries));
> +    read_info->offset_cpu = cpu_to_be16(offset_cpu);
>      read_info->highest_cpu = cpu_to_be16(machine->smp.max_cpus - 1);
>  
>      read_info->ibc_val = cpu_to_be32(s390_get_ibc_val());
> @@ -133,17 +165,16 @@ static void sclp_read_cpu_info(SCLPDevice *sclp, SCCB *sccb)
>  {
>      MachineState *machine = MACHINE(qdev_get_machine());
>      ReadCpuInfo *cpu_info = (ReadCpuInfo *) sccb;
> +    int offset_cpu = offsetof(ReadCpuInfo, entries);
>      int cpu_count;
>  
> -    if (be16_to_cpu(sccb->h.length) <
> -          (sizeof(ReadInfo) + machine->possible_cpus->len * sizeof(CPUEntry))) {
> -        sccb->h.response_code = cpu_to_be16(SCLP_RC_INSUFFICIENT_SCCB_LENGTH);
> +    if (!sccb_verify_length(sccb, machine->possible_cpus->len, offset_cpu)) {
>          return;
>      }
>  
>      prepare_cpu_entries(machine, cpu_info->entries, &cpu_count);
>      cpu_info->nr_configured = cpu_to_be16(cpu_count);
> -    cpu_info->offset_configured = cpu_to_be16(offsetof(ReadCpuInfo, entries));
> +    cpu_info->offset_configured = cpu_to_be16(offset_cpu);
>      cpu_info->nr_standby = cpu_to_be16(0);
>  
>      /* The standby offset is 16-byte for each CPU */
> @@ -229,6 +260,10 @@ int sclp_service_call_protected(CPUS390XState *env, uint64_t sccb,
>          goto out_write;
>      }
>  
> +    if (!sccb_verify_boundary(sccb, code, &work_sccb.h)) {
> +        goto out_write;
> +    }
> +
>      sclp_c->execute(sclp, &work_sccb, code);
>  out_write:
>      s390_cpu_pv_mem_write(env_archcpu(env), 0, &work_sccb,
> @@ -274,8 +309,7 @@ int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code)
>          goto out_write;
>      }
>  
> -    if ((sccb + be16_to_cpu(work_sccb.h.length)) > ((sccb & PAGE_MASK) + PAGE_SIZE)) {
> -        work_sccb.h.response_code = cpu_to_be16(SCLP_RC_SCCB_BOUNDARY_VIOLATION);
> +    if (!sccb_verify_boundary(sccb, code, &work_sccb.h)) {
>          goto out_write;
>      }
>  
> 


-- 
Thanks,

David / dhildenb


