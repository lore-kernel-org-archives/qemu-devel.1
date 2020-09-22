Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774C8C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 10:47:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0E3E2073A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 10:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yxlq//s0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0E3E2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKfpR-0006P5-Vd
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 06:47:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57262)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kKfjO-0008F7-RH
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 06:41:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25551
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kKfjM-0007hq-Os
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 06:41:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600771263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QkkX2KSqRZcm5V9jZUsc01VfT9xxl7WpUzWoSFLqsxs=;
 b=Yxlq//s0cVw4BFhIQKHPXb/SKFAV9ww9BGABIAsKqhCzqhhO/R+JdyMD6BTDIrDMpQ7ECZ
 V1SC/0xLRHuxntkNdQbmrtnn3e0Qqdf1pzJwsVZbhEhEbzd9wCzGTmV5gt6fo/6nRizPSu
 Sv9+5wlX2fueE3X6L2GXt7nRBNh/SAk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-577-ETfVrWIDM4OvGGRpuJUglg-1; Tue, 22 Sep 2020 06:41:02 -0400
X-MC-Unique: ETfVrWIDM4OvGGRpuJUglg-1
Received: by mail-wr1-f71.google.com with SMTP id v5so7164788wrs.17
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 03:41:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QkkX2KSqRZcm5V9jZUsc01VfT9xxl7WpUzWoSFLqsxs=;
 b=ezhbW70xfJqIT8dFlyAQWqbz4JQ+flRAD8lPJER+yxjhyv1RIwhlR0y4TPeFa2pM/M
 drzbn9v9XUzRpfHYFUgOGixolbGU2xgi+NJ6lAvImbbCH6JjatxvaeioG7ujyZatInvJ
 hjS6NI/su9jdTf4pBjicNYtIlIIQrJVxCpzyLwiOLefe8HZfoOQ5Bx0RYqGmZkd8ltbD
 8D1qiLWg5Sbt5rQyn1F/nUmQumFlrhoHs+yy8ugIxa+uuLKITMMRsPCOI+ODNrIt3ECh
 yFtiMnjqtxp3zTgVHIhl3PoiZSdUI/h6rRqc0oA7GdK8qXAoWquigMcdLyC6KUpEVt7j
 SLkw==
X-Gm-Message-State: AOAM533oG059E1jzD4/12IiVOsfTxNBKIcHd67iiSTy73xOAJuagMH4U
 3v54QZvx96khmb0rAUIgOiWWk7Rp/tUoqgLs+gQbFskwbryeChtmK0l1Nz+LoZrB8Y1fxhxyU6D
 6XVQySPLWq4aQ+H0=
X-Received: by 2002:a05:600c:2742:: with SMTP id
 2mr305834wmw.136.1600771260835; 
 Tue, 22 Sep 2020 03:41:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJySQMWlcOwdYHtOolJOE67gX8lwpbHAoJCjyZ9kei9rBxadbcPfXgxjZUz88uQoPl3K1drw+Q==
X-Received: by 2002:a05:600c:2742:: with SMTP id
 2mr305818wmw.136.1600771260614; 
 Tue, 22 Sep 2020 03:41:00 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ec2c:90a9:1236:ebc6?
 ([2001:b07:6468:f312:ec2c:90a9:1236:ebc6])
 by smtp.gmail.com with ESMTPSA id j26sm27156972wrc.79.2020.09.22.03.40.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2020 03:41:00 -0700 (PDT)
Subject: Re: [PATCH v2] checkpatch: Detect '%#' or '%0#' in printf-style
 format strings
To: Dov Murik <dovmurik@linux.vnet.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200914172623.72955-1-dovmurik@linux.vnet.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <262db394-d419-5e6e-2f9b-cbbfa35fe321@redhat.com>
Date: Tue, 22 Sep 2020 12:40:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200914172623.72955-1-dovmurik@linux.vnet.ibm.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 01:57:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14/09/20 19:26, Dov Murik wrote:
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

Queued, thanks.

Paolo


