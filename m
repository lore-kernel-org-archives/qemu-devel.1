Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1950C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 09:13:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F160207C4
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 09:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tu2WRIrw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F160207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRAwY-0007VF-Jy
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 05:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54330)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kRAuw-0005wG-2Z
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 05:11:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36775)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kRAuu-0006y8-EL
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 05:11:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602321111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XXeikj8pCuYkppEuGwTG8sGjlgij3M4k59XpUt3GcxI=;
 b=Tu2WRIrwSYBFWkEUV80cyQ/uTKSDk77Xz+ESgtlxLKlxHKDmLnAuWTm/kDcKkWjFAmGDi6
 X5DHFCc+e0hhb68bUaygjvboPyBK5Mo19lls4aarpEaXoM8YpII0f7DVD1B7Fo2Sii2wBk
 C62m87K/ukTXF4xUKdAfdS8FDhQY7SQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-5JE7u4gyMkiCifTR2Cv3eg-1; Sat, 10 Oct 2020 05:11:49 -0400
X-MC-Unique: 5JE7u4gyMkiCifTR2Cv3eg-1
Received: by mail-wr1-f70.google.com with SMTP id j7so6294732wro.14
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2020 02:11:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XXeikj8pCuYkppEuGwTG8sGjlgij3M4k59XpUt3GcxI=;
 b=o4S75UuDC6DY/7ltxv8//88oUX1OYlWRuh4D4k5LiaN+QWjnEUL8VpM/niYHZ3+g2t
 ZYauBqM6Tcj1Ypa1V67+/pZzsqBlC2auQkqPOPKQX+PM3vMCGwPlelEce/xR72/iRgsa
 yOaVTKXOwoTZGyzmzqtALKO3Z3PDK0aDzYKIdX9U2sNfTWl6QjERJVYx0RCAhSvqDf/e
 GgXF9ur7KUuUAS0PY4SpqrtMG+f97aNhjn4qt0XFS9yNsribB5i6Nw6a2F42JUjVl4A/
 60idqjg437AKj9qLiz4CMxHHHwpOQ4kEk27IGR6Q7No7wQlID8ZUxKStDlkBTumui9sv
 g54A==
X-Gm-Message-State: AOAM531eJZ9hfod6V4zGdFOu31O4PV19PXOfL6Bq9JrBZFrbAxt0r5zF
 l0dB4Qao2Fg3xByqSUhYjiok/e3YvCT7w7kCTsagczX0pVpHQS03Y8PSLjhspRFJrjxjvp6jehm
 9mxS8RkJZxUIpMn8=
X-Received: by 2002:a05:6000:1084:: with SMTP id
 y4mr18245859wrw.138.1602321108684; 
 Sat, 10 Oct 2020 02:11:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzBLcA/xyCPC6bDSUjNOHQKDS0mRF6ljiViknTgiLUXwVmETv4tKaEohDtr1rsW8xBEravQlA==
X-Received: by 2002:a05:6000:1084:: with SMTP id
 y4mr18245849wrw.138.1602321108493; 
 Sat, 10 Oct 2020 02:11:48 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id u63sm15520163wmb.13.2020.10.10.02.11.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Oct 2020 02:11:47 -0700 (PDT)
Subject: Re: [PATCH 3/3] Acceptance tests: show test report on GitLab CI
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
References: <20201009205513.751968-1-crosa@redhat.com>
 <20201009205513.751968-4-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d5ffb1b7-5516-ffdf-a78e-91a8cda7fac7@redhat.com>
Date: Sat, 10 Oct 2020 11:11:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201009205513.751968-4-crosa@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/10 02:57:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.208, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/9/20 10:55 PM, Cleber Rosa wrote:
> Avocado will, by default, produce JUnit files.  Let's ask GitLab
> to present those in the web UI.

https://gitlab.com/philmd/qemu/-/pipelines/200764992/test_report

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>   .gitlab-ci.yml | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index bed5fe6161..7d4b2ced9e 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -53,6 +53,11 @@ include:
>       paths:
>         - ${CI_PROJECT_DIR}/avocado-cache
>       policy: pull-push
> +  artifacts:
> +    paths:
> +      - build/tests/results/latest/results.xml
> +    reports:
> +      junit: build/tests/results/latest/results.xml
>     before_script:
>       - mkdir -p ~/.config/avocado
>       - echo "[datadir.paths]" > ~/.config/avocado/avocado.conf
> 


