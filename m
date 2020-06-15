Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC4EC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 06:39:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A933F2067B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 06:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TodUIwsS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A933F2067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkilp-0006Fv-VZ
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 02:39:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jkilC-0005pz-MY
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 02:38:22 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:56255)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jkilA-0004x0-VO
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 02:38:22 -0400
Received: by mail-wm1-x341.google.com with SMTP id c71so13391520wmd.5
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2020 23:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=d/EhzsIk0zn1ZdI2qXNbfYCHI4ajKssPtbGsfoa6HLE=;
 b=TodUIwsSt6vaxDq5LOiEgTl/vcWNbfn6JJYVrF4/7nGA7RYktyTJj8pAlsjcNVyQp0
 c4UIazqaN08PlK3mHVQu1d5Xz4EClnfTocV1YsRotuhhTUxHFa4eX7rRYlXU74g9cV1e
 hmVpxj2pdGhJnLzgfmAy9TuOdT+bnzx1M8hGtJRVdkDdkX13sHx2NiipWwOTWR0Bhc5S
 5Jl3pK/9G3GqUQFO/VEgLre1vkQ3zgL3da9A3bWB9XITXW5KqmOBPW2n/uc3oUYNk61d
 APzGGabp3Gb/hU18D21MeXPxOiUGanxmikNJI7E+OdKq7aTyMf8BYRyhVOBuWsezyiqu
 962w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=d/EhzsIk0zn1ZdI2qXNbfYCHI4ajKssPtbGsfoa6HLE=;
 b=S/wadQ98trdCM/L14CWgNkEPn7I8e0glUNL3Zek3h/7W5YfFHzCPhyJ31h6qxZ8Yng
 ZIA5LEcC/vTROLBTbusPnvesMDH1cCRvmb+RdvjdOOEJZLP0ti82TGcOGZjw6S+bHzIx
 rhMXJREMjTb8HEWVzCYNIJdrwvddvtAasHTrETpzDiMhRHVaCNn0DQY/oTmPm+u1j8Ot
 eyyggUjHVI9INqt7+8Zs1kuPTPxlIsy7gNgvQwt10XSPQqeIFFDdw234NE2YJtyayluZ
 4n62KIg5E9FqUy6qsLLxO+hAO+bFxOVZOA2Cby8hsyP1yDT28HP3+prQ89DGPIyRILiY
 QYkQ==
X-Gm-Message-State: AOAM530J4V688exmRe5oJl8L5Q10xV1I4TWvqC2DycTT1UA3EiVw+RBg
 NUW3OkFmH9DAN6z5MG0s9/Q=
X-Google-Smtp-Source: ABdhPJzOHQQIcw7YhaLe6zeSdHfcZlPkBdi4j1BwBa81h3LPWOoDR0zK1klYfZSNEJYIG7x0ERlhVg==
X-Received: by 2002:a05:600c:2945:: with SMTP id
 n5mr12311420wmd.189.1592203098758; 
 Sun, 14 Jun 2020 23:38:18 -0700 (PDT)
Received: from [192.168.1.40] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id c70sm20342083wme.32.2020.06.14.23.38.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Jun 2020 23:38:17 -0700 (PDT)
Subject: Re: [PATCH] .travis.yml: Use travis_retry() in case of network issues
To: Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20200613130622.20541-1-f4bug@amsat.org>
 <5ba02176-34c9-f984-95f4-1f61103d785c@ilande.co.uk>
 <bc9c331b-cfd4-9d46-3c02-86e95d93be88@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5bca1843-e401-18a5-1c0d-a83f89e39d2a@amsat.org>
Date: Mon, 15 Jun 2020 08:38:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <bc9c331b-cfd4-9d46-3c02-86e95d93be88@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/15/20 7:12 AM, Thomas Huth wrote:
> On 14/06/2020 11.48, Mark Cave-Ayland wrote:
>> On 13/06/2020 14:06, Philippe Mathieu-Daudé wrote:
>>
>>> Use travis_retry() when cloning SLOF (see 31c8cc4f94e) in the
>>> s390x container job, to avoid build failures:
>>>
>>>   $ ( cd ${SRC_DIR} ; git submodule update --init roms/SLOF )
>>>   Submodule 'roms/SLOF' (https://git.qemu.org/git/SLOF.git) registered for path 'roms/SLOF'
>>>   Cloning into '/home/travis/build/user/qemu/roms/SLOF'...
>>>   fatal: unable to access 'https://git.qemu.org/git/SLOF.git/': Could not resolve host: git.qemu.org
>>>   fatal: clone of 'https://git.qemu.org/git/SLOF.git' into submodule path '/home/travis/build/user/qemu/roms/SLOF' failed
>>>   Failed to clone 'roms/SLOF'. Retry scheduled
>>>   Cloning into '/home/travis/build/user/qemu/roms/SLOF'...
>>>   fatal: unable to access 'https://git.qemu.org/git/SLOF.git/': Could not resolve host: git.qemu.org
>>>   fatal: clone of 'https://git.qemu.org/git/SLOF.git' into submodule path '/home/travis/build/user/qemu/roms/SLOF' failed
>>>   Failed to clone 'roms/SLOF' a second time, aborting
>>>   The command "( cd ${SRC_DIR} ; git submodule update --init roms/SLOF )" exited with 1.
>>>
>>> Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>> ---
>>>  .travis.yml | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/.travis.yml b/.travis.yml
>>> index ec6367af1f..19a1b55aab 100644
>>> --- a/.travis.yml
>>> +++ b/.travis.yml
>>> @@ -496,7 +496,7 @@ jobs:
>>>          - CONFIG="--disable-containers --target-list=${MAIN_SOFTMMU_TARGETS},s390x-linux-user"
>>>          - UNRELIABLE=true
>>>        script:
>>> -        - ( cd ${SRC_DIR} ; git submodule update --init roms/SLOF )
>>> +        - ( cd ${SRC_DIR} ; travis_retry git submodule update --init roms/SLOF )
>>>          - BUILD_RC=0 && make -j${JOBS} || BUILD_RC=$?
>>>          - |
>>>            if [ "$BUILD_RC" -eq 0 ] ; then
>>
>> Hi Phil,
>>
>> Thanks for diagnosing and proposing a fix. Is there a reason why SLOF in particular
>> is failing compared to other repositories that might also need a similar change?
> 
> That's what I wonder, too. If git.qemu.org could not be resolved for
> SLOF.git, why should it be resolvable for the other submodules that are
> checked out automatically during the build process?

submodules updates are handled by make indeed:

config-host.mak -> git-submodule-update -> ./scripts/git-submodule.sh
using GIT_SUBMODULES generated by ./configure

Will respin.

> 
>  Thomas
> 

