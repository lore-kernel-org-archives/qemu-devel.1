Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC76C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 10:37:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43E42206FB
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 10:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uMx7vkD8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43E42206FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKffe-0002Xy-Tx
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 06:37:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55296)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kKfeB-00013L-Uj
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 06:35:43 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37305)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kKfeA-0006pR-9A
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 06:35:43 -0400
Received: by mail-wm1-x342.google.com with SMTP id a9so2807906wmm.2
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 03:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=z4YBUrOR3CuCckKm92AizzdAgBh8kNJaVTq6PVUtFWA=;
 b=uMx7vkD8XVvs1r3F2tbGyDWOi/PvSOUD3CVknOGcE++RTfNKL8lwoc2Yb/6xiU24x0
 LarCgU56EwVnR8W9V+rA3HKLKBEv9wD801zQ7hyBrk8D9JammGnhvWQ6PUkEgpnWwID9
 n1O9/X0aVkB9TnQsGW0WSio5f+4sX5btLeOJB7d7+iDJCi/tPVa7fruorxJPrH6hl+kF
 OMAa5n9NrPw9EPQSRjn9pGomU+BBof2vkKueH35nEAdoH6zP58lihT1vdkuMl1eIN3QS
 EsOk/8QovXBgBuG9seybyMAQ42IbqYLzy4QHlzUyeieB2A3i5xImfpuMgVzAKHkt1q4C
 8K7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=z4YBUrOR3CuCckKm92AizzdAgBh8kNJaVTq6PVUtFWA=;
 b=FzHEfWfWGisnoZbOqjjc1HHoVX7+caH0zmiRdDbcaw7CzctIt6WsKKjn+B8ZKWnvCQ
 POWM0AITro5TeKQiqoFmMbgoLQh6ShLDw43jqEKY1oRNsBMu7Fy/vV+IuUFHFm3fAuLk
 BY0jpfw3ViifCZ9J8afXUo6ZA4LsVGOE2NDSkWd2bzVnAEH3hKMXz+2LCatJ1ntv9/XO
 y3FLh6bK5allHsXAxUYlxQ/ETCj1KZQgTPWSah2CRa9ZErWhNLfBpVc+YMUOhtIIRDGL
 wDA3xQrRnJrsvfsT9Gz1AY9jumu3FvFeee24otjlI0l5RvlmDuVbIsuyDkjvmNW35VkC
 pNAA==
X-Gm-Message-State: AOAM5331GplAYu5YQUse5zstgd3Bh1j9rDZDXeA0oynyYQuAeZYyrWXT
 GwywMAJJE+j1HE7q1+LpQkQ=
X-Google-Smtp-Source: ABdhPJxCiZRgG4/k79xLhFryLCi7ZzIbL5zQtQdftlqSQcUrOyEf+Q58H3N7bRR9Fr3ltvsktgfeCg==
X-Received: by 2002:a7b:c3c8:: with SMTP id t8mr259270wmj.101.1600770940796;
 Tue, 22 Sep 2020 03:35:40 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id i26sm4207035wmb.17.2020.09.22.03.35.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2020 03:35:40 -0700 (PDT)
Subject: Re: [PATCH 3/7] tests/docker: Update the tricore container to debian
 10
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200921174320.46062-1-thuth@redhat.com>
 <20200921174320.46062-4-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9bbd9a2c-fae8-f312-96a4-6689b3c01612@amsat.org>
Date: Tue, 22 Sep 2020 12:35:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200921174320.46062-4-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/21/20 7:43 PM, Thomas Huth wrote:
> We do not support Debian 9 anymore, thus update the Tricore container
> to Debian 10 now.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  .gitlab-ci.d/containers.yml                          | 2 +-
>  tests/docker/Makefile.include                        | 2 +-
>  tests/docker/dockerfiles/debian-tricore-cross.docker | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/.gitlab-ci.d/containers.yml b/.gitlab-ci.d/containers.yml
> index 6769eef0ff..089cea7c14 100644
> --- a/.gitlab-ci.d/containers.yml
> +++ b/.gitlab-ci.d/containers.yml
> @@ -210,7 +210,7 @@ sparc64-debian-cross-container:
>  tricore-debian-cross-container:
>    <<: *container_job_definition
>    stage: containers-layer2
> -  needs: ['amd64-debian9-container']
> +  needs: ['amd64-debian10-container']
>    variables:
>      NAME: debian-tricore-cross
>  
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
> index 75704268ff..02ec92830b 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -137,7 +137,7 @@ docker-image-debian-sparc64-cross: docker-image-debian10
>  docker-image-travis: NOUSER=1
>  
>  # Specialist build images, sometimes very limited tools
> -docker-image-debian-tricore-cross: docker-image-debian9
> +docker-image-debian-tricore-cross: docker-image-debian10
>  docker-image-debian-all-test-cross: docker-image-debian10
>  docker-image-debian-arm64-test-cross: docker-image-debian11
>  
> diff --git a/tests/docker/dockerfiles/debian-tricore-cross.docker b/tests/docker/dockerfiles/debian-tricore-cross.docker
> index 769d95c77b..985925134c 100644
> --- a/tests/docker/dockerfiles/debian-tricore-cross.docker
> +++ b/tests/docker/dockerfiles/debian-tricore-cross.docker
> @@ -7,7 +7,7 @@
>  #
>  # SPDX-License-Identifier: GPL-2.0-or-later
>  #
> -FROM qemu/debian9
> +FROM qemu/debian10
>  
>  MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
>  
> 


