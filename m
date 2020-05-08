Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE9A9C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:50:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB362207DD
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MNhZLcop"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB362207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX5GX-00083f-Lo
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 11:50:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jX51g-00007j-HS
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:35:00 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48027
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jX51f-0001NZ-Ib
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:35:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588952098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XOD8ltYsEUkkdTRlhmIZq96e/KTiKYwVTjXwh8WZpOE=;
 b=MNhZLcop2k3ClnVLj3Ab9a8XkW946lC/pWdiOj4a9/zJLQH7YuZ/BOUrm0alRaSBtNrB5Z
 opl/rhq2BPpWVwDKyS1shCGad51HBBTNXZRzITcAW4Y9o8Df1lWNruvyLb5THhtAJuJkVH
 Q9IO3589pqo9wsVyZy8HTXk2LN7PBCI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-Jhf0Vp1jOMaqsiBlMd5AEw-1; Fri, 08 May 2020 11:34:56 -0400
X-MC-Unique: Jhf0Vp1jOMaqsiBlMd5AEw-1
Received: by mail-wr1-f70.google.com with SMTP id e14so1053801wrv.11
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 08:34:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XOD8ltYsEUkkdTRlhmIZq96e/KTiKYwVTjXwh8WZpOE=;
 b=ADHWjLZCz7rRWjRIscJV6HOwNvN3P6fRnO+a2L4PdszpJaErb7ui3h9vErtd9cXPPV
 +PSs2mJUtlZQwGiuiA9wBoS/dj74h2+5KUDCwZzH3gqFrn7oVohaVLLv6ZdpjSC+w1Vl
 CcwVHnW6CotryWfZQUiJPbr/YTY0juNtcldAfQuOZhgnnQGbaN4j52iLeewzGtn3L+Cz
 XQ84u2/L5mJTYSB8aYaoptfV2AnHmQzLtF/08Umjy6yD3a/6OnzD0BhFrp/KwEmnty2z
 r7W+3fCbLtCj/XpCVeTTLCn+7cCLMcYmbubpk2Vo50wBM0aA6+X0S/VZSh38rj9cBc4c
 JfKg==
X-Gm-Message-State: AGi0PuYs4HrNt9ePcbHz1ZRmjtF0esS19GZxzwfBCw5IQ9XZMg+NwimD
 KjV+WMzFoazRjFjcVv9x1rdIV51oLc51T5IEEF6J/M52Pyfw1/86lcVV7TmC3a/ioRkvyGVtTvK
 MfKmJVO+Ax1GCzsQ=
X-Received: by 2002:adf:f48a:: with SMTP id l10mr3388611wro.231.1588952095377; 
 Fri, 08 May 2020 08:34:55 -0700 (PDT)
X-Google-Smtp-Source: APiQypIfRJKnPKvComhZz0FArgba3iY+hNFGdrqx2HJQmK+sD6poSb78ZeZtZlhUIW0JP4Xr2hxmcA==
X-Received: by 2002:adf:f48a:: with SMTP id l10mr3388590wro.231.1588952095102; 
 Fri, 08 May 2020 08:34:55 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id n12sm3681849wrj.95.2020.05.08.08.34.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2020 08:34:54 -0700 (PDT)
Subject: Re: [PATCH 0/4] memory: Add memory_region_msync() & make NVMe
 emulated device generic
To: Paolo Bonzini <pbonzini@redhat.com>,
 Beata Michalska <beata.michalska@linaro.org>
References: <20200508062456.23344-1-philmd@redhat.com>
 <9396e0cb-388a-e08e-c066-82a60708ecdc@redhat.com>
 <CADSWDzvECqOXzusk=tj8r4z-E5CDZn4TNG8PJ5pxLHAn3saOzA@mail.gmail.com>
 <500bd6f3-2b14-eda8-72e5-56c46b7860bd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <653758ab-468d-b6f8-0ca6-404a799e3928@redhat.com>
Date: Fri, 8 May 2020 17:34:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <500bd6f3-2b14-eda8-72e5-56c46b7860bd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 08:00:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 Keith Busch <kbusch@kernel.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/8/20 5:33 PM, Paolo Bonzini wrote:
> On 08/05/20 17:20, Beata Michalska wrote:
>>>
>>> mr->dirty_log_mask tells if dirty tracking has been enabled, not if the
>>> page is dirty.  It would always be true during live migration and when
>>> running on TCG, but otherwise it would always be false.
>>>
>>> Beata, can you explain what you had in mind? :)
>>>
>> It has been a while ... , but the intention there was to skip the sync
>> if there is nothing to be synced in the first place - so for performance
>> reasons. I honestly do not recall why I went for the dirty_log_mask,
>> as that seems not  to be the right choice .
> 
> You probably wanted to look at the dirty bitmap, but you would have to
> define a new bitmap rather than looking at dirty_log_mask.
> 
> But that's cool, because it means that we can just remove it!  Thanks,

So I understand I can simply rename memory_region_writeback -> 
memory_region_msync in patch #2.


