Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 855BFC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 16:13:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 414982076B
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 16:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i/M9qQzq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 414982076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5tNR-0007GB-B2
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 12:13:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38164)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5tMi-0006of-WF
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 12:12:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26125)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5tMf-0000Jc-Hd
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 12:12:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597248752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=fdMGMeB70/4dICUTQ+OFOnh5dV02+75UI6c9slj1CO4=;
 b=i/M9qQzqZ2EFLF+LcxzkbVDHNfPe64sJPboNCvKUM6yUeRrSTVGt0Rl7H/862ONMA4TKAG
 sIFs/IMjXMHzI7lqd7bJSPXzmm219dbYKOpXtxyn1inY5s2rzBG6vTiP7UQ9cIPhHUSYby
 wy+KUcgcoZnuYOqkVArFidav/lzX1Sg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-7pFfGGehM9ug13sWRZS-yw-1; Wed, 12 Aug 2020 12:12:29 -0400
X-MC-Unique: 7pFfGGehM9ug13sWRZS-yw-1
Received: by mail-wm1-f69.google.com with SMTP id z10so1039221wmi.8
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 09:12:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=fdMGMeB70/4dICUTQ+OFOnh5dV02+75UI6c9slj1CO4=;
 b=L0XiKVvTwhEGNVcsYj4/l0+lBvUva0MyGJvLf/IBLI9ep4UgdllrIqEH5UNjJTZ/qy
 69I05zk1rbnrXLWlcEcrOCd/dpPGkG8LzZTjkpxTGLN+CBUW08EBj0wnTbtUHS1jlTU6
 yHYvuMb282Zvmdvw1ZLKvYb/ssNs6RqQ5YSku3TqU6LBBzabSfErSuDUsggD69Kp6tR4
 hBfZz0EnF03fOCemjA5VDA4k5a6SSRVarzk1gsi/A08V02fvwEfbqpETW6iOdAKJFtC0
 VkJ0T6+PjheD9FzqtWNq3XiNoxaCzv5C9S1+N+yjxtI19FRGnjshY7brdy9w0I7b3cXC
 T3vQ==
X-Gm-Message-State: AOAM532G9qVptcKR7J3Gz+rub3dGOzzp5DQAHTfFRJzdYA8JIt18LNV3
 ZN3RYooPS3Ju7nV6F68aUIJyY5PeTLe4kTs05vsnPoxbjRgTjPfO3jjskmTJyJmUXIHueoGU3LX
 5vFt7sWrRPFytmQc=
X-Received: by 2002:a05:6000:1149:: with SMTP id
 d9mr295030wrx.335.1597248747877; 
 Wed, 12 Aug 2020 09:12:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwmYQuy4dQuhLNGLe/lOViGh5ASj9ucXeA+S4Z0M4W+rOhp6E7eR4EyDlmjvIP/YWRXuq2KUg==
X-Received: by 2002:a05:6000:1149:: with SMTP id
 d9mr294995wrx.335.1597248747631; 
 Wed, 12 Aug 2020 09:12:27 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id f131sm4942999wme.40.2020.08.12.09.12.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2020 09:12:26 -0700 (PDT)
Subject: Re: [RFC v4 11/14] hvf: remove hvf specific functions from global
 includes
To: Claudio Fontana <cfontana@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <r.bolshakov@yadro.com>
References: <20200811210326.4425-1-cfontana@suse.de>
 <20200811210326.4425-12-cfontana@suse.de>
 <a729d3f4-3560-fc4f-aa57-ec02d23f16c2@suse.de>
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
Message-ID: <97bf709c-f73a-d9a9-9ede-a9cf487565a6@redhat.com>
Date: Wed, 12 Aug 2020 18:12:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <a729d3f4-3560-fc4f-aa57-ec02d23f16c2@suse.de>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 10:15:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, Wenchao Wang <wenchao.wang@intel.com>,
 haxm-team@intel.com, Sunil Muthuswamy <sunilmut@microsoft.com>,
 Richard Henderson <rth@twiddle.net>, Colin Xu <colin.xu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/12/20 4:49 PM, Claudio Fontana wrote:
> On 8/11/20 11:03 PM, Claudio Fontana wrote:
>> Signed-off-by: Claudio Fontana <cfontana@suse.de>
>> ---
>>  accel/stubs/Makefile.objs  |  1 -
>>  accel/stubs/hvf-stub.c     | 30 ------------------------------
>>  include/sysemu/hvf.h       |  8 --------
>>  target/i386/hvf/hvf-cpus.c |  1 +
>>  target/i386/hvf/hvf-int.h  | 24 ++++++++++++++++++++++++
>>  target/i386/hvf/hvf.c      |  1 +
>>  target/i386/hvf/x86hvf.c   |  2 ++
>>  target/i386/hvf/x86hvf.h   |  1 -
>>  8 files changed, 28 insertions(+), 40 deletions(-)
>>  delete mode 100644 accel/stubs/hvf-stub.c
>>  create mode 100644 target/i386/hvf/hvf-int.h
[...]
>> --- a/target/i386/hvf/hvf-cpus.c
>> +++ b/target/i386/hvf/hvf-cpus.c
>> @@ -55,6 +55,7 @@
>>  #include "target/i386/cpu.h"
>>  #include "qemu/guest-random.h"
>>  
>> +#include "hvf-int.h"
>>  #include "hvf-cpus.h"
>>  
>>  /*
>> diff --git a/target/i386/hvf/hvf-int.h b/target/i386/hvf/hvf-int.h
>> new file mode 100644
>> index 0000000000..50d108ca08
>> --- /dev/null
>> +++ b/target/i386/hvf/hvf-int.h
> 
> 
> Hmm maybe I could avoid creating a new header file,
> and just cram these functions in hvf-cpus.h ?

Yes it seems better (similar rename with the other accelerators).

> 
> Any thoughts?
> 
> Thanks,
> 
> Claudio


