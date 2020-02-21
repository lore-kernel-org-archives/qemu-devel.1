Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E0CC35641
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 22:34:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C68AC206EF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 22:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u9q1zQdY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C68AC206EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5Gsr-0005y5-SH
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 17:34:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39148)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <junaids@google.com>) id 1j5GT6-0000GB-Q8
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 17:08:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <junaids@google.com>) id 1j5GT5-0002VR-Q6
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 17:08:20 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c]:51802)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <junaids@google.com>) id 1j5GT5-0002UA-I3
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 17:08:19 -0500
Received: by mail-pj1-x102c.google.com with SMTP id fa20so1363140pjb.1
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 14:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=subject:to:cc:references:from:organization:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jNjBXjAdVCy5awvtdHoOypna1zj38J0pg8CQSdMcaDo=;
 b=u9q1zQdYJPKZ9WH5HewgltC6Opyxrtk0f1IEoD9S4k/3aRAlidhgR/JsnOSx0U7dap
 cpdYtH3g8KAud5TFgV/1Hv2f+EIwPSFOMuVjqL3sKrvfyIZEoXAXiPDcFCxyi3W0pvOh
 KS3gehjx5v7LCv3NJqk3ExEGTAMeblig3IotXjzLxQZwfyUMZTYk8RYaIhA/KVTOjRHg
 9oXd6bN7OZOb0NalnKaioyHOfchao+AzLKfu++2LUH11KK8/cPiRuSgVXH94LfX5cCYz
 pm/og+X94CNO7HhgfJnNwjUPP4nEF8sAL4oGo2H1pM0P2+ucAEdg6mORjGGBcxBKxzZ9
 hiyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:organization
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=jNjBXjAdVCy5awvtdHoOypna1zj38J0pg8CQSdMcaDo=;
 b=mMsTcISZ49A+yQYp1A9yFG4PJ5yhcAa7Hew5irkQd/629mJm/EED1F2kSs6jflaP39
 ZzWtnC5YjH+G9D1msDKcJZKvDJ41RBYrq97UJJ3Vj3qE6j9xb9kR4FSuUDtDW19mnqg+
 Q0hSwXgD5GyMkueJ2nBlawo/g7jp+S4qtqhtpiLrUj10oLxsajaUtBat85tzC9hE4mKx
 cf5itsH9ktq296GGDmICjhUHc7adPz6NbvlsVbrktWIxCTA+5X01NjYsubOP7s+Is0Eb
 PJJpRaDJmEvvYqxy2ItA1K2OiOn6SQ+wxx57VlwJnszcPKYzmHZuId2sqHKW7sV9rBHL
 V64Q==
X-Gm-Message-State: APjAAAXaTZXtRx8l+q9uaWw87o9b0hKtY34zrKXm7uDL3I5DmJIpvHpT
 qU1JkL3LqjEtdo0VNRo/d/Mz6g==
X-Google-Smtp-Source: APXvYqwttH1vhpl3udu/KCeWv2UYptzXfNlDcvmcYzCt3xV2vaHF6IfqyEVN59jTbw75X+J5/mD4ig==
X-Received: by 2002:a17:90b:8ce:: with SMTP id
 ds14mr5661172pjb.70.1582322897481; 
 Fri, 21 Feb 2020 14:08:17 -0800 (PST)
Received: from ?IPv6:2620:15c:2c1:101:8085:b46d:4651:575f?
 ([2620:15c:2c1:101:8085:b46d:4651:575f])
 by smtp.gmail.com with ESMTPSA id x197sm3921588pfc.1.2020.02.21.14.08.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Feb 2020 14:08:16 -0800 (PST)
Subject: Re: RFC: Split EPT huge pages in advance of dirty logging
To: Ben Gardon <bgardon@google.com>, "Zhoujian (jay)" <jianjay.zhou@huawei.com>
Cc: Peter Xu <peterx@redhat.com>, "kvm@vger.kernel.org"
 <kvm@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "quintela@redhat.com" <quintela@redhat.com>,
 "Liujinsong (Paul)" <liu.jinsong@huawei.com>,
 "linfeng (M)" <linfeng23@huawei.com>,
 "wangxin (U)" <wangxinxin.wang@huawei.com>,
 "Huangweidong (C)" <weidong.huang@huawei.com>, pfeiner@google.com
References: <B2D15215269B544CADD246097EACE7474BAF9AB6@DGGEMM528-MBX.china.huawei.com>
 <20200218174311.GE1408806@xz-x1>
 <B2D15215269B544CADD246097EACE7474BAFF835@DGGEMM528-MBX.china.huawei.com>
 <20200219171919.GA34517@xz-x1>
 <B2D15215269B544CADD246097EACE7474BB03772@DGGEMM528-MBX.china.huawei.com>
 <CANgfPd-P_=GqcMiwLSSkUhZDt42aMLUsCJt+CPdUN5yR3RLHmQ@mail.gmail.com>
From: Junaid Shahid <junaids@google.com>
Organization: Google
Message-ID: <cd4626a1-44b5-1a62-cf4b-716950a6db1b@google.com>
Date: Fri, 21 Feb 2020 14:08:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CANgfPd-P_=GqcMiwLSSkUhZDt42aMLUsCJt+CPdUN5yR3RLHmQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::102c
X-Mailman-Approved-At: Fri, 21 Feb 2020 17:34:13 -0500
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/20/20 9:34 AM, Ben Gardon wrote:
> 
> FWIW, we currently do this eager splitting at Google for live
> migration. When the log-dirty-memory flag is set on a memslot we
> eagerly split all pages in the slot down to 4k granularity.
> As Jay said, this does not cause crippling lock contention because the
> vCPU page faults generated by write protection / splitting can be
> resolved in the fast page fault path without acquiring the MMU lock.
> I believe +Junaid Shahid tried to upstream this approach at some point
> in the past, but the patch set didn't make it in. (This was before my
> time, so I'm hoping he has a link.)
> I haven't done the analysis to know if eager splitting is more or less
> efficient with parallel slow-path page faults, but it's definitely
> faster under the MMU lock.
> 

I am not sure if we ever posted those patches upstream. Peter Feiner would know for sure. One notable difference in what we do compared to the approach outlined by Jay is that we don't rely on tdp_page_fault() to do the splitting. So we don't have to create a dummy VCPU and the specialized split function is also much faster.

Thanks,
Junaid

