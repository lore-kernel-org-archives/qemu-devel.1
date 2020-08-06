Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 879DFC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 15:11:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E8C423133
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 15:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XzAvLVdI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E8C423133
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3hXw-0003X1-2P
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 11:11:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46152)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k3hWz-0002yE-M8
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 11:10:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34705
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k3hWy-0007H5-2l
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 11:10:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596726607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=KOLG92Sb99wi8Xk3drESY1ujvILPmM3Z8LNvhVXSk7Y=;
 b=XzAvLVdIgDzDFFW374AyKrs0FoCXBnqNEdp8uTEdPDQQ13Q9ufcJv2S18v2g23/Y2R4u3y
 qacYGlWuV5DhY02I7kvQWZqA2ZC1tbgVMWveKDBhYIYu1kR9iiCA+Qc4aKknR43YBK/3eP
 4T+CKR/Y+2h76aUKyH3Sfc0R0FWna6w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-uNnEFpAzMy-tRTgTBdwrBw-1; Thu, 06 Aug 2020 11:10:05 -0400
X-MC-Unique: uNnEFpAzMy-tRTgTBdwrBw-1
Received: by mail-wm1-f71.google.com with SMTP id f74so4264754wmf.1
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 08:10:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=KOLG92Sb99wi8Xk3drESY1ujvILPmM3Z8LNvhVXSk7Y=;
 b=c+lzvcANMZNtmtAwzBdidTMWJYVgXFLPbdbQFyFyIohbHBuEACzfaHTkw03X6fB01M
 QHlQNS4B3J1j27ZadznLO9KM7qpnyeTOif8hQjF3u8rw8B+2wQKNSOc+UIdj7IK+2l1e
 osxeAPR5g3HhDJIWI9sTY5cxVxmxll9MWxmBQ2qdzC/EDxcCIpWR+iC98fMf1ob8ecq0
 Nxw0Q9d1/VZl9q232NqC0pEXjYCmBTJsjcwsKWbnoWy/n91uUgRDxwlMeOuQFIs0CHdR
 SwTsi0g3P+lHgSC2R/gqMtC4LOIpJCuIYWqod15BG1HEU5zu9zSdra8TTTp/7rYFOFf9
 2txQ==
X-Gm-Message-State: AOAM531piAe9XvJ1xlFIT28GNc6vagGuaT0qcTpdDfGleOqHQEsovipF
 GhKm2kph0LuU+v3/mjVhzZwJ9JnVxFW8LjhHUFbvgtOBE1Hzf+mcPdLIkPFqbQPbU8C9gTreW1V
 tZoT0NDYRbTLRcNQ=
X-Received: by 2002:a5d:4701:: with SMTP id y1mr8166347wrq.416.1596726604717; 
 Thu, 06 Aug 2020 08:10:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzkCqIXSgRdMpgQzJvYrYn5NLdMuHb7dujvmimXJ57RpKV6V4/YtGIYYsWW29YAeTiqWevhLg==
X-Received: by 2002:a5d:4701:: with SMTP id y1mr8166315wrq.416.1596726604444; 
 Thu, 06 Aug 2020 08:10:04 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id m126sm6933679wmf.3.2020.08.06.08.10.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2020 08:10:03 -0700 (PDT)
Subject: Re: [PATCH] softmmu: Add missing trace-events file
To: Claudio Fontana <cfontana@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20200805130221.24487-1-philmd@redhat.com>
 <87wo2dmde8.fsf@dusky.pond.sub.org>
 <8c510787-119e-5849-9c3f-fa01fb3d3c80@redhat.com>
 <4816dcc4-2fa2-75a7-6164-e4b0b0ffa723@suse.de>
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
Message-ID: <f92dea77-90a3-d08e-3b9b-eb7c32bd04fa@redhat.com>
Date: Thu, 6 Aug 2020 17:10:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <4816dcc4-2fa2-75a7-6164-e4b0b0ffa723@suse.de>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/6/20 4:24 PM, Claudio Fontana wrote:
> On 8/6/20 4:21 PM, Paolo Bonzini wrote:
>> On 05/08/20 15:27, Markus Armbruster wrote:
>>>> Commit c7f419f584 moved softmmu-only files out of the root
>>>> directory, but forgot to move the trace events, which should
>>>> no longer be generated to "trace-root.h". Fix that by adding
>>>> softmmu/trace-events.
>>> Dang!  I'd like to have this in 5.1 if at all possible.
>>>
>>
>> Does this matter at all for usage of tracepoints?

Markus said on IRC it is a false alarm, can wait 5.2 :)

>>
>> Paolo
>>
>>
> 
> Hi Paolo, I tested both with and without the fix,
> the events seem to be generated anyway.
> 
> Using simple trace backend, simple smoke test tracing the memory_region_ops_read from softmmu/memory.c
> 
> Thanks,
> 
> Claudio
> 


