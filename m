Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70948C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 12:57:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BE4520776
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 12:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aZ6DbQg1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BE4520776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmGaQ-0001Je-Hn
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 08:57:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38716)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jmGYe-0007Rq-82
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 08:55:48 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28056
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jmGYc-0007ma-Gs
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 08:55:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592571345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JS9ukXCIgdCtkEHKUl8K+WAkcaaqmTYTmT4t6l9ISFI=;
 b=aZ6DbQg1SZy2/BLn2dY8yTsjk6GWzNUIYOOAlJNOeS4rzu8PlE6tSzIS9ApbKa7CDsw4Ue
 QR8UF8yU81fXwu3XEIs52ytZIUeerB9m5u2Dn5dcnZvS/3TXx+Bd9ZLuQcFu1loic88mAj
 qgEI670aL8OaHHlEyDg2feuFTrK6KGQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-ZFid8z_pOByuClqdh5j-JA-1; Fri, 19 Jun 2020 08:55:41 -0400
X-MC-Unique: ZFid8z_pOByuClqdh5j-JA-1
Received: by mail-wm1-f71.google.com with SMTP id x6so3940248wmj.9
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 05:55:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JS9ukXCIgdCtkEHKUl8K+WAkcaaqmTYTmT4t6l9ISFI=;
 b=eyWYJ2jZUmIb9hc0eziWZc/DcmpSx0+McDfkN3olWxb9L1U7mq7QdZoKUPMmDS7vXR
 9GUKX/E2mNON+vUEKHBv1NdAoep985j3YeSn1QviKIk6WtRihKO1Kcdgo0qKQjkCaV2w
 LCgUdZYjGvgGnkYlRiONK08dPUm40axJfzoLCWMI2NBK1X40+AaWwsNqane0XoLYC80P
 2gZ3D5B4+9Mses5ZG9R0NrEfLNTUKVUIGf6kir4Qd8cwJKvHfcytiWfHVYj54UYFXyA0
 85NHelwJPfit/lRlnlT9jqnLfAf5DnM9VKbBH7nS7ywqibC9cqnE7exVN6gSclhCMFbY
 3m9w==
X-Gm-Message-State: AOAM530U/z1NMbHIkbiHC+uoTd6P5kwWfFiILoX4P1w0J0Cm7uSipaX+
 TBFsDX9ycsBJ6BdWZlzPzefio0AfhVGxv5/e1ekNNVB/vbgf1V/V6GSC59lwssQxetdCPVmlBLd
 M6VDrz8IZpyiWC3k=
X-Received: by 2002:a1c:dc06:: with SMTP id t6mr3769247wmg.118.1592571340767; 
 Fri, 19 Jun 2020 05:55:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJznfhTRR9yeksT3hxvluDOgcXnF2Y6m0fKD9/C8X9cgCINRT6g2TheYfEN6MrVvKIZv63K+nQ==
X-Received: by 2002:a1c:dc06:: with SMTP id t6mr3769229wmg.118.1592571340552; 
 Fri, 19 Jun 2020 05:55:40 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e1d2:138e:4eff:42cb?
 ([2001:b07:6468:f312:e1d2:138e:4eff:42cb])
 by smtp.gmail.com with ESMTPSA id g82sm6937170wmf.1.2020.06.19.05.55.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jun 2020 05:55:40 -0700 (PDT)
Subject: Re: what are the requirements on target/ code for -icount to work
 correctly?
To: Peter Maydell <peter.maydell@linaro.org>
References: <CAFEAcA_HOxdK5rgKVnww6Bum3vGb=TrhDEp7oqDwsd=UbHmC_g@mail.gmail.com>
 <c47e9e4e-49eb-88c5-fdc7-8ebec121c165@ispras.ru>
 <f4fc4a1b-4054-cffd-0272-22c28d656aba@redhat.com>
 <CAFEAcA-=igrJfoiga7b7rcwZDj46nTNMiT2VEj11DKO7OiJpNA@mail.gmail.com>
 <1364f7e8-3283-8ca2-76f8-75e3eb74af7b@redhat.com>
 <CAFEAcA-8aKX=Qa=i5pahhPTWOBx6MOWfo9ezhFFH+89du8Wf7Q@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <049e21f4-7254-5f59-2207-c01ad8f26916@redhat.com>
Date: Fri, 19 Jun 2020 14:55:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-8aKX=Qa=i5pahhPTWOBx6MOWfo9ezhFFH+89du8Wf7Q@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 02:45:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/06/20 14:39, Peter Maydell wrote:
> On Fri, 19 Jun 2020 at 13:37, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> On 19/06/20 14:18, Peter Maydell wrote:
>>> On Fri, 19 Jun 2020 at 12:16, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>>>
>>>> On 19/06/20 07:46, Pavel Dovgalyuk wrote:
>>>>> I think, that we need some efforts from target maintainers to remove all such calls.
>>>>
>>>> I'll take care of target/i386 (which does need one of the three
>>>> gen_io_end calls that are left).
>>>
>>> So why does it need it ? Why can't it just rely on "TB going to
>>> end anyway which will clear the can_do_io flag" ?
>>
>> Because the TB is not always going to end in that case that is left.
> 
> OK, so when is it valid not to end the TB after an IO instruction ?
> My initial belief was that the TB should *always* end.

You're right, cpu_io_recompile works only for memory accesses so that
third one has to be fixed.

Paolo


