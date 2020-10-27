Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F48FC388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:52:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 901622225E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XrIOo04N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 901622225E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXQKP-0001z8-KZ
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 10:52:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kXPpt-00059P-CI
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 10:20:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46354)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kXPpp-0007uq-9R
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 10:20:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603808420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+6wzuZdWiWK6SCPBN5ZqOG6K6u8rqMSUCpYSh6r4O40=;
 b=XrIOo04NNxR0V0jmnRzCNHToXWbNhAQ1AZ56ONyAL9cPwgNZqHHsi5cWf2aLBDoJpGpy6E
 dq5RelbWsIiAPjvILJp8q0jJkzywAqgxbCOS/XT0FTRkVUsH7UtjANpGM7/QjiQ+OcDAoc
 lrjgQAQhAVSJjBAtSwdMO3OlISnl5R4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-r4g3n_rmMKyJf2IqgROXSQ-1; Tue, 27 Oct 2020 10:20:18 -0400
X-MC-Unique: r4g3n_rmMKyJf2IqgROXSQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D2E8C1019629
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 14:20:17 +0000 (UTC)
Received: from localhost (unknown [10.40.208.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D6C755578F;
 Tue, 27 Oct 2020 14:20:06 +0000 (UTC)
Date: Tue, 27 Oct 2020 15:20:04 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH RFC] memory: pause all vCPUs for the duration of memory
 transactions
Message-ID: <20201027152004.75aeee2d@redhat.com>
In-Reply-To: <87wnzbzspp.fsf@vitty.brq.redhat.com>
References: <20201026084916.3103221-1-vkuznets@redhat.com>
 <294a987d-b0ef-1b58-98ac-0d4d43075d6e@redhat.com>
 <d7a20a33-0317-467e-6fc6-6528b3b46062@redhat.com>
 <87imav26d8.fsf@vitty.brq.redhat.com>
 <cb74d717-cfc1-a78b-cf80-eb8ebf1075fd@redhat.com>
 <87a6w72565.fsf@vitty.brq.redhat.com>
 <e1d85d86-fb2f-d2a8-77ea-1e0d48c8fb67@redhat.com>
 <875z6v24e2.fsf@vitty.brq.redhat.com>
 <219ac264-dcd4-70f0-244f-1bee601aded7@redhat.com>
 <87wnzbzspp.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, "Dr. David
 Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 27 Oct 2020 14:47:14 +0100
Vitaly Kuznetsov <vkuznets@redhat.com> wrote:

> David Hildenbrand <david@redhat.com> writes:
> 
> >>> Same applies to all other kinds of operations (splitting, punching out,
> >>> ...) as you also mentioned.  
> >> 
> >> One question from a QEMU newbie though: why do you put
> >> kvm_ioctl_inhibit_begin()/kvm_ioctl_inhibit_end() to kvm_region_resize()
> >> only and not taking it all the way up to
> >> memory_region_transaction_begin()/memory_region_transaction_end() to
> >> support atomicity for all kinds of updates right away?  
> >
> > The clean way to implement it for 
> > memory_region_transaction_begin()/memory_region_transaction_end() is by 
> > implementing  
> > ->begin()
> > ->commit()  
> > callbacks for the KVM MemoryListener, and doing it in there, in KVM code.
> >
> >
> > Now, I wasn't sure how this might affect real-time workloads, where you 
> > really don't want to kick CPUs out of KVM. You can make a lot of 
> > operations without requiring this handling like
> >
> > 1. Adding regions (memory hotplug)
> > 2. Removing regions (memory hotunplug)
> > 3. Enabling/disabling dirty logging
> >
> > Resize/split(/move/...) are the problematic operations where we would 
> > need that handling. Modifying the size/location of existing slots.
> >
> > One way to tackle it would be to "sense" upfront if such "modifying" 
> > operations will be required, communicating that via "->begin()", and 
> > letting the KVM notifier decide based on that information whether to get 
> > everything out of KVM. Sounds feasible.
> >  
> 
> I don't actually know if we have such use-cases but thinking about
> e.g. punching a hole in a middle of an existing slot requires:
> 1) Resizing the existing slot to its first half
> 2) Creating the hole
> 3) Creating a new slot for the second half of the slot.
> In case we'd like to make this atomic, we need to cover the whole
> transaction. But again, I don't know if we have a use-case for it or
> not.

it usually happens during boot time on x86 where MMIO (re)maps
cause punching holes in lower RAM.
(you can observe it by tracing MemoryListener::region_add/del hooks)

[...]


