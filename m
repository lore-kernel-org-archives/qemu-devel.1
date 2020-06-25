Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD2CC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:53:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC27A2089D
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dLDP/91N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC27A2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joUCE-0001LY-2I
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 11:53:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1joToF-0004rA-Hn
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:29:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31745
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1joToD-0007c6-LE
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:29:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593098937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=S6G9mUMcLJzBUEYK6gSu4DZiZGVGd/0VkKvrjqg8dmc=;
 b=dLDP/91N6e6O2YEuC3eMM/XVdd1V39CiY48MmbnwACpLmxf/pNVekdooGIAfV/+dCQ/UeS
 NcKhDrWMH4+IlCuaeQIZQtqAUEoqW77IEyvNRzEbKJS3ptGdTG8wTpCTzLnHQxaMYaYiUc
 s/XSzshicwubuS1zQNpVk0hRcQbk6X8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-DDzfADixNPSl-sNJeKkJDw-1; Thu, 25 Jun 2020 11:28:52 -0400
X-MC-Unique: DDzfADixNPSl-sNJeKkJDw-1
Received: by mail-wr1-f70.google.com with SMTP id n4so5025444wrj.15
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 08:28:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=S6G9mUMcLJzBUEYK6gSu4DZiZGVGd/0VkKvrjqg8dmc=;
 b=uS9STgpgOxJQCgRfOols1BfDICHhahHZAEwNkH4/ip3qkkT6ckUvFW5Y1/nzcL+stk
 9eoWG81eTXZOqtlFyIOsccO/n4+DqgaLOBSPnhsni7mgePCFRJ4DAaRgmhzQAWmnBRUV
 LDcyuvg7pJf4C9gLf2loFgX9tvieTRwzrD7s5+gxVc5eB0Ar28c7nhxOBKPkshpLM1AB
 CVOqqI3pRKV+cS1Ts/G+Gtp8CBCKu4M5vl6/e4IXume4tBeA9L8ccyZxbLKzQVnSlFMN
 2JmhLEqJ9AtKDH/7Vvp3ClvGtpcImxeisCkvNOgausvPEIhHeVnJmB1td/SfD3MocfjY
 PB7w==
X-Gm-Message-State: AOAM532i40kRnhc8cx90vDDgmBqmub0JhWE9KWiKUaZfZCDbFDxfM4pr
 ca9z9tONnil2eW6bgQnhRk6oUF7DfTRMHpZMX+o7zHvrVDt3qHPpyCeH5expS6Bjkb9VfIOpnPt
 Br+eUFliJT77WlCE=
X-Received: by 2002:a05:600c:2202:: with SMTP id
 z2mr4145682wml.13.1593098930707; 
 Thu, 25 Jun 2020 08:28:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxRCexnE6TPCwhAvL+Rk5l9BHdzWAumxJYULnAKcRIxDS/4jJ0z6e5OkM96Zx425XAZAVcKTQ==
X-Received: by 2002:a05:600c:2202:: with SMTP id
 z2mr4145660wml.13.1593098930485; 
 Thu, 25 Jun 2020 08:28:50 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id z6sm8638217wmf.33.2020.06.25.08.28.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jun 2020 08:28:50 -0700 (PDT)
Subject: Re: [PATCH] gitlab-ci: Fix the change rules after moving the YML files
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20200625151627.24986-1-thuth@redhat.com>
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
Message-ID: <6145edbf-6e30-e26e-d51b-cdf3f3f1259f@redhat.com>
Date: Thu, 25 Jun 2020 17:28:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200625151627.24986-1-thuth@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 00:45:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Palmer Dabbelt <palmerdabbelt@google.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/25/20 5:16 PM, Thomas Huth wrote:
> The edk2.yml and opensbi.yml files have recently been moved/renamed,
> but the change has not been reflected in the rules in the YML files
> yet.
> 
> Fixes: 922febe2af ("Move edk2 and opensbi YAML files to .gitlab-ci.d folder")
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  .gitlab-ci.d/edk2.yml    | 2 +-
>  .gitlab-ci.d/opensbi.yml | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/.gitlab-ci.d/edk2.yml b/.gitlab-ci.d/edk2.yml
> index 088ba4b43a..a9990b7147 100644
> --- a/.gitlab-ci.d/edk2.yml
> +++ b/.gitlab-ci.d/edk2.yml
> @@ -2,7 +2,7 @@ docker-edk2:
>   stage: build
>   rules: # Only run this job when the Dockerfile is modified
>   - changes:
> -   - .gitlab-ci-edk2.yml
> +   - .gitlab-ci.d/edk2.yml

Thanks!

>     - .gitlab-ci.d/edk2/Dockerfile
>     when: always
>   image: docker:19.03.1
> diff --git a/.gitlab-ci.d/opensbi.yml b/.gitlab-ci.d/opensbi.yml
> index dd051c0124..6a1750784a 100644
> --- a/.gitlab-ci.d/opensbi.yml
> +++ b/.gitlab-ci.d/opensbi.yml
> @@ -2,7 +2,7 @@ docker-opensbi:
>   stage: build
>   rules: # Only run this job when the Dockerfile is modified
>   - changes:
> -   - .gitlab-ci-opensbi.yml
> +   - .gitlab-ci.d/opensbi.yml

FWIW:

./scripts/get_maintainer.pl -f .gitlab-ci.d/opensbi.yml
get_maintainer.pl: No maintainers found, printing recent contributors.
get_maintainer.pl: Do not blindly cc: them on patches!  Use common sense.

Missed in c6fc0fc1a71a (apparently patchew bot was down when Bin
sent the patch).

Cc'ing Alistair who Acked the patch (also missed in the same commit,
see https://www.mail-archive.com/qemu-devel@nongnu.org/msg682407.html)

>     - .gitlab-ci.d/opensbi/Dockerfile
>     when: always
>   image: docker:19.03.1
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


