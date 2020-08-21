Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B699C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 17:56:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D1AA20702
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 17:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HEb/xiWY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D1AA20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9BHK-0005I7-Bj
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 13:56:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k9BFw-00047R-JK
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 13:55:12 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35272
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k9BFt-0004iV-Dm
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 13:55:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598032507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=D/wzNG7qOM6TY3kaSyFv6y6JAoDm6Hav/HE3L7XYty8=;
 b=HEb/xiWYqfOT35kR5vaPX9Rm5XC9tS4dNEYt8rrG4iPLNHE238mjzAZVdQDQFyH5cslnAU
 Z4GoNbAzWOxekFRwSI7SVLwh+Tx4/A2el/e6CfsKQtJHvLi5ljRK+SsAzub6aK/KeK0eHO
 45F1xs4DbwIkB5CLo3KXBOLlQ1LxozE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-572-1BsB7XEEMNGTnLLF4DvfJw-1; Fri, 21 Aug 2020 13:55:06 -0400
X-MC-Unique: 1BsB7XEEMNGTnLLF4DvfJw-1
Received: by mail-wr1-f72.google.com with SMTP id o10so790567wrs.21
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 10:55:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=D/wzNG7qOM6TY3kaSyFv6y6JAoDm6Hav/HE3L7XYty8=;
 b=RRX0NgsBMdnU5tHc2aaleU9rJw3LhZNDkXj6JtZgduXszsHh0A2CMdbZ8GnfWIIrHf
 e/Zt+l04KD+Uoxr/hth4x77cmGcKiO8BZdyn3UYRu6gM/SzGq4CLFQzwRH+lMtMMO039
 yGr2bZurqnBkb+wBr8zwJTWWFVMlTA4ZBRe7zGr9dbGdjprBWsQiHVTYIxPEQHMC6l9c
 KJ0p5Mwjzjm+kUuFWO4v9D6EfDpZFPET4k+ySMRrimETyTuWXexnOaVE6Mb/7O7NwirO
 kIKD+DAgX9rYZ462ckSKIBIjcIDIBYZ285o+13ITCHlyePOSmSpE3h/GE4Mfzbj13aGo
 C1Tg==
X-Gm-Message-State: AOAM530dJ0obyRA9L4v8CXW9POAEdlLaZpj/dcSoMsh1GQeub55KXLXl
 ulBm8Z0a3qhxmn1rD+vliFceLCE2dAOvzLMJwlj4Dmpay6cTTPqydYLlJ7tFvuG3PQbe/IXBurI
 QAc9UiKyb6h6W1KQ=
X-Received: by 2002:a05:600c:514:: with SMTP id
 i20mr4991507wmc.102.1598032504910; 
 Fri, 21 Aug 2020 10:55:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwb97Y51Joz3AcG1AIaFL05ew3C6d3Z99igeYmNYm2wtJ34dItGvbWZiSPoDNEvDJMf+keYDA==
X-Received: by 2002:a05:600c:514:: with SMTP id
 i20mr4991489wmc.102.1598032504710; 
 Fri, 21 Aug 2020 10:55:04 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id y16sm5661408wrr.83.2020.08.21.10.55.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2020 10:55:03 -0700 (PDT)
Subject: Re: [PATCH] tests/docker: add liburing-devel to the Fedora image
To: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org
References: <20200821165458.100591-1-sgarzare@redhat.com>
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
Message-ID: <e5fdb193-952a-2bed-a1c7-4eb8bb0bbff7@redhat.com>
Date: Fri, 21 Aug 2020 19:55:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200821165458.100591-1-sgarzare@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 01:00:15
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/21/20 6:54 PM, Stefano Garzarella wrote:
> Install liburing-devel dependencies to get better coverage on
> io-uring stuff (block/io_uring.c and util/fdmon-io_uring.c).
> 
> Suggested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  tests/docker/dockerfiles/fedora.docker | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
> index 70b6186bd3..9650d324fa 100644
> --- a/tests/docker/dockerfiles/fedora.docker
> +++ b/tests/docker/dockerfiles/fedora.docker
> @@ -38,6 +38,7 @@ ENV PACKAGES \
>      libssh-devel \
>      libubsan \
>      libudev-devel \
> +    liburing-devel \
>      libusbx-devel \
>      libxml2-devel \
>      libzstd-devel \
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

../util/fdmon-io_uring.c:106:17: error: address argument to atomic
operation must be a pointer to _Atomic type ('unsigned int *' invalid)
    old_flags = atomic_fetch_or(&node->flags, FDMON_IO_URING_PENDING |
flags);
                ^               ~~~~~~~~~~~~
/usr/lib64/clang/10.0.0/include/stdatomic.h:138:42: note: expanded from
macro 'atomic_fetch_or'
#define atomic_fetch_or(object, operand) __c11_atomic_fetch_or(object,
operand, __ATOMIC_SEQ_CST)
                                         ^                     ~~~~~~
../util/fdmon-io_uring.c:130:14: error: address argument to atomic
operation must be a pointer to _Atomic type ('unsigned int *' invalid)
    *flags = atomic_fetch_and(&node->flags, ~(FDMON_IO_URING_PENDING |
             ^                ~~~~~~~~~~~~

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>


