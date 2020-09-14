Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8E8C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 06:56:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1E63207EA
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 06:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="StqDk6W/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1E63207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHiPl-0006cV-5T
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 02:56:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45464)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kHiOs-0005kO-Fo
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 02:55:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51985)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kHiOq-0007o2-G6
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 02:55:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600066539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QydyHfA6t0vZ4vD/vbXTe0/Qg0RVtDZoPko+EDkOhuQ=;
 b=StqDk6W/wFJRzwhPdtzMxHE1dmQkMYk9kdimdJjhf1CKllYOG901bQ8xTSG1be5gB1WrGh
 o6Wk3PZgZwjSN2/ojjeUCG8KTt9P/gN6+X1zoalAN/XhHGLYto8ba2Y/Wa6RncQlH2Fgyy
 nEphDG6yookdkfeYt3QTihYxWnkyLY8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-g_JJf4kwODelDBORQmluPw-1; Mon, 14 Sep 2020 02:55:36 -0400
X-MC-Unique: g_JJf4kwODelDBORQmluPw-1
Received: by mail-wr1-f70.google.com with SMTP id 33so6534134wre.0
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2020 23:55:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QydyHfA6t0vZ4vD/vbXTe0/Qg0RVtDZoPko+EDkOhuQ=;
 b=HoL6JVXXXIPan0zz1qng2+7aafw8H6qHQJLexRzXg4qFC8NIPANvBNeUH+TJ9V4GzP
 BdqyHpYe4HJ51wMWdC2ANfCofThWEGACHHaV5/YsCn+OM+o1+ywt95P2skojvnikxlvR
 +gATpGt713bJeay0vNgeiLsmNJZpAIZAF2EwyOyxkkHeie2LVEtJpq0ZYZtENrvt874Q
 qFu7WfwrKQ28aQ1AuFoDpzHYqMvpFw5fqc2vDlYCDDby7Yif1WlWmu0ksXLMwAOOC8Qz
 WtNGhPbKheWgI4eWFnLfSXWg+OD3vnRPhg+PXLeYhPjZri7Ds35Sk3a3U3+6R6KvWAlT
 E0+A==
X-Gm-Message-State: AOAM532+OxDF/6CTLdUV2wd9myfrZWOuh1Ts1A0NmqovyAXyzST/QCpq
 MHoirKz/m81/FjQYSYfstFbUr+cTdPQrDt4dZavlj2kCv3u3qBHYGVKLe29pZaxETRGBhCOhvuq
 98mZp2dOco5powkg=
X-Received: by 2002:a5d:4e0f:: with SMTP id p15mr14325475wrt.155.1600066535274; 
 Sun, 13 Sep 2020 23:55:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrrn8cuDW0GUWY32aBJNOsJc5UF9Asz4X9qrxeg3NCj6xUJav00YSY8wUK+nQ4eWyPRXIYaw==
X-Received: by 2002:a5d:4e0f:: with SMTP id p15mr14325452wrt.155.1600066534986; 
 Sun, 13 Sep 2020 23:55:34 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id z7sm19220600wrw.93.2020.09.13.23.55.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Sep 2020 23:55:34 -0700 (PDT)
Subject: Re: [PATCH] checkpatch: Detect '%#' or '%0#' in printf-style format
 strings
To: Dov Murik <dovmurik@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20200914060109.69583-1-dovmurik@linux.vnet.ibm.com>
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
Message-ID: <cc5a95d7-4efd-a3de-c1a2-0c77cb60c63a@redhat.com>
Date: Mon, 14 Sep 2020 08:55:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200914060109.69583-1-dovmurik@linux.vnet.ibm.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 02:55:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.695,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+qemu-perl team

On 9/14/20 8:01 AM, Dov Murik wrote:
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
>  scripts/checkpatch.pl | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index bd3faa154c..6ec2a9f6a1 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2891,6 +2891,18 @@ sub process {
>  			}
>  		}
>  
> +# check for %# or %0# in printf-style format strings
> +		while ($line =~ /(?:^|")([X\t]*)(?:"|$)/g) {
> +			my $string = substr($rawline, $-[1], $+[1] - $-[1]);
> +			$string =~ s/%%/__/g;
> +			if ($string =~ /(?<!%)%0?#/) {
> +				ERROR("Don't use '#' flag of printf format " .
> +				      "('%#') in format strings, use '0x' " .
> +				      "prefix instead\n" . $herecurr);
> +				last;
> +			}
> +		}
> +
>  # QEMU specific tests
>  		if ($rawline =~ /\b(?:Qemu|QEmu)\b/) {
>  			ERROR("use QEMU instead of Qemu or QEmu\n" . $herecurr);
> 

Thank you for this patch!

What about folding it in the same block?

-- >8 --
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2880,15 +2880,22 @@ sub process {
                                $herecurr);
                }

-# check for %L{u,d,i} in strings
+# format strings checks
                my $string;
                while ($line =~ /(?:^|")([X\t]*)(?:"|$)/g) {
                        $string = substr($rawline, $-[1], $+[1] - $-[1]);
                        $string =~ s/%%/__/g;
+                       # check for %L{u,d,i} in strings
                        if ($string =~ /(?<!%)%L[udi]/) {
                                ERROR("\%Ld/%Lu are not-standard C, use
%lld/%llu\n" . $herecurr);
                                last;
                        }
+                       if ($string =~ /(?<!%)%0?#/) {
+                               ERROR("Don't use '#' flag of printf
format " .
+                                     "('%#') in format strings, use
'0x' " .
+                                     "prefix instead\n" . $herecurr);
+                               last;
+                       }
                }

 # QEMU specific tests
---


