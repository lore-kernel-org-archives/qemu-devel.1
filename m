Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801E4C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 12:21:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BB8620709
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 12:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PHoQzpgz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BB8620709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb1Fj-0005WX-DH
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 08:21:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jb1Bx-00012c-T4
 for qemu-devel@nongnu.org; Tue, 19 May 2020 08:17:53 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37970
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jb1Bv-0001fG-UU
 for qemu-devel@nongnu.org; Tue, 19 May 2020 08:17:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589890670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NuTMMRU1BJ03A+ds1ndifIvf9UxZU+V1Xl+tuCLqd0A=;
 b=PHoQzpgzp/jNjP8Ypxc0EYpfO1/9YAgMXAO97xAKD/gMvuoLVTDAGNd43/BAnBiwI1rLWH
 I4NCJ1VmkWR2zGCNYaWI+SkZW1vu/vP/rO1WAGHKAQg8BxVW8e4E/JRCBgXKocXz4cpN+M
 kyTlR+i9+ZOBOJA1WtpEaAa7xEoC+s0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-3Jvrts9AM2q6PnlACZYXwg-1; Tue, 19 May 2020 08:17:43 -0400
X-MC-Unique: 3Jvrts9AM2q6PnlACZYXwg-1
Received: by mail-wr1-f71.google.com with SMTP id w9so7217179wrr.3
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 05:17:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NuTMMRU1BJ03A+ds1ndifIvf9UxZU+V1Xl+tuCLqd0A=;
 b=T0EY0tWlc+OKFBwa+Eu7+eyBJwTltfvLXS6k0P0TC5ESN5W/k4N/5Wumwy8XzlT0Ry
 dQEBJa7mxrK9qPHezpAcmCTLEnZv4c/6Dwaj/NWUoUqjE/lI6k8rx2NWgTgEETnytZj8
 V0ilVcFxTQN+eOEO0sC9FijHF2OYyJZ6aKGZE4EugnO5qLxBC+8dvi+5EegqetKEYc3t
 Sh+OuczRAZz8ik7eUesqyIpU1HXW4LqFQSJbga3NlIOU1fX153gZDt2sksQlpVUBvnJY
 ps1iSWxaZk0Aqq0Y60MWfYVsZqI1BrJ86yxxqTQI4lNheQzs2+HKht7eG1d0H7uLLSCj
 XvBw==
X-Gm-Message-State: AOAM530p9ChyMCTRiu6RJycpJpXUWHDEAyKf7Mf9CtnPUc0JzQUIWewp
 iXzKeAyzna15r4Jn+bhCHW0U1+8DxuGt0TbYZzgUTZ4oPZ2eVrUul1tlxLBXsxbEvlM9LQ+7dsc
 yfSvd948qttgbHto=
X-Received: by 2002:adf:fa47:: with SMTP id y7mr24130609wrr.337.1589890661977; 
 Tue, 19 May 2020 05:17:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzk6A2gRJwILoX/RcUbVb8phe6234CP4eCj2sm6KnuLPNZsLedHPU66Vnodcod0mvw7nkDASg==
X-Received: by 2002:adf:fa47:: with SMTP id y7mr24130581wrr.337.1589890661676; 
 Tue, 19 May 2020 05:17:41 -0700 (PDT)
Received: from [192.168.1.39] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id 1sm3906583wmz.13.2020.05.19.05.17.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2020 05:17:41 -0700 (PDT)
Subject: Re: [PATCH] linux-user/mmap.c: fix integer underflow in target_mremap
To: Stefano Garzarella <sgarzare@redhat.com>,
 Jonathan Marler <johnnymarler@gmail.com>
References: <20200502161225.14346-1-johnnymarler@gmail.com>
 <CACKT+Ao+hRRuSarAcWy0PDzV8u5CF9KQq07dgVsLmQddSTfj6Q@mail.gmail.com>
 <CACKT+ApwXFEK3tu5=ZpOZrGNYLXcO6w9rv7QUEDrJKBkCQ8wGw@mail.gmail.com>
 <CACKT+AoOJGtBE+9wwo8Pkp2=1WCA-3m7i80rhNa9yxc24FH+7A@mail.gmail.com>
 <20200519081115.xlvm7y4k63anfsmc@steredhat>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <81563291-895e-85aa-267a-282a6a0efc3e@redhat.com>
Date: Tue, 19 May 2020 14:17:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200519081115.xlvm7y4k63anfsmc@steredhat>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 00:34:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Jonathan.

On 5/19/20 10:11 AM, Stefano Garzarella wrote:
> Hi Jonathan,
> thanks for the patch!
> 
> CCing Riku and Laurent.
> 
> On Mon, May 18, 2020 at 12:13:41PM -0600, Jonathan Marler wrote:
>> Been a few more days.  Not sure how often I should be pinging.  If this is
>> too much to ping every few days let me know.

Pinging every week is fine. The problem here, as noticed by Stefano, is 
you forgot to Cc the maintainers, so they surely missed your patch.

Last time Riku sent an email to qemu-devel was more than 2 years ago, 
letling Laurent second him, then went MIA:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg507843.html

I'd say count 1 week starting today.

Regards,

Phil.

> 
> Is not too much, but next time is better to CC the maintainers.
> You can use 'scripts/get_maintainer.pl' to get the list of maintainers
> and reviewers.
> 
> Please take a look at https://wiki.qemu.org/Contribute/SubmitAPatch
> 
>>
>> On Fri, May 15, 2020 at 7:36 AM Jonathan Marler <johnnymarler@gmail.com>
>> wrote:
>>
>>> Been a couple weeks, checking to see if anyone has looked at this.
>>>
>>> On Sat, May 2, 2020 at 5:43 PM Jonathan Marler <johnnymarler@gmail.com>
>>> wrote:
>>>
>>>> FYI, I applied this patch to the qemu build that zig uses to run
>>>> non-native tests (
>>>> https://github.com/ziglang/qemu-static/blob/master/patch/mremap-underflow.diff
>>>> )
>>>>
>>>> After applying it, my new code that calls mremap now passes,
>>>> whereas before the fix I was getting a segfault.
>>>>
>>>> On Sat, May 2, 2020 at 10:12 AM Jonathan Marler <johnnymarler@gmail.com>
>>>> wrote:
>>>>
>>>>> Fixes: https://bugs.launchpad.net/bugs/1876373
> 
> should be "Buglink: https://bugs.launchpad.net/bugs/1876373"
> 
>>>>>
>>>>> This code path in mmap occurs when a page size is decreased with
>>>>> mremap.  When a section of pages is shrunk, qemu calls mmap_reserve on the
>>>>> pages that were released.  However, it has the diff operation reversed,
>>>>> subtracting the larger old_size from the smaller new_size.  Instead, it
>>>>> should be subtracting the smaller new_size from the larger old_size.  You
>>>>> can also see in the previous line of the change that this mmap_reserve call
>>>>> only occurs when old_size > new_size.
> 
> Please break the lines of the commit message (max 76 charactes per line):
> https://wiki.qemu.org/Contribute/SubmitAPatch#Write_a_meaningful_commit_message
> 
> Thanks,
> Stefano
> 
>>>>>
>>>>> Signed-off-by: Jonathan Marler <johnnymarler@gmail.com>
>>>>> ---
>>>>>   linux-user/mmap.c | 2 +-
>>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
>>>>> index e378033797..caab62909e 100644
>>>>> --- a/linux-user/mmap.c
>>>>> +++ b/linux-user/mmap.c
>>>>> @@ -708,7 +708,7 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong
>>>>> old_size,
>>>>>           if (prot == 0) {
>>>>>               host_addr = mremap(g2h(old_addr), old_size, new_size,
>>>>> flags);
>>>>>               if (host_addr != MAP_FAILED && reserved_va && old_size >
>>>>> new_size) {
>>>>> -                mmap_reserve(old_addr + old_size, new_size - old_size);
>>>>> +                mmap_reserve(old_addr + old_size, old_size - new_size);
>>>>>               }
>>>>>           } else {
>>>>>               errno = ENOMEM;
>>>>> --
>>>>> 2.23.1
>>>>>
>>>>>
> 
> 


