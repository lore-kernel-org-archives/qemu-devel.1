Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57399C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 17:46:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87523206BE
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 17:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ggYP77DS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87523206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGQej-00059v-6j
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 13:46:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46290)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kGQdU-0004Ol-NY
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 13:45:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52508
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kGQdT-0004BP-7j
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 13:45:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599759926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1ze00nNtFdnBPRLR9u9O66GTEom1zlctDSs/2sjdIV0=;
 b=ggYP77DSSSKFEJoZx8MpGI4cZqAmjx0a3lSxEx4rMT6rwU9nuvaFUdaTA1yJb7894EXbOc
 q/YJGD6ozKmCsobyOr2O7qs7Bro2A5VVi9wGxCzAaHdpn2pAMTforWAYzKP8cACm1Dgz8I
 Rz2YTRE/g15bV9DgcwvVSFO6/VDPfBA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-kWiwiosXOgazHNQwwUupsg-1; Thu, 10 Sep 2020 13:45:22 -0400
X-MC-Unique: kWiwiosXOgazHNQwwUupsg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7CD26425D2;
 Thu, 10 Sep 2020 17:45:18 +0000 (UTC)
Received: from thuth.remote.csb (unknown [10.40.194.173])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 33D4A19C66;
 Thu, 10 Sep 2020 17:45:02 +0000 (UTC)
Subject: Re: [PATCH v5 2/8] s390/sclp: rework sclp boundary checks
To: Collin Walling <walling@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
References: <20200910093655.255774-1-walling@linux.ibm.com>
 <20200910093655.255774-3-walling@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <4c495858-c7aa-2e12-ef2b-26952019e8ef@redhat.com>
Date: Thu, 10 Sep 2020 19:45:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200910093655.255774-3-walling@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 08:35:50
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.576, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, mst@redhat.com,
 pbonzini@redhat.com, sumanthk@linux.ibm.com, mihajlov@linux.ibm.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/09/2020 11.36, Collin Walling wrote:
> Rework the SCLP boundary check to account for different SCLP commands
> (eventually) allowing different boundary sizes.
> 
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> Acked-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  hw/s390x/sclp.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
> index 28b973de8f..69a8724dc7 100644
> --- a/hw/s390x/sclp.c
> +++ b/hw/s390x/sclp.c
> @@ -49,6 +49,18 @@ static inline bool sclp_command_code_valid(uint32_t code)
>      return false;
>  }
>  
> +static bool sccb_verify_boundary(uint64_t sccb_addr, uint16_t len)

Maybe it would be good to add a comment in front of the function to say
that len must be big endian?

 Thomas

> +{
> +    uint64_t sccb_max_addr = sccb_addr + be16_to_cpu(len) - 1;
> +    uint64_t sccb_boundary = (sccb_addr & PAGE_MASK) + PAGE_SIZE;
> +
> +    if (sccb_max_addr < sccb_boundary) {
> +        return true;
> +    }
> +
> +    return false;
> +}
> +
>  static void prepare_cpu_entries(MachineState *ms, CPUEntry *entry, int *count)
>  {
>      uint8_t features[SCCB_CPU_FEATURE_LEN] = { 0 };
> @@ -229,6 +241,11 @@ int sclp_service_call_protected(CPUS390XState *env, uint64_t sccb,
>          goto out_write;
>      }
>  
> +    if (!sccb_verify_boundary(sccb, work_sccb.h.length)) {
> +        work_sccb.h.response_code = cpu_to_be16(SCLP_RC_SCCB_BOUNDARY_VIOLATION);
> +        goto out_write;
> +    }
> +
>      sclp_c->execute(sclp, &work_sccb, code);
>  out_write:
>      s390_cpu_pv_mem_write(env_archcpu(env), 0, &work_sccb,
> @@ -274,7 +291,7 @@ int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code)
>          goto out_write;
>      }
>  
> -    if ((sccb + be16_to_cpu(work_sccb.h.length)) > ((sccb & PAGE_MASK) + PAGE_SIZE)) {
> +    if (!sccb_verify_boundary(sccb, work_sccb.h.length)) {
>          work_sccb.h.response_code = cpu_to_be16(SCLP_RC_SCCB_BOUNDARY_VIOLATION);
>          goto out_write;
>      }
> 


