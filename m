Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F98C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 14:08:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A24D2078C
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 14:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KyOhbTMv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A24D2078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jblrf-0000RC-Gi
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 10:08:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jblqT-0007Nu-M3
 for qemu-devel@nongnu.org; Thu, 21 May 2020 10:06:49 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38974
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jblqS-0003bj-Sn
 for qemu-devel@nongnu.org; Thu, 21 May 2020 10:06:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590070008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jvBWdr8a5YhmJdzLuNokxS28hpINEb1yCyCs7QbIVQs=;
 b=KyOhbTMv/LjgGbWyH/5bc8d6mmdi3OUCEHI9MUMyEXiaeURZ7XcI4ULmuX+5Cb+yjZM+x1
 +87zEFWnrtehpbCjMkSHeSH8Gwe4JrsZEq0f4IxJFNblusaz8CP0UFa4liWXY4i4vQBG34
 OjEbdPlJl4I41L2h+8uRdfjsfhf7mcc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-ddB5st48NmaTpr_uqqTtPA-1; Thu, 21 May 2020 10:06:46 -0400
X-MC-Unique: ddB5st48NmaTpr_uqqTtPA-1
Received: by mail-wr1-f69.google.com with SMTP id g10so2967964wrr.10
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 07:06:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jvBWdr8a5YhmJdzLuNokxS28hpINEb1yCyCs7QbIVQs=;
 b=MbT0eBPgeqZYeAZekn386oeI94/GG8zmz2maCBDwZUxEshP+zDHPPqpaKniK4L305m
 MrN7gii/BYHpElpA9cySa4n7bqBkSXecLWHEHENW74tIE0a9xmWaQtZmah3ccNyzN6EE
 az0ZUOlh/er4NqhuUqDWXjAAxYb+qlCCG3Jid0kK+VI2YvcXnv+cUPFSAfuPLVfUVY/O
 k5gNH+RweamDFtwHBnReHx+U9r69TGIlW8WBdX5v4SJEAcQ0LwGRO7khqLtTcQdHVZwX
 B6qKrtNTuC6p6DQB2sQ4tGo3pP0YhdvBd61a7pQFM/0PCIcEQT6QU8ZgTf6buPzhkxOd
 O/Cg==
X-Gm-Message-State: AOAM532one1ahmZy9cNKfXDA1SDkaEZOGyayCxL/BKHiDQMd3WoM9Aj9
 z/owhIw83/X5+8cKvrXz+030XYmhTGOQzZ8Thxa40w7Nc2iJhvUN8TZ2uYhSY53MgPrWbU3vLQj
 a64OJsiWgmkkwsT4=
X-Received: by 2002:a5d:674f:: with SMTP id l15mr8957804wrw.339.1590070005171; 
 Thu, 21 May 2020 07:06:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz3entDVIk+p6dxUu8fwBaTRMbGJFfk2ONiy7OKg7BR31T0d++Hcwlgwmru7g0Z9Al11Wcn7A==
X-Received: by 2002:a5d:674f:: with SMTP id l15mr8957790wrw.339.1590070005010; 
 Thu, 21 May 2020 07:06:45 -0700 (PDT)
Received: from [192.168.1.40] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id f128sm7015875wme.1.2020.05.21.07.06.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2020 07:06:44 -0700 (PDT)
Subject: Re: [PATCH v1 01/10] tests/guest-debug: catch hanging guests
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200513175134.19619-1-alex.bennee@linaro.org>
 <20200513175134.19619-2-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0e9981ac-9330-6ed1-a660-a220300bada1@redhat.com>
Date: Thu, 21 May 2020 16:06:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200513175134.19619-2-alex.bennee@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 01:47:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

On 5/13/20 7:51 PM, Alex Bennée wrote:
> If gdb never actually connected with the guest we need to catch that
> and clean-up after ourselves.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-Id: <20200512104338.27365-1-alex.bennee@linaro.org>
> ---
>   tests/guest-debug/run-test.py | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/tests/guest-debug/run-test.py b/tests/guest-debug/run-test.py
> index d9af9573b9e..71c55690546 100755
> --- a/tests/guest-debug/run-test.py
> +++ b/tests/guest-debug/run-test.py
> @@ -80,4 +80,10 @@ if __name__ == '__main__':
>           print("GDB crashed? SKIPPING")
>           exit(0)
>   
> +    try:
> +        inferior.wait(2)
> +    except subprocess.TimeoutExpired:
> +        print("GDB never connected? Killed guest")

Maybe "Killing guest"?

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> +        inferior.kill()
> +
>       exit(result)
> 


