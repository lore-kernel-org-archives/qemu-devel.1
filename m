Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9778C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 17:52:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1910920BED
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 17:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fh4ydkMB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1910920BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGQkQ-0004Wb-0s
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 13:52:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kGQjA-00032G-5W
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 13:51:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23730
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kGQj8-00064n-7e
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 13:51:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599760275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pP6URxAg0D7VX46Wby/EjLMI10j3Wkhm3RD1+ztHd+I=;
 b=fh4ydkMBmSjr8TDfN9+xuNaaW3mBb//UdfQEnaZvTcuij0BfHptNcAm9jxPvEXvuWCTC/k
 Y8pmajAb9lyZ+wFWR82wKGrSgreps8lVqKlwYNZpjMT4tq1c9D1EyUJs+jBWV5vPirt1Ga
 W6ntkNCfxDVM3Bs3/97c8ddwl9oNmds=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-ix2AdZaLOsyWnhVX_vTHMw-1; Thu, 10 Sep 2020 13:51:11 -0400
X-MC-Unique: ix2AdZaLOsyWnhVX_vTHMw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B612E18A2264;
 Thu, 10 Sep 2020 17:51:09 +0000 (UTC)
Received: from thuth.remote.csb (unknown [10.40.194.173])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 61E60100238C;
 Thu, 10 Sep 2020 17:51:00 +0000 (UTC)
Subject: Re: [PATCH v5 3/8] s390/sclp: read sccb from mem based on provided
 length
To: Collin Walling <walling@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
References: <20200910093655.255774-1-walling@linux.ibm.com>
 <20200910093655.255774-4-walling@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <02dabe89-8df2-90d4-c7f1-5ef951942639@redhat.com>
Date: Thu, 10 Sep 2020 19:50:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200910093655.255774-4-walling@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 09:07:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.576, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, mst@redhat.com,
 pbonzini@redhat.com, sumanthk@linux.ibm.com, mihajlov@linux.ibm.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/09/2020 11.36, Collin Walling wrote:
> The header contained within the SCCB passed to the SCLP service call
> contains the actual length of the SCCB. Instead of allocating a static
> 4K size for the work sccb, let's allow for a variable size determined
> by the value in the header. The proper checks are already in place to
> ensure the SCCB length is sufficent to store a full response and that
> the length does not cross any explicitly-set boundaries.
> 
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> ---
>  hw/s390x/event-facility.c |  2 +-
>  hw/s390x/sclp.c           | 58 ++++++++++++++++++++++-----------------
>  include/hw/s390x/sclp.h   |  2 +-
>  3 files changed, 35 insertions(+), 27 deletions(-)
> 
> diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
> index 645b4080c5..ed92ce510d 100644
> --- a/hw/s390x/event-facility.c
> +++ b/hw/s390x/event-facility.c
> @@ -213,7 +213,7 @@ static uint16_t handle_sccb_read_events(SCLPEventFacility *ef, SCCB *sccb,
>  
>      event_buf = &red->ebh;
>      event_buf->length = 0;
> -    slen = sizeof(sccb->data);
> +    slen = sccb_data_len(sccb);
>  
>      rc = SCLP_RC_NO_EVENT_BUFFERS_STORED;
>  
> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
> index 69a8724dc7..cb8e2e8ec3 100644
> --- a/hw/s390x/sclp.c
> +++ b/hw/s390x/sclp.c
> @@ -231,25 +231,30 @@ int sclp_service_call_protected(CPUS390XState *env, uint64_t sccb,
>  {
>      SCLPDevice *sclp = get_sclp_device();
>      SCLPDeviceClass *sclp_c = SCLP_GET_CLASS(sclp);
> -    SCCB work_sccb;
> -    hwaddr sccb_len = sizeof(SCCB);
> +    SCCBHeader header;
> +    SCCB *work_sccb;

I'd maybe use "g_autofree SCCB *work_sccb = NULL" so you don't have to
worry about doing the g_free() later.

> -    s390_cpu_pv_mem_read(env_archcpu(env), 0, &work_sccb, sccb_len);
> +    s390_cpu_pv_mem_read(env_archcpu(env), 0, &header, sizeof(SCCBHeader));
> +
> +    work_sccb = g_malloc0(header.length);

Please use be16_to_cpu(header.length) here as well.

> +    s390_cpu_pv_mem_read(env_archcpu(env), 0, work_sccb,
> +                         be16_to_cpu(header.length));
>  
>      if (!sclp_command_code_valid(code)) {
> -        work_sccb.h.response_code = cpu_to_be16(SCLP_RC_INVALID_SCLP_COMMAND);
> +        work_sccb->h.response_code = cpu_to_be16(SCLP_RC_INVALID_SCLP_COMMAND);
>          goto out_write;
>      }
>  
> -    if (!sccb_verify_boundary(sccb, work_sccb.h.length)) {
> -        work_sccb.h.response_code = cpu_to_be16(SCLP_RC_SCCB_BOUNDARY_VIOLATION);
> +    if (!sccb_verify_boundary(sccb, work_sccb->h.length)) {
> +        work_sccb->h.response_code = cpu_to_be16(SCLP_RC_SCCB_BOUNDARY_VIOLATION);
>          goto out_write;
>      }
>  
> -    sclp_c->execute(sclp, &work_sccb, code);
> +    sclp_c->execute(sclp, work_sccb, code);
>  out_write:
> -    s390_cpu_pv_mem_write(env_archcpu(env), 0, &work_sccb,
> -                          be16_to_cpu(work_sccb.h.length));
> +    s390_cpu_pv_mem_write(env_archcpu(env), 0, work_sccb,
> +                          be16_to_cpu(work_sccb->h.length));
> +    g_free(work_sccb);
>      sclp_c->service_interrupt(sclp, SCLP_PV_DUMMY_ADDR);
>      return 0;
>  }
> @@ -258,9 +263,8 @@ int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code)
>  {
>      SCLPDevice *sclp = get_sclp_device();
>      SCLPDeviceClass *sclp_c = SCLP_GET_CLASS(sclp);
> -    SCCB work_sccb;
> -
> -    hwaddr sccb_len = sizeof(SCCB);
> +    SCCBHeader header;
> +    SCCB *work_sccb;

Maybe g_autofree again?

>      /* first some basic checks on program checks */
>      if (env->psw.mask & PSW_MASK_PSTATE) {
> @@ -274,33 +278,37 @@ int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code)
>          return -PGM_SPECIFICATION;
>      }
>  
> +    /* the header contains the actual length of the sccb */
> +    cpu_physical_memory_read(sccb, &header, sizeof(SCCBHeader));
> +
> +    /* Valid sccb sizes */
> +    if (be16_to_cpu(header.length) < sizeof(SCCBHeader)) {
> +        return -PGM_SPECIFICATION;
> +    }
> +
>      /*
>       * we want to work on a private copy of the sccb, to prevent guests
>       * from playing dirty tricks by modifying the memory content after
>       * the host has checked the values
>       */
> -    cpu_physical_memory_read(sccb, &work_sccb, sccb_len);
> -
> -    /* Valid sccb sizes */
> -    if (be16_to_cpu(work_sccb.h.length) < sizeof(SCCBHeader)) {
> -        return -PGM_SPECIFICATION;
> -    }
> +    work_sccb = g_malloc0(header.length);

Needs be16_to_cpu again.

> +    cpu_physical_memory_read(sccb, work_sccb, be16_to_cpu(header.length));
>  
>      if (!sclp_command_code_valid(code)) {
> -        work_sccb.h.response_code = cpu_to_be16(SCLP_RC_INVALID_SCLP_COMMAND);
> +        work_sccb->h.response_code = cpu_to_be16(SCLP_RC_INVALID_SCLP_COMMAND);
>          goto out_write;
>      }
>  
> -    if (!sccb_verify_boundary(sccb, work_sccb.h.length)) {
> -        work_sccb.h.response_code = cpu_to_be16(SCLP_RC_SCCB_BOUNDARY_VIOLATION);
> +    if (!sccb_verify_boundary(sccb, work_sccb->h.length)) {
> +        work_sccb->h.response_code = cpu_to_be16(SCLP_RC_SCCB_BOUNDARY_VIOLATION);
>          goto out_write;
>      }
>  
> -    sclp_c->execute(sclp, &work_sccb, code);
> +    sclp_c->execute(sclp, work_sccb, code);
>  out_write:
> -    cpu_physical_memory_write(sccb, &work_sccb,
> -                              be16_to_cpu(work_sccb.h.length));
> -
> +    cpu_physical_memory_write(sccb, work_sccb,
> +                              be16_to_cpu(work_sccb->h.length));
> +    g_free(work_sccb);
>      sclp_c->service_interrupt(sclp, sccb);
>  
>      return 0;

 Thomas


