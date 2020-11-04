Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 374BDC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 11:21:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E18E221F8
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 11:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dy80Hh5t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E18E221F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaGqi-00070T-Cd
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 06:21:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50600)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kaGjm-0000Vl-LO
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 06:13:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53982)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kaGjk-000083-S4
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 06:13:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604488435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HS+dY8YTCUYIbmhvbzGBHroVhNemjCWzd1W0bmpcS40=;
 b=Dy80Hh5tJOtXBBJeCaNksOtwanwzqc86qqMUXbbXeoUzx0ClUlYSP6E3qTymgzQXvUTu3+
 51Yr9kuQzYnCz6WDwQTQGu6kJGL8SzswkPylOHhgGccBrlEfeS0JJFrfi+PR2yOpP2R7FK
 3YLAiYflvpGn0NZLRwfX3xPZgICG/LU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-y3z6uXSZPm-7fpG-2Flbhw-1; Wed, 04 Nov 2020 06:13:54 -0500
X-MC-Unique: y3z6uXSZPm-7fpG-2Flbhw-1
Received: by mail-wr1-f71.google.com with SMTP id b6so9061705wrn.17
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 03:13:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HS+dY8YTCUYIbmhvbzGBHroVhNemjCWzd1W0bmpcS40=;
 b=hIZjRIzbp5mrh2zfHXbdvCHMdgSs5SGs8BdYd/8uGDnSJKuZgo9dVuLyt3DiuO88QZ
 8G+bKZtWFZA3eT99VQHHAQswpUg1NnauG8Qk6jxhwp+WYnyeNX9zePyvXjQb3tG2ZFeq
 ByaJNimjqDsI3jXcZ6eEox9a4xJlfWkcfwtcC1RTZgl8PoA0U1pzmwJIXwDdbbqKXoAs
 F331UJPtSH0QKTA6bnsWc9h9tlqlXYoqKl4nUMcuyNBLKjKHJdsXcqjveEZfoO9TmDef
 FPAfw88jnfjSajJBLUKi9r3fAMo+W+TLGg8RtPfoGKNH4KZQgtJXhQWoGaJC4a3jYML/
 WSzA==
X-Gm-Message-State: AOAM532y1d+G+DY/N78e49b0CNMpopXBa2i0rH/VzYvzvWtkqd2qQVkk
 NznppvNospoaBlzhABnMDYWHw1DevBKGw0IjbmnRWmhc1SyMPvKwnTFc19KQDsaO9VXY9dKKHT2
 3Ec8+eFcXxC7WGfE=
X-Received: by 2002:adf:cd8d:: with SMTP id q13mr31348791wrj.268.1604488433255; 
 Wed, 04 Nov 2020 03:13:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwgm1JqqBHRaGC57JWmjdH+rLAw6ErCtHRnvvHuNrzvcg4hC+luCKJh1soqvGKuLVswMWp+yw==
X-Received: by 2002:adf:cd8d:: with SMTP id q13mr31348762wrj.268.1604488433029; 
 Wed, 04 Nov 2020 03:13:53 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id u3sm2031998wro.33.2020.11.04.03.13.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2020 03:13:52 -0800 (PST)
Subject: Re: [PATCH 1/4] bsd-user: space required after semicolon
To: Thomas Huth <thuth@redhat.com>, shiliyang <shiliyang@huawei.com>,
 richard.henderson@linaro.org, pbonzini@redhat.com, alex.bennee@linaro.org,
 laurent@vivier.eu
References: <fc9d7415-a17f-2958-69fd-0b5f54e553a1@huawei.com>
 <b7231b6c-97ad-5b4c-0932-08fa331dbb30@huawei.com>
 <28961057-f570-a203-e098-6ec0d5be3f75@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <52c7980b-33bc-7e76-b985-9df77259f33b@redhat.com>
Date: Wed, 4 Nov 2020 12:13:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <28961057-f570-a203-e098-6ec0d5be3f75@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: alex.chen@huawei.com, hunongda@huawei.com, qemu-trivial@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/4/20 12:08 PM, Thomas Huth wrote:
> On 04/11/2020 11.20, shiliyang wrote:
>> This patch fixes error style problems found by checkpatch.pl:
>> ERROR: space required after that ';'
>>
>> Signed-off-by: Liyang Shi <shiliyang@huawei.com>
>>
>> ---
>>  bsd-user/elfload.c | 2 +-
>>  bsd-user/syscall.c | 4 ++--
>>  2 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/bsd-user/elfload.c b/bsd-user/elfload.c
>> index 9f4210af9a..25e625d86b 100644
>> --- a/bsd-user/elfload.c
>> +++ b/bsd-user/elfload.c
>> @@ -1227,7 +1227,7 @@ int load_elf_binary(struct linux_binprm *bprm, struct target_pt_regs *regs,
>>      end_data = 0;
>>      interp_ex.a_info = 0;
>>
>> -    for(i=0;i < elf_ex.e_phnum; i++) {
>> +    for(i=0; i < elf_ex.e_phnum; i++) {
> 
> While you're at it, please also add white spaces around the "=" in that line.

IOW please run checkpatch after fixing a checkpatch issue ;)


