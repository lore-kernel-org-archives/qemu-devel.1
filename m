Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0949DC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 13:57:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 748EB214F1
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 13:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y1Ii0OOB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 748EB214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGN4v-0007Pc-7t
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 09:57:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44750)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1kGN3z-00065S-Mz
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 09:56:35 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31596
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1kGN3w-0003dG-Se
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 09:56:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599746191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YSWFx/cofNH1Si60n2IPG1OZBCpHlootSbq1tR7ZiH4=;
 b=Y1Ii0OOB4+7FQEsgzSCaPk18UkojzygvxYMlqbz8awfmyda6/yw4EAdc60Uul9k/qRC3AG
 1T1sXNwt+iY8bVVd5kcqVM/5Lj/dFLnwO5yoliTlZC5X/iMpFF+QlTgexk4m6qt20mex6M
 Sl+v4K/euMQLQYM2zrdupABa0NIk6Lk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-524-FLFqHds8Mi23NWWVl2_QoQ-1; Thu, 10 Sep 2020 09:56:28 -0400
X-MC-Unique: FLFqHds8Mi23NWWVl2_QoQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E42B1084C80;
 Thu, 10 Sep 2020 13:56:26 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.124])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1DECB81C51;
 Thu, 10 Sep 2020 13:56:20 +0000 (UTC)
Date: Thu, 10 Sep 2020 15:56:18 +0200
From: Andrew Jones <drjones@redhat.com>
To: Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v2 0/2] MTE support for KVM guest
Message-ID: <20200910135618.cvnlrgvhuy3amv6s@kamzik.brq.redhat.com>
References: <20200904160018.29481-1-steven.price@arm.com>
 <20200909152540.ylnrljd6aelxoxrf@kamzik.brq.redhat.com>
 <857566df-1b98-84f7-9268-d092722dc749@arm.com>
 <20200910062958.o55apuvdxmf3uiqb@kamzik.brq.redhat.com>
 <37663bb6-d3a7-6f53-d0cd-88777633a2b2@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37663bb6-d3a7-6f53-d0cd-88777633a2b2@arm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Received-SPF: pass client-ip=205.139.110.61; envelope-from=drjones@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 09:07:44
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
Cc: Peter Maydell <Peter.Maydell@arm.com>, Juan Quintela <quintela@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Dave Martin <Dave.Martin@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 10, 2020 at 10:21:04AM +0100, Steven Price wrote:
> On 10/09/2020 07:29, Andrew Jones wrote:
> > But if userspace created the memslots with memory already set with
> > PROT_MTE, then this wouldn't be necessary, right? And, as long as
> > there's still a way to access the memory with tag checking disabled,
> > then it shouldn't be a problem.
> 
> Yes, so one option would be to attempt to validate that the VMM has provided
> memory pages with the PG_mte_tagged bit set (e.g. by mapping with PROT_MTE).
> The tricky part here is that we support KVM_CAP_SYNC_MMU which means that
> the VMM can change the memory backing at any time - so we could end up in
> user_mem_abort() discovering that a page doesn't have PG_mte_tagged set - at
> that point there's no nice way of handling it (other than silently upgrading
> the page) so the VM is dead.
> 
> So since enforcing that PG_mte_tagged is set isn't easy and provides a
> hard-to-debug foot gun to the VMM I decided the better option was to let the
> kernel set the bit automatically.
>

The foot gun still exists when migration is considered, no? If userspace
is telling a guest it can use MTE on its normal memory, but then doesn't
prepare that memory correctly, or remember to migrate the tags correctly
(which requires knowing the memory has tags and knowing how to get them),
then I guess the VM is in trouble one way or another.

I feel like we should trust the VMM to ensure MTE will work on any memory
the guest could use it on, and change the action in user_mem_abort() to
abort the guest with a big error message if it sees the flag is missing.
 
> > > > 
> > > > If userspace needs to write to guest memory then it should be due to
> > > > a device DMA or other specific hardware emulation. Those accesses can
> > > > be done with tag checking disabled.
> > > 
> > > Yes, the question is can the VMM (sensibly) wrap the accesses with a
> > > disable/renable tag checking for the process sequence. The alternative at
> > > the moment is to maintain a separate (untagged) mapping for the purpose
> > > which might present it's own problems.
> > 
> > Hmm, so there's no easy way to disable tag checking when necessary? If we
> > don't map the guest ram with PROT_MTE and continue setting the attribute
> > in KVM, as this series does, then we don't need to worry about it tag
> > checking when accessing the memory, but then we can't access the tags for
> > migration.
> 
> There's a "TCO" (Tag Check Override) bit in PSTATE which allows disabling
> tag checking, so if it's reasonable to wrap accesses to the memory you can
> simply set the TCO bit, perform the memory access and then unset TCO. That
> would mean a single mapping with MTE enabled would work fine. What I don't
> have a clue about is whether it's practical in the VMM to wrap guest
> accesses like this.
> 

At least QEMU goes through many abstractions to get to memory already.
There may already be a hook we could use, if not, it probably wouldn't
be too hard to add one (famous last words).

Thanks,
drew


