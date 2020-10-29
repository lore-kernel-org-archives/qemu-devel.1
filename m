Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB2ADC2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 21:31:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1144F20731
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 21:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XEY5e63Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1144F20731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYFVt-0001zE-TP
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 17:31:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kYFTl-00016a-VA
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 17:29:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57002)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kYFTj-0002CP-3u
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 17:29:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604006941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4FI/YJl3O50X/CnKnxKF1tg5u9TOSsARbgF25NwuA2A=;
 b=XEY5e63Y0TXkgcQanBE3q8/YtneaOHpI8iRLy67SODK5uJBEnKeOo9DRH/UUfrYk7O4PT7
 B+IdQ1c7uIKiLcDw984/ESGhiwi6aF+FnfXjI6Eg/LQ6iBt7MCUhO5MNJQfqTPudttm3WK
 Dh22CYcXqrLBv9Grx2BqzQKWTnEaGDc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-75-DEHmot53Ou6QRz8sCXNpdg-1; Thu, 29 Oct 2020 17:28:59 -0400
X-MC-Unique: DEHmot53Ou6QRz8sCXNpdg-1
Received: by mail-wr1-f69.google.com with SMTP id t14so1814573wrs.2
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 14:28:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4FI/YJl3O50X/CnKnxKF1tg5u9TOSsARbgF25NwuA2A=;
 b=J87ovGrvefNN636vxy/r94ycyVswI1Pr7sSKzvBvYhGnOnJoslQkjEEXzev6hEq5Re
 QM1BhaXUYtSpWPvoyxXmXc8Wh8mbAS588/nCo3QiJ6IBB2HJfd1RLgBoAnZdO/7rspDy
 wfnRrBEeXkGzbN1/MB0HYgJdDQN5yVWxGmrmx8vlDcapBaaMWJTfoWpg7LkSu0Hx0Kom
 FBAzUO8Ss7DwYLYpMI46RPzepbCnmqefSm9RTCGw5Qv3wL9oQmFr+dF4qW5JS95q+R8K
 TAMZxCov4ISbRmvjFjEpt/Jz/rr2EiIQVIigh1Q/wDg1a4NslFlBX57Ks53eq7ydveEi
 imHQ==
X-Gm-Message-State: AOAM5306BEMCp45eOiLBx6OEdizDU/IMLi/5l2T900glCsSOn2kcOsOl
 qhmD69u2pcNlVrA+/+9AGNMsrTYDen7oJKlYz7Ij4GI9nw2awoVsdW/AsikSstaee9OjLOJlCYc
 kzR/s9CKXbNJexig=
X-Received: by 2002:a7b:cc0e:: with SMTP id f14mr1265185wmh.92.1604006938107; 
 Thu, 29 Oct 2020 14:28:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx6IipKsRejhrkUkQVsSAokO4b1Q+s7TJcsrATtWqIjfc2ejcUFGjypUvwxYQkffBadxloh4Q==
X-Received: by 2002:a7b:cc0e:: with SMTP id f14mr1265159wmh.92.1604006937864; 
 Thu, 29 Oct 2020 14:28:57 -0700 (PDT)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id h4sm7228783wrp.52.2020.10.29.14.28.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2020 14:28:57 -0700 (PDT)
Subject: Re: [PATCH] configure: surface deprecated targets in the help output
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20201029201449.6926-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <cd176496-eae5-81b9-eb65-4ea59076276c@redhat.com>
Date: Thu, 29 Oct 2020 22:28:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201029201449.6926-1-alex.bennee@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 00:47:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.261, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: thuth@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/29/20 9:14 PM, Alex Bennée wrote:
> Show the targets but keep them separate from the main list.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  configure | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/configure b/configure
> index 55e07c82dd..6c2e9ff37c 100755
> --- a/configure
> +++ b/configure
> @@ -1644,9 +1644,11 @@ Standard options:
>    --prefix=PREFIX          install in PREFIX [$prefix]
>    --interp-prefix=PREFIX   where to find shared libraries, etc.
>                             use %M for cpu name [$interp_prefix]
> -  --target-list=LIST       set target list (default: build everything)
> +  --target-list=LIST       set target list (default: build all non-deprecated)
>  $(echo Available targets: $default_target_list | \
>    fold -s -w 53 | sed -e 's/^/                           /')
> +$(echo Deprecated targets: $deprecated_targets_list | \
> +  fold -s -w 53 | sed -e 's/^/                           /')
>    --target-list-exclude=LIST exclude a set of targets from the default target-list
>  
>  Advanced options (experts only):
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>


