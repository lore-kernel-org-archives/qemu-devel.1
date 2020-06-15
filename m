Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7CB8C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 07:44:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B27162067B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 07:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xc4KRaYV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B27162067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkjnL-0005k1-1g
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 03:44:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jkjmX-0005AR-7E; Mon, 15 Jun 2020 03:43:49 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53359)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jkjmV-0007V2-EV; Mon, 15 Jun 2020 03:43:48 -0400
Received: by mail-wm1-x341.google.com with SMTP id l26so13563350wme.3;
 Mon, 15 Jun 2020 00:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=1s0bN70bEOKkdj9/NtcwoLGFW2ZzdcQpMyY9ziGa9CA=;
 b=Xc4KRaYVB/+4GjD3irReKq6lbuCh0Gs3XG7SH6Hjd9a0/1yL7EhJcZw+KscPgI4VAr
 rSapJltfGpm01DDme1P5oc2ktIRY/PkKazlU7L+2DnAf/rY9HtH0INKCVe0MOYAZrjSt
 4Q6oIaHS/444V6hqs+HvXVcqnnW0/YYHgE8KBITi3Ipc7N+haxHoU2dGgxAW+r3+iq8f
 gj9Mkf4a6AjJY1Nfvj3v7mTjdsxzaZTZ8oPcPMpzJn/hNrZEfJTOctdXHCyIC+BGpPFG
 GYkQWWT9KcDx7yNguB13BTfNJGCuzO6afPt+6VRKoLTC9A0X9kB9DSYnNTc/kQSzKhHD
 NCqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1s0bN70bEOKkdj9/NtcwoLGFW2ZzdcQpMyY9ziGa9CA=;
 b=bCSmZdlxjJbqYmzgXtAJChfLZ/6WsTjGIxVPylqx4N9kFpYC0loHo6Dh9IGzt1367N
 JgS9VZjk8FMvT2eSuYJfL/v+VBjuB0yMwlwRqN+sdP/uMsZFMTgPLUV205H4ec+K8cdg
 KYIslLEjlF6uqS6X2JZ/NnkhQz+jJPTmmTWFLbNYloBdGbcdBFl8A2ulLdGagfYaOkM2
 T4NWy7L6PVk6t1fToZS5nWiU2ilIhnTOH0ugxNpx3SdUb34kV4VfRHzJfv0iyAPIr82W
 qWHpwmegKZbDBLHpiR1ZktgGYMh+V3jIgklD6I/TxHMmtb25FQfuek7DmRYxLpjaJzvB
 IX7g==
X-Gm-Message-State: AOAM531Grg7AoVgIOjDpii2ktZGaa9oaJCJrmBUwIGRkmGhLcOPgCh5b
 CybPlvkdZIldLVQzoF7SXwk=
X-Google-Smtp-Source: ABdhPJyJcabg7tFzt0uAUDGrRx1CYZPr6OEWWZ9Wh+ndlKzcxRw/ApJi/k5vNIKYyzz55JBy+OG2WA==
X-Received: by 2002:a1c:6155:: with SMTP id v82mr11896551wmb.25.1592207025338; 
 Mon, 15 Jun 2020 00:43:45 -0700 (PDT)
Received: from [192.168.1.40] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id s2sm14475810wmh.15.2020.06.15.00.43.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2020 00:43:44 -0700 (PDT)
Subject: Re: [PATCH v2] configure: Let SLOF be initialized by
 ./scripts/git-submodule.sh
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20200615065721.7873-1-f4bug@amsat.org>
 <e1343dcf-6607-8e51-5287-a52722aee97c@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ac63e453-c21d-3365-7f30-4e6e460d3dd3@amsat.org>
Date: Mon, 15 Jun 2020 09:43:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <e1343dcf-6607-8e51-5287-a52722aee97c@redhat.com>
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
Cc: Fam Zheng <fam@euphon.net>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/15/20 9:31 AM, Thomas Huth wrote:
> On 15/06/2020 08.57, Philippe Mathieu-Daudé wrote:
>> The git-submodule.sh script is called by make and initialize the
>> submodules listed in the GIT_SUBMODULES variable generated by
>> ./configure.
>>
>> Add SLOF when we build the ppc64-softmmu target for the pSeries
>> machines (which use SLOF). This fixes:
>>
>>   $ ( cd ${SRC_DIR} ; git submodule update --init roms/SLOF )
>>   Submodule 'roms/SLOF' (https://git.qemu.org/git/SLOF.git) registered for path 'roms/SLOF'
>>   Cloning into '/home/travis/build/user/qemu/roms/SLOF'...
>>   fatal: unable to access 'https://git.qemu.org/git/SLOF.git/': Could not resolve host: git.qemu.org
>>   fatal: clone of 'https://git.qemu.org/git/SLOF.git' into submodule path '/home/travis/build/user/qemu/roms/SLOF' failed
>>   Failed to clone 'roms/SLOF'. Retry scheduled
>>   Cloning into '/home/travis/build/user/qemu/roms/SLOF'...
>>   fatal: unable to access 'https://git.qemu.org/git/SLOF.git/': Could not resolve host: git.qemu.org
>>   fatal: clone of 'https://git.qemu.org/git/SLOF.git' into submodule path '/home/travis/build/user/qemu/roms/SLOF' failed
>>   Failed to clone 'roms/SLOF' a second time, aborting
>>   The command "( cd ${SRC_DIR} ; git submodule update --init roms/SLOF )" exited with 1.
>>
>> Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>> CI: https://travis-ci.org/github/philmd/qemu/jobs/698406512#L1596
>> ---
>>  configure   | 12 ++++++++++++
>>  .travis.yml |  1 -
>>  2 files changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/configure b/configure
>> index 7c2adf36e5..f297a4b68f 100755
>> --- a/configure
>> +++ b/configure
>> @@ -2248,6 +2248,18 @@ if test "$edk2_blobs" = "yes" && ! has bzip2; then
>>    error_exit "The bzip2 program is required for building QEMU"
>>  fi
>>  
>> +###################################
>> +# SLOF is mandatory for the pSeries
>> +for target in $target_list; do
>> +  case $target in
>> +    ppc64-softmmu)
> 
> I know it's confusing, but actually, SLOF is not required for building
> ppc64-softmmu. It's required for building the s390-ccw firmware on
> s390x, since it is using the libnet code from SLOF for network booting.
> And that can only be built right now when we're on a s390x host and GCC
> is installed.
> 
> There is already a check in configure (look for "Only build s390-ccw
> bios" ...), so I'd suggest that you add the git_submodules line there
> instead.

I'v been looking at that and got confuse indeed, in particular because
only the s390x container has this failure, but SLOF documentation only
comments pSeries.

Will respin.

> 
>  Thanks,
>   Thomas
> 
> 
>> +      if test -e "${source_path}/.git" ; then
>> +          git_submodules="${git_submodules} roms/SLOF"
>> +      fi
>> +    ;;
>> +  esac
>> +done
>> +
>>  feature_not_found() {
>>    feature=$1
>>    remedy=$2
>> diff --git a/.travis.yml b/.travis.yml
>> index ec6367af1f..220855c1f0 100644
>> --- a/.travis.yml
>> +++ b/.travis.yml
>> @@ -496,7 +496,6 @@ jobs:
>>          - CONFIG="--disable-containers --target-list=${MAIN_SOFTMMU_TARGETS},s390x-linux-user"
>>          - UNRELIABLE=true
>>        script:
>> -        - ( cd ${SRC_DIR} ; git submodule update --init roms/SLOF )
>>          - BUILD_RC=0 && make -j${JOBS} || BUILD_RC=$?
>>          - |
>>            if [ "$BUILD_RC" -eq 0 ] ; then
>>
> 

