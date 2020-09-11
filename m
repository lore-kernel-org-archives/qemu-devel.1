Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE1ECC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 10:25:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A02120575
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 10:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W6SogusC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A02120575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGgFZ-0002qO-8Z
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 06:25:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kGgEV-000211-6F
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 06:24:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26667
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kGgET-0007dm-Jp
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 06:24:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599819880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gUoVZkpMK8D/S7Ye0pS5eEGndLMIe1JAMsxRMJNj/yU=;
 b=W6SogusCmUwCjLbfU+Rm4wo+7KGfCVt8PI528x4Vyh+zYBi8fuhhsUkb9zVr4hKSC045cu
 W14Q0sAvK9eal7sM4C6l2G8WRHUud+SH/iv5R7lvGiInshgNy7JuaaCokrVAH9VBEVglKW
 vs4/e2bct30tzjHI7j0HMacc4XpVFZA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-B2Uun85-MISrldppdHvBOQ-1; Fri, 11 Sep 2020 06:24:37 -0400
X-MC-Unique: B2Uun85-MISrldppdHvBOQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7132C18BFEC0;
 Fri, 11 Sep 2020 10:24:35 +0000 (UTC)
Received: from gondolin (ovpn-112-170.ams2.redhat.com [10.36.112.170])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1A0EA10013BD;
 Fri, 11 Sep 2020 10:24:26 +0000 (UTC)
Date: Fri, 11 Sep 2020 12:24:24 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v5 2/8] s390/sclp: rework sclp boundary checks
Message-ID: <20200911122424.582340f4.cohuck@redhat.com>
In-Reply-To: <4c495858-c7aa-2e12-ef2b-26952019e8ef@redhat.com>
References: <20200910093655.255774-1-walling@linux.ibm.com>
 <20200910093655.255774-3-walling@linux.ibm.com>
 <4c495858-c7aa-2e12-ef2b-26952019e8ef@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 03:28:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Collin Walling <walling@linux.ibm.com>, frankja@linux.ibm.com,
 mst@redhat.com, david@redhat.com, qemu-devel@nongnu.org, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, pbonzini@redhat.com,
 sumanthk@linux.ibm.com, mihajlov@linux.ibm.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 10 Sep 2020 19:45:01 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 10/09/2020 11.36, Collin Walling wrote:
> > Rework the SCLP boundary check to account for different SCLP commands
> > (eventually) allowing different boundary sizes.
> > 
> > Signed-off-by: Collin Walling <walling@linux.ibm.com>
> > Acked-by: Janosch Frank <frankja@linux.ibm.com>
> > Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> >  hw/s390x/sclp.c | 19 ++++++++++++++++++-
> >  1 file changed, 18 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
> > index 28b973de8f..69a8724dc7 100644
> > --- a/hw/s390x/sclp.c
> > +++ b/hw/s390x/sclp.c
> > @@ -49,6 +49,18 @@ static inline bool sclp_command_code_valid(uint32_t code)
> >      return false;
> >  }
> >  
> > +static bool sccb_verify_boundary(uint64_t sccb_addr, uint16_t len)  
> 
> Maybe it would be good to add a comment in front of the function to say
> that len must be big endian?

What about renaming it to sccb_h_len or so? That would make it more
clear that the parameter is not just some random length.

> 
>  Thomas
> 
> > +{
> > +    uint64_t sccb_max_addr = sccb_addr + be16_to_cpu(len) - 1;
> > +    uint64_t sccb_boundary = (sccb_addr & PAGE_MASK) + PAGE_SIZE;
> > +
> > +    if (sccb_max_addr < sccb_boundary) {
> > +        return true;
> > +    }
> > +
> > +    return false;
> > +}
> > +
> >  static void prepare_cpu_entries(MachineState *ms, CPUEntry *entry, int *count)
> >  {
> >      uint8_t features[SCCB_CPU_FEATURE_LEN] = { 0 };
> > @@ -229,6 +241,11 @@ int sclp_service_call_protected(CPUS390XState *env, uint64_t sccb,
> >          goto out_write;
> >      }
> >  
> > +    if (!sccb_verify_boundary(sccb, work_sccb.h.length)) {

...name inspired by the 'h' in here.

> > +        work_sccb.h.response_code = cpu_to_be16(SCLP_RC_SCCB_BOUNDARY_VIOLATION);
> > +        goto out_write;
> > +    }
> > +
> >      sclp_c->execute(sclp, &work_sccb, code);
> >  out_write:
> >      s390_cpu_pv_mem_write(env_archcpu(env), 0, &work_sccb,
> > @@ -274,7 +291,7 @@ int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code)
> >          goto out_write;
> >      }
> >  
> > -    if ((sccb + be16_to_cpu(work_sccb.h.length)) > ((sccb & PAGE_MASK) + PAGE_SIZE)) {
> > +    if (!sccb_verify_boundary(sccb, work_sccb.h.length)) {
> >          work_sccb.h.response_code = cpu_to_be16(SCLP_RC_SCCB_BOUNDARY_VIOLATION);
> >          goto out_write;
> >      }
> >   
> 


