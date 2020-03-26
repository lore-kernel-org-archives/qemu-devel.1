Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A740C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 20:16:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20B6820719
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 20:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L2+k0+Lu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20B6820719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHYvl-0007Cn-7j
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 16:16:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34096)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jHYkj-0006Kq-3f
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 16:05:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jHYkh-0000dI-4n
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 16:05:20 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:58798)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jHYkg-0000c9-VK
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 16:05:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585253118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ErY7UtjOtKlkaCV79EY8IujFefhusVnoOtX8SKn0gMg=;
 b=L2+k0+LuEslmHwoBR0OhgBm8KtcXn+bOqirZvUxw6O9RcWtHiums4zbbCPbfQny7NbN+KT
 YeELqQpZAOKhvH6Kx7muk5MHunXDFMWKy1eCiKKZ7pAFKuPqTQW0jpjNixlTuwPl7Uz3So
 8QFdorKuuuZqz6mjuXrGw8dE1ZUjBNg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-vaK-q7uuPvqpe_-eYzCojw-1; Thu, 26 Mar 2020 16:05:16 -0400
X-MC-Unique: vaK-q7uuPvqpe_-eYzCojw-1
Received: by mail-wm1-f69.google.com with SMTP id f8so3058894wmh.4
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 13:05:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ErY7UtjOtKlkaCV79EY8IujFefhusVnoOtX8SKn0gMg=;
 b=Pdcs8rC1WoFk/O0TAonEE6OnSDW7koMAJdBTR9rk+7hha162y3D/y00N2sK/IbWpjl
 p2j6OZ07iRHQ/MQUu+Igw23aPE2CaCNJNB91mTOFuU29AXP7ZwW10L4vHAVzJYv4OMGf
 RkVR+2Zv1M3SqbvXmc9xGS9JZ/pTCzYQZHocf5GPwH3r0EwYseferFV/nPLm1Yvn5wuz
 7lns/JNA/nl1qlZIvcN00jDr0vkNBcvoxZ6l1Fp8fA+XzrrzKNLF3KSxTeJN4bRfYOe2
 hmTg37Be/0fQaI3ojhnHaBZjq0rM1h1lXChwD2wsYBJc9RAlCuR2Bp0gA698AtMxa1ON
 X7Vg==
X-Gm-Message-State: ANhLgQ3DlS0XzEJEL/9X+Wgj45RJ0wIeeza6yU6k1a2u5pXXp83slAr4
 mcAzx6+5Lxi/DuYxKn5stZlJHSCZFEsGl28lqAkG+WXGY5LepYyd9h8jp5Hq1TUq9UdMv8yUyJR
 XVXPnG0YlSTeVLyo=
X-Received: by 2002:a7b:cbcf:: with SMTP id n15mr1759292wmi.13.1585253115026; 
 Thu, 26 Mar 2020 13:05:15 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vu5CNMeM4VfCie2Iu39C5/Giil0peWaRpIWCSTNNq6x1L6P6UUFTK4qADXyU+GozR6HtMd4Sg==
X-Received: by 2002:a7b:cbcf:: with SMTP id n15mr1759269wmi.13.1585253114782; 
 Thu, 26 Mar 2020 13:05:14 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
 by smtp.gmail.com with ESMTPSA id c5sm12308679wma.3.2020.03.26.13.05.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Mar 2020 13:05:14 -0700 (PDT)
Subject: Re: [PATCH] qemu/atomic.h: add #ifdef guards for stdatomic.h
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
References: <20200326170121.13045-1-alex.bennee@linaro.org>
 <fd05f470-1c3f-3357-ac91-26c06379bee2@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f01e8676-ce02-dcb1-e614-822699eb97d8@redhat.com>
Date: Thu, 26 Mar 2020 21:05:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <fd05f470-1c3f-3357-ac91-26c06379bee2@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/03/20 20:58, Richard Henderson wrote:
>> +
>> +#ifndef atomic_fetch_add
>>  #define atomic_fetch_add(ptr, n) __atomic_fetch_add(ptr, n, __ATOMIC_SEQ_CST)
>>  #define atomic_fetch_sub(ptr, n) __atomic_fetch_sub(ptr, n, __ATOMIC_SEQ_CST)
>>  #define atomic_fetch_and(ptr, n) __atomic_fetch_and(ptr, n, __ATOMIC_SEQ_CST)
>>  #define atomic_fetch_or(ptr, n)  __atomic_fetch_or(ptr, n, __ATOMIC_SEQ_CST)
>>  #define atomic_fetch_xor(ptr, n) __atomic_fetch_xor(ptr, n, __ATOMIC_SEQ_CST)
>> +#endif
> Do we really get sequential consistency from <stdatomic.h>?

Yes, it's the default value (to pass a memory order you need
atomic_fetch_*_explicit).

Paolo

> Should we not in fact #undef as a workaround instead?


