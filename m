Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 276EAC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:28:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECD53206C3
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LmLCbLbG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECD53206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqdj9-0004O8-5b
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 10:28:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39026)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jqdgW-0001rK-Rj
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 10:26:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21055
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jqdgU-0002An-UB
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 10:26:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593613558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t5HcXnEsZH1QefsX1QuZ3AuaKWbFdGteqhsXfdg5MN0=;
 b=LmLCbLbG/003PlQWLIgOMNdqIEKmPwrdEuC5v/xejfhDKvb+XjerK2AkMmNaLDd4I0aLQf
 kpAKl2rQBqAF/dsPYwafS92RQlnXwv4dBklpBrmFHB8eJ8LiYiifJw/ehb0b2+bKQePsWt
 xDnUdioQ3v6sE8QA5d94HB2UErw8yXI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-508-XQmBWqUgMW6QuXzxzgTFWw-1; Wed, 01 Jul 2020 10:25:52 -0400
X-MC-Unique: XQmBWqUgMW6QuXzxzgTFWw-1
Received: by mail-wm1-f70.google.com with SMTP id g187so23676997wme.0
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 07:25:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=t5HcXnEsZH1QefsX1QuZ3AuaKWbFdGteqhsXfdg5MN0=;
 b=eKcB03Om97QxkTJLMc6hS8yGILvQc+L+tMzQq0zhjoxQm7ub/UqosMDxqp1hJJ5DZ9
 24h3acQSdZYkoBTlPCWh3jStn87KB2DM6N0lIguLvJFwd6Bqg3vz7+TfhhsNtzTk23/C
 lIUku4SCqI29eJXvUktxXT6oyZOLRGMQ/KwFiN+CibeiPjCDkvVL1f6JRBmz92kBS75j
 od7ilzk+AIewF/1Yzt3f8ksn39yZz2Ckio4u5WQRDGFGTCx5Q3agUvpE7CoOZ1Go3Eww
 5guzkiXbKS+Q5/LQSS6tUOkDV/fqH5oXDLdP/gJC2gq2cpo8ePp29moY2aXfl6q8VYki
 mYtA==
X-Gm-Message-State: AOAM530Fw9xlRkSGEJfGR7jliTTIsXWsLrbwFJb59pE++YEclDr8JVZq
 xRthi3wunGXbOoIa+WjXw+TE4wVQbE3cfgqmcUlrz2bLzLLsYmqlO6Ckse5490ThO2s8dcNg79u
 gU74EurcVjQKrJeM=
X-Received: by 2002:adf:8444:: with SMTP id 62mr25784752wrf.278.1593613551557; 
 Wed, 01 Jul 2020 07:25:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwXz3UDVoujeKZYrNR5UUnOEBFQTmCz3ZJ4dxZna76kJys9sIEdy/NzLM41sMqbe4itldoEnA==
X-Received: by 2002:adf:8444:: with SMTP id 62mr25784728wrf.278.1593613551256; 
 Wed, 01 Jul 2020 07:25:51 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1142:70d6:6b9b:3cd1?
 ([2001:b07:6468:f312:1142:70d6:6b9b:3cd1])
 by smtp.gmail.com with ESMTPSA id t2sm7307442wma.43.2020.07.01.07.25.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jul 2020 07:25:50 -0700 (PDT)
Subject: Re: [PATCH] scripts/get_maintainer: Use .ignoredmailmap to ignore
 invalid emails
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200629172716.20781-1-f4bug@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8616bdd8-34a9-f737-aa9d-f11d735cc0fe@redhat.com>
Date: Wed, 1 Jul 2020 16:25:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200629172716.20781-1-f4bug@amsat.org>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 22:25:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/06/20 19:27, Philippe Mathieu-Daudé wrote:
> Sometime emails get rejected and 'bounce'. It might take time
> between we report that, a patch is posted, reviewed, merged...
> 
> To reduce time spent looking at bouncing emails in one mailbox,
> add the feature to simply ignore broken email addresses. The
> format is similar to the '.mailmap' file. Add an email address
> in your local '.ignoredmailmap. and get_maintainer.pl won't
> list it anymore.
> 
> This is particularly useful when git-send-email is used with
> the --cc-cmd argument, like suggested in QEMU wiki:
> https://wiki.qemu.org/Contribute/SubmitAPatch#CC_the_relevant_maintainer
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Do you have such a list already?

Paolo

> ---
>  scripts/get_maintainer.pl | 50 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
> index 271f5ff42a..7f7a4ff3ef 100755
> --- a/scripts/get_maintainer.pl
> +++ b/scripts/get_maintainer.pl
> @@ -38,6 +38,7 @@
>  my $interactive = 0;
>  my $email_remove_duplicates = 1;
>  my $email_use_mailmap = 1;
> +my $email_use_ignoredmailmap = 1;
>  my $output_multiline = 1;
>  my $output_separator = ", ";
>  my $output_roles = 0;
> @@ -365,6 +366,51 @@ sub read_mailmap {
>      close($mailmap_file);
>  }
>  
> +my $ignoredmailmap;
> +
> +read_ignoredmailmap();
> +
> +sub read_ignoredmailmap {
> +    $ignoredmailmap = {
> +	names => {},
> +	addresses => {}
> +    };
> +
> +    return if (!$email_use_ignoredmailmap || !(-f "${lk_path}.ignoredmailmap"));
> +
> +    open(my $ignoredmailmap_file, '<', "${lk_path}.ignoredmailmap")
> +	or warn "$P: Can't open .ignoredmailmap: $!\n";
> +
> +    while (<$ignoredmailmap_file>) {
> +	s/#.*$//; #strip comments
> +	s/^\s+|\s+$//g; #trim
> +
> +	next if (/^\s*$/); #skip empty lines
> +	#entries have one of the following formats:
> +	# name1 <mail1>
> +	# <mail1>
> +
> +	if (/^([^<]+)<([^>]+)>$/) {
> +	    my $real_name = $1;
> +	    my $address = $2;
> +
> +	    $real_name =~ s/\s+$//;
> +	    ($real_name, $address) = parse_email("$real_name <$address>");
> +	    $ignoredmailmap->{$address} = 1;
> +	} elsif (/^(.+)<([^>]+)>\s*<([^>]+)>$/) {
> +	    my $real_name = $1;
> +	    my $real_address = $2;
> +	    my $wrong_address = $3;
> +
> +	    $real_name =~ s/\s+$//;
> +	    ($real_name, $real_address) =
> +		parse_email("$real_name <$real_address>");
> +	    $ignoredmailmap->{$real_address} = 1;
> +	}
> +    }
> +    close($ignoredmailmap_file);
> +}
> +
>  ## use the filenames on the command line or find the filenames in the patchfiles
>  
>  my @files = ();
> @@ -1074,6 +1120,10 @@ sub push_email_address {
>      if ($address eq "") {
>  	return 0;
>      }
> +    if (exists $ignoredmailmap->{$address}) {
> +        #warn("Ignoring address: '" . $address . "'\n");
> +        return 0;
> +    }
>  
>      if (!$email_remove_duplicates) {
>  	push(@email_to, [format_email($name, $address, $email_usename), $role]);
> 


