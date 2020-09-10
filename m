Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92550C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 06:37:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7211206BE
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 06:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cUC44Riu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7211206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGGCt-0005e4-3t
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 02:37:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55104)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1kGGC5-0005Dm-Tb
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 02:36:29 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21889
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1kGGC3-0007CO-M7
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 02:36:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599719786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9UW16lUstnnCGbjpX3liKw7JzbSB4SPpIDupEPmn0vI=;
 b=cUC44Rius1mc73BemBo7fyesqnrDYA7MRjIW2915rHAFGbvqWXKV0NCPeIbKbvRNnrSk4S
 eZTOsj9qu7mry+fyxnp8Qqmignm4zC+9dBOh6TomBcFc2TBrmNdiI0bZql+iSLOOhggoGU
 ZsUJXjLB3S9IiZxntJEELTg3wwL9GmI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-l5e4-x2BMViknvYHd6dgQQ-1; Thu, 10 Sep 2020 02:36:25 -0400
X-MC-Unique: l5e4-x2BMViknvYHd6dgQQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B56951005E7C;
 Thu, 10 Sep 2020 06:30:06 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.124])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 60B0B7E46E;
 Thu, 10 Sep 2020 06:30:01 +0000 (UTC)
Date: Thu, 10 Sep 2020 08:29:58 +0200
From: Andrew Jones <drjones@redhat.com>
To: Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v2 0/2] MTE support for KVM guest
Message-ID: <20200910062958.o55apuvdxmf3uiqb@kamzik.brq.redhat.com>
References: <20200904160018.29481-1-steven.price@arm.com>
 <20200909152540.ylnrljd6aelxoxrf@kamzik.brq.redhat.com>
 <857566df-1b98-84f7-9268-d092722dc749@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <857566df-1b98-84f7-9268-d092722dc749@arm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Received-SPF: pass client-ip=205.139.110.61; envelope-from=drjones@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 01:44:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Peter Maydell <Peter.Maydell@arm.com>, linux-kernel@vger.kernel.org,
 Juan Quintela <quintela@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Marc Zyngier <maz@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
 Dave Martin <Dave.Martin@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 09, 2020 at 05:04:15PM +0100, Steven Price wrote:
> On 09/09/2020 16:25, Andrew Jones wrote:
> > On Fri, Sep 04, 2020 at 05:00:16PM +0100, Steven Price wrote:
> > >   2. Automatically promotes (normal host) memory given to the guest to be
> > >      tag enabled (sets PG_mte_tagged), if any VCPU has MTE enabled. The
> > >      tags are cleared if the memory wasn't previously MTE enabled.
> > 
> > Shouldn't this be up to the guest? Or, is this required in order for the
> > guest to use tagging at all. Something like making the guest IPAs memtag
> > capable, but if the guest doesn't enable tagging then there is no guest
> > impact? In any case, shouldn't userspace be the one that adds PROT_MTE
> > to the memory regions it wants the guest to be able to use tagging with,
> > rather than KVM adding the attribute page by page?
> 
> I think I've probably explained this badly.
> 
> The guest can choose how to populate the stage 1 mapping - so can choose
> which parts of memory are accessed tagged or not. However, the hypervisor
> cannot restrict this in stage 2 (except by e.g. making the memory uncached
> but that's obviously not great - however devices forward to the guest can be
> handled like this).
> 
> Because the hypervisor cannot restrict the guest's access to the tags, the
> hypervisor must assume that all memory given to the guest could have the
> tags accessed. So it must (a) clear any stale data from the tags, and (b)
> ensure that the tags are preserved (e.g. when swapping pages out).
> 

Yes, this is how I understood it.

> Because of the above the current series automatically sets PG_mte_tagged on
> the pages. Note that this doesn't change the mappings that the VMM has (a
> non-PROT_MTE mapping will still not have access to the tags).

But if userspace created the memslots with memory already set with
PROT_MTE, then this wouldn't be necessary, right? And, as long as
there's still a way to access the memory with tag checking disabled,
then it shouldn't be a problem.

> > 
> > If userspace needs to write to guest memory then it should be due to
> > a device DMA or other specific hardware emulation. Those accesses can
> > be done with tag checking disabled.
> 
> Yes, the question is can the VMM (sensibly) wrap the accesses with a
> disable/renable tag checking for the process sequence. The alternative at
> the moment is to maintain a separate (untagged) mapping for the purpose
> which might present it's own problems.

Hmm, so there's no easy way to disable tag checking when necessary? If we
don't map the guest ram with PROT_MTE and continue setting the attribute
in KVM, as this series does, then we don't need to worry about it tag
checking when accessing the memory, but then we can't access the tags for
migration.

> 
> > > 
> > > If it's not practical to either disable tag checking in the VMM or
> > > maintain multiple mappings then the alternatives I'm aware of are:
> > > 
> > >   * Provide a KVM-specific method to extract the tags from guest memory.
> > >     This might also have benefits in terms of providing an easy way to
> > >     read bulk tag data from guest memory (since the LDGM instruction
> > >     isn't available at EL0).
> > 
> > Maybe we need a new version of KVM_GET_DIRTY_LOG that also provides
> > the tags for all addresses of each dirty page.
> 
> Certainly possible, although it seems to conflate two operations: "get list
> of dirty pages", "get tags from page". It would also require a lot of return
> space (size of slot/32).
>

It would require num-set-bits * host-page-size / 16 / 2, right?
 
> > >   * Provide support for user space setting the TCMA0 or TCMA1 bits in
> > >     TCR_EL1. These would allow the VMM to generate pointers which are not
> > >     tag checked.
> > 
> > So this is necessary to allow the VMM to keep tag checking enabled for
> > itself, plus map guest memory as PROT_MTE, and write to that memory when
> > needed?
> 
> This is certainly one option. The architecture provides two "magic" values
> (all-0s and all-1s) which can be configured using TCMAx to be treated
> differently. The VMM could therefore construct pointers to otherwise tagged
> memory which would be treated as untagged.
> 
> However, Catalin's user space series doesn't at the moment expose this
> functionality.
>

So if I understand correctly this would allow us to map the guest memory
with PAGE_MTE and still access the memory when needed. If so, then this
sounds interesting.

Thanks,
drew 


