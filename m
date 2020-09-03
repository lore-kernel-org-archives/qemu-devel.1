Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94015C433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 17:56:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E4E92072A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 17:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hL6P+ymW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E4E92072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDtSs-0001pO-Bp
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 13:56:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34436)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDtSG-0001DK-38
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 13:55:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59600
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDtSE-0006RW-Bs
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 13:55:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599155721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/zynF/W9ggBtHGxQbrRsZ0Vjtxoi5NuAgsvGHOhncCI=;
 b=hL6P+ymWcfYrg6+Yn03gp003lTbvhIpJsljJOfLaMnX4v+hKay8jV8u3BEOC0OUB0Yuxb1
 c3J8b6Pqv5qrMYMpF8r5gY1xAQEum+fV++OW8bqoljaxp5bT3vpSn7vD7ZTbLFo1r3wxbx
 h6vK3rAiEw5mX5TV3ximDrvnh7sEZsg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-9NZwWz1eP2qAt2yX3YwSmw-1; Thu, 03 Sep 2020 13:55:17 -0400
X-MC-Unique: 9NZwWz1eP2qAt2yX3YwSmw-1
Received: by mail-wr1-f69.google.com with SMTP id m7so1332761wrb.20
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 10:55:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/zynF/W9ggBtHGxQbrRsZ0Vjtxoi5NuAgsvGHOhncCI=;
 b=cA57SthXpRM9t1ybRMyM6QnDNRMyg15hzfe4iWcmDx97VEYCQHXVs/yTOK7A7Cpu+0
 ftXetU9d+b/e58Gdy6nSt2QssLH+2nPBRmNJ+vZ8hBLPo9pfLv8yZR3eqzvgftf/JR5t
 3fT6EptbhYWf8Jx05HKjZaktKpUW5++P1ms6Pb6xqA0MobFn8gqbO/MpqyYU0ulQxvgC
 prITvFcXzcQFvq9izGvrBEW6+OoZ6kx32d+QSCnDSc6BgpUxrLbUOxTnIBdPyV3qN1mo
 cKQ+GyE7w2farQtQ4BKbR9FY+PalopQ9Yce4ONkSGw4SpszG54S95TPcxeWG9nfLjFR3
 bTpg==
X-Gm-Message-State: AOAM5331SJYb4ah8cZi/IP1kUQ5586oCiMRHIppWXXdLKiZU8+AqxfUb
 84pZUbjtS4T2zenefYHJnfsu3o+4h39Ghr/LL9Xc/f7tZJ2bPUhPoiBgHKUKc9LVLISyiubMgkW
 XPJQk0/STP4G1svY=
X-Received: by 2002:a5d:6acf:: with SMTP id u15mr3621408wrw.221.1599155716473; 
 Thu, 03 Sep 2020 10:55:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz5Fkuttt24MkmJy2dIeDP/bXlJgguw3p6wGF0BgMz14vaVHYeAFEUtpSPS90xQFn3tr/cxcw==
X-Received: by 2002:a5d:6acf:: with SMTP id u15mr3621387wrw.221.1599155716252; 
 Thu, 03 Sep 2020 10:55:16 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:197c:daa0:48d1:20b2?
 ([2001:b07:6468:f312:197c:daa0:48d1:20b2])
 by smtp.gmail.com with ESMTPSA id 5sm5508166wmz.22.2020.09.03.10.55.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2020 10:55:15 -0700 (PDT)
Subject: Re: [PATCH] meson: install ivshmem-client and ivshmem-server
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200903153524.98168-1-brogers@suse.com>
 <4eba2feb-a9b3-8bb7-6ed7-6b02c79519b1@redhat.com>
 <20200903154906.GA441291@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <69f279ce-30e8-e83c-718b-021d3e6b264d@redhat.com>
Date: Thu, 3 Sep 2020 19:55:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200903154906.GA441291@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:58:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.403, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org,
 Bruce Rogers <brogers@suse.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/09/20 17:49, Daniel P. Berrangé wrote:
> On Thu, Sep 03, 2020 at 05:44:25PM +0200, Paolo Bonzini wrote:
>> On 03/09/20 17:35, Bruce Rogers wrote:
>>> Turn on the meson install flag for these executables
>>>
>>> Signed-off-by: Bruce Rogers <brogers@suse.com>
>>> ---
>>>  contrib/ivshmem-client/meson.build | 2 +-
>>>  contrib/ivshmem-server/meson.build | 2 +-
>>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/contrib/ivshmem-client/meson.build b/contrib/ivshmem-client/meson.build
>>> index 1b171efb4f..83a559117f 100644
>>> --- a/contrib/ivshmem-client/meson.build
>>> +++ b/contrib/ivshmem-client/meson.build
>>> @@ -1,4 +1,4 @@
>>>  executable('ivshmem-client', files('ivshmem-client.c', 'main.c'),
>>>             dependencies: glib,
>>>             build_by_default: targetos == 'linux',
>>> -           install: false)
>>> +           install: true)
>>> diff --git a/contrib/ivshmem-server/meson.build b/contrib/ivshmem-server/meson.build
>>> index 3a53942201..a1c39aa3b3 100644
>>> --- a/contrib/ivshmem-server/meson.build
>>> +++ b/contrib/ivshmem-server/meson.build
>>> @@ -1,4 +1,4 @@
>>>  executable('ivshmem-server', files('ivshmem-server.c', 'main.c'),
>>>             dependencies: [qemuutil, rt],
>>>             build_by_default: targetos == 'linux',
>>> -           install: false)
>>> +           install: true)
>>>
>>
>> They weren't installed before the conversion, were they?
> 
> Unfortunately they were historically installed with --enable-tools.
> 
> IMHO nothing in contrib/ should be installed by default. If we consider
> something maintained and high enough quality for end users, it should
> migrate out of contrib/ into tools/.

Ah, via the tools variable in configure.  Nice maze.  I've queued the patch.

Paolo

> vhost-user-gpu and elf2dmp are also both in contrib/ but installed
> by default :-(
> 
> 
> Regards,
> Daniel
> 


