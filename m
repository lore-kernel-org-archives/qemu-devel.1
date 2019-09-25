Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11370C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 12:11:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1B5C217F4
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 12:11:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1B5C217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD68M-00078p-VH
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 08:11:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52761)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iD66n-0005rO-CU
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 08:09:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iD66m-0006FA-CH
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 08:09:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60676)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>)
 id 1iD66m-0006Ew-5o; Wed, 25 Sep 2019 08:09:24 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4E5918A1C95;
 Wed, 25 Sep 2019 12:09:23 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8C5A2600C8;
 Wed, 25 Sep 2019 12:09:17 +0000 (UTC)
Date: Wed, 25 Sep 2019 14:09:15 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v7 3/4] kvm: split too big memory section on several
 memslots
Message-ID: <20190925140915.3d43c8ab@redhat.com>
In-Reply-To: <20190925031211.GH28074@xz-x1>
References: <20190924144751.24149-1-imammedo@redhat.com>
 <20190924144751.24149-4-imammedo@redhat.com>
 <20190925031211.GH28074@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Wed, 25 Sep 2019 12:09:23 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: thuth@redhat.com, david@redhat.com, cohuck@redhat.com,
 qemu-devel@nongnu.org, borntraeger@de.ibm.com, qemu-s390x@nongnu.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 25 Sep 2019 11:12:11 +0800
Peter Xu <peterx@redhat.com> wrote:

> On Tue, Sep 24, 2019 at 10:47:50AM -0400, Igor Mammedov wrote:
> 
> [...]
> 
> > @@ -2877,6 +2912,7 @@ static bool kvm_accel_has_memory(MachineState *ms, AddressSpace *as,
> >  
> >      for (i = 0; i < kvm->nr_as; ++i) {
> >          if (kvm->as[i].as == as && kvm->as[i].ml) {
> > +            size = MIN(kvm_max_slot_size, size);
> >              return NULL != kvm_lookup_matching_slot(kvm->as[i].ml,
> >                                                      start_addr, size);
> >          }  
> 
> Ideally we could also check that the whole (start_addr, size) region
> is covered by KVM memslots here, but with current code I can't think
> of a case where the result doesn't match with only checking the 1st
> memslot. So I assume it's fine.
yep, it's micro-optimization that works on assumption that whole memory
section always is covered by memslots and original semantics where
working only for if start_addr/size where covering whole memory section.

Sole user mtree_print_flatview() is not performance sensitive,
so if you'd like I can post an additional patch that iterates
over whole range.

> Reviewed-by: Peter Xu <peterx@redhat.com>
> 


