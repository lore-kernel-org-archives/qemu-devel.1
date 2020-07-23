Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B11EC433E4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 15:14:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51C8920771
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 15:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SJQ35CFo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51C8920771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jycvM-0003oK-14
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 11:14:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jycsl-0002U6-St
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 11:11:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37178
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jycsj-0006xr-6D
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 11:11:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595517095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3wv+K87sVYWBDMUb8fYi2cJAuOW6CZdXBb4AToRd47k=;
 b=SJQ35CFom8ZZKrWesSQ2/siXcYMb5FNAJfmkHMUKYz4Bje8QnSdZmusQdXWMYtTNVe0wXK
 H0qeWElp8WoyR5udYcefmuRNr+nQ/jnsM39usQ1G0Y48vo4ekQJff4qI5zLn6EqZDkk0uZ
 A5GPqwXfvFjWVr4My0Lexy4lId8vkeQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-ok4M5eEnMBq3PMitsv5jPw-1; Thu, 23 Jul 2020 11:11:33 -0400
X-MC-Unique: ok4M5eEnMBq3PMitsv5jPw-1
Received: by mail-wr1-f70.google.com with SMTP id j16so1514208wrw.3
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 08:11:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=3wv+K87sVYWBDMUb8fYi2cJAuOW6CZdXBb4AToRd47k=;
 b=RzXg/Fkldc3ClLpWS17pYEq+IHom6sBizcqox0HdANZ2z3c9C1XN6MGe5gt14lu6L4
 Cf8Tl8kGlAgcTWy6X+ZqiaCGrSAiU+3Q8uFnxy4nK4tHV4rq68zJxJ7ryMvJwd3Uc0q/
 1SsOKA0VqPQKvOYiq29XYSCuHQ2WtOQUumPFeDcKtpp8QnSSuOr9q9oqfsF4gk1ePWnF
 ldOKnElD/5CwnM4A53R3+PjL7shlQ5aPa0Xd8j+yG8vZS7tM7HPSTJ+o5yIzRuF4DT53
 YG2pNvHHoQ2Qj7zA0uBDHxUDIGFYN8VxtgdNhjJBMo6EV1ZQwup0KMpb9QR+GVQi1rZ2
 huPg==
X-Gm-Message-State: AOAM5315cuEbvmqs2WNIzeoMjn8A/XxP1fTykY5iWbGJTuvc3LoMSarv
 PEt+lRo/yMoqhmyXsY9f0s7+hajIKLJMC05ynuN4VW8PBRG7RW5OnVrrL7480lO+1jpC5t7Y7S7
 hVsUaM1xbsuCTlpI=
X-Received: by 2002:a5d:51c3:: with SMTP id n3mr4536416wrv.104.1595517092017; 
 Thu, 23 Jul 2020 08:11:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwejTKMo3WKOnJJvd3+GOH5pIAk7CQoHZYmOfYoJRSfAfQCfjK9ghiZt8RaUNSsMoJhkDO6Og==
X-Received: by 2002:a5d:51c3:: with SMTP id n3mr4536403wrv.104.1595517091807; 
 Thu, 23 Jul 2020 08:11:31 -0700 (PDT)
Received: from [192.168.1.36] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id j5sm3529678wmb.15.2020.07.23.08.11.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2020 08:11:31 -0700 (PDT)
Subject: Re: [PATCH] target/unicore32: Remove CURSES stuff from the
 Makefile.objs
To: Thomas Huth <thuth@redhat.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 qemu-devel@nongnu.org
References: <20200723132219.2956-1-thuth@redhat.com>
 <b177ca63-a7bb-03e7-df22-13f77fed9678@redhat.com>
 <18291cc0-13e1-65de-d878-eb432acd6219@redhat.com>
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
Message-ID: <86546514-2afd-3769-bc01-3bea9d552f50@redhat.com>
Date: Thu, 23 Jul 2020 17:11:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <18291cc0-13e1-65de-d878-eb432acd6219@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 22:13:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: qemu-trivial@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/23/20 3:45 PM, Thomas Huth wrote:
> On 23/07/2020 15.42, Philippe Mathieu-Daudé wrote:
>> On 7/23/20 3:22 PM, Thomas Huth wrote:
>>> The dependency on curses has been removed in commit c7a856b42e403e2b
>>> ("target/unicore32: Prefer qemu_semihosting_log_out() over curses").
>>> So we can remove the related lines in the Makefile now, too.
>>
>> Don't we also need to remove all uses of CONFIG_CURSES to
>> be complete? Eventually display a warning with --(en|dis)able-curses
>> is used.
> 
> Which ones do you mean? I can't find any other CONFIG_CURSES anymore in
> the target/ folder...
> 
> Or do you also plan to get rid of ui/curses.c ??? ... that's certainly
> another story.

Ah indeed.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


