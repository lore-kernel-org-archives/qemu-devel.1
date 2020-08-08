Return-Path: <SRS0=zX6u=BS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BD4C433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2020 12:01:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54AFC20759
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2020 12:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KovJP+uz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54AFC20759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k4NXa-0003Nt-IA
	for qemu-devel@archiver.kernel.org; Sat, 08 Aug 2020 08:01:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54342)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k4NWf-0002bw-V2
 for qemu-devel@nongnu.org; Sat, 08 Aug 2020 08:00:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47737
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k4NWd-00029I-E7
 for qemu-devel@nongnu.org; Sat, 08 Aug 2020 08:00:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596888033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ds3PDR083NBIh+4L3ioQQpsx5ynu3bdau6xl1aWQ+UU=;
 b=KovJP+uz3rduw41Ao2145tduA5CLOsInXG1ZvnziLzzgQqFiYwXs9q5j5qcJe086pVm3p8
 KJisBePP9HcmfwhQA8ha9IMODL+xPAFYk0ZVV3mBwRJpKPaJnTbIIhzSg2gDi1iMZE2Fnk
 ptEfHsH6vwqckTyvRdNy/PNMfLrVpbc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-KsiIxqCrNJOLj1wX1pqWRw-1; Sat, 08 Aug 2020 08:00:31 -0400
X-MC-Unique: KsiIxqCrNJOLj1wX1pqWRw-1
Received: by mail-wr1-f72.google.com with SMTP id t3so1877229wrr.5
 for <qemu-devel@nongnu.org>; Sat, 08 Aug 2020 05:00:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ds3PDR083NBIh+4L3ioQQpsx5ynu3bdau6xl1aWQ+UU=;
 b=f7+QMp9nwHSEI0gIM2A2SZgxHq2W55vsClxKuMbyt9GbWC7BgCnJIDjf+t96OOCpbY
 p9cOb2rFHCOhw/kE1vTLPtdjo6Keh5BFcrv7QQqINUa6PkYRWfkRK+8wkOa0npzRQSZk
 5WvLvfcqdunpSJ7JTPiS/cEiMzj75qZuYd3qjJIKq8cJv3t3tEndoMSGxGfNpXOonXnU
 WQk+j3vOHAl2NQenDhKq/YJKJs+jQ4bdDli1aVPUn2mFSbmICvuJZoHCgteCHk3Baz5M
 DwLehqVEITITtzkMYXhvj2HreZ8W+R3Ij2btg1bGCpeHUYLa591GIXqkNu9Na41SP9Yd
 GQJQ==
X-Gm-Message-State: AOAM533hYlnqJcAT+1icgHk9z0hrRYmX3YD5hnuyJRp4PQBRSsdAXX3E
 eSft9rDSmTV7+F8l5Tt3vGfmwAJe1YsSIEdSr5qADa1pC0BFyrReq0eOM+SIgiFBLC+0lXK/hfe
 bI7QJqGSKOMB/5d0=
X-Received: by 2002:a1c:7e44:: with SMTP id z65mr17910465wmc.13.1596888029889; 
 Sat, 08 Aug 2020 05:00:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw2AnvTAdrvI3u593Hcsu6O+UgON7fwEBBPsJA+cpRd+OR7lIT+JDbNXTzq2R95mLPZWWv6Cw==
X-Received: by 2002:a1c:7e44:: with SMTP id z65mr17910436wmc.13.1596888029588; 
 Sat, 08 Aug 2020 05:00:29 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:310b:68e5:c01a:3778?
 ([2001:b07:6468:f312:310b:68e5:c01a:3778])
 by smtp.gmail.com with ESMTPSA id l10sm13553687wru.3.2020.08.08.05.00.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 08 Aug 2020 05:00:28 -0700 (PDT)
Subject: Re: [PATCH v1 01/21] accel/tcg: Change interrupt/exception handling
 to remove implied BQL
To: Robert Foley <robert.foley@linaro.org>
References: <20200805181303.7822-1-robert.foley@linaro.org>
 <20200805181303.7822-2-robert.foley@linaro.org>
 <ca24d2c5-2c5e-eace-4cf2-90011e684485@linaro.org>
 <4e678ed7-fc36-7918-ce9e-7a7e309c56df@redhat.com>
 <CAEyhzFvveC=nhpo4uyJ_89J8Wi4+9NEc2T2Mk9mg6Y9ZMQjNSA@mail.gmail.com>
 <CAEyhzFvh79ViuXYLYyihTBS3d5dviGpOXjntAt95yyuwE+HwLA@mail.gmail.com>
 <CAEyhzFsMgQWr=sOM43-w3jwSgNyUiKMRKFGdRGRqxM5=offsGA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e1cad321-b24d-dd72-cd9c-541940a8d8d6@redhat.com>
Date: Sat, 8 Aug 2020 14:00:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAEyhzFsMgQWr=sOM43-w3jwSgNyUiKMRKFGdRGRqxM5=offsGA@mail.gmail.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/08 08:00:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, "Emilio G. Cota" <cota@braap.org>,
 Peter Puhov <peter.puhov@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/08/20 00:18, Robert Foley wrote:
> 2) Another perhaps cleaner option is to add a new cpu class function
> ->do_interrupt_locked.
>    This lets callers like *_cpu_exec_interrupt call to ->do_interrupt_locked
>    with lock held and solves the issue without resorting to conditional locking.
> 
>    Another benefit we could gain from this approach is to simplify our solution
>    overall by adding a common do_interrupt function.
> 
>    void cpu_common_do_interrupt(CPUState *cs)
>    {
>         CPUClass *cc = CPU_GET_CLASS(cpu);
>         qemu_mutex_lock_iothread();
>         cc->do_interrupt_locked(cpu);
>         qemu_mutex_unlock_iothread();
>     }
>    cc->do_interrupt would be set to cpu_common_do_interrupt by default
> in cpu_class_init.
>    In other words, the base cpu class would handle holding the BQL for us,
>    and we would not need to implement a new *_do_interrupt function
> for each arch.
> 
> We are thinking that 2) would be a good option.

Yes, it is.  The only slight complication is that you'd have both
->do_interrupt and ->do_interrupt_locked so you probably should add some
consistency check, for example

    /*
     * cc->do_interrupt_locked should only be needed if
     * the class uses cpu_common_do_interrupt.
     */
    assert(cc->do_interrupt == cpu_common_do_interrupt ||
           !cc->do_interrupt_locked);

Therefore, a variant is to add ->do_interrupt_locked to ARMCPUClass and
CRISCPUClass (target/avr/helper.c can just call
avr_cpu_do_interrupt_locked, because that's the only value that
cc->do_interrupt can have).  Then ARM and CRIS can have a do_interrupt
like you wrote above:

void arm_do_interrupt(CPUState *cs)
{
    ARMCPUClass *acc = ARM_CPU_GET_CLASS(cs);
    qemu_mutex_lock_iothread();
    acc->do_interrupt_locked(cpu);
    qemu_mutex_unlock_iothread();
}

with a small duplication between ARM and CRIS but on the other hand a
simpler definition of the common CPUClass.

Paolo


