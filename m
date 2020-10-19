Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED69C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 17:24:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ABDE2224D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 17:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CrqDb4zQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ABDE2224D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUYtQ-0005VO-4T
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 13:24:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46306)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kUYsJ-0004jU-Ne
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 13:23:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20824)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kUYsH-0004DM-Ja
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 13:23:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603128188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iyfaajfaeY0sL3SM1O7r3+L+hK8i+b4BJi1UnSz8L/Q=;
 b=CrqDb4zQ6VYnhW8K3xqPzIO/dmzXVgQ9KFScgKt+9Cr3flLqXkDQvV1GkC21II5MPlhd82
 I9otTl/3/WJ/Wcv5tV7SSS9UcmdjQnbvYBexyZOg9X4lKgSRDXl7/qx6zZJjh/DkdW+GHO
 LjIHlKAsbmsdkEqZdDRMnZ0JBcd3A5k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-178-HdWKQuP4NM-VLegGJYupOQ-1; Mon, 19 Oct 2020 13:23:05 -0400
X-MC-Unique: HdWKQuP4NM-VLegGJYupOQ-1
Received: by mail-wm1-f72.google.com with SMTP id c204so70804wmd.5
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 10:23:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iyfaajfaeY0sL3SM1O7r3+L+hK8i+b4BJi1UnSz8L/Q=;
 b=q7M4wkT7bJ0fMPzeVOAmK/YdioE4cPsJezZkwCYUrrP1dfppiDSw4WkZ7KayXbdXvK
 vpZm/Idl+6T9t34JyG7XwFqA4m4VU8OEPrNaY3PFk4RCPL5V/CuYRryIJoygz8E5VYz/
 hyRDH9+LAbgN6UzTvEghCI5fpxRPzaa5IYtrUEHv7PMs4vubCNtVlED1AfV7Z59k/0qu
 t/a+B7bqXhW/MYF87WPaEnpJevsxtlep4/XkSZaoPva75eIGjtUF3TwwLh36jxpSecTW
 7tG2JJsuUKOy/1cyeLQqdAplt/DjOuPYQVdzmorO8g8AsIquhhavIFmCkRdu3P2tZW2t
 ZkRw==
X-Gm-Message-State: AOAM530J13wrz+d3FaJrz+L5avcv9fzESvIsKupR5T8VougdVSaSviK/
 cJUNhtwHoZSjeBSA3mc9eK8fdgZxu/P+uMKuJsDbdrI5mjQGSI6ms9TE68x6HL4lzTWndOA0x6m
 G47rskJI2kwi2srQ=
X-Received: by 2002:a5d:6cae:: with SMTP id a14mr288577wra.187.1603128183968; 
 Mon, 19 Oct 2020 10:23:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxp5a3Ur3bzuI2abaNiB2URm2K7WGwncR4g7KiOErx8Yz0Fr298GZ1uww9AHk+v60JRBVo8fw==
X-Received: by 2002:a5d:6cae:: with SMTP id a14mr288564wra.187.1603128183784; 
 Mon, 19 Oct 2020 10:23:03 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id m1sm247792wmm.34.2020.10.19.10.23.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2020 10:23:03 -0700 (PDT)
Subject: Re: ld: file not found: _PreallocMode_lookup on macOS Catalina
To: Emmanuel Blot <eblot.ml@gmail.com>, QEMU <qemu-devel@nongnu.org>
References: <24B952F3-465C-4AB2-AF28-6CA4722D94B7@gmail.com>
 <3869557c-10a0-8f07-a59a-69120a522568@redhat.com>
 <AA504B32-5134-4CDD-8CDA-6F200C7376CF@gmail.com>
 <3C35D6D8-D9FE-4977-B27F-59CCACFEAA32@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <34bcbf58-141b-35a1-6433-006a369827db@redhat.com>
Date: Mon, 19 Oct 2020 19:23:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <3C35D6D8-D9FE-4977-B27F-59CCACFEAA32@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 02:32:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/10/20 19:16, Emmanuel Blot wrote:
> --- undef_sh.log    2020-10-19 19:15:08.000000000 +0200
> +++ undef_py.log    2020-10-19 19:15:20.000000000 +0200
> @@ -1,3 +1,4 @@
> +-Wl,-u,
>  -Wl,-u,_PreallocMode_lookup
>  -Wl,-u,__TRACE_CURL_CLOSE_DSTATE
>  -Wl,-u,__TRACE_CURL_OPEN_DSTATE
> 
> 
> I think it can be addressed with the following patch:
> 
> From d157bd508d32485dd5cdb3efcff7969a89628cc1 Mon Sep 17 00:00:00 2001
> From: Emmanuel Blot <emmanuel.blot@sifive.com>
> Date: Mon, 19 Oct 2020 19:07:03 +0200
> Subject: [PATCH] Fix regression with undefined symbol filter introduced in
>  604f3e4e.
> 
> ---
>  scripts/undefsym.py | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/scripts/undefsym.py b/scripts/undefsym.py
> index 69a895cd26..254c456f25 100644
> --- a/scripts/undefsym.py
> +++ b/scripts/undefsym.py
> @@ -21,6 +21,8 @@ def filter_lines_set(stdout, from_staticlib):
>                      continue
>                  if not from_staticlib and tokens[1] != b'U':
>                      continue
> +            if not tokens[0]:
> +                continue
>              new_line = b'-Wl,-u,' + tokens[0]
>              if not new_line in linesSet:
>                  linesSet.add(new_line)

Great, thanks.  Can you check if my patch would also work, as it would
adhere more to the pre-conversion logic?

Paolo


