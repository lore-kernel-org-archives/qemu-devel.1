Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F6CC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 16:14:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FAE020855
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 16:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MC0WDZtG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FAE020855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k99fz-0007EV-UG
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 12:13:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56304)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k99ew-0006Lm-QS
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 12:12:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24859
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k99ev-0004W7-4D
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 12:12:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598026372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=IIBXUBdwUcOdvsIbCDkDqLvjTVwZqbEmSXC8+2kB9lA=;
 b=MC0WDZtGI5+tYYrmK99B+aQDtErRhpnrfUno24S9hLPonRPmI63xWbD9ErF2A0E2JR8iiS
 HEmhQphxwiPMsgw0NTuMFWl6Q7DJVS0p1FzOzpveV7ko5jCNsO2OZbZmEryfsvgmlq6Aw4
 H7YNmvhsxXa0v/T2AHYxUh+YcNOxR2s=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-w1kmnX7WNTKxk8nNb-cyxg-1; Fri, 21 Aug 2020 12:12:49 -0400
X-MC-Unique: w1kmnX7WNTKxk8nNb-cyxg-1
Received: by mail-wr1-f69.google.com with SMTP id o10so689431wrs.21
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 09:12:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=IIBXUBdwUcOdvsIbCDkDqLvjTVwZqbEmSXC8+2kB9lA=;
 b=RfybieJHQwDpub2UssYIw4Xr1h5Um0bW7ZkJIe4kXLoD4GrNTtCl1jDYXTyXMLwAHn
 QIaTAnq0axdR+ue6dOtQAdO7D6jIirrKnGMWRhkXb2NH18+q+s4VpI5/LIJ+nid4eF8p
 LM38XsXhIr2ySRGRqlVGKRScHhDT+hzMBBp84S4qebrWiH28JIEFnF2iyF4gDOqFWSFy
 RieRO9r4S2uol8zM/ytuLpJ97AqnwAAhasHSRTSqBSz1oCFkctG0gNxJW/W5+hcKRvvX
 jmiJ9IRF4569otTpO6N3QhIGixWBjeXfjB6qMpo8/Ic2tIKj6tNGRvTWBh0A7HE7rwOI
 vqmw==
X-Gm-Message-State: AOAM530/Y8Mt/LfKKVuEjOYRU8/MKkxuYMCf+JeLwUJCHG1kqQr5/QVZ
 RxqT7Nm2wwdk5Po4F1NMMi/gwE/KexlH663ZAtOKuwFglaS9ggCvY6BjCeF8jtuOYIrr7o53+jp
 rcGS16DYq6Uphp/0=
X-Received: by 2002:a1c:7203:: with SMTP id n3mr4087265wmc.149.1598026368293; 
 Fri, 21 Aug 2020 09:12:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyXc0w3Rs3441scNtwPkCFkAlhNQ5wIJdcr+hnZsezXgkjMBIKfYudugUTryG28dZ5Hz6TgyA==
X-Received: by 2002:a1c:7203:: with SMTP id n3mr4087239wmc.149.1598026368123; 
 Fri, 21 Aug 2020 09:12:48 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id m8sm4970048wro.75.2020.08.21.09.12.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2020 09:12:47 -0700 (PDT)
Subject: Re: [PATCH] util/meson.build: fix fdmon-io_uring build
To: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org
References: <20200821154853.94379-1-sgarzare@redhat.com>
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
Message-ID: <b750b7e1-2fca-2662-b575-2883d1073743@redhat.com>
Date: Fri, 21 Aug 2020 18:12:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200821154853.94379-1-sgarzare@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 23:41:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Stefano,

On 8/21/20 5:48 PM, Stefano Garzarella wrote:
> libqemuutil.a build fails with this error:
> 
>   /usr/bin/ld: libqemuutil.a(util_fdmon-io_uring.c.o): in function `get_sqe':
>   qemu/build/../util/fdmon-io_uring.c:83: undefined reference to `io_uring_get_sqe'
>   /usr/bin/ld: qemu/build/../util/fdmon-io_uring.c:92: undefined reference to `io_uring_submit'
>   /usr/bin/ld: qemu/build/../util/fdmon-io_uring.c:96: undefined reference to `io_uring_get_sqe'
>   /usr/bin/ld: libqemuutil.a(util_fdmon-io_uring.c.o): in function `fdmon_io_uring_wait':
>   qemu/build/../util/fdmon-io_uring.c:289: undefined reference to `io_uring_submit_and_wait'
>   /usr/bin/ld: libqemuutil.a(util_fdmon-io_uring.c.o): in function `fdmon_io_uring_setup':
>   qemu/build/../util/fdmon-io_uring.c:328: undefined reference to `io_uring_queue_init'
>   /usr/bin/ld: libqemuutil.a(util_fdmon-io_uring.c.o): in function `fdmon_io_uring_destroy':
>   qemu/build/../util/fdmon-io_uring.c:343: undefined reference to `io_uring_queue_exit'
>   collect2: error: ld returned 1 exit status

Can you add a gitlab job to reproduce this? (Or at least explain
how to reproduce, so we add that job later). Thanks!

> 
> This patch fix the issue adding 'linux_io_uring' dependency for
> fdmon-io_uring.c
> 
> Fixes: a81df1b68b ("libqemuutil, qapi, trace: convert to meson")
> Cc: pbonzini@redhat.com
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  util/meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/util/meson.build b/util/meson.build
> index 23b8ad459b..e6b207a99e 100644
> --- a/util/meson.build
> +++ b/util/meson.build
> @@ -4,7 +4,7 @@ util_ss.add(when: 'CONFIG_ATOMIC64', if_false: files('atomic64.c'))
>  util_ss.add(when: 'CONFIG_POSIX', if_true: files('aio-posix.c'))
>  util_ss.add(when: 'CONFIG_POSIX', if_true: files('fdmon-poll.c'))
>  util_ss.add(when: 'CONFIG_EPOLL_CREATE1', if_true: files('fdmon-epoll.c'))
> -util_ss.add(when: 'CONFIG_LINUX_IO_URING', if_true: files('fdmon-io_uring.c'))
> +util_ss.add(when: ['CONFIG_LINUX_IO_URING', linux_io_uring], if_true: files('fdmon-io_uring.c'))
>  util_ss.add(when: 'CONFIG_POSIX', if_true: files('compatfd.c'))
>  util_ss.add(when: 'CONFIG_POSIX', if_true: files('event_notifier-posix.c'))
>  util_ss.add(when: 'CONFIG_POSIX', if_true: files('mmap-alloc.c'))
> 


