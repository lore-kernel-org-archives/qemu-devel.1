Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BEDC433E6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 08:24:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3962320709
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 08:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aHmWeR1R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3962320709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDO4H-00019p-DN
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 04:24:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDO0n-0002gZ-K7
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 04:20:57 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20287
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDO0l-0003Wd-RT
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 04:20:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599034854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=VubfB4Wo9wd9ILlGtC2QPGbvmdd4QVFY6mWphsEc//I=;
 b=aHmWeR1RFFtH9C8ZnCA16ElxXnPOm7dF431N3Qus0WL/4NKyph4yugKit5GqPAj2EmWXbD
 GFcwq+jbM3SXNm3+4maBlT1JXOC26JwsTUKpCabLazSB8Wxb4XSoFxRTB6/sS35FXs6XDt
 yowIKd+qXhAeAxwEmZ3FTchFtLH/DFw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-eFanYQO9M2av0nbf-_N0QQ-1; Wed, 02 Sep 2020 04:20:52 -0400
X-MC-Unique: eFanYQO9M2av0nbf-_N0QQ-1
Received: by mail-wm1-f69.google.com with SMTP id c72so1313036wme.4
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 01:20:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=VubfB4Wo9wd9ILlGtC2QPGbvmdd4QVFY6mWphsEc//I=;
 b=g2sf6LMBm4xHv/uUWlP1phrTASQ+njdCsbKXtNtbqMDTRKbpi0VVfYX1f4c79dnUTX
 iac/h0BGvaWcDW3Pb4WYJ6r92tksc0tLuf1R2k8Zh1bkGR/yANrMxJ3ytenUZrCR0i8q
 cfyiYta1OrHODvFETaVkRgLzq5vdCYGYZgqJ4+bLe39bpedlpNh+1NKkWHv/LBBSm6U5
 3dPaQXASK+vJxr3ligp5rkWjBJ59WCXB2bI7jk4wscpjObN41gHJ/ABSZfBf/Py3IKq9
 rqUEDOMJMBG6muYKAiebNtFvCX7Mlt/8fiFqC8lbEPMryoM8/jBLV4/88CXUAGtjNXtC
 Loag==
X-Gm-Message-State: AOAM530KfwhJ6T/x5GoWJ0APV9Ko0Vjzx+m1YYygNl1FUf57a1dD/t06
 iAieN4vEBQrY6dIVUsaFeZyiMa9CiUyQ3S15feWjYm6GFC03Aq2OBkuVs1DiiyhvBL8QvSmarzI
 iNxYinCGDgBa+zgg=
X-Received: by 2002:adf:f6c2:: with SMTP id y2mr5801207wrp.79.1599034851741;
 Wed, 02 Sep 2020 01:20:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJylES3AuD+M4+DFQHtDrCcR0kzsmx6ZDtITB7lFhf2rM3hKpOfD1SrECdJE9lM0SrL5zaJe6w==
X-Received: by 2002:adf:f6c2:: with SMTP id y2mr5801181wrp.79.1599034851521;
 Wed, 02 Sep 2020 01:20:51 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id p11sm1392014wma.11.2020.09.02.01.20.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2020 01:20:50 -0700 (PDT)
Subject: Re: [PATCH 05/13] oslib-posix: relocate path to /var
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200901062020.26660-1-pbonzini@redhat.com>
 <20200901062020.26660-6-pbonzini@redhat.com>
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
Message-ID: <e82a0a4a-f202-11ab-d440-873ffadf82f7@redhat.com>
Date: Wed, 2 Sep 2020 10:20:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200901062020.26660-6-pbonzini@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 03:24:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.13, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/1/20 8:20 AM, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  util/oslib-posix.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index a68fccb52d..8e23b8fac0 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -339,8 +339,10 @@ int qemu_pipe(int pipefd[2])
>  char *
>  qemu_get_local_state_pathname(const char *relative_pathname)
>  {
> -    return g_strdup_printf("%s/%s", CONFIG_QEMU_LOCALSTATEDIR,
> -                           relative_pathname);
> +    g_autofree char *dir = g_strdup_printf("%s/%s",
> +                                           CONFIG_QEMU_LOCALSTATEDIR,
> +                                           relative_pathname);
> +    return get_relocated_path(dir);
>  }
>  
>  void qemu_set_tty_echo(int fd, bool echo)
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


