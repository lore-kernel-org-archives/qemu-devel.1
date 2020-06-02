Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F45C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 15:37:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EE96207D8
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 15:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/wwkCjd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EE96207D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg8yt-0007Ea-Ap
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 11:37:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53304)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jg8xh-0006IQ-Iu
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 11:36:21 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44890)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jg8xg-0004bP-Kf
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 11:36:21 -0400
Received: by mail-wr1-x441.google.com with SMTP id y17so3829899wrn.11
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 08:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=OZ2oS+tWchzvzEkyNrHIAPl6KAwL2QAg4/cj/Ld0kxI=;
 b=g/wwkCjdtdN2RDrWOPieKYZnjw0ArN0u9j+E0o5O0hrdLWGV9gENotCvD6kjlVOUAg
 eCOV5l/nnisNctO8VfY7D+XWQywpUxSHDVIXfyvYPujQAVsq/iLtWxKuveYbxGkCX++D
 OWbbbGXxqjSR/k4sQaIap1VhLgp2flbzDbewte5HkJ7LfyVHSUJyDDnoKo9wkFtBNySf
 k+76nLCrZw5hFFR33c2JCjL0GPjnqB1GLe7tnVmuyHhlq3AHtBH0URwjR40peJz3aP/a
 P8SUuGyHdJybv5AWuVcxFa6xB08N/0A+zdgfCB7/hJ6yG/z489q8yxpybwaldDToJAu8
 z6NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OZ2oS+tWchzvzEkyNrHIAPl6KAwL2QAg4/cj/Ld0kxI=;
 b=s7JHFFikiXQhmc1ctdNVPoYBweIgmlaQeKAhJjhkEHMGRFwF31iex06WqsAxBHw99M
 /oracVLlu0Ja33VveaREyk9W7vcdEl6/ueR/Lu6/Fi8eaCEe/L0rVrT5CM4fwZ2Ug8Qp
 b3RdOvU7XfsIlbe/O8z5qs3GBcPBmqAUUdnuhG6LxbyL/VvI0PaP67RxtSATz7WENQdy
 a3rWno68eOY9tV4ajwJnedzqc/JFbHVQYfRMZxmTUsH+QGQ04UpI5h0a0x3WDOORvaU3
 66I+7s8GmTHgHIB3ImT3VFDBtJeKIaqJCMY+XJg+ZAJtKpHRzBwYjcUUTusqnLBD0Oz9
 zH5A==
X-Gm-Message-State: AOAM532g1c0fqa44ahT5k9QknN7Krk5/j9IHikacj23Fz98/5KKlXZMJ
 Y8R2jG3WmT64bbehRtNZeBE=
X-Google-Smtp-Source: ABdhPJwywyp3p3kzS6BTo1NMipzab0GLXgRe4R7hLaEbtk8jUiIyexPbEqJjMp3qjPnugcqgMhlvCQ==
X-Received: by 2002:adf:ed01:: with SMTP id a1mr29135540wro.271.1591112179223; 
 Tue, 02 Jun 2020 08:36:19 -0700 (PDT)
Received: from [192.168.1.43] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id u14sm170967wmd.0.2020.06.02.08.36.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jun 2020 08:36:18 -0700 (PDT)
Subject: Re: [PATCH] .travis.yml: Temporarily disable the aarch64 job
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200602113702.28549-1-f4bug@amsat.org>
 <87lfl57aid.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2c6ad72e-c7c4-1a74-c16e-4183c9356c42@amsat.org>
Date: Tue, 2 Jun 2020 17:36:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87lfl57aid.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/2/20 5:28 PM, Alex Bennée wrote:
> 
> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
> 
>> Travis-CI Aarch64 runners are currently broken, the build fails
>> because the filesystem quota is full [1]:
>>
>>     AR      libqemuutil.a
>>   nm: qemu-sockets.o: Bad value
>>     LINK    qemu-ga
>>   qga/main.o: In function `main':
>>   /home/travis/build/qemu/qemu/qga/main.c:1494: undefined reference to `socket_local_address'
>>   qga/channel-posix.o: In function `ga_channel_open':
>>   /home/travis/build/qemu/qemu/qga/channel-posix.c:210: undefined reference to `socket_parse'
>>   /home/travis/build/qemu/qemu/qga/channel-posix.c:193: undefined reference to `unix_listen'
>>   /home/travis/build/qemu/qemu/qga/channel-posix.c:218: undefined reference to `socket_listen'
>>   collect2: error: ld returned 1 exit status
>>   Makefile:686: recipe for target 'qemu-ga' failed
>>   make: *** [qemu-ga] Error 1
>>
>> Per [2], LXD container have 'approx 18GB' of storage, but our runner show:
>>
>>   $ df -h
>>   Filesystem                                                                                         Size  Used Avail Use% Mounted on
>>   /var/snap/lxd/common/lxd/storage-pools/instances/containers/travis-job-qemu-qemu-693775643/rootfs  895G   38G  854G   5% /
>>
>> As we suppose a filesystem quota makes our build fail,
>> disable the aarch64 job as a temporary kludge.
>>
>> [1] https://travis-ci.org/github/qemu/qemu/jobs/693775643
>> [2] https://docs.travis-ci.com/user/reference/overview/#virtualisation-environment-vs-operating-system
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  .travis.yml | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/.travis.yml b/.travis.yml
>> index 564be50a3c..3569ee99b3 100644
>> --- a/.travis.yml
>> +++ b/.travis.yml
>> @@ -399,6 +399,7 @@ jobs:
>>          - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
>>  
>>      - name: "[aarch64] GCC check-tcg"
>> +      if: false # Temporarily disabled due to problem in aarch64 runner.
>>        arch: arm64
>>        dist: xenial
>>        addons:
> 
> I was experimenting with something along the lines of:
> 
> --8<---------------cut here---------------start------------->8---
> .travis.yml: allow failure for unreliable hosts
> 
> They will still run but they won't get in the way of the result.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> 1 file changed, 5 insertions(+)
> .travis.yml | 5 +++++
> 
> modified   .travis.yml
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

Have you experienced problems with the s390x/powerpc jobs too?

Anyway if your patch works, I'm happier with it :)

> --8<---------------cut here---------------end--------------->8---
> 
> 
> 

