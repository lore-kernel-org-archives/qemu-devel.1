Return-Path: <SRS0=Iy1T=CA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA4CC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 20:14:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0A602072D
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 20:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BKRDHKzG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0A602072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9ZuF-0001Wh-2z
	for qemu-devel@archiver.kernel.org; Sat, 22 Aug 2020 16:14:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37196)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k9Ztj-00017I-IA
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 16:13:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40886
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k9Zti-0003lu-3m
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 16:13:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598127232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DERWlz8d3KVQ9hc0w6HKmjhhTigEN1WJSRJgDbLY8Oo=;
 b=BKRDHKzGFLxJZzfgaF8qTb1EiGQgRId3bVBzedczAmkjPn6eGC46+TujnxhhQctJ5Z8UqL
 c6xfM7SdTyAthakcnHWkh3LLmq6u1iILgD6+XA5TdCPZfVwYos17g0ocSMN5y2KyzFGkD3
 onXC+ciLGkooPvPbi9+MOl+mFjqsQCc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-503--HLEEf2BN6iTqmA1-X4WdQ-1; Sat, 22 Aug 2020 16:13:51 -0400
X-MC-Unique: -HLEEf2BN6iTqmA1-X4WdQ-1
Received: by mail-wr1-f71.google.com with SMTP id y6so1971547wrs.11
 for <qemu-devel@nongnu.org>; Sat, 22 Aug 2020 13:13:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=5NmE3PQlQpFgdVRKpCF4uSk7oZRbyHx4Bk4Nv3D2I/g=;
 b=giwP9KIpdzVu2c03qWj4ilBxCZBcToY05UAj0CAGAC4fHDi9vGLtXUrxZwzGxt+G3R
 8YhUviWxQLYfVmJ1vz7NTMm0nCtjojk0zWqQgm6ywZr522EHHstbvkWixhoS0UjmmR7B
 YBZrydwv2ei96C4dLBXky9YBRAh7ssos+Lu5lkJBLmvf1+JQcfnXZMJtFjP3N/iHorXF
 LL2tF2Hyz2mrq5FkAuqHaFUFGjpSrfR1BcABfFhZzlukxhdvD41PuUce+l/TyBZ3ub2m
 lXHhzicC3ZaAZVV9qan5xrpO8QULMmx5G8jDqV6jk7oSeWYHxe+8/96wIeLqdSoLlT1A
 e3aQ==
X-Gm-Message-State: AOAM530c11DfUynfMVjp/N53aDNQXeTQC91up5R5Qr43qDkTurvL/dcE
 SvCqz8lTiCtwO4Tfgb8i1YKhPMLddZr11CAezafiaxuYTXJfULpOVCQGFdobj40gSFuAHw23etS
 GjpaVfF1fG1TRh+E=
X-Received: by 2002:a5d:49c9:: with SMTP id t9mr8733469wrs.302.1598127229932; 
 Sat, 22 Aug 2020 13:13:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJylVpnLSmGxqY+H0iVCxpdnuS/8CRY6eOVUvzk8SuQqn0IJyeXVRvEDQIpdOJBRSjrIFEBzSg==
X-Received: by 2002:a5d:49c9:: with SMTP id t9mr8733454wrs.302.1598127229771; 
 Sat, 22 Aug 2020 13:13:49 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id y13sm1693564wrn.48.2020.08.22.13.13.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 22 Aug 2020 13:13:49 -0700 (PDT)
Subject: Re: [PATCH-for-5.2] exec: Remove MemoryRegion::global_locking field
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, Robert Foley <robert.foley@linaro.org>
References: <20200806150726.962-1-philmd@redhat.com>
 <20200807100256.GC600298@stefanha-x1.localdomain>
 <451a50f0-d0ce-5d3b-a38d-e1ca6c0f882f@redhat.com>
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
Message-ID: <a3a263ba-68e1-2fd8-22ab-93e2cafdcdfd@redhat.com>
Date: Sat, 22 Aug 2020 22:13:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <451a50f0-d0ce-5d3b-a38d-e1ca6c0f882f@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/22 15:57:54
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
Cc: David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Alexander Bulekov <alxndr@bu.edu>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+Robert

On 8/7/20 12:16 PM, Paolo Bonzini wrote:
> On 07/08/20 12:02, Stefan Hajnoczi wrote:
>> On Thu, Aug 06, 2020 at 05:07:26PM +0200, Philippe Mathieu-Daudé wrote:
>>> Last uses of memory_region_clear_global_locking() have been
>>> removed in commit 7070e085d4 ("acpi: mark PMTIMER as unlocked")
>>> and commit 08565552f7 ("cputlb: Move NOTDIRTY handling from I/O
>>> path to TLB path").
>>> Remove memory_region_clear_global_locking() and the now unused
>>> 'global_locking' field in MemoryRegion.
>>>
>>> Reported-by: Alexander Bulekov <alxndr@bu.edu>
>>> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>> ---
>>>  include/exec/memory.h | 14 --------------
>>>  accel/tcg/cputlb.c    |  4 ++--
>>>  exec.c                |  2 +-
>>>  softmmu/memory.c      |  6 ------
>>>  4 files changed, 3 insertions(+), 23 deletions(-)
>>
>> It can be added back in later, if necessary. For now let's drop the dead
>> code.
>>
>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>>
> 
> I expect it will come back since Linaro is working on BQL-free interrupt
> handling for TCG, but no objections.

Robert, any comment on this patch?

Thanks,

Phil.


