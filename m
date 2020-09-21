Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FBEC43464
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 13:29:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CF032076E
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 13:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="HeksDpTp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CF032076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKLsm-0002nY-4R
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 09:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50884)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1kKLqU-0001Er-Aa
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 09:27:06 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:51852)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1kKLqO-0001xF-MH
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 09:27:03 -0400
Received: by mail-pj1-x1041.google.com with SMTP id a9so7485554pjg.1
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 06:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=nZmfSDMk822FKIeNtvMuhgkxectriKIKe+38dSjolUw=;
 b=HeksDpTp70jzJ7Ab1YhL3f80tMlmrnAuHGs+UU7VCDJqfyWtEtpk1emRRGYRx6VoQ/
 OofMkrN8zreTCTC8LG2xFKhraA7LX9dOtjlJ5sv1wDBvGwTWi1EnIrwEOPwg+SPLFk8+
 l2KtkBFk2fK1FVhIF8n8bilBhNTDp3Mt+7lAHg/VZTc2acvygXm42lssNAGLxqFvyt7d
 DXgXdHaLlHjx9umklJgxGxSd40H9qVMZRAB3VnYd4O7lqQ/fWw7/MNeHREmjcBFbC+NS
 Z6kLPy01WQ3w9entVvCrUIXntwywYrsKSEsKCRwUzWL6d4YDmFlw/Vcz0vKE2BUBMx2m
 gDZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nZmfSDMk822FKIeNtvMuhgkxectriKIKe+38dSjolUw=;
 b=eqHXsTccfV5xacuEw0cabbqBPFo/Ccd44CacRG0B1toutf/PnMlIkX2BDoOf9s3pbJ
 3bkgiXIC9Pzf8Sm5oHdT5448bZbAFGaNczHmD3IoHONQP4tuHsMgbLDZw4Nb/Dx1U2Ig
 oRBT1kwfjc4ImqrHZUpAsmIYafU3q1VkAJUDlCTfmQF6kusbqcOqtYw833zQoreuAVVB
 Q5kY01ZHjO6+IP3mQ4ThCpR+r2nYZXI5N+z0gLLk01zmYbz9/a+Vmm5E5DgRKUgcatNS
 RjYkHsYzKzv5mX8YjSRPWS+gpfkqWZNr/CxbfXIaS7JXcEMHOggboVI4rdMiLApLsSeW
 ZnhQ==
X-Gm-Message-State: AOAM532cSUYimWV8bjIuBX7+HsTy7G6KOgSjIPwXZonBNBFpsqItmR15
 OU9Gt94C0agI2c/PYkrGSCeN7w==
X-Google-Smtp-Source: ABdhPJyqdJKIi9LoxifGnKgdUhyaEXVWXEfHQFare17UeWu4HhNPr0gxWkQBwaJ4MeEOdu+7b0br7g==
X-Received: by 2002:a17:90a:e02:: with SMTP id v2mr24390639pje.6.1600694817278; 
 Mon, 21 Sep 2020 06:26:57 -0700 (PDT)
Received: from [10.2.24.220] ([61.120.150.77])
 by smtp.gmail.com with ESMTPSA id x20sm12056740pfr.190.2020.09.21.06.26.54
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 21 Sep 2020 06:26:56 -0700 (PDT)
Subject: Re: [External] Re: ping: [PATCH 0/3] add MEMORY_FAILURE event
To: Paolo Bonzini <pbonzini@redhat.com>, armbru@redhat.com, mtosatti@redhat.com
References: <20200914134321.958079-1-pizhenwei@bytedance.com>
 <b38abe18-0211-d2fc-d843-c081227ac05e@bytedance.com>
 <a0854841-28b4-5ea6-6e1e-25bec6baa93f@redhat.com>
From: zhenwei pi <pizhenwei@bytedance.com>
Message-ID: <d7f64589-c475-f0ea-bd4e-728d30d73b08@bytedance.com>
Date: Mon, 21 Sep 2020 21:26:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <a0854841-28b4-5ea6-6e1e-25bec6baa93f@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 9/21/20 8:09 PM, Paolo Bonzini wrote:
> On 21/09/20 04:22, zhenwei pi wrote:
>> Hi,
>>
>> A patchset about handling 'MCE' might have been ignored, can anyone tell
>> me whether the purpose is reasonable?
>>
>> https://patchwork.kernel.org/cover/11773795/
> 
> Yes, it's very useful.  Just one thing, "guest-mce" can be reported for
> both AR and AO faults.  Is it worth adding a 'type' field to distinguish
> the two?
> 
> Paolo
> 
Sure. how about adding a 'flags' of a structure? and a field named 
'action-required' to describe AO or AR?
>> On 9/14/20 9:43 PM, zhenwei pi wrote:
>>> Although QEMU could catch signal BUS to handle hardware memory
>>> corrupted event, sadly, QEMU just prints a little log and try to fix
>>> it silently.
>>>
>>> In these patches, introduce a 'MEMORY_FAILURE' event with 4 detailed
>>> actions of QEMU, then uplayer could know what situaction QEMU hit and
>>> did. And further step we can do: if a host server hits a
>>> 'hypervisor-ignore'
>>> or 'guest-mce', scheduler could migrate VM to another host; if hitting
>>> 'hypervisor-stop' or 'guest-triple-fault', scheduler could select other
>>> healthy servers to launch VM.
>>>
>>> zhenwei pi (3):
>>>     target-i386: seperate MCIP & MCE_MASK error reason
>>>     iqapi/run-state.json: introduce memory failure event
>>>     target-i386: post memory failure event to uplayer
>>>
>>>    qapi/run-state.json  | 46
>>> ++++++++++++++++++++++++++++++++++++++++++++++
>>>    target/i386/helper.c | 30 +++++++++++++++++++++++-------
>>>    target/i386/kvm.c    |  5 ++++-
>>>    3 files changed, 73 insertions(+), 8 deletions(-)
>>>
>>
> 

-- 
zhenwei pi

