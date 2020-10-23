Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F42C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:15:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CCB82192A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="COKRgJxw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CCB82192A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVzia-0001Um-Qr
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 12:15:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38074)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kVzIK-0005SD-Ts
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:48:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60914)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kVzII-0004Db-Pq
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:47:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603468073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z7+KvGQSbrx8Dqh1IxSfOisQOqpXcm3ISi3KgAMYGB0=;
 b=COKRgJxwOpT4cN45ocUYbSB7NG3QY3hESliI9ErA82uoy2qvmmiaZOCEFZt86cygWsUS+B
 OMGR6lsUAf5JwqoN4OeWoaYMkpGKouG/d+leFFEAWbpLcc9GPGnofbmn9BYKcVUNQ/eTfA
 xcmCfvBUdyQ6BZM4CBd2Dhb5jOstkEE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-554-HDQPGburNWyuhF0Bj4ZjpQ-1; Fri, 23 Oct 2020 11:47:50 -0400
X-MC-Unique: HDQPGburNWyuhF0Bj4ZjpQ-1
Received: by mail-wm1-f72.google.com with SMTP id r19so602049wmh.9
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 08:47:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=z7+KvGQSbrx8Dqh1IxSfOisQOqpXcm3ISi3KgAMYGB0=;
 b=pYiOiCRUQVFkWlyYdZZ4giz8hAXVZe9aG6j93OO4lnBZH+HA739KqcXIoPLXXc1dDu
 sBOr1i5uLiMIFjBfwxYj9DrWGGzKrnw3zHl7ZoVb2CUOQLArvljo6D7rcPkF67FKrcmp
 BcXgmh0uk/WmueCDbU831vDPTk+SYc3WuO0khWTrxQZWO23Gcd+GxFyT2DAHrOo3DUNa
 1ySoFA9djQqd0Arnz7ECB087wzn9ANEyRoEBiSbjtpk+RLl9jXRO1uYoKhHoWcoWf300
 +MfuWkz8qDMI2Y9NqDqayw00egDMVpKC8O0WdDhkVActBXp86Q3xlu7A+0fsVqZxKQ4F
 Y2qQ==
X-Gm-Message-State: AOAM530DvoQrVqmHC/Yl1SDk4LdDNNQ7507znXetv8ppUilGa4hq1XV9
 slLyImHixsNb4R2M81mt7/sBi9oj+LcyyQl6Ykh4qdrsxVr06ngpBGTGm4LOlSglm0IZX9m5CJO
 tSSY3y5S9QWiy4h4=
X-Received: by 2002:a1c:bc55:: with SMTP id m82mr2859446wmf.159.1603468067171; 
 Fri, 23 Oct 2020 08:47:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZpg3Rj4HG8fLb7l78pPrIGbR9NOh0kE9ddFAqX96Zj/rbsrtHoylV872PLrnJ+GzyxqQ8aQ==
X-Received: by 2002:a1c:bc55:: with SMTP id m82mr2859424wmf.159.1603468066955; 
 Fri, 23 Oct 2020 08:47:46 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id x15sm4603941wrr.36.2020.10.23.08.47.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2020 08:47:46 -0700 (PDT)
Subject: Re: [qemu-web PATCH 6/7] Add link to "edit this page" for all pages
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20201023152957.488974-1-berrange@redhat.com>
 <20201023152957.488974-7-berrange@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d61c100e-fb49-6f13-77e0-2262cb06946d@redhat.com>
Date: Fri, 23 Oct 2020 17:47:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201023152957.488974-7-berrange@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 02:46:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.108, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/10/20 17:29, Daniel P. Berrangé wrote:
> The link takes the user directly to the source markdown file in gitlab,
> where they can press the "Edit" button and make changes directly in the
> browser. They will be prompted to fork the project when committing the
> changes if they don't already have a fork.  The result is a commit which
> can be submitted for review per the contributing guidelines.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

I think this is a good idea *if* we switch to merge requests for website
edits---which isn't something I'm opposed to.

Paolo

> ---
>  _includes/footer.html        | 3 +++
>  assets/css/style-desktop.css | 4 ++++
>  assets/css/style.css         | 2 +-
>  3 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/_includes/footer.html b/_includes/footer.html
> index 2dd247b..0a77d8e 100644
> --- a/_includes/footer.html
> +++ b/_includes/footer.html
> @@ -1,4 +1,7 @@
>  <div id="footer">
> +	<div id="edit-page">
> +		<a href="https://gitlab.com/qemu-project/qemu-web/-/blob/master/{{page.path}}">edit this page</a>
> +	</div>
>  	<div id="external-links">
>  		<ul class="style">
>  			<li><a href="http://qemu-advent-calendar.org">Advent calendar</a></li>
> diff --git a/assets/css/style-desktop.css b/assets/css/style-desktop.css
> index d45ec15..19272ad 100644
> --- a/assets/css/style-desktop.css
> +++ b/assets/css/style-desktop.css
> @@ -102,6 +102,10 @@
>  /* Footer                                                                        */
>  /*********************************************************************************/
>  
> +	#edit-page {
> +		text-align: right;
> +	}
> +
>  	#licenses {
>  		float: right;
>  	}
> diff --git a/assets/css/style.css b/assets/css/style.css
> index e2fee29..50bbcd1 100644
> --- a/assets/css/style.css
> +++ b/assets/css/style.css
> @@ -514,7 +514,7 @@
>  		margin: 0em;
>  	}
>  
> -	#conservancy, #licenses {
> +	#conservancy, #licenses, #edit-page {
>  		padding: 0em;
>  		padding-left: 1em;
>  		padding-right: 1em;
> 


