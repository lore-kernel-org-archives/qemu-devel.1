Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44369C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 19:31:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB09A20722
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 19:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0bN5nzy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB09A20722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDuww-00053H-RX
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 15:31:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57644)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kDuvy-0004R7-Gq
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 15:30:11 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38273)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kDuvw-0001dC-4v
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 15:30:10 -0400
Received: by mail-wr1-x443.google.com with SMTP id g4so4430537wrs.5
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 12:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=/yMenlyFwplSkn/qogCbY8RV7QL2rxS5lVaQlSzo29o=;
 b=a0bN5nzyUpV2GseUB/yiSCOnsLwjeWQMXWmSTJ6MZBcoitU8Xcz2PMKvwBAhEtbqSu
 Bf1bS0Zxwcvuix8XNe1WLmyoEc2jjJhmyadwwXQoAfmUZ6ZfqNR1iVySn075WCg55PPu
 bqFptGs+R7FC8wLSGvVOYwli1DZqx1yMD+4uPc87dFkL/WIIog3rE541wqPf1fVPfuC0
 spirB8E2RYYfTKXdXeUTJuu6T7HK9VReA168CekZC8ZQ6nSI4yBLq1Tna9VIjT3MPvhJ
 iLMGgWo0N0/XtYwzmFQoPMl4lipD3z/DUqW3MjZOjbFifGTjx9QKcwduqeWNb59o8AUM
 dO4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/yMenlyFwplSkn/qogCbY8RV7QL2rxS5lVaQlSzo29o=;
 b=RteHgae8AMZBK6/cZcQ7OBItf5tcx/WnokYRH6GrG7MZ1iUrvPj0yZAMltfu0XgBAR
 TFsPwRLElo3/p7uwQf2alJUZ70ykBKoCd48z+JTDycpWiLIBUsTqqI33Fdxp6ow8adY8
 u4Mj0yqfHXeMTUPk+7vzLGHTkf+P6yu3pPDfBRxpp1m1ZXwemAlVbJ5cMsz9EQ3rHkxn
 K/5pQf/FM1oOOgs8XtZ3hKE7odIksFhhmyX7kCjWY4w0ac4Ip9OVV6p+3oPOtG/izQIw
 lBAbY28DOtmGRxGlvtmkAJmAyut7aqaM2wjhvcwCJo22tHAWdZZTcrU6SB2zU7dwfL2n
 Q5/w==
X-Gm-Message-State: AOAM530yn9Ihz7bkAO7kaknmVS1Xv5qHvDiRGg4/B8eoezGTTYQvsb8z
 gvU+Mraywe+4u5FR2DrROdk=
X-Google-Smtp-Source: ABdhPJxSiCGXlBHOGGhOhPenIILDI+KQWLUr5KMzt5t8duAhpzSG1eL/xzVsSBiIReD9t/pJzD2uJg==
X-Received: by 2002:a5d:4c90:: with SMTP id z16mr4291566wrs.170.1599161406497; 
 Thu, 03 Sep 2020 12:30:06 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id k184sm5931099wme.1.2020.09.03.12.30.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2020 12:30:05 -0700 (PDT)
Subject: Re: [PATCH v1 3/8] tests/docker: add python3-setuptools the docker
 images
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200903112107.27367-1-alex.bennee@linaro.org>
 <20200903112107.27367-4-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <805aec73-dc2b-a706-da32-e86c4bb5c5b5@amsat.org>
Date: Thu, 3 Sep 2020 21:30:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200903112107.27367-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, NICE_REPLY_A=-2.403,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 richard.henderson@linaro.org, cota@braap.org, stefanha@redhat.com,
 marcandre.lureau@redhat.com, pbonzini@redhat.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/3/20 1:21 PM, Alex Bennée wrote:
> We need these now for builds to work.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  tests/docker/dockerfiles/debian10.docker | 1 +
>  tests/docker/dockerfiles/debian9.docker  | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/tests/docker/dockerfiles/debian10.docker b/tests/docker/dockerfiles/debian10.docker
> index bcdff04ddfe..e3c11a454ee 100644
> --- a/tests/docker/dockerfiles/debian10.docker
> +++ b/tests/docker/dockerfiles/debian10.docker
> @@ -29,6 +29,7 @@ RUN apt update && \
>          pkg-config \
>          psmisc \
>          python3 \
> +        python3-setuptools \
>          python3-sphinx \
>          texinfo \
>          $(apt-get -s build-dep qemu | egrep ^Inst | fgrep '[all]' | cut -d\  -f2)
> diff --git a/tests/docker/dockerfiles/debian9.docker b/tests/docker/dockerfiles/debian9.docker
> index 0f0ebe530af..3edb5147ef3 100644
> --- a/tests/docker/dockerfiles/debian9.docker
> +++ b/tests/docker/dockerfiles/debian9.docker
> @@ -28,4 +28,5 @@ RUN apt update && \
>          pkg-config \
>          psmisc \
>          python3 \
> +        python3-setuptools \
>          $(apt-get -s build-dep qemu | egrep ^Inst | fgrep '[all]' | cut -d\  -f2)
> 

