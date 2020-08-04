Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1873C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 18:52:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A0D020792
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 18:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hpNolkJP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A0D020792
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3239-000406-PQ
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 14:52:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k322W-0003YQ-V3
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 14:51:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54550
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k322U-0002bk-24
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 14:51:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596567112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5UbbOUUjnkovL7OIIJ/4cZcOxiv8PE+rgVuS+M8UUSs=;
 b=hpNolkJPR/SzcHS9Y0gtEWgt3ODhfk9Y+BfsuWeQ6My1ZxhpmUSgnqyMHLtEGqdV1dFcb3
 mFM+pUlTWfyraUF6sAl3yUUhCQbQK/lkIXsiQ8ygSakFEoSIqRm0KVOyhGPAi7zqlrHSOu
 +wUEkng34gDhIMyK50pivzdipq4N4oo=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-fdTHfVWxOVWfHu20JWUNsg-1; Tue, 04 Aug 2020 14:51:50 -0400
X-MC-Unique: fdTHfVWxOVWfHu20JWUNsg-1
Received: by mail-ed1-f70.google.com with SMTP id cz26so2250751edb.7
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2020 11:51:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=5UbbOUUjnkovL7OIIJ/4cZcOxiv8PE+rgVuS+M8UUSs=;
 b=Lkxx4sVZYTp1MX8o0CXOoXgjoUVhyhf4XrqoGH6iHrB4aHHpCaF5lpXRpPIw5aUXAY
 Da9LEz31EU6y+pefuHLFzbtIxemzd0mSQYETNGONxI/bcJuP5DPMbLAOue2je6r9XRge
 AOcF5QCJ4Wkrxa9DZrIA1H1CTdN7k1jR3Rlu5PzELQK+JD3Z7B7cYBYKL0HW0t7hll27
 iSplf+9YCGlMrtf7elRj0ASjObma9zelZAvTv2zlxqh3t0UaayhiOVgbOzNetkCdnco5
 GXlhgUW8caD1bwwyHYri2r3EZKX1uNvR1tGaGm45P9EGDHYlgAVNPRBb4fd8qxAjwQVC
 mTJw==
X-Gm-Message-State: AOAM531lbQZWy7OYqdzwNm2qeCZxtRlYWSfCMDS1umfR50LZ+akbBSGp
 P112RVQ9rrMlVELJGCQnGqF/YyXwhmOAMJ4/IMKgmyvwJMM/Ro7+hPsXAdDnTbSTTN+Y9MUqARt
 0caD9nye+K8WNoeM=
X-Received: by 2002:a17:906:7f0b:: with SMTP id
 d11mr24207326ejr.116.1596567109401; 
 Tue, 04 Aug 2020 11:51:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxd6aVjKq0vFurdTtBchZ7q4PzS3+Iit09f+5twQgSRX7qxF88VKh7Cn5fhASp9o+klGZuZ5g==
X-Received: by 2002:a17:906:7f0b:: with SMTP id
 d11mr24207313ejr.116.1596567109193; 
 Tue, 04 Aug 2020 11:51:49 -0700 (PDT)
Received: from [192.168.1.43] (214.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.214])
 by smtp.gmail.com with ESMTPSA id js19sm19956227ejb.76.2020.08.04.11.51.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Aug 2020 11:51:48 -0700 (PDT)
Subject: Re: [PATCH-for-5.1] stubs: Fix notify-event stub linkage error on
 MinGW
To: qemu-devel@nongnu.org
References: <20200804182241.31805-1-philmd@redhat.com>
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
Message-ID: <18d16d36-87a1-2d1a-6caa-6b62911a8f46@redhat.com>
Date: Tue, 4 Aug 2020 20:51:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200804182241.31805-1-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 01:28:23
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/4/20 8:22 PM, Philippe Mathieu-Daudé wrote:
> In commit e4d6d41ce2 we reduced the user-mode object list,
> but forgot to also change the notify.o stub in the next commit
> dc70f80fb2. This triggers a linker error while compiling the
> tests under MinGW:
> 
>   LINK    tests/test-timed-average.exe
>  libqemuutil.a(main-loop.o): In function `qemu_notify_event':
>  util/main-loop.c:139: multiple definition of `qemu_notify_event'
>  tests/test-timed-average.o:/builds/huth/qemu/tests/../stubs/notify-event.c:5: first defined here
>  collect2: error: ld returned 1 exit status
>  rules.mak:124: recipe for target 'tests/test-timed-average.exe' failed
> 
> Correct by placing the stub object between the system emulation /
> tools guards.
> 
> Fixes: dc70f80fb2 ("stubs/Makefile: Reduce the user-mode object list")
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  stubs/Makefile.objs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
> index d42046afe4..4e8605a609 100644
> --- a/stubs/Makefile.objs
> +++ b/stubs/Makefile.objs
> @@ -12,7 +12,6 @@ stub-obj-y += isa-bus.o
>  stub-obj-$(CONFIG_LINUX_AIO) += linux-aio.o
>  stub-obj-$(CONFIG_LINUX_IO_URING) += io_uring.o
>  stub-obj-y += monitor-core.o
> -stub-obj-y += notify-event.o
>  stub-obj-y += pci-bus.o
>  stub-obj-y += qmp_memory_device.o
>  stub-obj-y += qtest.o
> @@ -45,6 +44,7 @@ stub-obj-y += iothread.o
>  stub-obj-y += machine-init-done.o
>  stub-obj-y += migr-blocker.o
>  stub-obj-y += monitor.o
> +stub-obj-y += notify-event.o
>  stub-obj-y += pci-host-piix.o
>  stub-obj-y += ram-block.o
>  stub-obj-y += replay-user.o
> 

self-NACK, this doesn't work as expected =)


