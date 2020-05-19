Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD792C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 13:20:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80739204EA
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 13:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FJt3aGXZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80739204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb2Aj-0007mp-Nz
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 09:20:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59008)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jb29y-0006uA-JD
 for qemu-devel@nongnu.org; Tue, 19 May 2020 09:19:54 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21583
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jb29x-0006xH-RV
 for qemu-devel@nongnu.org; Tue, 19 May 2020 09:19:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589894393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hl2dg43Jii3KB43oZp3taiRUucBPwKse1O/hnFMMjU8=;
 b=FJt3aGXZTbMtarm9YJbV7u6UAGz0tkaWta8CjRDLZFnCecMMoOrYZZSkt9D9S4f83noASv
 kIu+bRhg7OxvdYOWhU8FFJawXWuWsLMe6TdKsNVqNC/ojder4aHKkIx7ImeyCEy05i1mEs
 nvS4qCRcHjPYo37xzKRVevj322xdsiI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-MzRAC2vmOWi-hlWieh19Xg-1; Tue, 19 May 2020 09:19:49 -0400
X-MC-Unique: MzRAC2vmOWi-hlWieh19Xg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A26D8BFC2;
 Tue, 19 May 2020 13:19:47 +0000 (UTC)
Received: from gondolin (ovpn-112-229.ams2.redhat.com [10.36.112.229])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5C3F760BE1;
 Tue, 19 May 2020 13:19:39 +0000 (UTC)
Date: Tue, 19 May 2020 15:19:36 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Collin Walling <walling@linux.ibm.com>
Subject: Re: [PATCH v2 3/8] s390/sclp: rework sclp boundary and length checks
Message-ID: <20200519151936.1071fa14.cohuck@redhat.com>
In-Reply-To: <e8dd0421-0db6-ff92-43af-6fd082d76e7e@linux.ibm.com>
References: <20200515222032.18838-1-walling@linux.ibm.com>
 <20200515222032.18838-4-walling@linux.ibm.com>
 <2fcd0d94-12c7-e3b8-d6a6-3c512ae25150@linux.ibm.com>
 <e8dd0421-0db6-ff92-43af-6fd082d76e7e@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 23:19:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: thuth@redhat.com, Janosch Frank <frankja@linux.ibm.com>, david@redhat.com,
 mst@redhat.com, qemu-devel@nongnu.org, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, svens@linux.ibm.com,
 pbonzini@redhat.com, mihajlov@linux.ibm.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 18 May 2020 11:15:07 -0400
Collin Walling <walling@linux.ibm.com> wrote:

> On 5/18/20 4:50 AM, Janosch Frank wrote:
> > On 5/16/20 12:20 AM, Collin Walling wrote:  
> >> Rework the SCLP boundary check to account for different SCLP commands
> >> (eventually) allowing different boundary sizes.
> >>
> >> Move the length check code into a separate function, and introduce a
> >> new function to determine the length of the read SCP data (i.e. the size
> >> from the start of the struct to where the CPU entries should begin).
> >>
> >> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> >> ---
> >>  hw/s390x/sclp.c | 57 ++++++++++++++++++++++++++++++++++++++++++-------
> >>  1 file changed, 49 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
> >> index 2bd618515e..987699e3c4 100644
> >> --- a/hw/s390x/sclp.c
> >> +++ b/hw/s390x/sclp.c
> >> @@ -49,6 +49,34 @@ static inline bool sclp_command_code_valid(uint32_t code)
> >>      return false;
> >>  }
> >>  
> >> +static bool sccb_has_valid_boundary(uint64_t sccb_addr, uint32_t code,
> >> +                                    SCCBHeader *header)
> >> +{
> >> +    uint64_t current_len = sccb_addr + be16_to_cpu(header->length);
> >> +    uint64_t allowed_len = (sccb_addr & PAGE_MASK) + PAGE_SIZE;  
> > 
> > Those are addresses not length indications and the names should reflect
> > that.  
> 
> True
> 
> > Also don't we need to use PAGE_SIZE - 1?
> >   
> 
> Technically we need to -1 on both sides since length denotes the size of
> the sccb in bytes, not the max address.
> 
> How about this:
> 
> s/current_len/sccb_max_addr
> s/allowed_len/sccb_boundary

+1, like the names.

> 
> -1 to sccb_max_addr
> 
> Change the check to: sccb_max_addr < sccb_boundary
> 
> ?
> 
> > I'm still trying to wake up, so take this with a grain of salt.
> >   
> 
> No worries. I appreciate the review nonetheless :)
> 
> >> +
> >> +    switch (code & SCLP_CMD_CODE_MASK) {
> >> +    default:
> >> +        if (current_len <= allowed_len) {
> >> +            return true;
> >> +        }
> >> +    }
> >> +    header->response_code = cpu_to_be16(SCLP_RC_SCCB_BOUNDARY_VIOLATION);
> >> +    return false;
> >> +}
> >> +
> >> +/* Calculates sufficient SCCB length to store a full Read SCP/CPU response */
> >> +static bool sccb_has_sufficient_len(SCCB *sccb, int num_cpus, int data_len)
> >> +{
> >> +    int required_len = data_len + num_cpus * sizeof(CPUEntry);
> >> +
> >> +    if (be16_to_cpu(sccb->h.length) < required_len) {
> >> +        sccb->h.response_code = cpu_to_be16(SCLP_RC_INSUFFICIENT_SCCB_LENGTH);
> >> +        return false;
> >> +    }
> >> +    return true;
> >> +}  
> > 
> > Hm, from the function name alone I'd not have expected it to also set
> > the response code.
> >   
> 
> It also sets the required length in the header for an extended-length
> sccb. Perhaps this function name doesn't hold up well.
> 
> Does sccb_check_sufficient_len make more sense?

To me it does.

> 
> I think the same could be said of the boundary check function, which
> also sets the response code.
> 
> What about setting the response code outside the function, similar to
> what sclp_comand_code_valid does?

Whatever results in the least code churn to make it consistent ;)

> 
> >> +
> >>  static void prepare_cpu_entries(MachineState *ms, CPUEntry *entry, int *count)
> >>  {
> >>      uint8_t features[SCCB_CPU_FEATURE_LEN] = { 0 };
> >> @@ -66,6 +94,16 @@ static void prepare_cpu_entries(MachineState *ms, CPUEntry *entry, int *count)
> >>      }
> >>  }
> >>  
> >> +/*
> >> + * The data length denotes the start of the struct to where the first
> >> + * CPU entry is to be allocated. This value also denotes the offset_cpu
> >> + * field.
> >> + */
> >> +static int get_read_scp_info_data_len(void)
> >> +{
> >> +    return offsetof(ReadInfo, entries);
> >> +}  
> > 
> > Not sure what the policy for this is, but maybe this can go into a
> > header file?
> > David and Conny will surely make that clear to me :)
> >   
> 
> Not sure either. If anything it might be a good candidate for an inline
> function.

If we don't process read info outside of this file, no need to move it
to a header. The compiler is probably also smart enough to inline it on
its own, I guess.


