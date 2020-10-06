Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA5F0C41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 16:28:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11DA0206D4
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 16:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YUW0jt5m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11DA0206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPpos-0005CR-73
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 12:28:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPphI-0007Mg-R2
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 12:20:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44367)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPphF-0005yj-UN
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 12:20:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602001211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1ZqRsb5H/weW70ggx7GtfdhvmfEiFZX/PVMuo6tIdIk=;
 b=YUW0jt5maQxlR+r4odb985aUqRJhf9E+7yiLzhh8XRbje7Ki5P09kAYDdRGqlA0XZSOOpw
 X/nPKqrIriWd6OEQQ/xXM6g6+OF63h5t48wZ9BVIRF5ciML7CpGk0+R6QevwDkF0Kbvgc9
 szrJaVnXCMF/c4mIOuDwxIted9T+HwY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-ctmukmDiMG2lC_IVIhlAcQ-1; Tue, 06 Oct 2020 12:20:10 -0400
X-MC-Unique: ctmukmDiMG2lC_IVIhlAcQ-1
Received: by mail-wm1-f72.google.com with SMTP id 21so1303287wma.7
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 09:20:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=1ZqRsb5H/weW70ggx7GtfdhvmfEiFZX/PVMuo6tIdIk=;
 b=eOSFF58quD7w5DE22sRsP6Txrqu53oED5OIX3vXurPQok1kfZ207g39JiEocm4cFoX
 +x/2vtewTLiu1jdpkFqbV/0vyabjHv+WVpbKCLo+VZiFO8AxWvVhqKRZG4QEuKfHMJp1
 zP8QAMem2VFrdfCYjJ5zthcimc1nzJr8BNgI3CsEBfRWlf/e3gCBaqNBEO8+75eR/aYv
 O0lzXpSzuMBpPjhFCX2ectYDiUrES4IwRgny9WSOyRGCOzpx6673F6jbKSYVs+0XDgRy
 uqsp/O8s3KqEKi5LEY3aIJN+12lt+6hQR0wh65x57sSzgBxfSSqhaLMPkpJJYfAxAsaW
 apxw==
X-Gm-Message-State: AOAM530N+NCsQlsz3XE0ELd/VZuuYN2bJE2HC34bXAWfYw+fL9X5ct0W
 0nqwrDTkwwFGKiOnmzOvYbdS99LWDvCUAYRvbCbDdb1Fc2QFJkn/tRcqX93MbLakDnVXcUaIxwY
 KZ+lOBjzS94vVFy4=
X-Received: by 2002:a1c:7708:: with SMTP id t8mr5613442wmi.6.1602001208934;
 Tue, 06 Oct 2020 09:20:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyq0KkqSVM7552/GYLySqMe/LW3s3MK3CvK1PtQFqOXvQuErhr8jCzMrNIwPMra60vuwgQiYg==
X-Received: by 2002:a1c:7708:: with SMTP id t8mr5613425wmi.6.1602001208746;
 Tue, 06 Oct 2020 09:20:08 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id u127sm4965935wmu.48.2020.10.06.09.20.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2020 09:20:08 -0700 (PDT)
Subject: Re: [PATCH v3 1/1] hw/nvram: Always register
 FW_CFG_DATA_GENERATOR_INTERFACE
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20201006153636.2383248-1-philmd@redhat.com>
 <20201006153636.2383248-2-philmd@redhat.com>
 <134bbd15-c53c-7686-a36d-f02a81b56e0d@linaro.org>
 <700d357f-e214-8ba6-910f-78b857757d32@redhat.com>
 <a73ef334-01c2-21f8-e793-15e822da28a0@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <bf40cc1e-bdea-1507-f4f1-a0822ceea6d6@redhat.com>
Date: Tue, 6 Oct 2020 18:20:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <a73ef334-01c2-21f8-e793-15e822da28a0@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 01:55:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/6/20 6:15 PM, Paolo Bonzini wrote:
> On 06/10/20 18:02, Philippe Mathieu-Daudé wrote:
>> On 10/6/20 5:51 PM, Richard Henderson wrote:
>>> On 10/6/20 10:36 AM, Philippe Mathieu-Daudé wrote:
>>>> +++ b/hw/nvram/fw_cfg-interface.c
>>>> @@ -0,0 +1,15 @@
>>>> +#include "qemu/osdep.h"
>>>> +#include "hw/nvram/fw_cfg.h"
>>>
>>> License boilerplate missing.
>>
>> Grr. Paolo since you queued this, do you mind fixing directly?
>>
> 
> Please write it here and I'll paste it in place.

/*
 * QEMU Firmware configuration device emulation (QOM interfaces)
 *
 * Copyright 2020 Red Hat, Inc.
 *
 * SPDX-License-Identifier: GPL-2.0-or-later
 */

Thanks!

Phil.


