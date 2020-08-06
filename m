Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D79C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:16:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFBB3204FD
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d3FspSac"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFBB3204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3c7G-0001Y0-TR
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 05:23:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49418)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3c6X-00017K-F2
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 05:22:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48559
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3c6V-0005l2-Oi
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 05:22:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596705746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YVCxsIxNYIIg84fCi1L/mXH9GaN8oefsfthOkBczvTI=;
 b=d3FspSachAUHphMUBT3ytMVOazgiUekLyxyZvWG4TF/RYP4Af1uMBgNPLy0quVzaGQkW8E
 /LmC6FWnBM1X4Fc1rlLJZgwXTM63gjoJVpOIh9sF9IOKRVIKocQBNOnL1yBFQaQlRgefNw
 +sE3CpkrnGumTZCXdSAx8Tqi7MgeQg0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-WyOHENyEP1GULs8Cd7Efaw-1; Thu, 06 Aug 2020 05:22:25 -0400
X-MC-Unique: WyOHENyEP1GULs8Cd7Efaw-1
Received: by mail-wm1-f72.google.com with SMTP id c124so3349284wme.0
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 02:22:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YVCxsIxNYIIg84fCi1L/mXH9GaN8oefsfthOkBczvTI=;
 b=FKA8UcAWh/LlOXnY3NUwuANCIHC9wXlMDpFthWJDUt9IKUk2DyRZT5yALCk6/mqz2e
 oHg3MwcBgjqu75jzuP/YfSn/tA/DW9PnPdBrf7lemWUoS3j5Kzoal1c67el6CiMkjdcv
 w1+qw7tP7bhj/0Aa4Htw8y8Gw7Bgdgv8hnkniWtNVDPpa8N5hGJnEhkxRh3UlX+cekIj
 fn8Q5odYuhCFTxvkBB677kz6HJfMv9pEW4EAwi+Lt1mP8urKI1wjaf5xVhxsRzB+YW90
 rim0XDu6nfHgAho36nevKyoUM7I4iGpN8j7jYV7Z6jfk1M+WZyUsKox3D9KrEZSem06Q
 H+/A==
X-Gm-Message-State: AOAM5300zvKcLIhu0AnTrvFYSP43ZPFdZFuvRVoggWCjS2mwrp2T583n
 pBwk8j/dda/E5SI4D6pBg6o/QfrVP4C6i7e/TNJ0wcuMeiEjM155oYNU/vIaliPN7lcWUMhVvns
 U6rVTfV1XNtqnqjA=
X-Received: by 2002:adf:eccc:: with SMTP id s12mr7254673wro.157.1596705744030; 
 Thu, 06 Aug 2020 02:22:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyQk4U+7MLsqzyqFGmIxaNm0MFk0Z61miYK8TKIFYZhGSpLYy0btT6kPeGgI9wzryhymcZn1g==
X-Received: by 2002:adf:eccc:: with SMTP id s12mr7254648wro.157.1596705743786; 
 Thu, 06 Aug 2020 02:22:23 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7841:78cc:18c6:1e20?
 ([2001:b07:6468:f312:7841:78cc:18c6:1e20])
 by smtp.gmail.com with ESMTPSA id y203sm6121359wmc.29.2020.08.06.02.22.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2020 02:22:23 -0700 (PDT)
Subject: Re: [PATCH v1 01/21] accel/tcg: Change interrupt/exception handling
 to remove implied BQL
To: Richard Henderson <richard.henderson@linaro.org>,
 Robert Foley <robert.foley@linaro.org>, qemu-devel@nongnu.org
References: <20200805181303.7822-1-robert.foley@linaro.org>
 <20200805181303.7822-2-robert.foley@linaro.org>
 <ca24d2c5-2c5e-eace-4cf2-90011e684485@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4e678ed7-fc36-7918-ce9e-7a7e309c56df@redhat.com>
Date: Thu, 6 Aug 2020 11:22:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <ca24d2c5-2c5e-eace-4cf2-90011e684485@linaro.org>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 00:24:10
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
Cc: peter.puhov@linaro.org, cota@braap.org, alex.bennee@linaro.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/08/20 21:18, Richard Henderson wrote:
> On 8/5/20 11:12 AM, Robert Foley wrote:
>> This change removes the implied BQL from the cpu_handle_interrupt,
>> and cpu_handle_exception paths. This BQL acquire is being pushed
>> down into the per arch implementation.
>>
>> Signed-off-by: Robert Foley <robert.foley@linaro.org>
>> ---
>>  accel/tcg/cpu-exec.c | 19 +++++++++++--------
>>  1 file changed, 11 insertions(+), 8 deletions(-)
>>
>> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
>> index 80d0e649b2..8e2bfd97a1 100644
>> --- a/accel/tcg/cpu-exec.c
>> +++ b/accel/tcg/cpu-exec.c
>> @@ -517,9 +517,7 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
>>  #else
>>          if (replay_exception()) {
>>              CPUClass *cc = CPU_GET_CLASS(cpu);
>> -            qemu_mutex_lock_iothread();
>>              cc->do_interrupt(cpu);
>> -            qemu_mutex_unlock_iothread();
>>              cpu->exception_index = -1;
>>  
> 
> This patch is not bisectable.  The removal of the lock here needs to happen at
> the end, or something.

Indeed the series should be structured like this:

1) rename all *_do_interrupt functions to *_do_interrupt_locked

2) add back *_do_interrupt that takes the BQL and calls
*_do_interrupt_locked, point ->do_interrupt to it, remove the BQL from
cpu-exec.c

3) modify the cpu_mutex and BQL critical sections around
->cpu_exec_interrupt, so that the BQL critical section covers just the
call to ->cpu_exec_interrupt.  Document which fields are now covered by
cpu_mutex.

4/5) same as 1/2 for ->cpu_exec_interrupt

Patches 1/2 would be pretty large, but they're trivial to review just by
grepping for "->do_interrupt\s*=", and likewise for 4/5.

Thanks,

Paolo


