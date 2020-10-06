Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 869FCC4363D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 11:49:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CED442083B
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 11:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hUJfANgl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CED442083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPlT6-0001wM-Tu
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 07:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40156)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPlGD-000345-FC
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 07:36:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45947)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPlGB-0008Ne-Jk
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 07:36:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601984156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=SNcUbL/LPbVvkZfpdHM/aLr1f5frJWAHlBZbUFodFh4=;
 b=hUJfANgl/ES2cprKv/hxL/5lAwDchk5b7LBWaXu3gs2GIyi39WEvyykIhmPLoE2+J/nWeZ
 Go3ScjRE2IrtEaxnsJwpDHv7V5Srnego9eQW8P0TYLIMIPbqf1+DH1ZIq9OzDfjLEo1XUI
 +qBptgIGAm0FrfH33ARTAbxaxIrVFHE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-461-VMi7V0gjPWigGR-7hrjDnA-1; Tue, 06 Oct 2020 07:35:54 -0400
X-MC-Unique: VMi7V0gjPWigGR-7hrjDnA-1
Received: by mail-wr1-f71.google.com with SMTP id j7so5255172wro.14
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 04:35:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=SNcUbL/LPbVvkZfpdHM/aLr1f5frJWAHlBZbUFodFh4=;
 b=nYJoM8q7lyhyRnM1UTBaP9vqRAy9EeYz2ODatghbphcWPreVVZB868VIuG25lJ4sNm
 gY+3D6+EEZJfV0L/XthcfgyU1ESlwRSNjCD/LunM/7Im7nHd/ALVu4I4shpK0A1VTvuc
 zOyK+EQlgGoDam3KO3vVR73YP59DS8PpAh8zmBGnaLeeKHKXavnF4LeW8JLLA4/vCnbh
 HVL+6CqqOUmH6katcROQTt3N6AW7KatQtEn5RXgugbutFPUQ2iWU6PudTXmmMayBeL/c
 fun3XrNL7tM2F9Uw8lEXDZ7gIt6wZeZVI+xGcNlsBxY0fi4CVRFkZpkt9lPkZqG1exg6
 36Pg==
X-Gm-Message-State: AOAM532Mn8GGBYzPe12o0+K2OSt+WzCiDyQ0XtIoZ/7kBqvSjyvSh6yh
 SXOid6ADpmLpeGAzCpH2QEBBVT2EGGZKGALoPrkGao0mkz6twMZAgT6lU9V5kCJYzL57WMlqdZC
 rKOyYUbAhG5pEOIg=
X-Received: by 2002:a1c:e045:: with SMTP id x66mr4400658wmg.104.1601984153630; 
 Tue, 06 Oct 2020 04:35:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxjIDJ9sCr4XVmL4FBxUcICRKjddrXPsuK1uNQKVMfeYbo6mlhEf6Jl+UJV0Q5hqxPXVCCodA==
X-Received: by 2002:a1c:e045:: with SMTP id x66mr4400645wmg.104.1601984153459; 
 Tue, 06 Oct 2020 04:35:53 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id n66sm3640529wmb.35.2020.10.06.04.35.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2020 04:35:52 -0700 (PDT)
Subject: Re: [PATCH v5 13/36] qapi/common.py: Replace one-letter 'c' variable
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20201005195158.2348217-1-jsnow@redhat.com>
 <20201005195158.2348217-14-jsnow@redhat.com>
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
Message-ID: <8e02089a-8c67-b47b-d011-d5dbf10bcae9@redhat.com>
Date: Tue, 6 Oct 2020 13:35:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201005195158.2348217-14-jsnow@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 00:55:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/5/20 9:51 PM, John Snow wrote:
> Signed-off-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Cleber Rosa <crosa@redhat.com>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  scripts/qapi/common.py | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> index a417b6029c8..338adedef4f 100644
> --- a/scripts/qapi/common.py
> +++ b/scripts/qapi/common.py
> @@ -30,14 +30,14 @@ def camel_to_upper(value):
>      new_name = ''
>      length = len(c_fun_str)
>      for i in range(length):
> -        c = c_fun_str[i]
> -        # When c is upper and no '_' appears before, do more checks
> -        if c.isupper() and (i > 0) and c_fun_str[i - 1] != '_':
> +        char = c_fun_str[i]
> +        # When char is upper case and no '_' appears before, do more checks
> +        if char.isupper() and (i > 0) and c_fun_str[i - 1] != '_':
>              if i < length - 1 and c_fun_str[i + 1].islower():
>                  new_name += '_'
>              elif c_fun_str[i - 1].isdigit():
>                  new_name += '_'
> -        new_name += c
> +        new_name += char
>      return new_name.lstrip('_').upper()

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


