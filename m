Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A30EC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 13:17:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6361D20708
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 13:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nxo+OYOG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6361D20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtWQT-00081h-KE
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 09:17:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jtWOh-0006j4-Ca
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 09:15:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46905
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jtWOe-0001Aw-7q
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 09:15:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594300526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ow+P327arJf5v3YUbhGMO61FgZA1rjXB+QgDvJpX5QY=;
 b=Nxo+OYOGcU2WOuasccEGn25hbyD6LFFM3YbAKeepBEPoIdc9LR8Cm8FaFNQyFECXJlySr8
 Xa99gz/rYybCXxgcpqULkX/ZR6rvik7rwEYQlSgaxGIqUzTdr6Roau1qD7qEkiKA5Kzz3+
 PiEFMfqAizGfxC9rTz7PZt71dpmNLCI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-Y-l-t-LSPzOAtypOsL5f-w-1; Thu, 09 Jul 2020 09:15:25 -0400
X-MC-Unique: Y-l-t-LSPzOAtypOsL5f-w-1
Received: by mail-wr1-f69.google.com with SMTP id g14so1894475wrp.8
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 06:15:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=ow+P327arJf5v3YUbhGMO61FgZA1rjXB+QgDvJpX5QY=;
 b=pbG2Ux04vdHJ5oNXEXpSxvE30MW8dGt27PavMJ7O5W3O+aiOl2L8J4dHjTJuLCbEQ3
 meNMwNslkzdVKMNWqY/EY77ibeWmsMroWy2wVqbsxG63qDHV9iw47gAaNaL9S+6rqcae
 fP42ViRpiVsRzVXBHCrLQep/O/Hal7YIqJp+CYRif+9JPqIPEuBT0i78hEs1MbEgbBrv
 sfAMcvVSJyoOkxOzDfssvi6bszaWDTUPfdzocO1a2pohBhSQFhcGxc59K6182xZ0XUi9
 qV5wk9hA6Be8KdzoYsYWd5aa0FtSDzjKM1BbrWWi32yvtyuHtpJXYjVuSdTYEAhNFYzj
 R/Lw==
X-Gm-Message-State: AOAM533H5uxbAVtmFjYPIGlJY6pZB58sH9uUbrXqR4SDux90qsUgZa/p
 3j6fxzcvXLBu/godRAbSaDJfoFE/kXVhZNJ3QrWKpmvPDzJ2j/bDQuCLK+WNYv/3iz5edsdX3Hi
 ABLnA44KSBaanfoc=
X-Received: by 2002:a5d:4611:: with SMTP id t17mr60089781wrq.243.1594300522740; 
 Thu, 09 Jul 2020 06:15:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzIXkWYhTE/6jBccg7aKAJORBh7FuuK4dLDdP0UYkMMXRv4nOQvgr6OKsFatD8RJQMWlaNdxg==
X-Received: by 2002:a5d:4611:: with SMTP id t17mr60089753wrq.243.1594300522525; 
 Thu, 09 Jul 2020 06:15:22 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id q188sm4662440wma.46.2020.07.09.06.15.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2020 06:15:21 -0700 (PDT)
Subject: Re: [PATCH-for-5.1 2/2] fuzz: add missing header for rcu_enable_atfork
To: Thomas Huth <thuth@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 qemu-devel@nongnu.org
References: <20200708200104.21978-1-alxndr@bu.edu>
 <20200708200104.21978-3-alxndr@bu.edu>
 <96f1c98a-982b-c146-80af-8f83e8117ac5@redhat.com>
 <3afe7750-3401-7365-bfe8-d5fd02663b69@redhat.com>
 <9a0e3688-3531-1b6f-a5bc-6192a034a8bd@redhat.com>
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
Message-ID: <2de18c26-79da-23e0-5426-43433a5e0739@redhat.com>
Date: Thu, 9 Jul 2020 15:15:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <9a0e3688-3531-1b6f-a5bc-6192a034a8bd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Bandan Das <bsd@redhat.com>, liq3ea@163.com,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/9/20 7:15 AM, Thomas Huth wrote:
> On 09/07/2020 07.09, Philippe Mathieu-Daudé wrote:
>> On 7/9/20 7:03 AM, Philippe Mathieu-Daudé wrote:
>>> On 7/8/20 10:01 PM, Alexander Bulekov wrote:
>>>> In 45222b9a90, I fixed a broken check for rcu_enable_atfork introduced
>>>> in d6919e4cb6. I added a call to rcu_enable_atfork after the
>>>> call to qemu_init in fuzz.c, but forgot to include the corresponding
>>>> header, breaking --enable-fuzzing --enable-werror builds.
>>>>
>>>> Fixes: 45222b9a90 ("fuzz: fix broken qtest check at rcu_disable_atfork")
>>>> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
>>>> ---
>>>>  tests/qtest/fuzz/fuzz.c | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/tests/qtest/fuzz/fuzz.c b/tests/qtest/fuzz/fuzz.c
>>>> index a36d9038e0..0b66e43409 100644
>>>> --- a/tests/qtest/fuzz/fuzz.c
>>>> +++ b/tests/qtest/fuzz/fuzz.c
>>>> @@ -19,6 +19,7 @@
>>>>  #include "sysemu/runstate.h"
>>>>  #include "sysemu/sysemu.h"
>>>>  #include "qemu/main-loop.h"
>>>> +#include "qemu/rcu.h"
>>>>  #include "tests/qtest/libqtest.h"
>>>>  #include "tests/qtest/libqos/qgraph.h"
>>>>  #include "fuzz.h"
>>>>
>>>
>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>>
>>
>> Please add the include to softmmu/vl.c too.
> 
> Why? Did you run into compile problems here, too?

No, because it is unexpectedly pulled by "exec/memory.h".

You are right however this is unrelated to 45222b9a90,
it comes from 73c6e4013b ("rcu: completely disable pthread_atfork
callbacks as soon as possible"), so I'll send a separate patch.


