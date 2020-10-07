Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284FAC4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 05:44:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C2B1208C7
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 05:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F4VahVoB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C2B1208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ2FP-0003pN-Aq
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 01:44:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kQ2Dw-0002xz-Ql
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 01:42:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42234)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kQ2Du-0007W4-A0
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 01:42:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602049365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=GrBLzYVAzSy4umfJgdGVu5FoZ37hFhzpmmee3WNsmVY=;
 b=F4VahVoBgtwu7wZBblipTaFTS9OPW9UHv89DdDq7b1flAi2zf13T6y83JCcuDYCl4JJZ5F
 fY3Eqat1Z6BEbC2UMBi5tbAf5iHP4Iqmth35ImcAmG5aExBTkrJHvjzaQl8wHpLM77R8M5
 2DtqwsJ4G0FeIyUC3cUiffWyU6vOyps=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-91-UhZzD3xXO2qGZwel5Z4koQ-1; Wed, 07 Oct 2020 01:42:43 -0400
X-MC-Unique: UhZzD3xXO2qGZwel5Z4koQ-1
Received: by mail-wm1-f72.google.com with SMTP id 73so127731wma.5
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 22:42:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=GrBLzYVAzSy4umfJgdGVu5FoZ37hFhzpmmee3WNsmVY=;
 b=JmSR2YSklLs8I6n00tDX4jSOvsL+JvzcCObZnLeIWM+QBgdlYdwzlcB1yS7F6/kV9m
 DzkwAEQ7UaBt+OnBkxRnsoLeA5ULoWUdwes3muHc2ce3woqZW9PWMIoSO0xCjp+X4gsF
 jgJ45hLxZUigcZTQ54zzKwjdjs36ZkGyv71FetQl765FKcIb1yed324kz7j/w5oSvsT2
 1eXy43u3IwC1ylx6mCVi1qwidCdIPBji8x1kEXE15tgePry3VsxaRms7c76IgqxYfy0f
 hjZx2hu2ZYmEPG16o0ZRf3bpg0uQIm2ksYyob7QaqbY6loy91fvnuLjtEj7dGh5vIjeL
 s8jw==
X-Gm-Message-State: AOAM530co10lcpQw/t3h56heDmJS1k9Rgj0aIKjm3BRmNytIHF8C6fUm
 912PYM5Yq2ig/CKHEgP1qnvFuAHcSSIsEm49KrplGME4lrJ83rzOsZABuwkGyAPW75z3lfE59rR
 Hy3H+u/KwqRqImHg=
X-Received: by 2002:a1c:f311:: with SMTP id q17mr1423175wmq.168.1602049362160; 
 Tue, 06 Oct 2020 22:42:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4XhdUUNBCPx0QdnLhML8khYH/OrK5toXwD7EIDqDERzRsHyNLgnyDDmsvWZLIY4kOKd+BbA==
X-Received: by 2002:a1c:f311:: with SMTP id q17mr1423151wmq.168.1602049361957; 
 Tue, 06 Oct 2020 22:42:41 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id c14sm1193648wrm.64.2020.10.06.22.42.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2020 22:42:41 -0700 (PDT)
Subject: Re: [PATCH v7 14/14] tests/acceptance: add reverse debugging test
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>, qemu-devel@nongnu.org
References: <160174516520.12451.10785284392438702137.stgit@pasha-ThinkPad-X280>
 <160174524678.12451.13258942849173670277.stgit@pasha-ThinkPad-X280>
 <31cffd67-388e-96df-d4f1-c971d3bb0016@redhat.com>
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
Message-ID: <dc58c359-44cc-f897-2b84-efc1387e473a@redhat.com>
Date: Wed, 7 Oct 2020 07:42:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <31cffd67-388e-96df-d4f1-c971d3bb0016@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:54:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: kwolf@redhat.com, wrampazz@redhat.com, ehabkost@redhat.com,
 mtosatti@redhat.com, armbru@redhat.com, mreitz@redhat.com, stefanha@redhat.com,
 crosa@redhat.com, pbonzini@redhat.com, alex.bennee@linaro.org,
 zhiwei_liu@c-sky.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/6/20 9:55 PM, Philippe Mathieu-Daudé wrote:
> On 10/3/20 7:14 PM, Pavel Dovgalyuk wrote:
>> From: Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>
>>
>> This is a test for GDB reverse debugging commands: reverse step and reverse continue.
>> Every test in this suite consists of two phases: record and replay.
>> Recording saves the execution of some instructions and makes an initial
>> VM snapshot to allow reverse execution.
>> Replay saves the order of the first instructions and then checks that they
>> are executed backwards in the correct order.
>> After that the execution is replayed to the end, and reverse continue
>> command is checked by setting several breakpoints, and asserting
>> that the execution is stopped at the last of them.
>>
>> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> Reviewed-by: Willian Rampazzo <willianr@redhat.com>
>>
>> --

This separator confuses the git tools. Can you stop using it
and use the '---' one instead?

>>
>> v5:
>>  - disabled (as some other tests) when running on gitlab
>>    due to the unidentified timeout problem

^ this should be stripped automatically but isn't.

>> ---
>>  MAINTAINERS                           |    1 
>>  tests/acceptance/reverse_debugging.py |  208 +++++++++++++++++++++++++++++++++
>>  2 files changed, 209 insertions(+)
>>  create mode 100644 tests/acceptance/reverse_debugging.py
> 
> Thanks, applied to my acceptance-testing tree.

This patch as already be merged by Paolo as commit be52eca309
("tests/acceptance: add reverse debugging test").

The notes below your '--' separator have been merged too.
Dirty, but not a big deal.

Regards,

Phil.


