Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3408C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 09:52:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA1762080A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 09:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LSc8iNMg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA1762080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVAn7-0000rd-JK
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 05:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVAli-0000Os-0r
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 05:50:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32231)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVAle-0004DF-TJ
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 05:50:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603273849;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P41Pm3xJMva7biGbc9PnhQsO8hXCib0K/z0MtL3YmPw=;
 b=LSc8iNMg5W/uqpqlOdojGQJ68R2we52d2dQRYGuNWeQD1t1wgiNNgLKMmsluKzj+WGEUee
 ZSeA98U2PJUDo8WxEwNsMHUQ6IGmDqnUaKKBghoYbmuIl+ymzmsvVjkJMqCjmZ97PoULXc
 MtlFGWcGs6SGdEZ2tBymCCWMrn5kS78=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-eVyL99nzOiakcd7ye1ti4A-1; Wed, 21 Oct 2020 05:50:46 -0400
X-MC-Unique: eVyL99nzOiakcd7ye1ti4A-1
Received: by mail-wr1-f72.google.com with SMTP id 31so1769624wrg.12
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 02:50:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=P41Pm3xJMva7biGbc9PnhQsO8hXCib0K/z0MtL3YmPw=;
 b=FAY3HvP41TqDpCLgiEWaE+a9A+3CmZM6BPUJBuT5Os0PY0oTFHt5jKeDrRKVtn6/0Z
 +P2g6cszCz/P8tZmFykTcrJZKcHSJX73Dx88UXeipq5HHZsS5Bxtqed8AYAHaVWqS4Go
 o28Cfh5nChKohp2aN/QNThLleMtC+i4l5o7hiyXxdGzJaxqklGt6AfvtFipG2/rPk+u1
 QIANndLci6SxTgozBoAwkfyJN5d6+p+PWhDR8LmpVuWbB+VEWbv67YZYCU5dGFdLU04k
 DdLQkTcsHdP2zW3FJV7ms2MKFuKbon0xuQf7kGkes9/wkmT/WM79zxGEERfd4iXH5AK5
 Ntgw==
X-Gm-Message-State: AOAM533cI0sWCXBv1o0trlw+Q+5sKd0/CJNJknt6fmowZ2rejfT7iVPb
 xUexeIZq79IR+b4DlY1lkJBiRCaDzjOll5EIDQb15oQ1fI9FMoY41OP608ceHLBUD0Jlrdu32pb
 kPofMRlHpXL/Z/V4=
X-Received: by 2002:adf:8462:: with SMTP id 89mr3636102wrf.389.1603273845099; 
 Wed, 21 Oct 2020 02:50:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzjPHf/QQoxe0g+g4m4aCacDU1Y8nfwrFhk4TvQnZyiukZoLHnHp3xbc6f6noHG/n9Ex5p2Jg==
X-Received: by 2002:adf:8462:: with SMTP id 89mr3636077wrf.389.1603273844891; 
 Wed, 21 Oct 2020 02:50:44 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id 30sm3047013wrr.35.2020.10.21.02.50.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2020 02:50:44 -0700 (PDT)
Subject: Re: [PATCH] docs/devel/testing.rst: Update outdated Avocado URLs
To: qemu-devel@nongnu.org
References: <20201010080741.2932406-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ad938d74-71fe-47d1-64eb-ff85d64e1753@redhat.com>
Date: Wed, 21 Oct 2020 11:50:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201010080741.2932406-1-philmd@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 02:16:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: avocado-devel@redhat.com, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/10/20 10:07 AM, Philippe Mathieu-Daudé wrote:
> Avocado documentation referred returns 404 error.
> Update the broken links.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>   docs/devel/testing.rst | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
> index bd64c1bdcdd..23a1697d9f4 100644
> --- a/docs/devel/testing.rst
> +++ b/docs/devel/testing.rst
> @@ -696,7 +696,7 @@ To manually install Avocado and its dependencies, run:
>   
>   Alternatively, follow the instructions on this link:
>   
> -  http://avocado-framework.readthedocs.io/en/latest/GetStartedGuide.html#installing-avocado
> +  https://avocado-framework.readthedocs.io/en/latest/guides/user/chapters/installing.html
>   
>   Overview
>   --------
> @@ -879,7 +879,7 @@ Parameter reference
>   To understand how Avocado parameters are accessed by tests, and how
>   they can be passed to tests, please refer to::
>   
> -  http://avocado-framework.readthedocs.io/en/latest/WritingTests.html#accessing-test-parameters
> +  https://avocado-framework.readthedocs.io/en/latest/guides/writer/chapters/writing.html#accessing-test-parameters
>   
>   Parameter values can be easily seen in the log files, and will look
>   like the following:
> 

Thanks, applied to my acceptance-testing tree.


