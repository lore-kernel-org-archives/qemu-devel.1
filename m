Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C869C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 14:59:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECE7B20768
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 14:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SQtZpyDr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECE7B20768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo6rm-0001ml-87
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 10:59:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46944)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jo6qS-0000km-Ok
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 10:57:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21613
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jo6qQ-000373-K7
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 10:57:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593010666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yb+B2eaLJtYlIiv8/XmIBl+1YCP1+uAy/IJLh/VXGFA=;
 b=SQtZpyDrtAwNr0bM4w7ZSixgaxg3vUquGm/V+7AmbnkhxtIGqrQhfv0cj3AlDH2WpZ1dx3
 ptT2ocKpwSn6NAlLRFre/jyiE8QSx4v3+3DCJcfITyyGegtd67VR7PV4Gsnd3RcjU1NJiI
 nd3PN9pBUnBizdRL/qYtJikSMUwnoqo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335--zZi4b4sN2SkVObnWTwylA-1; Wed, 24 Jun 2020 10:57:44 -0400
X-MC-Unique: -zZi4b4sN2SkVObnWTwylA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E661F1005512;
 Wed, 24 Jun 2020 14:57:42 +0000 (UTC)
Received: from gondolin (ovpn-112-38.ams2.redhat.com [10.36.112.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3AB5D579A3;
 Wed, 24 Jun 2020 14:57:33 +0000 (UTC)
Date: Wed, 24 Jun 2020 16:57:30 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Collin Walling <walling@linux.ibm.com>
Subject: Re: [PATCH v3 6/8] s390/sclp: add extended-length sccb support for
 kvm guest
Message-ID: <20200624165730.358a883f.cohuck@redhat.com>
In-Reply-To: <7ad94e6b-7e5e-04f6-109a-990075a1d8c2@linux.ibm.com>
References: <20200618222258.23287-1-walling@linux.ibm.com>
 <20200618222258.23287-7-walling@linux.ibm.com>
 <20200624143635.2d87c1ca.cohuck@redhat.com>
 <d627e738-7414-4c7f-52ce-4972dfc30544@redhat.com>
 <20200624145500.69f9ab24.cohuck@redhat.com>
 <7ad94e6b-7e5e-04f6-109a-990075a1d8c2@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 02:33:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Thomas Huth <thuth@redhat.com>, frankja@linux.ibm.com, david@redhat.com,
 mst@redhat.com, qemu-devel@nongnu.org, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, svens@linux.ibm.com,
 pbonzini@redhat.com, mihajlov@linux.ibm.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 24 Jun 2020 10:49:57 -0400
Collin Walling <walling@linux.ibm.com> wrote:

> On 6/24/20 8:55 AM, Cornelia Huck wrote:
> > On Wed, 24 Jun 2020 14:40:58 +0200
> > Thomas Huth <thuth@redhat.com> wrote:
> >   
> >> On 24/06/2020 14.36, Cornelia Huck wrote:  
> >>> On Thu, 18 Jun 2020 18:22:56 -0400
> >>> Collin Walling <walling@linux.ibm.com> wrote:
> >>>     
> >>>> As more features and facilities are added to the Read SCP Info (RSCPI)
> >>>> response, more space is required to store them. The space used to store
> >>>> these new features intrudes on the space originally used to store CPU
> >>>> entries. This means as more features and facilities are added to the
> >>>> RSCPI response, less space can be used to store CPU entries.
> >>>>
> >>>> With the Extended-Length SCCB (ELS) facility, a KVM guest can execute
> >>>> the RSCPI command and determine if the SCCB is large enough to store a
> >>>> complete reponse. If it is not large enough, then the required length
> >>>> will be set in the SCCB header.
> >>>>
> >>>> The caller of the SCLP command is responsible for creating a
> >>>> large-enough SCCB to store a complete response. Proper checking should
> >>>> be in place, and the caller should execute the command once-more with
> >>>> the large-enough SCCB.
> >>>>
> >>>> This facility also enables an extended SCCB for the Read CPU Info
> >>>> (RCPUI) command.
> >>>>
> >>>> When this facility is enabled, the boundary violation response cannot
> >>>> be a result from the RSCPI, RSCPI Forced, or RCPUI commands.
> >>>>
> >>>> In order to tolerate kernels that do not yet have full support for this
> >>>> feature, a "fixed" offset to the start of the CPU Entries within the
> >>>> Read SCP Info struct is set to allow for the original 248 max entries
> >>>> when this feature is disabled.
> >>>>
> >>>> Additionally, this is introduced as a CPU feature to protect the guest
> >>>> from migrating to a machine that does not support storing an extended
> >>>> SCCB. This could otherwise hinder the VM from being able to read all
> >>>> available CPU entries after migration (such as during re-ipl).
> >>>>
> >>>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> >>>> ---
> >>>>   hw/s390x/sclp.c                     | 21 ++++++++++++++++++++-
> >>>>   include/hw/s390x/sclp.h             |  1 +
> >>>>   target/s390x/cpu_features_def.inc.h |  1 +
> >>>>   target/s390x/gen-features.c         |  1 +
> >>>>   target/s390x/kvm.c                  |  8 ++++++++
> >>>>   5 files changed, 31 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
> >>>> index 0dfbe6e5ec..f7c49e339e 100644
> >>>> --- a/hw/s390x/sclp.c
> >>>> +++ b/hw/s390x/sclp.c
> >>>> @@ -56,6 +56,18 @@ static bool sccb_has_valid_boundary(uint64_t sccb_addr, uint32_t code,
> >>>>       uint64_t sccb_boundary = (sccb_addr & PAGE_MASK) + PAGE_SIZE;
> >>>>   
> >>>>       switch (code & SCLP_CMD_CODE_MASK) {
> >>>> +    case SCLP_CMDW_READ_SCP_INFO:
> >>>> +    case SCLP_CMDW_READ_SCP_INFO_FORCED:
> >>>> +    case SCLP_CMDW_READ_CPU_INFO:
> >>>> +        /*
> >>>> +         * An extended-length SCCB is only allowed for Read SCP/CPU Info and
> >>>> +         * is allowed to exceed the 4k boundary. The respective commands will
> >>>> +         * set the length field to the required length if an insufficient
> >>>> +         * SCCB length is provided.
> >>>> +         */
> >>>> +        if (s390_has_feat(S390_FEAT_EXTENDED_LENGTH_SCCB)) {
> >>>> +            return true;
> >>>> +        }    
> >>>
> >>> Add a fallthrough annotation?    
> >>
> >> ... otherwise Coverity and friends will complain later.  
> > 
> > Nod.
> >   
> 
> Something simple like...
> 
> /* without this feature, these commands must respect the 4k boundary */
> 
> ?

No, I meant something that is parsed by static checkers (/* fallthrough */
seems to be the common marker for that in QEMU). I think what the
fallthrough does is already clear enough to humans.

> 
> >>  
> >>>>       default:
> >>>>           if (sccb_max_addr < sccb_boundary) {
> >>>>               return true;


