Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B47CC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 13:12:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 001F020733
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 13:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="be6Jpkxo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 001F020733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIuDe-0005Vi-47
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 09:12:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45445)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jIuCw-0004st-4z
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 09:12:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jIuCt-0008V3-Ia
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 09:12:00 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:22798)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jIuCt-0008SR-D0
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 09:11:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585573918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=89ruKB609VKVPe/cPXYOEULL9nsa9e+8JbJ4CI25lCw=;
 b=be6Jpkxo0GcGRhEr3gkVENHg0XBVynRjXuLod47gxNbg/jMfcYLvF5UaFfSxvrio/EXju0
 AYYQsTtf4syH0oRUeIJpxnDCgq9rVhMrf6BLPBsPucYuka6uQESA0yUUbJSAPQohuu3mwd
 4iCOJvjVt+Rm2u3vaEDzBawT7pr2Duo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-9VIL14BeNyugCnqpz8Oz0g-1; Mon, 30 Mar 2020 09:11:56 -0400
X-MC-Unique: 9VIL14BeNyugCnqpz8Oz0g-1
Received: by mail-wm1-f71.google.com with SMTP id w9so7088035wmi.2
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 06:11:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=89ruKB609VKVPe/cPXYOEULL9nsa9e+8JbJ4CI25lCw=;
 b=Gc0zX9M6+PWniBGRzAPQ7mv+1I9qbBsaPxWGDvzQr78/KyC5Bfk8iNNPyNSh7yyG4O
 sLTTo15HxxgzNtKhygSsyiE2hUKvkxgOWKrz70nOSYpSTBY923rFrJOhnxwzbj+Y6iGT
 xjufUbGY31NX9KXNIJUSJ4RiW9TNHbXOVJqru2cXYjrqXl4EogMAtBtKHaQNa1Db5+5a
 TBSD2kXSR/bleeokIeCl6e30Y27vEm32EDe584N/B+cLdcQBzSP0mUrMTACXd2QS2ZuR
 H7HC1QjydIrMKpNqJ71R183RiuQ3t4Wv+HSzMVa8/GmruT9TC9S91vIMEFoHlb5d1N62
 0RBw==
X-Gm-Message-State: ANhLgQ2AIuGsPx06rTawllZ3AcRKqWHSEO0wk9Xj8Kpn+w36lnzLfrTN
 TW3FKGWeeNsD90ZsmZA+UwlM2Yfq7q2D1kmZ7F2EDAcuQPXt7ZpAfS1oShgMzqDjIwtSSabsBAn
 9EyC1Is6rfzga5Fg=
X-Received: by 2002:a7b:ce12:: with SMTP id m18mr6764273wmc.135.1585573915454; 
 Mon, 30 Mar 2020 06:11:55 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vurTevvkuCw+LnZ2oF3Fdp5q8OPuN6zsJSM3pd++CMCUxrW3x0E4pSibx82sKiY8mABZWvoaw==
X-Received: by 2002:a7b:ce12:: with SMTP id m18mr6764253wmc.135.1585573915198; 
 Mon, 30 Mar 2020 06:11:55 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b55d:5ed2:8a41:41ea?
 ([2001:b07:6468:f312:b55d:5ed2:8a41:41ea])
 by smtp.gmail.com with ESMTPSA id v186sm14676775wme.24.2020.03.30.06.11.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Mar 2020 06:11:54 -0700 (PDT)
Subject: Re: Question on dirty sync before kvm memslot removal
To: Peter Xu <peterx@redhat.com>,
 QEMU Devel Mailing List <qemu-devel@nongnu.org>
References: <20200327150425.GJ422390@xz-x1>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c90a6ffd-0cab-186d-b9c8-8e379921783f@redhat.com>
Date: Mon, 30 Mar 2020 15:11:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200327150425.GJ422390@xz-x1>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27/03/20 16:04, Peter Xu wrote:
> That makes perfect sense to me, however... What if the vcpu generates
> dirty bits _after_ we do KVM_GET_DIRTY_LOG but _before_ we send
> KVM_SET_USER_MEMORY_REGION to remove the memslot?  If the vcpu is in
> the userspace I think it's fine because BQL is needed so it won't be
> able to, however the vcpus running inside KVM should not be restricted
> to that.  I think those dirty bits will still get lost, but it should
> be extremely hard to trigger.

Yes, you've found a bug.

> I'm not sure whether I missed something above, but if I'm correct, I
> think the solution should be a flag for KVM_SET_USER_MEMORY_REGION to
> set the memslot as invalid (KVM_MEM_INVALID), then when removing the
> memslot which has KVM_MEM_LOG_DIRTY_PAGES enabled, we should:
> 
>   - send KVM_SET_USER_MEMORY_REGION with KVM_MEM_INVALID to invalidate
>     the memslot, but keep the slot and bitmap in KVM
> 
>   - send KVM_GET_DIRTY_LOG to fetch the bitmap for the slot
> 
>   - send KVM_SET_USER_MEMORY_REGION with size==0 to remove the slot

Or KVM_MEM_READONLY.

> However I don't know whether that'll worth it.

Yes, especially in the light of the dirty ring issue below.

> (Side question which is irrelevant to this: for kvm dirty ring we now
>  need to do similar thing to flush dirty bits before removing a
>  memslot, however that's even trickier because flushing dirty ring
>  needs to kick all vcpu out, currently the RFC series is using
>  run_on_cpu() which will release the BQL and wait for all vcpus to
>  quit into userspace, however that cannot be done inside
>  kvm_set_phys_mem because it needs the BQL.  I'm still thinking about
>  a good way to fix this, but any idea is greatly welcomed :)

The problem here is also that the GFN is not an unique identifier of the
QEMU ram_addr_t.  However you don't really need to kick all vCPUs out,
do you?  You can protect the dirty ring with its own per-vCPU mutex and
harvest the pages from the main thread.

Paolo


