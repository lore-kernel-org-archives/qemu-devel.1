Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27041C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 12:39:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6D30207E8
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 12:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZnZ0pwJr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6D30207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmGIl-0007J7-5g
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 08:39:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35354)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jmGHR-00053n-6A
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 08:38:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30581
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jmGHP-0004yF-25
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 08:38:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592570278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rv8+Z25VIsouKM9jhFYoADWupgt5qpmMZmw+1np2zSA=;
 b=ZnZ0pwJr+PxOXZQhfUWraE0kZ77SBU9/mLTAd6bpkCi/LDuYyFPg5MD2fsxxPq620ZOaFO
 53xjgO1dVlxUsYkVozm4mXjSpBQZ0fOF/aQZEH0d+4ZeJjiQZWNQxvmnLtfRxAeo48zAif
 X7DZPJ+mJKbV9NHmrpusypz8O0amVu8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-DMmYNHyeOKeHl6QYrEBndA-1; Fri, 19 Jun 2020 08:37:56 -0400
X-MC-Unique: DMmYNHyeOKeHl6QYrEBndA-1
Received: by mail-wr1-f70.google.com with SMTP id d6so4224513wrn.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 05:37:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rv8+Z25VIsouKM9jhFYoADWupgt5qpmMZmw+1np2zSA=;
 b=rO17IQEiXITrchAt6m8cmhbcMGm92YA48qU9yXZen8aL1ooFvtkXRSA2MGrpvUFGAs
 GltM4nGvIgusuLEDigPzPkymJInlnZPEkcgPkyf+rdHX8BEkUEtR1BitN84UHvH9ETcS
 luuiIENdKLZo2N8NQotdlxerw7JpSu8o3sE7Fdmyglg767kOfMLpfCfLgT2DaS8pu7Yo
 02YbCExnyb7iUA8G6Cv1q+1MPTVVEbt88US6268pZopYB+mKdvmw8DD/hDXuESno/ljD
 E/GrHE2lvkU2QN7itLAeLJb7fpnX0X5d+zK/JCNXQPRWtnfI4R8/6EK6S8DJSjnoNQEF
 D1xg==
X-Gm-Message-State: AOAM533JVv5X3Bjy5P/frlRGjv83Xq9mntu3oM3XoPDoDsyoIXao6iz6
 6qxI6h/Z+1FAjk3O75oFxhRFFBX7wU2S/oyDR0MNBkekEaTi0uBC0C6ajR3T8yFqnHH7sfTDlt4
 w+nqAWq84GzvPRsY=
X-Received: by 2002:a7b:c8d6:: with SMTP id f22mr3423832wml.108.1592570275431; 
 Fri, 19 Jun 2020 05:37:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxz3wsr/gEmluhRxuhEd24X9yh7F+UORKzygSoWQGb/kZzYO825z1FwL+XYbvL/cvZB6NUGPw==
X-Received: by 2002:a7b:c8d6:: with SMTP id f22mr3423806wml.108.1592570275141; 
 Fri, 19 Jun 2020 05:37:55 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e1d2:138e:4eff:42cb?
 ([2001:b07:6468:f312:e1d2:138e:4eff:42cb])
 by smtp.gmail.com with ESMTPSA id t188sm6901699wmt.27.2020.06.19.05.37.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jun 2020 05:37:54 -0700 (PDT)
Subject: Re: what are the requirements on target/ code for -icount to work
 correctly?
To: Peter Maydell <peter.maydell@linaro.org>
References: <CAFEAcA_HOxdK5rgKVnww6Bum3vGb=TrhDEp7oqDwsd=UbHmC_g@mail.gmail.com>
 <c47e9e4e-49eb-88c5-fdc7-8ebec121c165@ispras.ru>
 <f4fc4a1b-4054-cffd-0272-22c28d656aba@redhat.com>
 <CAFEAcA-=igrJfoiga7b7rcwZDj46nTNMiT2VEj11DKO7OiJpNA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1364f7e8-3283-8ca2-76f8-75e3eb74af7b@redhat.com>
Date: Fri, 19 Jun 2020 14:37:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-=igrJfoiga7b7rcwZDj46nTNMiT2VEj11DKO7OiJpNA@mail.gmail.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 03:15:03
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

On 19/06/20 14:18, Peter Maydell wrote:
> On Fri, 19 Jun 2020 at 12:16, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> On 19/06/20 07:46, Pavel Dovgalyuk wrote:
>>> I think, that we need some efforts from target maintainers to remove all such calls.
>>
>> I'll take care of target/i386 (which does need one of the three
>> gen_io_end calls that are left).
> 
> So why does it need it ? Why can't it just rely on "TB going to
> end anyway which will clear the can_do_io flag" ?

Because the TB is not always going to end in that case that is left.

>>>> Q2: is it a requirement that after an insn which is a "known
>>>> to be an I/O insn" one (like x86 in/out) and which is marked
>>>> up with gen_io_start()/gen_io_end() that we also end the TB?
>>>
>>> It is a requirement for instructions that access virtual clock/icount
>>> value (directly or not).
>>>
>>> There is also an assertion that can_do_io is enabled while generating an
>>> interrupt. I believe, that it doesn't affect RR, but is useful for
>>> deterministic icount mode.
>>
>> As I understand it, the definition of "I/O insn" is anything that can
>> either:
>>
>> - affect the icount deadline (e.g. by setting or removing a
>> QEMU_CLOCK_VIRTUAL timer)
>>
>> - interrupt the current translation block with cpu_loop_exit,
>> cpu_restore_state or similar.
> 
> Right, but really what I'm interested in is what the
> requirements are on translate.c code that emits one of these
> insns.

I would be interested in a precise definition of that as well (I've not
really done any icount work on the translation side).

Paolo

> The exact definition of what an I/O insn seems
> more straightforward (and you can always err on the safe side).
> 
> thanks
> -- PMM
> 


