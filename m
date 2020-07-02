Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E9EAC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 15:37:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D83820737
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 15:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EAZKlO4A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D83820737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr1HI-0001RM-Lm
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 11:37:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43992)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jr19B-00044m-26
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 11:29:09 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43303
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jr198-0006g6-3w
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 11:29:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593703745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UYGYdfE0NqxsnzzAmVx2BH8ivmxlP+PhNNOR4bGBfH8=;
 b=EAZKlO4Aso3NKIEfHmxB16OB1XG+bvmCdp3Al/Qrdn2DK38EwjT64E8bJCwIkQOhEk2mJB
 QK6Dwipkinp9rbgSyfCZzM+FRANk86UwZxx3tN1p9nGLkh0iy5UuN+Sce1bV2cGYltsgI1
 7+CbQq20atHEapeAlmpSIcbwieGdcCY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-GdlD0zvKNZWvfvkG2QvUWA-1; Thu, 02 Jul 2020 11:29:03 -0400
X-MC-Unique: GdlD0zvKNZWvfvkG2QvUWA-1
Received: by mail-ej1-f70.google.com with SMTP id lg24so21821745ejb.11
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2020 08:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=UYGYdfE0NqxsnzzAmVx2BH8ivmxlP+PhNNOR4bGBfH8=;
 b=kKI1ck7ldgXvC5sv29II9GTg9op0m+YDpKy6UUCZlC4AdWMETucx4EhSL9+tSM3ndO
 sZvi8KC002vfd0oEqwHNBA4ribn4X4k8/VAgKIInQN76pCqKush1qNUXAGYWnQ2vjHe9
 ufNxnRdjy5YRZUxcUvhOMTdgO4tv1aiEaMmYh2oLXpFqC+ST8cxxtXMyUEpEK2graSsk
 Ov/3S3zVrW49Vgf6M+5L0gYSLNWG0sPJb4ORJppAaMDfGh0bTyNAKDc6Ffrk2tYfWkam
 1ATQtTUOY2F6SR7g8jOFmKi8XCu0xW/u5JgppfkOs6lSxLTihd+njrICehM52/oaG2MB
 sTGQ==
X-Gm-Message-State: AOAM530sLU2w1V6d3AqtSlzfoPedHkeKmPumYA+pD44XDZypLIIG8KnO
 CNLdaDBAhnwEjHwp/dmc6ld1/IAdbVYPCRyo82Wh2wtmahF7aNaChzXcniZV3VZVoIktFRFC2x1
 YjE++4Ca23Bm1lCM=
X-Received: by 2002:a17:906:456:: with SMTP id
 e22mr22615680eja.178.1593703742532; 
 Thu, 02 Jul 2020 08:29:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXXOVAz9eOuM27sb6MmAKu8o9f57g7t2ScUqp7tWVtFV0Ew1hff1NIKS93TyqgwRm93AwXHg==
X-Received: by 2002:a17:906:456:: with SMTP id
 e22mr22615659eja.178.1593703742245; 
 Thu, 02 Jul 2020 08:29:02 -0700 (PDT)
Received: from [192.168.1.39] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id d26sm7231269ejw.89.2020.07.02.08.29.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2020 08:29:01 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] util: validate whether O_DIRECT is supported after
 failure
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20200702125612.2176194-1-berrange@redhat.com>
 <20200702125612.2176194-2-berrange@redhat.com>
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
Message-ID: <8793a9e9-5ee1-bebc-d1b5-75b9f53302c2@redhat.com>
Date: Thu, 2 Jul 2020 17:29:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200702125612.2176194-2-berrange@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 03:42:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 P J P <ppandit@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/2/20 2:56 PM, Daniel P. Berrangé wrote:
> Currently we suggest that a filesystem may not support O_DIRECT after
> seeing an EINVAL. Other things can cause EINVAL though, so it is better
> to do an explicit check, and then report a definitive error message.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  util/osdep.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/util/osdep.c b/util/osdep.c
> index 4829c07ff6..e2b7507ee2 100644
> --- a/util/osdep.c
> +++ b/util/osdep.c
> @@ -332,9 +332,11 @@ int qemu_open(const char *name, int flags, ...)
>      }
>  
>  #ifdef O_CLOEXEC
> -    ret = open(name, flags | O_CLOEXEC, mode);
> -#else
> +    flags |= O_CLOEXEC;
> +#endif
>      ret = open(name, flags, mode);
> +
> +#ifndef O_CLOEXEC
>      if (ret >= 0) {
>          qemu_set_cloexec(ret);
>      }
> @@ -342,8 +344,13 @@ int qemu_open(const char *name, int flags, ...)

Too bad the git-diff removed 2 lines of context to add a comment instead.

In case it helps other reviewers, what was stripped out of the
context is this single line:

   #endif

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>  
>  #ifdef O_DIRECT
>      if (ret == -1 && errno == EINVAL && (flags & O_DIRECT)) {
> -        error_report("file system may not support O_DIRECT");
> -        errno = EINVAL; /* in case it was clobbered */
> +        int newflags = flags & ~O_DIRECT;
> +        ret = open(name, newflags, mode);
> +        if (ret != -1) {
> +            close(ret);
> +            error_report("file system does not support O_DIRECT");
> +            errno = EINVAL;
> +        }
>      }
>  #endif /* O_DIRECT */
>  
> 


