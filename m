Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6F1C4741F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 18:09:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73B85206FA
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 18:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q8COo7/Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73B85206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaNEK-0005xe-GJ
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 13:09:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44714)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kaNDk-0005WJ-Nd
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 13:09:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58589)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kaNDg-0005Ya-Jk
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 13:09:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604513355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+3HvVHQBlBkf1tKdv9NhaN0p9Eh63TT6R1HpKMP1QI8=;
 b=Q8COo7/ZZASkNaqZ3wHyOfgREVOqLem2oQ3XIap8yw2k5E+TmPXR0nHujYJcZG3w78N11M
 XVmulMVvKG1/mEcDbyMIMSS8qvvMN7Bgh4T5vXFhqi7XiCy+tzv0RzHNf4tTTUD9jXsnlH
 Cbdj43an6+mbinr48xCZNwvmg++z5sA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-JgG3hkHFN-qE9fMmzq3jYg-1; Wed, 04 Nov 2020 13:09:13 -0500
X-MC-Unique: JgG3hkHFN-qE9fMmzq3jYg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3EF8A1868409
 for <qemu-devel@nongnu.org>; Wed,  4 Nov 2020 18:09:12 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-112-163.ams2.redhat.com
 [10.36.112.163])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4D2017664A;
 Wed,  4 Nov 2020 18:09:03 +0000 (UTC)
Subject: Re: [PATCH RFC] memory: pause all vCPUs for the duration of memory
 transactions
To: Peter Xu <peterx@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>
References: <20201026084916.3103221-1-vkuznets@redhat.com>
 <20201102195729.GA20600@xz-x1> <87v9emy4g2.fsf@vitty.brq.redhat.com>
 <20201103163718.GH20600@xz-x1>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <f7cd01b0-086c-307e-f995-d4c3c4729bd6@redhat.com>
Date: Wed, 4 Nov 2020 19:09:02 +0100
MIME-Version: 1.0
In-Reply-To: <20201103163718.GH20600@xz-x1>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lersek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/03/20 17:37, Peter Xu wrote:
> On Tue, Nov 03, 2020 at 02:07:09PM +0100, Vitaly Kuznetsov wrote:
>> In case it is a normal access from the guest, yes, but AFAIR here
>> guest's CR3 is pointing to non existent memory and when KVM detects that
>> it injects #PF by itself without a loop through userspace.
> 
> I see, thanks Vitaly.  I think this kind of answered my previous confusion on
> why we can't just bounce all these to QEMU since I thought QEMU should try to
> take the bql if it's mmio access - probably because there're quite a lot of
> references to guest memslots in kernel that cannot be naturally treated as
> guest MMIO access (especially for nested, maybe?) so that maybe it's very hard
> to cover all of them.  Paolo has mentioned quite a few times that he'd prefer a
> kernel solution for this; I feel like I understand better on the reason now..
> 
> Have any of us tried to collect the requirements on this new kernel interface
> (if to be proposed)?  I'm kind of thinking how it would look like to solve all
> the pains we have right now.
> 
> Firstly, I think we'd likely want to have the capability to handle "holes" in
> memslots, either to punch a hole, which iiuc is the problem behind this patch.
> Or the reversed operation, which is to fill up a whole that we've just punched.
> The other major one could be virtio-mem who would like to extend or shrink an
> existing memslot.  However IIUC that's also doable with the "hole" idea in that
> we can create the memslot with the maximum supported size, then "punch a hole"
> at the end of the memslot just like it shrinked.  When extend, we shrink the
> hole instead rather than the memslot.
> 
> Then there's the other case where we want to keep the dirty bitmap when
> punching a hole on existing ram.  If with the "hole" idea in the kernel, it
> seems easy too - when we punch the hole, we drop dirty bitmaps only for the
> range covered by the hole.  Then we won't lose the rest bitmaps that where the
> RAM still makes sense, since the memslot will use the same bitmap before/after
> punching a hole.
> 
> So now an simple idea comes to my mind (I think we can have even more better,
> or more complicated ideas, e.g., to make kvm memslot a tree? But I'll start
> with the simple): maybe we just need to teach each kvm memslot to take "holes"
> within itself.  By default, there's no holes with KVM_SET_USER_MEMORY_REGION
> configured kvm memslots, then we can configure holes for each memslot using a
> new flag (assuming, KVM_MEM_SET_HOLE) of the same ioctl (after LOG_DIRTY_PAGES
> and READ_ONLY).  Initially we may add a restriction on how many holes we need,
> so the holes can also be an array.
> 
> Thoughts?

My only one (and completely unwashed / uneducated) thought is that this
resembles the fact (?) that VMAs are represented as rbtrees. So maybe
don't turn a single KVM memslot into a tree, but represent the full set
of KVM memslots as an rbtree?

My understanding is that "interval tree" is one of the most efficient
data structures for tracking a set of (discontiguous) memory regions,
and that an rbtree can be generalized into an interval tree. I'm super
rusty on the theory (after having contributed a genuine rbtree impl to
edk2 in 2014, sic transit gloria mundi :/), but I think that's what the
VMA stuff in the kernel does, effectively.

Perhaps it could apply to KVM memslots too.

Sorry if I'm making no sense, of course. (I'm going out on a limb with
posting this email, but whatever...)

Laszlo


