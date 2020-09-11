Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B155C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 14:29:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34FA022286
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 14:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hsUfIEJa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34FA022286
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGk3F-0004kN-OP
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 10:29:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kGk28-0003US-7y
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 10:28:12 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27248
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kGk25-0003nK-Er
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 10:28:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599834487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ul9TDPFS1na5v+d/JW1rD55prioCxwM5v21bwz6IbPo=;
 b=hsUfIEJaFODXofmyEIbpUxCstNC25bhn/UZh8cnckV3bphF11W/zQt5mBXYF907/whYzBr
 5DYNf5GsfIwAJGNDPBu0Ig3w5bWP7kduAHpeFFjc6TGLXHLWTKX+J723K46nS2wfB6BJAE
 H86+qlQ7BfpWCviZhiOvN5lLLeACTjw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-7vAdte9LMqyKqrbUPXnD2A-1; Fri, 11 Sep 2020 10:28:05 -0400
X-MC-Unique: 7vAdte9LMqyKqrbUPXnD2A-1
Received: by mail-wm1-f70.google.com with SMTP id l26so1426069wmg.7
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 07:28:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=ul9TDPFS1na5v+d/JW1rD55prioCxwM5v21bwz6IbPo=;
 b=dZoTn1JMYZ8bbm40TkSyc+BfTDQ83aJal9e3TZlce1SuNN4gpCnhLFKuUjK1graYLt
 sDw3R02/BZydOSh5tdTObVdqRnLM8HMDyS0aDwtrr1qiEbJb4UPR0aWlFlW7SwfT6SPV
 Ylo5STyO03Zp+HII7uNamUPca+6crATHa86egWG6dtRfvUOiDAJtDYzCFiDL7BwEOyQA
 vbp46Y3otZBjm0tc3OnJ8XyMFLWVfCN9ZHwO8gYQuhcvt/672xbFjkNmMhJcJtu6K5t5
 yCLn/8QurVlhjpk8MS8fvILFSI15Xupf/ICafwpU1f2ZVW4+LT26Jdsp2IsIY1JjrT6t
 tluw==
X-Gm-Message-State: AOAM53182dklVYvujbX7qHA7ZNQ5IqbUSpTE6dIB0kBLWNuIBdW6iGB9
 janvXbZEvC/N0WSneaOgsGGdZw0aALT8IYcBq7+8r3JRrsrGPIkozv7xA61rfFF3PPnL14afNDP
 EGKwPhi2Q2mOZsBE=
X-Received: by 2002:a5d:674c:: with SMTP id l12mr2314412wrw.325.1599834483384; 
 Fri, 11 Sep 2020 07:28:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxNfr4LqWWXt6AF6rdqo20PdQumkg54835tNVOstlbLvGmeqjSgEz1aCrvthBpcNLZhbV6xoQ==
X-Received: by 2002:a5d:674c:: with SMTP id l12mr2314388wrw.325.1599834483175; 
 Fri, 11 Sep 2020 07:28:03 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id t202sm4832023wmt.14.2020.09.11.07.28.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2020 07:28:02 -0700 (PDT)
Subject: Re: [PATCH] tests: add missing genh dependency
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200911134221.46636-3-pbonzini@redhat.com>
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
Message-ID: <79c2c28d-2f30-1a7f-5006-56a86dd42951@redhat.com>
Date: Fri, 11 Sep 2020 16:28:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200911134221.46636-3-pbonzini@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 03:40:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.469, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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
Cc: Claudio Fontana <cfontana@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/11/20 3:42 PM, Paolo Bonzini wrote:
> Fix high-parallelism builds by forcing all generated headers
> to be created before tests are compiled.

FYI I had this problem too (simply building with -j8)
simply adding a new qapi/file.json.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> 
> Reported-by: Claudio Fontana <cfontana@suse.de>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/meson.build | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/meson.build b/tests/meson.build
> index 3683512dca..e2b915ea8f 100644
> --- a/tests/meson.build
> +++ b/tests/meson.build
> @@ -56,7 +56,7 @@ test_qapi_files = custom_target('Test QAPI files',
>  # perhaps change qapi_gen to replace / with _, like Meson itself does?
>  subdir('include')
>  
> -libtestqapi = static_library('testqapi', sources: [test_qapi_files, test_qapi_outputs_extra])
> +libtestqapi = static_library('testqapi', sources: [test_qapi_files, genh, test_qapi_outputs_extra])
>  testqapi = declare_dependency(link_with: libtestqapi)
>  
>  testblock = declare_dependency(dependencies: [block], sources: 'iothread.c')
> @@ -223,7 +223,7 @@ foreach test_name, extra: tests
>      src += test_ss.all_sources()
>      deps += test_ss.all_dependencies()
>    endif
> -  exe = executable(test_name, src, dependencies: deps)
> +  exe = executable(test_name, src, genh, dependencies: deps)
>  
>    test(test_name, exe,
>         depends: test_deps.get(test_name, []),
> 


