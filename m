Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D07C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 14:27:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 736FF2176D
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 14:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jKeypN1b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 736FF2176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaKlg-0000SU-FX
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 09:27:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37837)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iaKDn-0006aF-TY
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 08:52:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iaKDd-00071B-It
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 08:52:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27247
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iaKDd-0006js-Do
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 08:52:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574949145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SGCbpaHpF1H1MImu0dEy65dgZ6Op5SK82aXIs9CJRYI=;
 b=jKeypN1bC9nbEYMbfTNg06LHV9K4AjTdpqlV/39++C20L49Iib/uebCzUxjIhS9S+rLhMR
 2wJfhxLQiZxS8OcacBccHv+UPncYfRM/CrY+R0FVnaLGQXg/7l6xiPaz3qPRt/0Vz7Yvvq
 fZAraKbWauWgJFN/ATjTNcfoml0xKfI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-1-DJ4-2DPTOgJHSzw0bTLA-1; Thu, 28 Nov 2019 08:52:22 -0500
Received: by mail-wr1-f72.google.com with SMTP id h7so13938751wrb.2
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 05:52:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SGCbpaHpF1H1MImu0dEy65dgZ6Op5SK82aXIs9CJRYI=;
 b=D46MMGhQtoyFFa/ise19fp5sld6kZUs1rt1QDG+chtDoq0Wc7jBwjNnPIc8KNLhQkF
 tY3yTjJ9iZR28e3o6YLtO9MGZla357ru74o3pPfwaRcCTZkUNp8Jn3Y7fWDGnTkZTeSZ
 oFAZtJFNuzdiDjjRawnWGWK869/61oGnHVEn3SIrG6Z6eajvhjUcjovJwTXulqSM/+pQ
 SJfO+R8lsH541UVJYfgr3gw5YJLxEm+CrUK3BJYicB3tCFEWhkr5zuDW7cu7ZdW1Ri4i
 7iAsyvmaW2yXOag/yMyCUppOYmr8Oq120/vmZx/uWNIUyD571hkv2GW7iSdKmZOZZFBN
 Deaw==
X-Gm-Message-State: APjAAAXc//fuccJWrBi10bI4yNwecUCECW0ksWIs8RhOfZF6aARJik3t
 Zm65rB7jtUJSwx12BMTOqIMOh79HGF5XAtW10rXQDwIqejKpfELpoQUlARzmJwuDSuYs2+qgV19
 +loR03kUdTabQV94=
X-Received: by 2002:a5d:5091:: with SMTP id a17mr927642wrt.362.1574949140991; 
 Thu, 28 Nov 2019 05:52:20 -0800 (PST)
X-Google-Smtp-Source: APXvYqw8eOjBTnXUhOmAcHEPLwaZZkIJc8IXP3v3jLYmCjXlPEOmsZYqUUrADpabxW1SI7vtCzOXcw==
X-Received: by 2002:a5d:5091:: with SMTP id a17mr927618wrt.362.1574949140609; 
 Thu, 28 Nov 2019 05:52:20 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:459f:99a9:39f1:65ba?
 ([2001:b07:6468:f312:459f:99a9:39f1:65ba])
 by smtp.gmail.com with ESMTPSA id r2sm10954051wma.44.2019.11.28.05.52.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Nov 2019 05:52:19 -0800 (PST)
Subject: Re: [PATCH v2 5/5] hvf: save away type as well as vector so we can
 reinject them
To: Cameron Esfahani <dirty@apple.com>
References: <cover.1574625592.git.dirty@apple.com>
 <e07e6085d8ab9054e58f85ae58e112df6adc024d.1574625592.git.dirty@apple.com>
 <eb3a2de7-fcfe-f0d5-8534-1c59ff40f61e@redhat.com>
 <5F8C8B54-3653-4417-9A08-E724032294F9@apple.com>
 <524CCF5D-EED6-4710-A561-6AD634015F5F@apple.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <19f45c8c-7029-6fd7-6dd0-59541a99b9a2@redhat.com>
Date: Thu, 28 Nov 2019 14:52:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <524CCF5D-EED6-4710-A561-6AD634015F5F@apple.com>
Content-Language: en-US
X-MC-Unique: 1-DJ4-2DPTOgJHSzw0bTLA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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

On 28/11/19 06:57, Cameron Esfahani wrote:
> 
> What we were seeing was, under heavy loads, running many concurrent
macOS VMs, that we would get spurious interrupts.  Tracking it down, we
discovered that VMCS_INTR_T_SWINTR was getting injected when
VMCS_INTR_T_HWINTR was expected.
> 
> If I take our proposed patch code, which built on top of master from a
> few days ago, and has fd13f23b8c95311eff74426921557eee592b0ed3,  and add
> an assert, like the following:
> 
>>     if (env->interrupt_injected != -1) {
>>         /* Type and vector are both saved in interrupt_injected. */
>>         vector = env->interrupt_injected & VMCS_IDT_VEC_VECNUM;
>>         intr_type = env->interrupt_injected & VMCS_IDT_VEC_TYPE;
>>         if (VMCS_INTR_T_SWINTR != intr_type) {
>>             printf("VMCS_INTR_T_SWINTR (%x) != intr_type (%llx)\n", VMCS_INTR_T_SWINTR, intr_type);
>>             assert(VMCS_INTR_T_SWINTR == intr_type);
>>         }
>>     } else if (env->exception_nr != -1) {
> 
> Then we will see the assert trigger and get the following output:
> 
>> VMCS_INTR_T_SWINTR (400) != intr_type (0)
>> Assertion failed: (VMCS_INTR_T_SWINTR == intr_type), function hvf_inject_interrupts, file qemu_upstream/target/i386/hvf/x86hvf.c, line 362.

Great, thanks.  It's good to know that it's only software vs. hardware
interrupt.  I'll compare the KVM and QEMU source code to see why KVM
does not lose software vs. hardware interrupt, since the QEMU event
injection code was modeled against KVM's.

Paolo


