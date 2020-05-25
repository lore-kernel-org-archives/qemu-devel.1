Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F02C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 13:33:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 870602078B
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 13:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y1h4F24w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 870602078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdDEX-0007Sx-O9
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 09:33:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdDDZ-0006Ng-8k
 for qemu-devel@nongnu.org; Mon, 25 May 2020 09:32:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37928
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdDDX-00063A-4Q
 for qemu-devel@nongnu.org; Mon, 25 May 2020 09:32:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590413553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=fhj4B4tf3cla4aXOrCalIOukAOudgVK/WH7y/va36T4=;
 b=Y1h4F24wWmXpo3UV2OhtpAiKwU7817Y7EkBXP3Ojg0t/NnbRElPrbd7QtFDLhtZIWUMbGe
 GCC0NVHl4N2HNEXrooBecQQ0r1YVbbWSOoxXC4QxNqrtXX1YR+xnYyo4C3QNSY+6AKZStn
 HD5O+Rle6kLpnp+T5KpvB3tt2BN6mXI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-_urRr4YLNhKC2WqKZaAEEQ-1; Mon, 25 May 2020 09:32:32 -0400
X-MC-Unique: _urRr4YLNhKC2WqKZaAEEQ-1
Received: by mail-ej1-f70.google.com with SMTP id o23so6354003ejx.21
 for <qemu-devel@nongnu.org>; Mon, 25 May 2020 06:32:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=fhj4B4tf3cla4aXOrCalIOukAOudgVK/WH7y/va36T4=;
 b=mvZe0uvcA19xWYy59jVw6YUQjqJl8n2k7q/R2Hr4MGumWpc4OF6RymN8RiD/+5P+ol
 qojpKVD8NcoO39021HZ7hUO8deuTmGIZcBco8Z7493TmShro5Nmt0wuZd1nz26a1C+KX
 QZOkxIIz5JpFO0dYoi60eTP1jM+lezGptEblm5r3A4HeHqpeo3/8Eg7P6vmpfa/E7aap
 Ek/0bPob82/mIFRrEnSpQ1vPpAodTuKDBC990XHW3/moH04pN4rM2mCz0eP7rhPslIlI
 HRSG2j95hZYBQOYCBWlH/+rlTHirssqVjTF0NhLals0ziOxVkIz3KzJsg03Azcg1d8nC
 ychg==
X-Gm-Message-State: AOAM532rRiy+UPUCi8SWNtRsvl4KO8Roc2CYadX+sJUMWE26ZvC75bJN
 Guus6oL0x0KjuIcK31UG57bY0mkJWJncLQmNc/iuQv98LGPOUBtNlCuhkno1wNDiQzE/xhMJEpQ
 p/NDrYgTWLXnx2NI=
X-Received: by 2002:a17:906:6951:: with SMTP id
 c17mr18339528ejs.112.1590413550739; 
 Mon, 25 May 2020 06:32:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxNu+v/uPs4AMBZg9Ru+diA/qkP9bMakHry99QojYZ+iY0ox0tS89+pybNKX8xm8ZbE2/mXZQ==
X-Received: by 2002:a17:906:6951:: with SMTP id
 c17mr18339504ejs.112.1590413550495; 
 Mon, 25 May 2020 06:32:30 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id v6sm15685650eje.113.2020.05.25.06.32.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 May 2020 06:32:29 -0700 (PDT)
Subject: Re: [PATCH 4/7] gitlab-ci: Move edk2 and opensbi YAML files to
 .gitlab-ci.d folder
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20200525131823.715-1-thuth@redhat.com>
 <20200525131823.715-5-thuth@redhat.com>
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
Message-ID: <8beb510f-35c4-325f-f6dc-bd0e9101238d@redhat.com>
Date: Mon, 25 May 2020 15:32:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200525131823.715-5-thuth@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 01:44:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/25/20 3:18 PM, Thomas Huth wrote:
> We have a dedicated folder for the gitlab-ci - so there is no need
> to clutter the top directory with these .yml files.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  .gitlab-ci-edk2.yml => .gitlab-ci.d/edk2.yml       | 0
>  .gitlab-ci-opensbi.yml => .gitlab-ci.d/opensbi.yml | 0
>  .gitlab-ci.yml                                     | 4 ++--
>  MAINTAINERS                                        | 2 +-
>  4 files changed, 3 insertions(+), 3 deletions(-)
>  rename .gitlab-ci-edk2.yml => .gitlab-ci.d/edk2.yml (100%)
>  rename .gitlab-ci-opensbi.yml => .gitlab-ci.d/opensbi.yml (100%)
> 
> diff --git a/.gitlab-ci-edk2.yml b/.gitlab-ci.d/edk2.yml
> similarity index 100%
> rename from .gitlab-ci-edk2.yml
> rename to .gitlab-ci.d/edk2.yml
> diff --git a/.gitlab-ci-opensbi.yml b/.gitlab-ci.d/opensbi.yml
> similarity index 100%
> rename from .gitlab-ci-opensbi.yml
> rename to .gitlab-ci.d/opensbi.yml
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index bc6aee6aba..5208d93ff8 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -1,6 +1,6 @@
>  include:
> -  - local: '/.gitlab-ci-edk2.yml'
> -  - local: '/.gitlab-ci-opensbi.yml'
> +  - local: '/.gitlab-ci.d/edk2.yml'
> +  - local: '/.gitlab-ci.d/opensbi.yml'
>  
>  .update_apt_template: &before_script_apt
>   before_script:
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bde5fd480f..d43c98115c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2534,7 +2534,7 @@ F: roms/edk2
>  F: roms/edk2-*
>  F: tests/data/uefi-boot-images/
>  F: tests/uefi-test-tools/
> -F: .gitlab-ci-edk2.yml
> +F: .gitlab-ci.d/edk2.yml
>  F: .gitlab-ci.d/edk2/
>  
>  Usermode Emulation
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


