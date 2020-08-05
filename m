Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C20C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 09:43:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA3B22067C
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 09:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hJxHaTy8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA3B22067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3FxK-0005eu-6l
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 05:43:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34420)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k3Fwm-0005F0-Ty
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 05:42:56 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26605
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k3Fwl-0006su-5i
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 05:42:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596620574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=JP0kXz5YwsIo1r6JllrlB4SLuCJa2dbXbChiQU6/QIE=;
 b=hJxHaTy84qkz9RKLUrcHkVf66h4u7QeLPAU8fpKY0frbVev25hZbAd0Slq3EfyUHtPNy+c
 jL+aivcYZ0HRtmJoHulKq/md112WMeoQp5Kofb7FZPxeCBph8zfyBdz/jf+jfH5q1qQyNb
 uSyL4J3leDAHjtQCyDAYdSqFx7sUiQs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-thsViKpAPDeltl5YBbnmQQ-1; Wed, 05 Aug 2020 05:42:52 -0400
X-MC-Unique: thsViKpAPDeltl5YBbnmQQ-1
Received: by mail-wm1-f71.google.com with SMTP id z1so2492729wmf.9
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 02:42:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=JP0kXz5YwsIo1r6JllrlB4SLuCJa2dbXbChiQU6/QIE=;
 b=KpC9G/WbHHG/RatYEwodZBL3G9QWa+UdJ/Jh6FpszXSiVh4xpGBWaFnm3jIfGxYUmA
 VZgm9GbceIWNV86TVJjohvE1YjWjUElcbix8MuKmOCWe6t+LzPRQuwxWVgtRpFDEh3UY
 Y78TaRKDwHDQAoOgCW6viWXpbqHrsF/eEqp74Xa9+FsfJB1U/ljavTOLiMsA37a4lTR0
 +QCiB9DQqE6PLbV2zuMDafTQxS1XCARXyVQfk8nRDQraXupi3EVHQsyZrtekbAho2NZx
 iX4VdDnfhcXt1yHVBIDJh9BaVtjtYDVRl/EFTZIAWCUqEGRgaDpEQweu+fVR99dd5MrO
 cMWA==
X-Gm-Message-State: AOAM533e1CgWLK6smgkTzsoW7PxRna9y1NozZ2dx7w82xFUl4qY4ocbb
 cCIVKGO/nAcs+bmwnOuT4VDdEaE1BvEOW3n+TUTG9MEBaqahpqY0CqteEahW2CsMmzR4+dWSh1i
 E8MuPHi+JXIar6p0=
X-Received: by 2002:a1c:c910:: with SMTP id f16mr2461042wmb.82.1596620571644; 
 Wed, 05 Aug 2020 02:42:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwbV4U8p2Z41oErdqscyCyW1Y1MnH4eVrIBeVfLqdMYvYO+j9+E+NlqVjtDaZczl6xLrBr/mw==
X-Received: by 2002:a1c:c910:: with SMTP id f16mr2461020wmb.82.1596620571344; 
 Wed, 05 Aug 2020 02:42:51 -0700 (PDT)
Received: from [192.168.1.43] (214.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.214])
 by smtp.gmail.com with ESMTPSA id h11sm1959013wrb.68.2020.08.05.02.42.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Aug 2020 02:42:50 -0700 (PDT)
Subject: Re: [PATCH-for-5.1 v2 2/2] stubs: Remove qemu_notify_event()
To: qemu-devel@nongnu.org
References: <20200805085526.9787-1-philmd@redhat.com>
 <20200805085526.9787-3-philmd@redhat.com>
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
Message-ID: <6846f9a0-ba29-059a-e400-603116f5bb69@redhat.com>
Date: Wed, 5 Aug 2020 11:42:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200805085526.9787-3-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 03:37:07
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/5/20 10:55 AM, Philippe Mathieu-Daudé wrote:
> We don't need the qemu_notify_event() stub anymore.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  stubs/cpu-get-icount.c | 2 +-
>  stubs/notify-event.c   | 6 ------
>  stubs/Makefile.objs    | 1 -
>  3 files changed, 1 insertion(+), 8 deletions(-)
>  delete mode 100644 stubs/notify-event.c
> 
> diff --git a/stubs/cpu-get-icount.c b/stubs/cpu-get-icount.c
> index b35f844638..8962dfd71f 100644
> --- a/stubs/cpu-get-icount.c
> +++ b/stubs/cpu-get-icount.c
> @@ -17,5 +17,5 @@ int64_t cpu_get_icount_raw(void)
>  
>  void qemu_timer_notify_cb(void *opaque, QEMUClockType type)
>  {
> -    qemu_notify_event();
> +    abort();

This abort makes iotest 077 fail.
I think I'll simply repost without it.

>  }
> diff --git a/stubs/notify-event.c b/stubs/notify-event.c
> deleted file mode 100644
> index 827bb52d1a..0000000000
> --- a/stubs/notify-event.c
> +++ /dev/null
> @@ -1,6 +0,0 @@
> -#include "qemu/osdep.h"
> -#include "qemu/main-loop.h"
> -
> -void qemu_notify_event(void)
> -{
> -}
> diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
> index d42046afe4..cb374c96db 100644
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
> 


