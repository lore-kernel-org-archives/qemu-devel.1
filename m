Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4644EC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 19:18:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F85C2255F
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 19:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e592i9lz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F85C2255F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvQRX-00043h-CJ
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 15:18:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvQQx-0003YM-1K
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 15:17:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34004
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvQQu-0004wY-O1
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 15:17:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594754259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1FhVWs3JKd3uEIBrnVXU/Jqx35HNlZ9v975jexPoM9g=;
 b=e592i9lzrQswBcs6Ibl71hrkdsWPxQWXyCzw0M7VerERf8iN4aYqLKWH7fpph5eZHm1N9/
 miRLM48N4NF8Uk+yswFIpNgbGmQ638S5bJhjrj9llu8y4S6AzneOwRauCgJCxTHlvO4OLU
 wYI3RB8qPQawzAN8vUgVaJ0zr1WAsbg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-rTnnA7M1PXydwDKtzXWP_A-1; Tue, 14 Jul 2020 15:17:37 -0400
X-MC-Unique: rTnnA7M1PXydwDKtzXWP_A-1
Received: by mail-wm1-f69.google.com with SMTP id g124so5308379wmg.6
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 12:17:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=1FhVWs3JKd3uEIBrnVXU/Jqx35HNlZ9v975jexPoM9g=;
 b=ZXLrMWtHkK5Lr+Yz+MB07EX9qJkCvTJx06PdkrTcbMolySp2COYdaIsGtV5UftA84I
 vQEv1L+R89ch8aUgNl6VfUiIlp4IO2X8xooIfvuVurhxuaKHWyGzg9GbsB09t36PVkaX
 yp1Vdtg4m5KJaa5MJa6+vXQPsPgr3rx4LUHu6JpokLnEqSmXgVi/4e8jUqn5fkTc9XRq
 CSrH+bs5E4M0FUlq8IaR/LlmZqaruvxs1dbhoiOzM0hq0iW2943rYezJ7u3ok8XMIjPR
 Z8sRH/ZWJXMDN/O+KwK/B48XTFo/SbwUT1NxUu2RUAlJlm+MFwmGgADhC/3mFOrOTaAC
 VwUg==
X-Gm-Message-State: AOAM533AxCYpM0DHV5a3VzpDPbSf6zMU7CizKd/yiUcbbBsZmJa3jnLq
 xr6piFx8NBqfVqt4jto45I5lmZ7xYMMhH2e0lHdKjPQWXa42G1UktqluuRIhyLOan1eqgyC+l7F
 im5pTOWRMUvyYb7w=
X-Received: by 2002:adf:db4d:: with SMTP id f13mr7393686wrj.336.1594754256851; 
 Tue, 14 Jul 2020 12:17:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyVWp4h19Y7JABsKk/QSLRbIr/I3wLyX0icLB/wnhNqQhS14qrgkb1y6DgUSlAv1bThuG59sg==
X-Received: by 2002:adf:db4d:: with SMTP id f13mr7393665wrj.336.1594754256609; 
 Tue, 14 Jul 2020 12:17:36 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id b18sm30505580wrs.46.2020.07.14.12.17.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2020 12:17:36 -0700 (PDT)
Subject: Re: [PATCH v5 00/12] python/machine.py: refactor shutdown
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200710050649.32434-1-jsnow@redhat.com>
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
Message-ID: <19310630-6101-4b4a-42c5-6354081c783e@redhat.com>
Date: Tue, 14 Jul 2020 21:17:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200710050649.32434-1-jsnow@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 21:44:01
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
Cc: kwolf@redhat.com, Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Cleber Rosa <crosa@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/10/20 7:06 AM, John Snow wrote:
> v5: More or less rewritten.
> 
> This series is motivated by a desire to move python/qemu onto a strict
> mypy/pylint regime to help prevent regressions in the python codebase.
> 
> 1. Remove the "bare except" pattern in the existing shutdown code, which
>    can mask problems and make debugging difficult.
> 
> 2. Ensure that post-shutdown cleanup is always performed, even when
>    graceful termination fails.
> 
> 3. Unify cleanup paths such that no matter how the VM is terminated, the
>    same functions and steps are always taken to reset the object state.
> 
> 4. Rewrite shutdown() such that any error encountered when attempting a
>    graceful shutdown will be raised as an AbnormalShutdown exception.
>    The pythonic idiom is to allow the caller to decide if this is a
>    problem or not.
> 
> Previous versions of this series did not engage the fourth goal, and ran
> into race conditions. When I was trying to allow shutdown to succeed if
> QEMU was already closed, it became impossible to tell in which cases
> QEMU not being present was "OK" and in which cases it was evidence of a
> problem.
> 
> This refactoring is even more explicit. If a graceful shutdown is
> requested and cannot be performed, an exception /will/ be raised.
> 
> In cases where the test writer expects QEMU to already have exited,
> vm.wait() should be used in preference to vm.shutdown(). In cases where
> a graceful shutdown is not interesting or necessary to the test,
> vm.kill() should be used.
> 
> John Snow (12):
>   python/machine.py: consolidate _post_shutdown()
>   python/machine.py: Close QMP socket in cleanup
>   python/machine.py: Add _early_cleanup hook
>   python/machine.py: Perform early cleanup for wait() calls, too
>   python/machine.py: Prohibit multiple shutdown() calls
>   python/machine.py: Add a configurable timeout to shutdown()
>   python/machine.py: Make wait() call shutdown()
>   tests/acceptance: wait() instead of shutdown() where appropriate
>   tests/acceptance: Don't test reboot on cubieboard
>   python/machine.py: split shutdown into hard and soft flavors
>   python/machine.py: re-add sigkill warning suppression
>   python/machine.py: change default wait timeout to 3 seconds

Series (finally) queued on python-next, thanks.


