Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39965C32771
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 08:04:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 031FA2071E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 08:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O1zqh25n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 031FA2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ivzNO-00029L-7v
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 03:04:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44965)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ivzMZ-0001kV-IV
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 03:03:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ivzMY-0007sr-As
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 03:03:15 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46260
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ivzMY-0007s6-6u
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 03:03:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580112193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8/xGhtiPQtjKKKC3qi9rqHu9uzydwTvYDHnYP96c634=;
 b=O1zqh25n58/2wzSq6Egyudk8aM8BepmCypsq7ACH0oMOuxbG0eitZK/ZYoG1zBgJLa540f
 IMAiHz7K3HcI7SgY1A+0naKsagtVRBeo1B082EGsJYHq4Iq6N/qPDo79Ptjksg0u0/j2x+
 tFNEKQrfrbWIZW8lxTOvd64yIv+Lvxk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-MO3kNdXJMoq17gpnWYzjhg-1; Mon, 27 Jan 2020 03:03:12 -0500
Received: by mail-wr1-f71.google.com with SMTP id v17so5649680wrm.17
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 00:03:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8/xGhtiPQtjKKKC3qi9rqHu9uzydwTvYDHnYP96c634=;
 b=Gn/CtsYP9mKHUz8Wl5P5aJoSWuqaYp7GViAjOLwulLfxKHQkFiQz3cKbKwxJqvCHQV
 rT866LOT661Eg65n2Ehxno5VmvYBJLd15OYwM/iND/q24JzooR1gAOaLG5GltyXCJaj/
 ce6Qc65Kza+nMKCosRFZxW4cQY31o20+XxLYPlv4ic+fkfc6x7C0xa+flKfZwGJ6zw5s
 Y4IvZGUi9U7g0atDEfeMRcueZ1ZPZhuCgFEZeOK8wyh6Krj1DuF8yWj1dIv2+SPYnsFV
 mVwdUgZzU3nTlSuJ3TwkKZL16OFAse5ulwfygY/gOuvJ+d53drzXpP83bkVimakOzL8z
 7k9A==
X-Gm-Message-State: APjAAAXci/OInu4HNQmIrrJSe9zDaQEpxZvIUQv6n2AuXrz7++wAalaU
 jlUQ7cGOpQS5BxzmgtwAloiJKFoifmiMnq3VKk2bthmQzhXy5SrlWvJuB09cm19QD5/5W8SXFqu
 o0AN9N7Ve2ETE6EM=
X-Received: by 2002:adf:ebc1:: with SMTP id v1mr20880054wrn.351.1580112190683; 
 Mon, 27 Jan 2020 00:03:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqyQEX23FSnMlRbHcyeB6yEFzLYmDllBGD3aPsWexlFiROcob8ClL6NbISOCVYKAGbdYvAxvyg==
X-Received: by 2002:adf:ebc1:: with SMTP id v1mr20880019wrn.351.1580112190440; 
 Mon, 27 Jan 2020 00:03:10 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id z4sm17533772wma.2.2020.01.27.00.03.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jan 2020 00:03:09 -0800 (PST)
Subject: Re: [PATCH rc3 02/30] target/avr: Introduce AVR CPU class object
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
References: <1580079311-20447-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1580079311-20447-3-git-send-email-aleksandar.markovic@rt-rk.com>
 <CAL1e-=h5v5nXBkoxhSx6inU6G59AHca_8_XrkOsX13C7uRU1jA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8743beb5-22e1-4500-7e81-649298316580@redhat.com>
Date: Mon, 27 Jan 2020 09:03:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAL1e-=h5v5nXBkoxhSx6inU6G59AHca_8_XrkOsX13C7uRU1jA@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: MO3kNdXJMoq17gpnWYzjhg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.81
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
Cc: Michael Rolnik <mrolnik@gmail.com>, Sarah Harris <S.E.Harris@kent.ac.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/27/20 3:39 AM, Aleksandar Markovic wrote:
>> +static void avr_cpu_initfn(Object *obj)
>> +{
>> +    AVRCPU *cpu = AVR_CPU(obj);
>> +
>> +    cpu_set_cpustate_pointers(cpu);
>> +
>> +#ifndef CONFIG_USER_ONLY
>> +    /* Set the number of interrupts supported by the CPU. */
>> +    qdev_init_gpio_in(DEVICE(cpu), avr_cpu_set_int,
>> +            sizeof(cpu->env.intsrc) * 8);
>> +#endif
>> +}
> 
> A question for Michael:
> 
> What is CONFIG_USER_ONLY doing here, if we know AVR cores from this
> series doesn't have and will never have user mode, since they do not
> work with the kernel?
> 
> Do you plan to support some AVR 32-bit CPUs in the same file, which
> would be able to have linux-user mode? But, in this case, many files
> must be completely redone. My advice is to separate them completely,
> and that this file supports only 8-bit AVR cores, and in that case
> checks for CONFIG_USER_ONLY do not make sense.

You are right, CONFIG_USER_ONLY doesn't make sense.

Suggestion: add in target/avr/cpu.h:

   #ifdef CONFIG_USER_ONLY
   #error "AVR 8-bit does not support user mode"
   #endif


