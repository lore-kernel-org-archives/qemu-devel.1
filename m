Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA533C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 07:50:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 384A021D43
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 07:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WKLR2OvU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 384A021D43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFYOV-0000nv-4h
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 03:50:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52944)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFYNv-0000NU-Op
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 03:49:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29655
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFYNt-0005uu-Ie
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 03:49:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599551383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5MMX3DKa5vhdn25psU7KkTBPPRVjjsM4R5gGThi9iU0=;
 b=WKLR2OvUNjLa6NoNLRSa/9T5lkqdPl2aNza4m2QsX8H0yaYsW9O0urISHL+1dNKWm07NBn
 M6avTBxg7BXM8PZ/q0fSogXLRpKYN4Dl1wZQ5Cm9Hp2tlxUp03qcdl2ZcFmTlNKUvPFLBc
 H9P4zTan8FVMBDCBb+X2/WKTYuB4Fks=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-hqUNACP4PNKVzHsyBvhavw-1; Tue, 08 Sep 2020 03:49:39 -0400
X-MC-Unique: hqUNACP4PNKVzHsyBvhavw-1
Received: by mail-wm1-f70.google.com with SMTP id w3so4434106wmg.4
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 00:49:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=5MMX3DKa5vhdn25psU7KkTBPPRVjjsM4R5gGThi9iU0=;
 b=EpAcVWtEf+iOrmoCyNQdZyIcGDPPWI++Xx3AToAXANOQLi7B9nHvVGKe2t4ZkqtUx7
 a71iE/Ss4cqG58QEb2ypNlrEnYeO/Swvpfvz5acwmLxkDfljm9MZ+8578v7p+CHpDCAW
 QlCDxDQUWWmbwaCFkJTkZRAIdx5qkQF2RTFrjLCya8CKBhIca+eQHjJ8UTnU1rcTsnAC
 v3TNEmAkhraURfbFoEqWmXsJ99xqyl6fkK8+eUmHVwJPIDZfZk1dWL4L93+WwkhtXSUh
 RuiDa+YbB2N7WpqZY7Y7EUpwB03FvqDg0nTGcekuoZ1+/4DmXmit+NxYJMeNOFL5Eq7m
 A+PA==
X-Gm-Message-State: AOAM531Twn1iSb/CjSvSgLGTdT/B0SXY2QJFGn5oDqxhyqmvNWzfz3Fr
 hakCNiecQqKm63+PtP9Dy4hCdwlZtLYUTkQdZt5fhx+i2UTKC7yWFZc9e5dPdBoWK2n8W+8VINW
 XkjRYu9noU/4oB7U=
X-Received: by 2002:adf:ec47:: with SMTP id w7mr6787515wrn.175.1599551378544; 
 Tue, 08 Sep 2020 00:49:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxyPDsHgLaFxesAiduJeUav8uHvOmeQrSQlqlrgUI3+7t1A5qzm3BAEZ8AE2OZmPUmK8M49gg==
X-Received: by 2002:adf:ec47:: with SMTP id w7mr6787495wrn.175.1599551378313; 
 Tue, 08 Sep 2020 00:49:38 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id t203sm32811081wmg.43.2020.09.08.00.49.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2020 00:49:37 -0700 (PDT)
Subject: Re: [PATCH] meson.build: tweak sdl-image error message
To: Sergei Trofimovich <slyfox@gentoo.org>, qemu-devel@nongnu.org
References: <20200908074016.2593596-1-slyfox@gentoo.org>
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
Message-ID: <89434eee-42cb-62db-32f7-9bb0dd7c31ea@redhat.com>
Date: Tue, 8 Sep 2020 09:49:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200908074016.2593596-1-slyfox@gentoo.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 02:10:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.825, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Rafael Kitover <rkitover@gmail.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/8/20 9:40 AM, Sergei Trofimovich wrote:
> Before the change missing SDL was reported as:
> 
>     ../meson.build:253:4: ERROR: Expected 1 arguments, got 2.
> 
> After the error as:
> 
>     ../meson.build:258:4: ERROR: Problem encountered: sdl-image required, but SDL was not found
> 
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: "Marc-André Lureau" <marcandre.lureau@redhat.com>
> CC: "Philippe Mathieu-Daudé" <philmd@redhat.com>
> CC: Rafael Kitover <rkitover@gmail.com>
> Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  meson.build | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index 04e070bb3b..7fd2a903c5 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -255,8 +255,8 @@ if sdl.found()
>                           method: 'pkg-config', static: enable_static)
>  else
>    if get_option('sdl_image').enabled()
> -    error('sdl-image required, but SDL was @0@',
> -          get_option('sdl').disabled() ? 'disabled' : 'not found')
> +    error('sdl-image required, but SDL was @0@'.format(
> +          get_option('sdl').disabled() ? 'disabled' : 'not found'))
>    endif
>    sdl_image = not_found
>  endif
> 


