Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C873C55178
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 21:13:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0D4F21534
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 21:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DqL4e5vG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0D4F21534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka3c4-0001DG-Qo
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 16:13:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ka3bI-0000kN-Jj
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 16:12:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54352)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ka3bG-0004ZO-Oq
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 16:12:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604437937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g4zMKcggnyMGx1p03DsVEYRpscju/CZiO55UMvkXe4Y=;
 b=DqL4e5vGN1/8dBwbty/kUQSQulxDHihoan5dRZxbARVgyYitLVFEqJp2VEX1txOywMns1p
 k9RwdWDijRVZXipRIaWOykGF+ZojvgyY2ZWcSIp5vyGq40VOsyyp4W6GescJvmryb7d6Ei
 WGXItmMINpjFp8r9DJQ/ALNQv6bQoDE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-t7oxLjrnMjCfrrISLQdH5w-1; Tue, 03 Nov 2020 16:12:14 -0500
X-MC-Unique: t7oxLjrnMjCfrrISLQdH5w-1
Received: by mail-wr1-f69.google.com with SMTP id i1so8259715wrb.18
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 13:12:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=g4zMKcggnyMGx1p03DsVEYRpscju/CZiO55UMvkXe4Y=;
 b=P2u0WHUT2jc5nsagHtRp5T+36c3/kOTYOTRMAcE4NwuGme2LP9+pXuS1FfMuq5eS8Y
 llgPwkP1aK6MBdyaVGbHEIKE1OWUOrWmNhlelUP+iBmQZoN9V/ytMoCUuj2TdH2YM1pP
 a2HhIEQ6us8ZEynkvqz0LD0s6vMI1HHuPIFjLrwJXTdKf4oth/JUdzKtzAmSEfgX9DAC
 ZE2sOiBRleoMMh6yRfwNytJKSUpukiXuiWkVTfxU3KaflQ//TNidc5j5z9dStSaHQo7W
 VPN9qU1DzSk3smvXV6LXphyoiNx34zZII3b9T1wqkRfgJE5esJSmX7V8kMFVobq/QWTH
 F/1A==
X-Gm-Message-State: AOAM530Z6j1tmrdB61dySo9cudE5OG3lj1OKf226TEmCJDyUHGmjgvim
 FBmbeyrSEG3Shtg/Aj3YTRvjAHWYoo9rUV232ScjsqnjMLDVG5JZSqXBg9BPyMHbB5LYj+5cb89
 7fO/EPRx5n/ujN7c=
X-Received: by 2002:adf:ed4c:: with SMTP id u12mr10217199wro.63.1604437932648; 
 Tue, 03 Nov 2020 13:12:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwhTZvJyjVKAqgwusNbxQtYLIQs9fUntBiPIvESC/ScLkRz2LzexmgbEfsvsVuc96PFTcI5+g==
X-Received: by 2002:adf:ed4c:: with SMTP id u12mr10217180wro.63.1604437932446; 
 Tue, 03 Nov 2020 13:12:12 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id v14sm27887505wrq.46.2020.11.03.13.12.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2020 13:12:11 -0800 (PST)
Subject: Re: [PATCH-for-5.2 2/3] gitlab-ci: Add a job to cover the
 --without-default-devices config
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20201103164604.2692357-1-philmd@redhat.com>
 <20201103164604.2692357-3-philmd@redhat.com>
 <20201103165247.GT205187@redhat.com>
 <7654e063-98d3-84e0-8116-5a1b41d14636@redhat.com>
 <CABgObfYN+_GsVS89oxRThCivox0F6BJ6XjM3d2gro85y-_17=g@mail.gmail.com>
 <0a7209fb-5e77-d42e-c823-87573897598b@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ac602313-18b7-1517-1261-e9841a6df6d8@redhat.com>
Date: Tue, 3 Nov 2020 22:12:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <0a7209fb-5e77-d42e-c823-87573897598b@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x <qemu-s390x@nongnu.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/11/20 22:07, Philippe Mathieu-Daudé wrote:
>> diff --git a/accel/Kconfig b/accel/Kconfig
>> index 2ad94a3839..d24664d736 100644
>> --- a/accel/Kconfig
>> +++ b/accel/Kconfig
>> @@ -7,3 +7,4 @@ config KVM
>>   config XEN
>>       bool
>>       select FSDEV_9P if VIRTFS
>> +    select 9PFS if VIRTFS
> Without this line ^ it works! Thanks :*

Without which line?

(Also if both work I prefer the other one).

Paolo


