Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025DEC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 08:43:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AD7B207DE
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 08:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GYGULSei"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AD7B207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXKa3-0003sN-1k
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 04:43:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXKZG-0003Gx-Gk
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 04:42:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21474)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXKZE-0006Zz-Tz
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 04:42:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603788176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=txrqpTCRWlY1XESfwFG/FGYIdaVmXeSaZVRkTt5/9xs=;
 b=GYGULSeiPC/sZnDdIRfpGvjJ2aV4AgAhAyMXEzx1s7XP9X+aUIougTbsQqRW5Luwga1T78
 y4AxWDy8RhWbMCB0wOKOsGtr3+6zSANPwtzHjRtL9ktJdUCqEAhD485wmRwzwgVVl602Fz
 eq4LR6cstCJxRUFyYsWXnL8lZa06qRc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-EPWG9Ba_OnCa6ixNewotag-1; Tue, 27 Oct 2020 04:42:54 -0400
X-MC-Unique: EPWG9Ba_OnCa6ixNewotag-1
Received: by mail-ed1-f69.google.com with SMTP id o2so410343edw.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 01:42:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=txrqpTCRWlY1XESfwFG/FGYIdaVmXeSaZVRkTt5/9xs=;
 b=TSffNFGtA4C6fT2+YMqohqfBlQUaUv+eue82jGdEw/oTalWDg+k318H0DeaMrPLszM
 aqEDxQk3DuP3nA5AmBlc93QYDEMKCGOEu+/rA/UXIo6oxAqhkdU3A9MQ9rFOWvAtgYSA
 S3WFndxcjYAbEQykJwz1cDL9hTaVmSohy3oEqzreQTUcQMZN1jQpLuH3Ji74yAYKOhh+
 dMsVtQhgynRUHE+Zi9HrPH5tVq9XwANOIsu/GJtm8cqL8rRYz9J9hhd5KTlPWAD0i5hQ
 rNzlgkewiFnqkaJQvBf6GLBcAv0LiYE6MmROG9WtP8zIDzZ+RYJCB7TT53SQJ2m+dtmG
 XcLw==
X-Gm-Message-State: AOAM530YHF5Nm8zxmpF6otI4iuLUICdYDcUSQ/JEwI9BfQIF6THKN1UE
 Apf2ihAPwaYwd5+g+WJpjldXegxYSd0y9ZnLIbn1kFhHiyjNGvQE4R16T1zd0cy39khh99UV46i
 m9qBHMkHZ6FPNU+k=
X-Received: by 2002:a05:6402:cac:: with SMTP id
 cn12mr1056039edb.326.1603788172934; 
 Tue, 27 Oct 2020 01:42:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxTvzdtqsR65vAO0G1VKXZGmdiof9rDhUMmYdLN4jVKT/WhLiKJ6rdz0tlpCCWamWH4m0RM8Q==
X-Received: by 2002:a05:6402:cac:: with SMTP id
 cn12mr1056027edb.326.1603788172752; 
 Tue, 27 Oct 2020 01:42:52 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id se12sm567659ejb.37.2020.10.27.01.42.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2020 01:42:52 -0700 (PDT)
Subject: Re: [PATCH] virtiofsd: Fix the help message of posix lock
To: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20201027081558.29904-1-zhangjiachen.jaycee@bytedance.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <437ac64b-fca8-2092-2bdc-8c3fbdea5161@redhat.com>
Date: Tue, 27 Oct 2020 09:42:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201027081558.29904-1-zhangjiachen.jaycee@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/27/20 9:15 AM, Jiachen Zhang wrote:
> The commit 88fc107956a5812649e5918e0c092d3f78bb28ad disabled remote
> posix locks by default. But the --help message still says it is enabled
> by default. So fix it to output no_posix_lock.
> 
> Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  tools/virtiofsd/helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c
> index 85770d63f1..574dd09e91 100644
> --- a/tools/virtiofsd/helper.c
> +++ b/tools/virtiofsd/helper.c
> @@ -161,7 +161,7 @@ void fuse_cmdline_help(void)
>             "                               allowed (default: 10)\n"
>             "    -o posix_lock|no_posix_lock\n"
>             "                               enable/disable remote posix lock\n"
> -           "                               default: posix_lock\n"
> +           "                               default: no_posix_lock\n"
>             "    -o readdirplus|no_readdirplus\n"
>             "                               enable/disable readirplus\n"
>             "                               default: readdirplus except with "
> 


