Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882C7C433E1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:20:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53B5522DBF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:20:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i71UcZBj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53B5522DBF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3bzM-0006LQ-Ke
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 05:15:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3byU-0005VF-FV
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 05:14:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25049
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3byT-0004rl-1G
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 05:14:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596705247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=731Q14db66V9di9dbOv+mpl8HAnEsqVTkra1MagnkT8=;
 b=i71UcZBjbevNGGNurTlq6jNoYwTyqy0CX7A9oQxg5EjHLfvvu93J2ZnQ1APjLSogGmgjGs
 R0f5cmWySRQtvrN5I89VZRwDD0nKz47e3AOXWN7GvvdqmDd7dh0x1uZ4f1EO9ZSawD9x+a
 QEjYUizKCGJmiKWXsSH/mpsRjjwRVFE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-129-yMvA0I7fMV-58a4gjXjIwg-1; Thu, 06 Aug 2020 05:13:01 -0400
X-MC-Unique: yMvA0I7fMV-58a4gjXjIwg-1
Received: by mail-wm1-f72.google.com with SMTP id c184so2774528wme.1
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 02:13:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=731Q14db66V9di9dbOv+mpl8HAnEsqVTkra1MagnkT8=;
 b=a2Cda0KAiPzm9Iqf06ZcQJ5IrkIAE3+BuVEKtvxMvcn7AOPWrM13Q7IBc94Xzfa6O/
 AjQtCAvNqTCbZbpiPBh6TM+24f/wy0/XnEFt+iJCf7knGoCeJiwxAurGDqaPbL+ZFi8e
 TxfkCoS8FwJOIrNjJ9NBSH6dHuVHWisUAJmZBmD58vr+u3GEm7KkkKsQ5wUum6l422gH
 CkU7WWO2iNvLg/FtriqgmiDFCpZIj5TYw/2tU1fEm6lpjt6YJJC0lDhcQ9DgXpOy/Lf7
 gE0nZgZGF+Gr/c6uLEN6/3baqE7y1UBtDA0esEcIK+eQ070j3YASBMM7SpvbH/jUd3m5
 gbLg==
X-Gm-Message-State: AOAM531wFChDgkVYmfnSFdFaEXEC2T6MR/WGEeJrTNHoAxIZv9Fjbc/T
 +DLE8gAtF8BRcyWPffDDicSdfbVWsjEPnhhY1fY+wtMOLtUSXbFI3GjPEaflCLfbWQfYsK+om2k
 CAOUy5S42w4Rew7U=
X-Received: by 2002:adf:f485:: with SMTP id l5mr6006426wro.147.1596705180631; 
 Thu, 06 Aug 2020 02:13:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxiOHzSJVJUilRbNFQ2NU0Tw+yU1OGEc6kpiVvoagzIP14J/3/WL22N+tHONTf6Sy9jYXAQ4A==
X-Received: by 2002:adf:f485:: with SMTP id l5mr6006408wro.147.1596705180356; 
 Thu, 06 Aug 2020 02:13:00 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7841:78cc:18c6:1e20?
 ([2001:b07:6468:f312:7841:78cc:18c6:1e20])
 by smtp.gmail.com with ESMTPSA id x11sm5481966wmc.33.2020.08.06.02.12.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2020 02:12:59 -0700 (PDT)
Subject: Re: [PATCH v1 17/21] target/s390x: add BQL to do_interrupt and
 cpu_exec_interrupt
To: Cornelia Huck <cohuck@redhat.com>, Robert Foley <robert.foley@linaro.org>
References: <20200805181303.7822-1-robert.foley@linaro.org>
 <20200805181303.7822-18-robert.foley@linaro.org>
 <20200806105923.2bd2b0de.cohuck@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fefaec2a-0bb3-80e8-7798-7537530ba041@redhat.com>
Date: Thu, 6 Aug 2020 11:12:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200806105923.2bd2b0de.cohuck@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-devel@nongnu.org, "open list:S390 TCG CPUs" <qemu-s390x@nongnu.org>,
 cota@braap.org, peter.puhov@linaro.org, alex.bennee@linaro.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/08/20 10:59, Cornelia Huck wrote:
>>      bool stopped = false;
>> -
>> +    bool bql = !qemu_mutex_iothread_locked();
>> +    if (bql) {
>> +        qemu_mutex_lock_iothread();
>> +    }
> I'm not sure I like that conditional locking. Can we instead create
> __s390_cpu_do_interrupt() or so, move the meat of this function there,
> take the bql unconditionally here, and...
> 

Agreed, except the usual convention would be s390_cpu_do_interrupt_locked.

Paolo


