Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579DEC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 12:12:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D76CB2072D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 12:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TKTQ1eL2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D76CB2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juxJh-0007Sc-T4
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 08:12:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56336)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1juxIw-00072N-Cd
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 08:11:30 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41775
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1juxIu-0006cS-MX
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 08:11:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594642286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gixm9X4WbXB4zZa3ZcLBeAHMPxRIO42uFEJOhSCF18Q=;
 b=TKTQ1eL2ruGglQ606+Wt0B7cLeNkSIE3WmLOBW7Y58c+gKp9u4+nYcy2QtW0RCi99AyfTH
 ShnU8WycJEOL1F7Gt79eKkmiBVBEcGESWPfqcG1LGFAFrkOq4L7POJVpS0KnmKBUv4J7bX
 1lEfEMJgLfW4FPU4fQ+reNhPJsiYHLc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-6fGAFGDYPW6dCWVXi-bzhA-1; Mon, 13 Jul 2020 08:11:25 -0400
X-MC-Unique: 6fGAFGDYPW6dCWVXi-bzhA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 63056EB352;
 Mon, 13 Jul 2020 12:11:16 +0000 (UTC)
Received: from gondolin (ovpn-113-13.ams2.redhat.com [10.36.113.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9447E100E870;
 Mon, 13 Jul 2020 12:11:08 +0000 (UTC)
Date: Mon, 13 Jul 2020 14:11:05 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH RFC 2/5] s390x: implement diag260
Message-ID: <20200713141105.6aad1a7c.cohuck@redhat.com>
In-Reply-To: <68e4c043-2d4a-f538-1f86-a7171098b0db@de.ibm.com>
References: <20200708185135.46694-1-david@redhat.com>
 <20200708185135.46694-3-david@redhat.com>
 <20200709123741.28a1e3b2.cohuck@redhat.com>
 <520dafce-917f-9a88-a3ee-c7d614ac113f@redhat.com>
 <68e4c043-2d4a-f538-1f86-a7171098b0db@de.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 02:19:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, "Michael S .
 Tsirkin" <mst@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>,
 qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 qemu-s390x@nongnu.org, Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 13 Jul 2020 13:54:41 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 10.07.20 10:32, David Hildenbrand wrote:
> 
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
> 
> diag 44 gives a PRIVOP on LPAR, so I think this is fine. 
> 

Seems like a bug/inconsistency in CP (or its documentation), then.


