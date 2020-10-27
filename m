Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F84C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 13:39:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B04D621707
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 13:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fQOVEl7f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B04D621707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXPCb-0008Th-Dt
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 09:39:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kXP88-0002ZQ-IR
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:35:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52955)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kXP85-0000w6-KR
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:35:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603805712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5kt11jFdffqZX72kckWEauMzWDnxMg8qtaeRoY4kAMk=;
 b=fQOVEl7f3Y5cA8zqfDgB8uFIp5s9GD0wfj8mQRncUHW2IqeyQCRAqqyNpi8VIrfddfLlUl
 RLfmXCGXd9Uki4Tpnck09cohE5c2uHbQkTbF9j1eP2kwzxr3dK4HNKOE/PzrNUrzpYHU9v
 FXj4OMZrrw1IcdiUo8whRihmRBRLnqw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-DguBrrtnM6OeyyiBBs4LzA-1; Tue, 27 Oct 2020 09:35:10 -0400
X-MC-Unique: DguBrrtnM6OeyyiBBs4LzA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A387809DD5
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 13:35:09 +0000 (UTC)
Received: from [10.36.113.185] (ovpn-113-185.ams2.redhat.com [10.36.113.185])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1BB5460C07;
 Tue, 27 Oct 2020 13:35:04 +0000 (UTC)
Subject: Re: [PATCH RFC] memory: pause all vCPUs for the duration of memory
 transactions
To: Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel@nongnu.org
References: <20201026084916.3103221-1-vkuznets@redhat.com>
 <294a987d-b0ef-1b58-98ac-0d4d43075d6e@redhat.com>
 <d7a20a33-0317-467e-6fc6-6528b3b46062@redhat.com>
 <87imav26d8.fsf@vitty.brq.redhat.com>
 <cb74d717-cfc1-a78b-cf80-eb8ebf1075fd@redhat.com>
 <87a6w72565.fsf@vitty.brq.redhat.com>
 <e1d85d86-fb2f-d2a8-77ea-1e0d48c8fb67@redhat.com>
 <875z6v24e2.fsf@vitty.brq.redhat.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <219ac264-dcd4-70f0-244f-1bee601aded7@redhat.com>
Date: Tue, 27 Oct 2020 14:35:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <875z6v24e2.fsf@vitty.brq.redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Peter Xu <peterx@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

>> Same applies to all other kinds of operations (splitting, punching out,
>> ...) as you also mentioned.
> 
> One question from a QEMU newbie though: why do you put
> kvm_ioctl_inhibit_begin()/kvm_ioctl_inhibit_end() to kvm_region_resize()
> only and not taking it all the way up to
> memory_region_transaction_begin()/memory_region_transaction_end() to
> support atomicity for all kinds of updates right away?

The clean way to implement it for 
memory_region_transaction_begin()/memory_region_transaction_end() is by 
implementing
->begin()
->commit()
callbacks for the KVM MemoryListener, and doing it in there, in KVM code.


Now, I wasn't sure how this might affect real-time workloads, where you 
really don't want to kick CPUs out of KVM. You can make a lot of 
operations without requiring this handling like

1. Adding regions (memory hotplug)
2. Removing regions (memory hotunplug)
3. Enabling/disabling dirty logging

Resize/split(/move/...) are the problematic operations where we would 
need that handling. Modifying the size/location of existing slots.

One way to tackle it would be to "sense" upfront if such "modifying" 
operations will be required, communicating that via "->begin()", and 
letting the KVM notifier decide based on that information whether to get 
everything out of KVM. Sounds feasible.

> 
> The second question is whether you plan to sumbit this any time soon)

Once we have an agreement on how to proceed, either I can try to 
dedicate some time, or if you have some time, you can pickup my work and 
make it also handle the other problematic cases (as discussed e.g., ^).

-- 
Thanks,

David / dhildenb


