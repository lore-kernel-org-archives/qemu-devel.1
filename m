Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1249C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 12:03:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF07A206C3
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 12:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WP/+/D3x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF07A206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjLvH-0000Rx-VB
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 08:03:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59928)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jjLuH-000846-Mw
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 08:02:06 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25700
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jjLuD-0006lJ-Uz
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 08:02:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591876920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=3s8TL4z4sxSRXsRdj82LLaBpF8GrjlwtWTIc93f4+zw=;
 b=WP/+/D3xkLc7hZbjNV8dDyWajDzzH3nlFSR/MlPwG1H8pjmn46q6hyWjy+cJgyF3cIoxiw
 rn1uY+U0VyXKaXBpmqNG5eEvnP+pmfIvQeVzb98Z+8be7ZezMjGr7ckaIksLhPnW4yNp4y
 HNnG4NOvh0qtAj/eQe5kagYg4CsazEo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-59Z0WTYMP0S1FrqTh-CKdQ-1; Thu, 11 Jun 2020 08:01:59 -0400
X-MC-Unique: 59Z0WTYMP0S1FrqTh-CKdQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A8B2B1054F90;
 Thu, 11 Jun 2020 12:01:57 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-114-175.ams2.redhat.com [10.36.114.175])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C0A73891E2;
 Thu, 11 Jun 2020 12:01:54 +0000 (UTC)
Subject: Re: [PATCH v2 2/8] s390/sclp: check sccb len before filling in data
To: Collin Walling <walling@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
References: <20200515222032.18838-1-walling@linux.ibm.com>
 <20200515222032.18838-3-walling@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <ad9bd716-745b-210f-8716-46043ca1b110@redhat.com>
Date: Thu, 11 Jun 2020 14:01:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200515222032.18838-3-walling@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 03:29:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 svens@linux.ibm.com, pbonzini@redhat.com, mihajlov@linux.ibm.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/05/2020 00.20, Collin Walling wrote:
> The SCCB must be checked for a sufficient length before it is filled
> with any data. If the length is insufficient, then the SCLP command
> is suppressed and the proper response code is set in the SCCB header.
> 
> Fixes: 832be0d8a3bb ("s390x: sclp: Report insufficient SCCB length")
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> ---
>  hw/s390x/sclp.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
> index 61e2e2839c..2bd618515e 100644
> --- a/hw/s390x/sclp.c
> +++ b/hw/s390x/sclp.c
> @@ -75,6 +75,11 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
>      int rnsize, rnmax;
>      IplParameterBlock *ipib = s390_ipl_get_iplb();
>  
> +    if (be16_to_cpu(sccb->h.length) < (sizeof(ReadInfo) + cpu_count * sizeof(CPUEntry))) {

You are using cpu_count here ...

> +        sccb->h.response_code = cpu_to_be16(SCLP_RC_INSUFFICIENT_SCCB_LENGTH);
> +        return;
> +    }
> +
>      /* CPU information */
>      prepare_cpu_entries(machine, read_info->entries, &cpu_count);

... but it is only initialized here.

Even if you replace the code in a later patch, please fix this here,
too, to maintain bisectability of the code.

>      read_info->entries_cpu = cpu_to_be16(cpu_count);
> @@ -83,12 +88,6 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
>  
>      read_info->ibc_val = cpu_to_be32(s390_get_ibc_val());
>  
> -    if (be16_to_cpu(sccb->h.length) <
> -            (sizeof(ReadInfo) + cpu_count * sizeof(CPUEntry))) {
> -        sccb->h.response_code = cpu_to_be16(SCLP_RC_INSUFFICIENT_SCCB_LENGTH);
> -        return;
> -    }
> -
>      /* Configuration Characteristic (Extension) */
>      s390_get_feat_block(S390_FEAT_TYPE_SCLP_CONF_CHAR,
>                           read_info->conf_char);
> @@ -135,17 +134,16 @@ static void sclp_read_cpu_info(SCLPDevice *sclp, SCCB *sccb)
>      ReadCpuInfo *cpu_info = (ReadCpuInfo *) sccb;
>      int cpu_count;
>  
> +    if (be16_to_cpu(sccb->h.length) < (sizeof(ReadCpuInfo) + cpu_count * sizeof(CPUEntry))) {

dito!

> +        sccb->h.response_code = cpu_to_be16(SCLP_RC_INSUFFICIENT_SCCB_LENGTH);
> +        return;
> +    }
> +
>      prepare_cpu_entries(machine, cpu_info->entries, &cpu_count);
>      cpu_info->nr_configured = cpu_to_be16(cpu_count);
>      cpu_info->offset_configured = cpu_to_be16(offsetof(ReadCpuInfo, entries));
>      cpu_info->nr_standby = cpu_to_be16(0);
>  
> -    if (be16_to_cpu(sccb->h.length) <
> -            (sizeof(ReadCpuInfo) + cpu_count * sizeof(CPUEntry))) {
> -        sccb->h.response_code = cpu_to_be16(SCLP_RC_INSUFFICIENT_SCCB_LENGTH);
> -        return;
> -    }
> -
>      /* The standby offset is 16-byte for each CPU */
>      cpu_info->offset_standby = cpu_to_be16(cpu_info->offset_configured
>          + cpu_info->nr_configured*sizeof(CPUEntry));

 Thanks,
  Thomas


