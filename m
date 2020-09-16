Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE6EC43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 13:06:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D69122210
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 13:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PAwXgjr8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D69122210
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIX9A-0004MB-3z
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 09:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47714)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kIX8A-0003X1-7w
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 09:05:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21585)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kIX86-00029C-Uq
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 09:05:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600261545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z0Ry5SfIQo3qQuY1wdbn6dMq5Oth4hoJVj59TBZXuY0=;
 b=PAwXgjr8HKU6Llro+Ghj7eI+mY6m2aWtgLBt8cSrpaxyqnCgoUMe+tts0zoYrswWblTeX8
 k1orE8O6t9YN2n1o6T7dBCWkONzWAkpOQi5W5wt7K1dx3oST3bjLnKLlE8uGE4GHR0oD78
 2nfevgbbJNBrdvC4rxDiZsMHZXw7SLw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-v5govDuSMaC5jvtjMt8LEQ-1; Wed, 16 Sep 2020 09:05:43 -0400
X-MC-Unique: v5govDuSMaC5jvtjMt8LEQ-1
Received: by mail-wm1-f69.google.com with SMTP id m125so1005571wmm.7
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 06:05:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=z0Ry5SfIQo3qQuY1wdbn6dMq5Oth4hoJVj59TBZXuY0=;
 b=NFEg+dVNKBO228Ny6UX4Lig9PKjLJsxCt9zwfMKOGee9N0OVM+4LPZ+iGSYdX4LIsL
 ziZp1PSqq5OqtUUGh6+Pv8sWv4SCUPnYccT4XtJaRVM8ZXDuCZaBfH48dnQDLz9TEVVz
 CfYf9nn8zx7Y9s3Ttx/MGdR0Sviqqubyx/kehXhzkqTmOZqtwz0/vvqGOkweO1EhKVGb
 GTaakAo3t66gMTPs+26quWIiZTCZJyMdzRvq7wKXmhpsM+4Ye05c0Cd+J7Hpwe2h+uao
 cqYB9RIiA2yvtAQNcTIX6J2sFNQqgnYEuhJ9SjjBz4MyIaxLt3ujzsiQ1oZgsjyWzh4J
 OAuw==
X-Gm-Message-State: AOAM530OpJz+1Ty5essR94ymlHf2SqrWybXRHib+VrewYgMtEEJAFwk2
 7P9qkDJLpQ5sxsXkVDaoJ3gdvjvVCues6vlAtyx80cwCfMp1KY8zDm3+vwjly8f7kQl2CKW1Omh
 mmcGD0hezOSu6OPM=
X-Received: by 2002:a1c:8109:: with SMTP id c9mr4688661wmd.130.1600261542163; 
 Wed, 16 Sep 2020 06:05:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw5cUkTkxcasVF60sYzDjoY7NuzPBxeJRxgV1WAQn7xgtEKSgrR2xXP/68lrFKFcDf6sSxvCA==
X-Received: by 2002:a1c:8109:: with SMTP id c9mr4688633wmd.130.1600261541908; 
 Wed, 16 Sep 2020 06:05:41 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:cf8e:a9a0:1aed:9a37?
 ([2001:b07:6468:f312:cf8e:a9a0:1aed:9a37])
 by smtp.gmail.com with ESMTPSA id f16sm3642510wrp.47.2020.09.16.06.05.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2020 06:05:41 -0700 (PDT)
Subject: Re: [BUG] Migration hv_time rollback
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Antoine Damhet <antoine.damhet@blade-group.com>, vkuznets@redhat.com
References: <20200916090602.blkm7eym6g5bnvvk@tartarus>
 <20200916112956.GE2833@work-vm>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <37b1b2b7-40f5-d0b1-2709-df9fe24fc65f@redhat.com>
Date: Wed, 16 Sep 2020 15:05:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200916112956.GE2833@work-vm>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:35:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.062, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/09/20 13:29, Dr. David Alan Gilbert wrote:
>> I have tracked the bug to the fact that `kvmclock` is not exposed and
>> disabled from qemu PoV but is in fact used by `hv-time` (in KVM).
>>
>> I think we should enable the `kvmclock` (qemu device) if `hv-time` is
>> present and add Hyper-V support for the `kvmclock_current_nsec`
>> function.

Yes, this seems correct.  I would have to check but it may even be
better to _always_ send kvmclock data in the live migration stream.

Paolo


