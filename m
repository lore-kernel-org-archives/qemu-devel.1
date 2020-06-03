Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CECF7C433E1
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 08:19:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F1922074B
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 08:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GK8gJe92"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F1922074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgOcO-0005QC-VF
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 04:19:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40502)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jgObj-0004tr-Ji
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 04:18:43 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39895)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jgObi-0001kI-Kq
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 04:18:43 -0400
Received: by mail-wm1-x342.google.com with SMTP id k26so1018577wmi.4
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2020 01:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=rbwh+XMefO8OUHhb7wPn4JhL8e9XIf+xU3wuKKLsIUc=;
 b=GK8gJe92yE/r6oPEflba9LhcbF6zlQQTxEyVBrm8GaAHQCdrFQrHuaa7XgDlgruZoL
 BBhr11L4jNlM+0gyfA887ejxVoSIZGUJkcdqPcTPewUDYwi40sFv/rYjN6bkWknPdDup
 WEVj/TN9iBNFgypsxdX4YCJr2wvPHUj1qbVjr419QYqV2JGTbKSGX+LdLBuNImkjjp6K
 x2R5rZTIWQPkbTR8CNmYDnbjkRRLnJrWkVv8sUhWxGfBPYbcMRnAr0B/L4czSBHllSIa
 12eg80Kmc+lQzvY8BO7vXgoTFHvpBQKr0z/MC2I//eUuKN4tMR+902Xw4lDC/RK9z+UL
 5cOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rbwh+XMefO8OUHhb7wPn4JhL8e9XIf+xU3wuKKLsIUc=;
 b=HBjaovxJpcdnHHlN0KIWYHHE5Eh7XIbHeR1oyNHogESmVErK7dOCYC99cnn1g8JjUn
 1BIaRQIM2qlcrFF8ZS+99B6zDrCsgv8uThLIsf0YSJquxTI4xHjmUrujHs7LCrf5Lpbr
 12hPJXhyt0olqn47N30yMYDkF9HJ5a5Ml5LdHUz+UEdp7bjrXsWIY7pyOIoPPA8+nwlw
 6uovd4bPjWiSlfb3G1AS4rjzXhcZ3h/LBRgI6jDTDt1S/bi+/MVl6uhmbmOSxmRobar2
 C2Zn3kXZgvf39v5m0kSvvlLPoI1cShI+7HD4qc6utd9b2WGIf/uuHctBqIxc5/bIJ++O
 Jx5g==
X-Gm-Message-State: AOAM532UtJzUQ6jvebePFoWwbrOU8ilbLLi/6l5A8tKcC2z19EhPuXlZ
 8KadM1Cd5sxfCp6oTnMpDns=
X-Google-Smtp-Source: ABdhPJyR+uoUD7AY/lAMezH/mOJtCcLFnU3pD5Gka9Siuq0dhjxmyuGT4D6PePm1rtmkf87vqCSWPQ==
X-Received: by 2002:a1c:2503:: with SMTP id l3mr7275463wml.44.1591172320096;
 Wed, 03 Jun 2020 01:18:40 -0700 (PDT)
Received: from [192.168.1.43] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id y37sm2611366wrd.55.2020.06.03.01.18.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jun 2020 01:18:39 -0700 (PDT)
Subject: Re: [PATCH v1 9/9] .travis.yml: allow failure for unreliable hosts
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200602154624.4460-1-alex.bennee@linaro.org>
 <20200602154624.4460-10-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7783d10d-faa9-b454-a0cd-dba51be1a9af@amsat.org>
Date: Wed, 3 Jun 2020 10:18:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200602154624.4460-10-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: Fam Zheng <fam@euphon.net>, robert.foley@linaro.org, robhenry@microsoft.com,
 aaron@os.amperecomputing.com, cota@braap.org, kuhn.chenqun@huawei.com,
 peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/2/20 5:46 PM, Alex Bennée wrote:
> They will still run but they won't get in the way of the result.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  .travis.yml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/.travis.yml b/.travis.yml
> index 564be50a3c1..ec6367af1f0 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -429,6 +429,7 @@ jobs:
>        env:
>          - TEST_CMD="make check check-tcg V=1"
>          - CONFIG="--disable-containers --target-list=${MAIN_SOFTMMU_TARGETS}"
> +        - UNRELIABLE=true
>  
>      - name: "[ppc64] GCC check-tcg"
>        arch: ppc64le
> @@ -493,6 +494,7 @@ jobs:
>        env:
>          - TEST_CMD="make check check-tcg V=1"
>          - CONFIG="--disable-containers --target-list=${MAIN_SOFTMMU_TARGETS},s390x-linux-user"
> +        - UNRELIABLE=true
>        script:
>          - ( cd ${SRC_DIR} ; git submodule update --init roms/SLOF )
>          - BUILD_RC=0 && make -j${JOBS} || BUILD_RC=$?
> @@ -535,6 +537,7 @@ jobs:
>          - TEST_CMD="make check-unit"
>          - CONFIG="--disable-containers --disable-tcg --enable-kvm
>                    --disable-tools --host-cc=clang --cxx=clang++"
> +        - UNRELIABLE=true
>  
>      # Release builds
>      # The make-release script expect a QEMU version, so our tag must start with a 'v'.
> @@ -556,3 +559,5 @@ jobs:
>          - mkdir -p release-build && cd release-build
>          - ../configure ${BASE_CONFIG} ${CONFIG} || { cat config.log && exit 1; }
>          - make install
> +  allow_failures:
> +    - env: UNRELIABLE=true
> 

It is frustrating when you are expecting Travis to fail to see test this
patch, but Travis is back working correctly...

