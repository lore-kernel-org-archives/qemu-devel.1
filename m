Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B82C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 16:19:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B58F2073D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 16:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hSbjEzQM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B58F2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iorZl-0005T3-MC
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 11:19:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40253)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iorZ0-0004QF-L1
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:18:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iorYz-0006m8-3I
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:18:38 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28133
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iorYy-0006lb-VW
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:18:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578413915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=af5qc1kW1UxCBHBp1i3XNcqOR40WKwLPjAEKLkrMKmU=;
 b=hSbjEzQMxs4Q294QSAyTqH4mJNT7Ml34viV4rQQ+T/PK63yfYXU0gvV6kKRRYyX/uy9Zc0
 FBJN5T0utxnGp4jlzTbGKwCtao1lXbCktVn6okJtRL03LDKW0lxPdVkA6UMH3JH/iIz/+Y
 FRzq7+RQKORptxwaNqCpYco4O97HLJo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-KFMyDVQTM4CB-EXmoszJaA-1; Tue, 07 Jan 2020 11:18:34 -0500
Received: by mail-wm1-f71.google.com with SMTP id p2so41378wma.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 08:18:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=af5qc1kW1UxCBHBp1i3XNcqOR40WKwLPjAEKLkrMKmU=;
 b=hQ3HeXuIpmkzBDEPFHak0R8y92OOOJCIhvC6p+SL8UjQuSItsyOpyH7XRrvF+G8NdB
 xTdPTpI03IPaT8CVVB6A1PLSM4dim1bcIGM9tM7+6wLFXUUesXY4wzSf4dgZUxDn2Xms
 M5XDmSMgKAigl5VTzBa1wBcEshnm4j6sTV3IlDyRKFMrSfxOY/WL8UtsB/juori796FR
 wYIyKLVcYpfgySuLf8SdMd2+alZ+yd/dyQaEg++INEwgn5yWHyHX0nG/C3J3lFu2G/zP
 KnPb9oVuCFxwT0YsxdT3chIbkveJ9E6ZDtcaK4t/PiHBI+yrRoDlZfE8zuDdf8rFB3Ij
 JIEw==
X-Gm-Message-State: APjAAAX4o94+Z9HNqLr1uqaiPsQG8DuJoDlD8oujyfv5lrn2Xk+5MiHR
 B6UiCq1O9m3Id+0wfKEyYILsHYr3SPJq/kUTqgHCAGTU6SBcZYHBm5RbwnYAICiUv4RMFJ6oF8P
 NyfL6dZ1s6yaOiu8=
X-Received: by 2002:a05:600c:2406:: with SMTP id
 6mr35649192wmp.30.1578413913178; 
 Tue, 07 Jan 2020 08:18:33 -0800 (PST)
X-Google-Smtp-Source: APXvYqzlp4yGEOvjtN/bINsWALKoC+NVrugKLoCmp5iq1Xd/EdIS1Kk0mTztSnnWpre8N4EtCUhoQA==
X-Received: by 2002:a05:600c:2406:: with SMTP id
 6mr35649181wmp.30.1578413912946; 
 Tue, 07 Jan 2020 08:18:32 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c6d:4079:b74c:e329?
 ([2001:b07:6468:f312:c6d:4079:b74c:e329])
 by smtp.gmail.com with ESMTPSA id t190sm85174wmt.44.2020.01.07.08.18.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2020 08:18:32 -0800 (PST)
Subject: Re: [PULL 29/87] kvm: convert "-machine kernel_irqchip" to an
 accelerator property
To: Peter Maydell <peter.maydell@linaro.org>
References: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
 <1576670573-48048-30-git-send-email-pbonzini@redhat.com>
 <CAFEAcA-qbxVxR6qWRjPjfXf+XQzoA=D6LfhDJ2Do4LfZALZ-EA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8dff7f70-c06b-0757-3b8b-712bde8c733a@redhat.com>
Date: Tue, 7 Jan 2020 17:18:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-qbxVxR6qWRjPjfXf+XQzoA=D6LfhDJ2Do4LfZALZ-EA@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: KFMyDVQTM4CB-EXmoszJaA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/01/20 15:46, Peter Maydell wrote:
> On Wed, 18 Dec 2019 at 12:26, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
>> +static void kvm_set_kernel_irqchip(Object *obj, Visitor *v,
>> +                                   const char *name, void *opaque,
>> +                                   Error **errp)
>> +{
>> +    Error *err = NULL;
>> +    KVMState *s = KVM_STATE(obj);
>> +    OnOffSplit mode;
>> +
>> +    visit_type_OnOffSplit(v, name, &mode, &err);
> 
> Coverity complains that this call uses 'mode' uninitialized,
> which seems correct since it starts off with 'value = *obj'.
> (CID 1412230)

The visitor here is not supposed to look at value (rather it should fill
it in)---but yeah this is an ugly part of the visitor API that we can
work around most simply by initializing mode.

Paolo

> 
>> +    if (err) {
>> +        error_propagate(errp, err);
>> +        return;
>> +    } else {
>> +        switch (mode) {
>> +        case ON_OFF_SPLIT_ON:
>> +            s->kernel_irqchip_allowed = true;
>> +            s->kernel_irqchip_required = true;
>> +            s->kernel_irqchip_split = false;
>> +            break;
>> +        case ON_OFF_SPLIT_OFF:
>> +            s->kernel_irqchip_allowed = false;
>> +            s->kernel_irqchip_required = false;
>> +            s->kernel_irqchip_split = false;
>> +            break;
>> +        case ON_OFF_SPLIT_SPLIT:
>> +            s->kernel_irqchip_allowed = true;
>> +            s->kernel_irqchip_required = true;
>> +            s->kernel_irqchip_split = true;
>> +            break;
>> +        default:
>> +            /* The value was checked in visit_type_OnOffSplit() above. If
>> +             * we get here, then something is wrong in QEMU.
>> +             */
>> +            abort();
>> +        }
>> +    }
>> +}
> 
> 
> thanks
> -- PMM
> 


