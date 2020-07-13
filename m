Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BDC9C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 09:32:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 666C020758
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 09:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D2KEKzE8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 666C020758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juupQ-0004p6-Lr
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 05:32:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58688)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1juunV-0003CY-1N
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 05:30:53 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45856
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1juunT-0006ep-AB
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 05:30:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594632650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Uet4wVpMZ6iy6HebTX+cjq4F9PpDiK9bHIq9rvul9so=;
 b=D2KEKzE8dYZB2gpSZSk47IKmGipX3SiJI0/1fmikpeN0ntdJJUagS/K4o5wngCjt+7Yc/B
 inw3d61LKWtfocggJ/EhXfPnytSq0k/wOP/wtBWpgPMza+zfv7QQDlKMvpfYSuf5geO5yo
 BwRyKdBXVd8dsfdkRIkokVqlhjLn36o=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-YT7vZ4stObmQXJnP8JFf6g-1; Mon, 13 Jul 2020 05:30:47 -0400
X-MC-Unique: YT7vZ4stObmQXJnP8JFf6g-1
Received: by mail-wr1-f69.google.com with SMTP id y16so17066729wrr.20
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 02:30:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=Uet4wVpMZ6iy6HebTX+cjq4F9PpDiK9bHIq9rvul9so=;
 b=Eo3kS5B+p86iR1QhRnPnU4Vvz6gLWngZ+9ZWXCnj+IcKoxlMpwuuLrjPVETlEdrvLo
 HJjemhdPR9MGTlR3NgEJNSUlByXTP+9oTwHqynjxlKqLViWiVrtdaMcXUhXdR48l1kRA
 nbV8yaiq/p+KOnqRpPpYg87dJz8WJwX/arn+E33xTjjmJUKW38PqMyKnzx2TaPfwXmaW
 QGh7eqC4viPXxvywU8qP08Zt+4+Lsv6efyjRv9p7HL5SNC+KDyldfB7LH7KyuKaPyyOx
 kgexeli9/uXlIEYzn+bbCh0uu/DPgHnob5y4Q3oX3hHAZuN79Pnu3Rmn35SVbK6QSfjv
 re5w==
X-Gm-Message-State: AOAM532Vgd+gp16ZOId7GeY5yAy1rYkihLCGeS5831VOd9ZDGeNkQCKm
 WBqulnd62/QOLy1K7QfbwOKVWcBsy2RyJro5rCdcJKW7elkyOG4YzxMwW4oeLvI6ZwuOS6OhsF2
 81/FTy8KwZSPtQEE=
X-Received: by 2002:a1c:6887:: with SMTP id
 d129mr17674760wmc.179.1594632645764; 
 Mon, 13 Jul 2020 02:30:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxH6ilSyIjvvrhP1TgWZZbC4z759Heh0lJ1r3rLLSXR/776Uc7FF3soe0D7ihLo0UolPb9SIg==
X-Received: by 2002:a1c:6887:: with SMTP id
 d129mr17674749wmc.179.1594632645584; 
 Mon, 13 Jul 2020 02:30:45 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id a15sm26405792wrh.54.2020.07.13.02.30.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2020 02:30:45 -0700 (PDT)
Subject: Re: [PATCH v5 12/12] python/machine.py: change default wait timeout
 to 3 seconds
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200710050649.32434-1-jsnow@redhat.com>
 <20200710050649.32434-13-jsnow@redhat.com>
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
Message-ID: <82f01e5f-22f5-98ed-ff25-515d5e728bdb@redhat.com>
Date: Mon, 13 Jul 2020 11:30:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200710050649.32434-13-jsnow@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 01:36:29
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
> Machine.wait() does not appear to be used except in the acceptance tests,
> and an infinite timeout by default in a test suite is not the most helpful.
> 
> Change it to 3 seconds, like the default shutdown timeout.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  python/qemu/machine.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/python/qemu/machine.py b/python/qemu/machine.py
> index 02d66e3cff..d08a8e4a6e 100644
> --- a/python/qemu/machine.py
> +++ b/python/qemu/machine.py
> @@ -472,12 +472,12 @@ def kill(self):
>          """
>          self.shutdown(hard=True)
>  
> -    def wait(self, timeout: Optional[int] = None) -> None:
> +    def wait(self, timeout: Optional[int] = 3) -> None:
>          """
>          Wait for the VM to power off and perform post-shutdown cleanup.
>  
>          :param timeout: Optional timeout in seconds.
> -                        Default None, an infinite wait.
> +                        Default 3 seconds, A value of None is an infinite wait.
>          """
>          self.shutdown(has_quit=True, timeout=timeout)
>  
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


