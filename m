Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6912AC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 09:20:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 262EF2078D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 09:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YMxa2YBh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 262EF2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtpD4-0000k7-6V
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 05:20:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44388)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jtpCA-0000AB-91
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 05:19:50 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51976
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jtpC8-0003L9-NV
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 05:19:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594372788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zLjp3rqy0dxlWJGbvkvBlrK6sA7P6QlJ9jm2hvXfLKY=;
 b=YMxa2YBhN3jFCNzcWsFfLRWEA2pTSOTGuQIKTUPNiO7sSawe0emDJCa6miNKM8sQLoPL8U
 K92F1ZGYfsvNWkR2EwNtu4tVHRQcgb5ihkBgYjkmX0sEWkj06xEpg091k1YlXCwQi0L2Pk
 hst2sgmghSX8IGLhDtgyiXbjkCL52JM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-vQC0pZ0GNfmQE38xKvnPig-1; Fri, 10 Jul 2020 05:19:46 -0400
X-MC-Unique: vQC0pZ0GNfmQE38xKvnPig-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07EE6100F975;
 Fri, 10 Jul 2020 09:19:45 +0000 (UTC)
Received: from gondolin (ovpn-112-227.ams2.redhat.com [10.36.112.227])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2467474F54;
 Fri, 10 Jul 2020 09:19:34 +0000 (UTC)
Date: Fri, 10 Jul 2020 11:19:31 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFC 2/5] s390x: implement diag260
Message-ID: <20200710111931.025d378f.cohuck@redhat.com>
In-Reply-To: <e09f18a9-fda9-5caa-da4f-d7d21e50e01b@redhat.com>
References: <20200708185135.46694-1-david@redhat.com>
 <20200708185135.46694-3-david@redhat.com>
 <20200709123741.28a1e3b2.cohuck@redhat.com>
 <520dafce-917f-9a88-a3ee-c7d614ac113f@redhat.com>
 <e09f18a9-fda9-5caa-da4f-d7d21e50e01b@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 22:08:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, qemu-devel@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 10 Jul 2020 10:41:33 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 10.07.20 10:32, David Hildenbrand wrote:
> > On 09.07.20 12:37, Cornelia Huck wrote:  
> >> On Wed,  8 Jul 2020 20:51:32 +0200
> >> David Hildenbrand <david@redhat.com> wrote:

> >>> diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
> >>> index 58dbc023eb..d7274eb320 100644
> >>> --- a/target/s390x/misc_helper.c
> >>> +++ b/target/s390x/misc_helper.c
> >>> @@ -116,6 +116,12 @@ void HELPER(diag)(CPUS390XState *env, uint32_t r1, uint32_t r3, uint32_t num)
> >>>      uint64_t r;
> >>>  
> >>>      switch (num) {
> >>> +    case 0x260:
> >>> +        qemu_mutex_lock_iothread();
> >>> +        handle_diag_260(env, r1, r3, GETPC());
> >>> +        qemu_mutex_unlock_iothread();
> >>> +        r = 0;
> >>> +        break;
> >>>      case 0x500:
> >>>          /* KVM hypercall */
> >>>          qemu_mutex_lock_iothread();  
> >>
> >> Looking at the doc referenced above, it seems that we treat every diag
> >> call as privileged under tcg; but it seems that 0x44 isn't? (Unrelated
> >> to your patch; maybe I'm misreading.)  
> > 
> > That's also a BUG in kvm then?
> > 
> > int kvm_s390_handle_diag(struct kvm_vcpu *vcpu)
> > {
> > ...
> > 	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
> > 		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
> > ...
> > }
> >   
> 
> But OTOH, it does not sound sane if user space can bypass the OS to
> yield the CPU ... so this might just be a wrong documentation. All DIAGs
> should be privileged IIRC.

Maybe not all of them, but the diag 0x44 case is indeed odd. No idea
what is documented for its use on LPAR (I don't think that document is
public.)


