Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F861C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 08:33:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF5DF206C3
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 08:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D1BFaLb1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF5DF206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbKAZ-0007L9-Tm
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 04:33:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43008)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbK9Q-0006eZ-OE
 for qemu-devel@nongnu.org; Wed, 20 May 2020 04:32:32 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51031
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbK9N-0004s6-UB
 for qemu-devel@nongnu.org; Wed, 20 May 2020 04:32:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589963547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M6g4yJieRG2IaRtj1pHojWaStGXQcNNZhymIqj5VeAA=;
 b=D1BFaLb1wrXMjp6SySMtwL7q+mOWnJ/ZJ0QRB8QTzsYIIjfRLxxYNH+NIwYbOOyiv96Q9t
 aMr2/NJex9FRCgty9GWNKfyxv1YjTj815DEBIPRd4ufJIleJWr7BVeDYmFdPMwjCqpsgOB
 ZSyYNGxrTWp4st416mkAgF9zgod76EQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-U8y5vSeBP0qThRqsg4hZ8A-1; Wed, 20 May 2020 04:32:24 -0400
X-MC-Unique: U8y5vSeBP0qThRqsg4hZ8A-1
Received: by mail-wm1-f69.google.com with SMTP id 23so919779wma.8
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 01:32:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=M6g4yJieRG2IaRtj1pHojWaStGXQcNNZhymIqj5VeAA=;
 b=e0mpdrIGVxYtQ8kEXb4JJBb2yPuFnroH+n8+fZhrGIpGZCeZ+pZMan+9Z8BaLYW6zS
 nudGP3BoQz/7Ms+cVOA890nJ90m1iD87RL3vvYdtk/22eCg8IIiHVkziB8HY69Im1449
 pdZfr+Iz93axMd3tqqAeXdcGk157+FNJBNhrUtgR9jS6M7d147UBsGyqF5t+R/4qb3SQ
 PX8wwUXB2gKX5k/8ay6DDfapIS89eUGLM6fZElSScj2s/M7uZxuuGgNT75n1QV9ib5nG
 UX7ewxW4/Xthje2UPkhpkTwmiiz09o6V+nz9OPo24N67bPTfDLUd612gXTMjipaZhf2O
 tgLg==
X-Gm-Message-State: AOAM532DkMoij9AkyywRhCCnxQa2VWYEJP4jAUqfoV0d5Z5TSbEWzsa7
 V61F+Lo5sEFsa6HsLWEQWp0EjQw36r8evavUtYrmhyi4KCh8IkMROIYwmQULhvPm6rHCfei/Ob3
 UcDpez1D9/8rE23s=
X-Received: by 2002:adf:ec88:: with SMTP id z8mr2929516wrn.44.1589963543007;
 Wed, 20 May 2020 01:32:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyKdxnnsuCBMgv9JlCSZrSqF/OUDGr32Kd5aQqaYgkV0dP0bf5tysAmtdaFSeFuftIxdGDv7g==
X-Received: by 2002:adf:ec88:: with SMTP id z8mr2929502wrn.44.1589963542821;
 Wed, 20 May 2020 01:32:22 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:60b0:79b4:e56:bfb5?
 ([2001:b07:6468:f312:60b0:79b4:e56:bfb5])
 by smtp.gmail.com with ESMTPSA id p65sm2205312wmp.36.2020.05.20.01.32.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2020 01:32:22 -0700 (PDT)
Subject: Re: kvm_buf_set_msrs: Assertion `ret == cpu->kvm_msr_buf->nmsrs'
 failed.
To: Li Feng <fengli@smartx.com>
References: <CAHckoCymFfuVd=tKV-hk+PHn2fk6ydWjSxwKVorj9Qe5KV6nGQ@mail.gmail.com>
 <CAHckoCzWmN4oedOHMvR_TbbBcbYqSjg1fUr2RjJkh-iuZO-Jng@mail.gmail.com>
 <55b6466c-0769-6652-a237-c6bc18704064@redhat.com>
 <20200514125220.GJ2787@work-vm>
 <CAHckoCyegWG9yH_y6VjHhnghfHJD-Wq+EmOyRZE3EYguTOHfPw@mail.gmail.com>
 <20200514151600.GO2787@work-vm>
 <CAHckoCxc2XTA3ckU0sq-BmbZZFtfAY_GaEOW46XFzfZ2qXjeMQ@mail.gmail.com>
 <20200514153129.GP2787@work-vm>
 <CAHckoCxOjNEAM4DwWtXS9JT_aPsqOtDAzf5zhhiRrDyAmQa00Q@mail.gmail.com>
 <CAHckoCwee+aNHcgRFvReCCz_0J-vLrM5=MPZFpqvQjkefV2MiQ@mail.gmail.com>
 <986fbf33-8127-870b-9163-4aa8d332553f@redhat.com>
 <CAHckoCxw=j8+uXHD3tzQc4vGkRu-_xhcHn8sSeiKaSHw=Bt6mA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7ecfb762-0359-92a4-d8b3-1a9e081ace92@redhat.com>
Date: Wed, 20 May 2020 10:32:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAHckoCxw=j8+uXHD3tzQc4vGkRu-_xhcHn8sSeiKaSHw=Bt6mA@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 04:09:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: vkuznets@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/05/20 10:22, Li Feng wrote:
>> - bit 2, vmx-exit-nosave-debugctl
>> - bit 9, host address space size, is handled automatically by QEMU
>> - bit 15, vmx-exit-ack-intr
>> - bit 17, vmx-exit-save-pat
>> - bit 18, vmx-exit-load-pat
>> - bit 19, vmx-exit-save-efer
>> - bit 20, vmx-exit-load-efer
>> - bit 21, vmx-exit-save-preemption-timer
>>
>> Try removing all of these and see if QEMU starts:
>>
>> qemu-kvm ... -cpu
>> host,-vmx-exit-nosave-debugctl,-vmx-exit-ack-intr,-vmx-exit-save-pat,-vmx-exit-load-pat,-vmx-exit-save-efer,-vmx-exit-load-efer,-vmx-exit-save-preemption-timer
>>
>> And then add them back one at a time.
> Hi, Paolo.
> Thanks, the crash is still here when removing the above features:
> qemu-system-x86_64: error: failed to set MSR 0x48f to 0x36fff00036dff
> 
> After computing xor, the result is 0b1000000000.
> The bit 9 is set.

Are you running KVM with a 32-bit kernel.

Paolo


