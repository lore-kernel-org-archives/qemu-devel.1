Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B6AC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 13:16:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C19D02074B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 13:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e9+JI5p1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C19D02074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k18QN-0004yV-2e
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 09:16:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38468)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k18PC-0003Xe-Pi
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 09:15:30 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56691
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k18PB-0004lV-1y
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 09:15:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596114928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=SeZf0aDOryz8oEIwi7cYGFtK46KvQ1YiUCO/5R0RNio=;
 b=e9+JI5p10aWdErLT+9tXxDjRmjj8UqZEb+Xe8G25ZYf5/VySLRZv6SwUgNrqLJ8jNvKtUT
 woax80jk3R0vhgu2LUM7wUjhDkJvGtjBFDFK48HPpP0ulAxDZu2X4h3et5qW5fx5jOvdGF
 BpRTq+C2mPTzKH28+CvMTopm4WURU0w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-py_4m1gYPFeQsNp40jAqQQ-1; Thu, 30 Jul 2020 09:15:24 -0400
X-MC-Unique: py_4m1gYPFeQsNp40jAqQQ-1
Received: by mail-wm1-f71.google.com with SMTP id h205so2235403wmf.0
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 06:15:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=SeZf0aDOryz8oEIwi7cYGFtK46KvQ1YiUCO/5R0RNio=;
 b=LhaFLvPxIhk7DgSvST30KrekR7dNwM1DjhAXkeuEgEkt3g0909zYmTcL2o+EDyUiM3
 JoUiTEX+DqH3XEXxVl/U+YD8vVSNQaa1xOd1bYoLzj6B9rgwu6WNC7oQIe7qHDOr0z7R
 alkrrmsBzLsrJ1xPbsLI6aWMFbQRgDO0pQtaLCDa/51+WflfaCgZJ0gUgVt+eXngiIyw
 ZZskST8NN6jMDbchvUNyhdJKbMgu6mogIK40LDHX1ssstIYQHxoq0N3JEBh7A8Q2IOSw
 ZFZWD1q+44bH/ptIwpRBp7RB0wZ2dy3+6iUzD9hT726iwpyBGlDT4rxVf2vFmCHkrCIE
 7nmw==
X-Gm-Message-State: AOAM531jzHqr/DrFlwOyzOqlmzpllt9qZNrlbM2FTnQJOUrm4RMwejH8
 L04PFbiFfFptBMl9WfDPKDl4w9fOGCcl9HCHHPmOhC2X8WJhdQSKtZ/0k8SmKiKgqPdHQjo6aDd
 5gaAsJ95sU7nM42c=
X-Received: by 2002:a1c:ba83:: with SMTP id
 k125mr13483069wmf.160.1596114923380; 
 Thu, 30 Jul 2020 06:15:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzFlq0J/Y9ZQkH6DmJ5wvl+qX49N5AfiaRjz+i90teWcKn20Q2FwaCvJPJ2x3rC3TEQts6LUw==
X-Received: by 2002:a1c:ba83:: with SMTP id
 k125mr13483051wmf.160.1596114923109; 
 Thu, 30 Jul 2020 06:15:23 -0700 (PDT)
Received: from [192.168.1.39] (214.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.214])
 by smtp.gmail.com with ESMTPSA id z6sm10069322wrs.36.2020.07.30.06.15.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2020 06:15:22 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] virtio-mem: Change PRIx32 to PRIXPTR to fix
 compile error.
To: Kaige Li <likaige@loongson.cn>, "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <1596110248-7366-1-git-send-email-likaige@loongson.cn>
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
Message-ID: <601c098c-0f39-92be-8800-99f5fe99399f@redhat.com>
Date: Thu, 30 Jul 2020 15:15:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1596110248-7366-1-git-send-email-likaige@loongson.cn>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 03:41:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/30/20 1:57 PM, Kaige Li wrote:
> When I compile qemu with such as:
> 
> git clone https://git.qemu.org/git/qemu.git
> cd qemu
> git submodule init
> git submodule update --recursive
> ./configure
> make

^ this timeless description is pointless (think at a developer
who read this in 2 weeks, 3 months, 1 year).

> 
> There is error log:
> 
> /home/LiKaige/qemu/hw/virtio/virtio-mem.c: In function ‘virtio_mem_set_block_size’:
> /home/LiKaige/qemu/hw/virtio/virtio-mem.c:756:9: error: format ‘%x’ expects argument of type ‘unsigned int’, but argument 7 has type ‘uintptr_t’ [-Werror=format=]

What compiler are you using? That is the relevant information to
include.

>          error_setg(errp, "'%s' property has to be at least 0x%" PRIx32, name,
>          ^
> cc1: all warnings being treated as errors
> /home/LiKaige/qemu/rules.mak:69: recipe for target 'hw/virtio/virtio-mem.o' failed
> 
> So, change PRIx32 to PRIXPTR to fix this.
> 
> Signed-off-by: Kaige Li <likaige@loongson.cn>
> ---
>  hw/virtio/virtio-mem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
> index c12e9f7..3dcaf9a 100644
> --- a/hw/virtio/virtio-mem.c
> +++ b/hw/virtio/virtio-mem.c
> @@ -753,7 +753,7 @@ static void virtio_mem_set_block_size(Object *obj, Visitor *v, const char *name,
>      }
>  
>      if (value < VIRTIO_MEM_MIN_BLOCK_SIZE) {
> -        error_setg(errp, "'%s' property has to be at least 0x%" PRIx32, name,
> +        error_setg(errp, "'%s' property has to be at least 0x%" PRIXPTR "\n", name,
>                     VIRTIO_MEM_MIN_BLOCK_SIZE);
>          return;
>      } else if (!is_power_of_2(value)) {
> 


