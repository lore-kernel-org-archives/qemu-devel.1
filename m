Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3CBAC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 04:21:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7B7F2075F
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 04:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nov3G95O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7B7F2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jd4cI-0005Dv-SX
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 00:21:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48338)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jd4bb-0004md-Oo
 for qemu-devel@nongnu.org; Mon, 25 May 2020 00:20:51 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49964
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jd4ba-0004on-A2
 for qemu-devel@nongnu.org; Mon, 25 May 2020 00:20:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590380448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=C0lDCbx2O2j/tjV55sDnHX103bMl15EJ3Z8poC0dNA0=;
 b=Nov3G95O3fa2mvM4Wn8ZODPN++YtfIU9dCJhywJe7fNS3wN53tsoO6Cnsgt6cJ7r1lKraz
 lWCiY5YcLphGtW0e+RJDhv7dTjb1dE4IP7112+pRS4IMQ4dmFroJAkj6ymj4v9I8uDxNp7
 p2WSn/k0HzNaeO6rYTMpmmRlgYRxTLs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-dvlbolVtP2yYwWVxraN9iQ-1; Mon, 25 May 2020 00:20:46 -0400
X-MC-Unique: dvlbolVtP2yYwWVxraN9iQ-1
Received: by mail-wm1-f72.google.com with SMTP id t62so6234705wmt.7
 for <qemu-devel@nongnu.org>; Sun, 24 May 2020 21:20:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=C0lDCbx2O2j/tjV55sDnHX103bMl15EJ3Z8poC0dNA0=;
 b=Nbq0oKxc9FtKTWYsn5s5AkH6xA09QjxmiTXi+jf/N3VYgW6wYANZbBKMmkLRwIkwTH
 cl4GN8pHMVjuJjuV5wkDDRZvMpy0KZqcn19J9bLJM2TngnfA40MTZ6ogjCdPZGiSJnIc
 QQRJRzWLV/BKFrmBJgJ1gtVu05gl1Oi9kNFoqWg/hIW++a6Ecni3QYpN2zEavax3o7zR
 Ni0Xd4YjaeIT4FYfTYHXst5A4kD4rbsmM1A0Caw5Mxl6Nxp09QJYm+6MfK9CSTGG/bIf
 I868wrHk1BFesoOHsVWLRuzrZyVsi2TbwqRBl7BqL6fUpPCnt09jowYu5mMDZ0hFQKCL
 IhFg==
X-Gm-Message-State: AOAM533l1pxrwMM2Bs8ZvYnkWg2XeQLsFJoRJNByMycRrjHsyjl1HlFK
 sAPLb2ygbm50nbIUl1Qifs4OhRkaomnwXoYOimjD3333OzxqzlGdi+h5EbhY3MTXaIsjX1v5XcE
 Iuks+4IQIf7GlazI=
X-Received: by 2002:adf:8287:: with SMTP id 7mr13412354wrc.396.1590380445662; 
 Sun, 24 May 2020 21:20:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxgJzS/yvLLIq5yr3NrxoWJnxa6z71LuE4YR0DPjCZRi80ncuHbKUFvnhFlaYEFTABAwLWYUA==
X-Received: by 2002:adf:8287:: with SMTP id 7mr13412335wrc.396.1590380445469; 
 Sun, 24 May 2020 21:20:45 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id l5sm9004551wml.27.2020.05.24.21.20.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 24 May 2020 21:20:44 -0700 (PDT)
Subject: Re: [PATCH] configure: Do not ignore malloc value
To: Leonid Bloch <lb.workbox@gmail.com>, qemu-devel@nongnu.org
References: <20200524221204.9791-1-lb.workbox@gmail.com>
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
Message-ID: <a03a3bf6-4761-1d1a-2812-13701980680e@redhat.com>
Date: Mon, 25 May 2020 06:20:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200524221204.9791-1-lb.workbox@gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 00:06:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/25/20 12:12 AM, Leonid Bloch wrote:
> From: Leonid Bloch <lbloch@janustech.com>
> 
> Not checking the value of malloc will cause a warning with GCC 10.1,
> which may result in configuration failure, with the following line in
> config.log:
> 
> config-temp/qemu-conf.c:2:18: error: ignoring return value of ‘malloc’ declared with attribute ‘warn_unused_result’ [-Werror=unused-result]
>     2 | int main(void) { malloc(1); return 0; }
>       |                  ^~~~~~~~~

Do we want to add -Wno-unused-result to compile_prog()?

> 
> Signed-off-by: Leonid Bloch <lb.workbox@gmail.com>
> ---
>  configure | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/configure b/configure
> index 2fc05c4465..d0220b2944 100755
> --- a/configure
> +++ b/configure
> @@ -4567,7 +4567,13 @@ fi
>  if test "$tcmalloc" = "yes" ; then
>    cat > $TMPC << EOF
>  #include <stdlib.h>
> -int main(void) { malloc(1); return 0; }
> +int main(void) {
> +    void *tmp = malloc(1);
> +    if (tmp != NULL) {
> +        return 0;
> +    }
> +    return 1;
> +}
>  EOF
>  
>    if compile_prog "" "-ltcmalloc" ; then
> @@ -4583,7 +4589,13 @@ fi
>  if test "$jemalloc" = "yes" ; then
>    cat > $TMPC << EOF
>  #include <stdlib.h>
> -int main(void) { malloc(1); return 0; }
> +int main(void) {
> +    void *tmp = malloc(1);
> +    if (tmp != NULL) {
> +        return 0;
> +    }
> +    return 1;
> +}
>  EOF
>  
>    if compile_prog "" "-ljemalloc" ; then
> @@ -6144,7 +6156,9 @@ if test "$sanitizers" = "yes" ; then
>  #include <stdlib.h>
>  int main(void) {
>      void *tmp = malloc(10);
> -    return *(int *)(tmp + 2);
> +    if (tmp != NULL) {
> +        return *(int *)(tmp + 2);
> +    }
>  }
>  EOF
>    if compile_prog "$CPU_CFLAGS -Werror -fsanitize=undefined" ""; then
> 


