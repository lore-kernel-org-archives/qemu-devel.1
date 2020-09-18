Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357B1C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 08:45:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FF222085B
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 08:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dsK5+Dg/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FF222085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJC0t-00058t-Ci
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 04:45:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36404)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJBvo-0008Py-OS
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 04:39:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40557)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJBvj-0007Kp-8i
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 04:39:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600418382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iu3PRXMQqCnnNHWZE2V3pgC2Lg0mBjCRg8JAPEBuzsM=;
 b=dsK5+Dg/QqtyeiMtSM4IsH/4NSQYDQ0Gttc5pBtEaKfjQ38/QliXeR0fpEd7B2E1TzIkv2
 j+8Dv9HnxstlNdN/nVQ24mTyO5bPkACr+2ugKajFVS/RdNIznvx2YEJ4ycLJZ4c6LCGxxl
 p7JUmvT3W8dO67VCSuoS/hStoz1euVs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-cqqQ9y1BPqinQBrhaaLghA-1; Fri, 18 Sep 2020 04:39:40 -0400
X-MC-Unique: cqqQ9y1BPqinQBrhaaLghA-1
Received: by mail-wr1-f72.google.com with SMTP id x15so1856154wrm.7
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 01:39:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iu3PRXMQqCnnNHWZE2V3pgC2Lg0mBjCRg8JAPEBuzsM=;
 b=nje2e7QebilsCXAtXJvr6Uyvra2a5JnBPsg3LEv9d3pyyh8R4cGNI8zz6YAIrsv1/F
 wkNnH9oedKCAzMiOsILoreQWfUSrJ6HmaUw9j97noDDAGqnINDal2dLYrnKiLys6isT5
 jE2vX28NijkjPM+Vy3dPkXjpQiMk09WiJv2TImrRB86tdl+bv2S3tKKdzf6kFW2WVeUQ
 kEP+3mzH0mYZNzojobI8zkswjuZqN/79RsP54maXHc//k82NmDBNfWM8xk/0GDCVocD8
 VQI2nGKI5FeUU3JBFGWi2578wJHkP0p7fKBtcsEgmKrzYp8RlkW5ND+CkeopDscvoY2L
 h7yA==
X-Gm-Message-State: AOAM533iwEn2uwTyGxz1AfKC47hhKtQmGa3QKyzKoHBqNv0nnR4WqShk
 IqZSnJ6mHYpKDf6M835VlVGIVHAN2ch3S9/Xe/Wom6I5mml/jdQa29OmajPJpN8rgUn4tboc3Wt
 yeuahmYC5LOgEKys=
X-Received: by 2002:a1c:f20b:: with SMTP id s11mr14842448wmc.144.1600418379644; 
 Fri, 18 Sep 2020 01:39:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwYyCp0dUvLcGRQ0XzVY9TBAn3vC36y7BsbLq7xmKJD9xpwpRQT6CHYDrlyA37T0RiTEYEB7Q==
X-Received: by 2002:a1c:f20b:: with SMTP id s11mr14842427wmc.144.1600418379430; 
 Fri, 18 Sep 2020 01:39:39 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:69b4:4715:609f:385f?
 ([2001:b07:6468:f312:69b4:4715:609f:385f])
 by smtp.gmail.com with ESMTPSA id g8sm3573089wmd.12.2020.09.18.01.39.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Sep 2020 01:39:38 -0700 (PDT)
Subject: Re: [PATCH] target/i386: always create kvmclock device
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>
References: <20200917111306.819263-1-vkuznets@redhat.com>
 <20200917122559.e7i5o64k7rw7urdh@tartarus>
 <87ft7gh6gy.fsf@vitty.brq.redhat.com> <20200917144237.GK2793@work-vm>
 <875z8ch2m6.fsf@vitty.brq.redhat.com> <20200917174410.GU2793@work-vm>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3e22df90-fa06-bf88-70ca-04ec5047d96c@redhat.com>
Date: Fri, 18 Sep 2020 10:39:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200917174410.GU2793@work-vm>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 00:20:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Antoine Damhet <antoine.damhet@blade-group.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/09/20 19:44, Dr. David Alan Gilbert wrote:
>> This may happen with an older machine type when the destination is
>> running an unfixed QEMU and the source has the fix, right?
> Yes I think so.
> 
>> The solution
>> would be to introduce a flag for older machine types (or for new ones)
>> like 'kvmclock_always'.
> Yep sounds the normal answer.
> (You might want to try it first to trigger the bug)
> 

Right -- unqueued it :)

Paolo


