Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B0BC43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 17:51:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A6C020EDD
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 17:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WwFiO13K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A6C020EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHsd3-0000dh-1x
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 13:51:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52384)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kHsbU-0008Qx-KJ
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 13:49:24 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40426
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kHsbS-0001j6-7h
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 13:49:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600105760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mUK8TfCL1d2mMb/KwS3krzn3qMbhDt35RVkErtm0zUo=;
 b=WwFiO13KpXTjZ2O0vdtptHloiI/zAVCFFfnXbfJpvF4B+S6JMvJZodKZrPTfaFdOQrPlO3
 oKmzCzQJbCN0nOXoA56Hyq3tKcmW7B3nh+JfGcOcuyzpqzQYshgY2zmPk39NKAt6PCE8Lx
 8nvKMsAHX1NlmNidVwKBCFyNzWlglEs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-s7wdtC1rMC6guPVkeA7pOQ-1; Mon, 14 Sep 2020 13:49:18 -0400
X-MC-Unique: s7wdtC1rMC6guPVkeA7pOQ-1
Received: by mail-wm1-f69.google.com with SMTP id s19so276645wme.2
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 10:49:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=mUK8TfCL1d2mMb/KwS3krzn3qMbhDt35RVkErtm0zUo=;
 b=M9M8jYaUtP5IXthEKiuGf0FGmSjJwh42hvq38LfMsJMLa6/7mqnPuOMsRJ4720Um4e
 9T8EhUz4QkZysA7v3sM+PeT6nI4XTjXpSC+XH/JhgzzsqcaHq5hGFOfRZl0+Q3ZeMnr/
 sKd1MKU5Twbl5Z3JPToFVIhHHzDFHTUDXKPYNEsTF57Pxi9PsuJ/pMc/rJgFWnXtAA2g
 73bIuSBeJkN/YcDu6OLuvwSFC5aspnfmYGJqnmB2T50gteWZff7ut5flWuzpqlGYxpay
 FhqSaI/cEVvF1M2gH6h/JF7KTCoOLPtucdAvH5V4v+VtfUzvPRVad8ddEWI3VS7l7OYc
 2nyw==
X-Gm-Message-State: AOAM533RDoHuPkqs4LS2G3D4NzrS/+y8EuXwQrRh7/QTS0TNrkh276kz
 T8G1hyFrS8sbLuMVtUFgcTe24KuTB2cPpqlIH++k09lrBRWXR/9/i0XiLD8tteZj7aw6MsYbpeo
 Tcf6gqH2B1jzMni4=
X-Received: by 2002:a5d:5642:: with SMTP id j2mr17017016wrw.417.1600105756900; 
 Mon, 14 Sep 2020 10:49:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7AK6nMpyQ3gIUVaUDUq8X5F2Zuc/uT6yAOHqVnKuIIx24vAHCG+XvE3ZB7hGDJR38NK8KVg==
X-Received: by 2002:a5d:5642:: with SMTP id j2mr17016995wrw.417.1600105756681; 
 Mon, 14 Sep 2020 10:49:16 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id o15sm3348058wmh.29.2020.09.14.10.49.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2020 10:49:15 -0700 (PDT)
Subject: Re: [PATCH v2] checkpatch: Detect '%#' or '%0#' in printf-style
 format strings
To: Dov Murik <dovmurik@linux.vnet.ibm.com>, qemu-devel@nongnu.org
References: <20200914172623.72955-1-dovmurik@linux.vnet.ibm.com>
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
Message-ID: <c6935847-2fe8-cc58-69eb-95b51c5427aa@redhat.com>
Date: Mon, 14 Sep 2020 19:49:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200914172623.72955-1-dovmurik@linux.vnet.ibm.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 00:11:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/14/20 7:26 PM, Dov Murik wrote:
> According to the coding style document, we should use literal '0x' prefix
> instead of printf's '#' flag (which appears as '%#' or '%0#' in the format
> string).  Add a checkpatch rule to enforce that.
> 
> Note that checkpatch already had a similar rule for trace-events files.
> 
> Example usage:
> 
>   $ scripts/checkpatch.pl --file chardev/baum.c
>   ...
>   ERROR: Don't use '#' flag of printf format ('%#') in format strings, use '0x' prefix instead
>   #366: FILE: chardev/baum.c:366:
>   +            DPRINTF("Broken packet %#2x, tossing\n", req); \
>   ...
>   ERROR: Don't use '#' flag of printf format ('%#') in format strings, use '0x' prefix instead
>   #472: FILE: chardev/baum.c:472:
>   +        DPRINTF("unrecognized request %0#2x\n", req);
>   ...
> 
> Signed-off-by: Dov Murik <dovmurik@linux.vnet.ibm.com>
> ---
> 
> Since v1:
> - consolidate format string checks to avoid code duplication
> 
> ---
>  scripts/checkpatch.pl | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index bd3faa154c..f8dac953b2 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2880,14 +2880,20 @@ sub process {
>  				$herecurr);
>  		}
>  
> -# check for %L{u,d,i} in strings
> +# format strings checks
>  		my $string;
>  		while ($line =~ /(?:^|")([X\t]*)(?:"|$)/g) {
>  			$string = substr($rawline, $-[1], $+[1] - $-[1]);
>  			$string =~ s/%%/__/g;
> +			# check for %L{u,d,i} in strings
>  			if ($string =~ /(?<!%)%L[udi]/) {
>  				ERROR("\%Ld/%Lu are not-standard C, use %lld/%llu\n" . $herecurr);
> -				last;
> +			}
> +			# check for %# or %0# in printf-style format strings
> +			if ($string =~ /(?<!%)%0?#/) {
> +				ERROR("Don't use '#' flag of printf format " .
> +				      "('%#') in format strings, use '0x' " .
> +				      "prefix instead\n" . $herecurr);
>  			}
>  		}
>  
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


