Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4524AC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 09:56:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DB482068F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 09:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MbkH811d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DB482068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juvCB-0004Y2-9m
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 05:56:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38922)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1juvA2-0002MK-Dm
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 05:54:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26190
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1juv9z-0001wa-BX
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 05:54:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594634045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ItDriLSvwdTQnxAERn6ezbqF0lJisg/PWfAYrF7UrNU=;
 b=MbkH811d/uT/wo/PQ8QPTwC96CW40GDLVkXcJhd+/YOG6nAmoyLhkF1HPfhPI6Z2RHTPey
 QhtNae7RpTTjOVrkNqAZ0DzOy33tpm3RfaKyPkbUW0+cMf6PE59EPlTdyij5HCz6QaVYhl
 siq7VhsoFYSeq4fvvkwUXAfyUvUWc8s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-u73oP6iKOQ2c9GkTsNXkew-1; Mon, 13 Jul 2020 05:54:04 -0400
X-MC-Unique: u73oP6iKOQ2c9GkTsNXkew-1
Received: by mail-wm1-f70.google.com with SMTP id u68so18050256wmu.3
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 02:54:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=ItDriLSvwdTQnxAERn6ezbqF0lJisg/PWfAYrF7UrNU=;
 b=Eqj5Ky4o1q0B/IwlM0jVDMm1ls43fk+Y1bz9rFo/GQmIgFbwzsgQ/4+soorIbjbYMr
 X5tQ5+Yj35aJnbInhZCanNQ4JnaaemZ9dJcES8ybVs5Yg67UIZ5GgFDHsj375s5DV9CA
 pBOEStgXQPnMhZBwJOrzk0E6wIcC7cuLwgh0h1CxBDk2DzXFnzmsH0cGqS+9JsiK4tWY
 h8xcaIOaonltz6ZQfmr41gNJNV1CWtSOAFfAGZ0qSNUlpaRdBjkWCKvdds9RsybHVOKT
 PfzlRbYzOpWmcNEA2y44tdjOwDqa3OTK+x/2QHHnvltgRhs53aczfGBIu+iHhiocqe5X
 rCjA==
X-Gm-Message-State: AOAM5311/ZYBF3AOeuqf39c0UnhJQI0xZCb3Yq+gRPFzs0u3ZjYDk022
 3ki7tP8VU4O5toJcef0T+BxeuvpFqwn+gPaXI+0wgrUmRT5D/E/EYHKrgJGyjVdqsPmdYpiXdLc
 r49n81vVZ7/eAB9Q=
X-Received: by 2002:a1c:cc0c:: with SMTP id h12mr19246946wmb.140.1594634042701; 
 Mon, 13 Jul 2020 02:54:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9zmqo4IehzkGWtMZDle4cJQwQscVlrAzVQk54xVi5269yKamRKsoH2FS3uzm1RoZ0W3/F8A==
X-Received: by 2002:a1c:cc0c:: with SMTP id h12mr19246921wmb.140.1594634042482; 
 Mon, 13 Jul 2020 02:54:02 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id f9sm23160503wru.47.2020.07.13.02.54.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2020 02:54:02 -0700 (PDT)
Subject: Re: [PATCH v5 10/12] python/machine.py: split shutdown into hard and
 soft flavors
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200710050649.32434-1-jsnow@redhat.com>
 <20200710050649.32434-11-jsnow@redhat.com>
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
Message-ID: <19c24819-4fe7-fc73-8ea2-8f5b7c5ceb9d@redhat.com>
Date: Mon, 13 Jul 2020 11:54:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200710050649.32434-11-jsnow@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 02:19:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
> This is done primarily to avoid the 'bare except' pattern, which
> suppresses all exceptions during shutdown and can obscure errors.
> 
> Replace this with a pattern that isolates the different kind of shutdown
> paradigms (_hard_shutdown and _soft_shutdown), and a new fallback shutdown
> handler (_do_shutdown) that gracefully attempts one before the other.
> 
> This split now also ensures that no matter what happens,
> _post_shutdown() is always invoked.
> 
> shutdown() changes in behavior such that if it attempts to do a graceful
> shutdown and is unable to, it will now always raise an exception to
> indicate this. This can be avoided by the test writer in three ways:
> 
> 1. If the VM is expected to have already exited or is in the process of
> exiting, wait() can be used instead of shutdown() to clean up resources
> instead. This helps avoid race conditions in shutdown.
> 
> 2. If a test writer is expecting graceful shutdown to fail, shutdown
> should be called in a try...except block.
> 
> 3. If the test writer has no interest in performing a graceful shutdown
> at all, kill() can be used instead.
> 
> 
> Handling shutdown in this way makes it much more explicit which type of
> shutdown we want and allows the library to report problems with this
> process.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  python/qemu/machine.py | 95 +++++++++++++++++++++++++++++++++++-------
>  1 file changed, 80 insertions(+), 15 deletions(-)
> 

:))

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


