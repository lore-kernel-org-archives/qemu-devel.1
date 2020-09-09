Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F92DC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 12:58:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9261921941
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 12:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjjCR9jy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9261921941
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFzgf-0007vZ-LX
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 08:58:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54342)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kFzfA-0005g5-BM; Wed, 09 Sep 2020 08:57:24 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40171)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kFzf6-0001GO-Pu; Wed, 09 Sep 2020 08:57:22 -0400
Received: by mail-wr1-x444.google.com with SMTP id j2so2839872wrx.7;
 Wed, 09 Sep 2020 05:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=LpoMojLL29P7U6nHQe0Eo+xaN0TjWQoqfyVSEXNAYYk=;
 b=VjjCR9jyqIHpNY/m7KkJh5f7xOWpA5uUKY/mHWfOXiAP70vOyWDcopEtjOWpOQyMzk
 i6yKfztBcrbbIK/JUAkinXCuwACuj2dJ9TIdWTxAeHjpwoywBA9daEaLHCN33NpqbLKG
 555bwnUdVAXjXdu18LSAdXKe+pymG6+eHaiM/3dumtHrsmP8iwd+af2wMQXcVyegDbPf
 nt4w2kSDwJqRQaW1dkRwxJSCxMvCSdLQCgpfNT/AfxuHqfL9e/Cu7QktjBU/KjA9Pfq2
 JkBDhBI6i0y6ghj5XrIkI3U1cFxC6kT2B7OIzLnYx0z+tz9xwlthxFJ8MRo8kZs93L44
 Pw7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LpoMojLL29P7U6nHQe0Eo+xaN0TjWQoqfyVSEXNAYYk=;
 b=PM7QiyafCQ4GH1CvX5/iUIb0VfVGXVl4AEd05wUD6PDABCiJiE5N2cY6vAMW3XNBJb
 /q3cT+mmpv0C3ifDC7eHAJiXve2uJeOlJ8z8TqaulJCq5FfSKoWi0OFWxomBpDSGYZXf
 FLsGQoj08M7I6YliuXxS0rvPbvwnolsAC2hpZ/seKN4mauK1l/xvtqH5anUaEfioOYCi
 yJAuqfc0PSZGFdw2urur3r4kyp8kyVSXeBYiNt8Pf2f/8wWQGMAGmLqXsUbuTBmVuSKx
 2sYzQEqP8bGvDoyQaJRfTFnFpR2go96GMUlnAc0PNG5y2HgKZ/nwS2bzWvhW2NfPd+xU
 STIQ==
X-Gm-Message-State: AOAM5304wK4IZHpdKZ+B+QO/sneXKejBjV6igPg66Lcz3zD4zSeawwCA
 4o3xKJ6zvs7r/TpvgNbIPqEYeYQ3va0=
X-Google-Smtp-Source: ABdhPJyCrtEdJfR/cUBbFIF0YTaSf/8Q47cbFq2Lg+QZxDEFiKGxdlLeV1gYnTlx+L/CJ0O8BoGWsg==
X-Received: by 2002:adf:e58b:: with SMTP id l11mr4174625wrm.210.1599656238265; 
 Wed, 09 Sep 2020 05:57:18 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id o124sm3737174wmb.2.2020.09.09.05.57.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Sep 2020 05:57:17 -0700 (PDT)
Subject: Re: [PATCH v2 06/10] configure: don't enable ppc64abi32-linux-user by
 default
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200909112742.25730-1-alex.bennee@linaro.org>
 <20200909112742.25730-7-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <92251f84-4cf0-273e-6d9b-7feb787ea51e@amsat.org>
Date: Wed, 9 Sep 2020 14:57:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200909112742.25730-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-3.576,
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
Cc: fam@euphon.net, berrange@redhat.com, richard.henderson@linaro.org,
 cota@braap.org, qemu-ppc <qemu-ppc@nongnu.org>, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing qemu-ppc@

On 9/9/20 1:27 PM, Alex Bennée wrote:
> The user can still enable this explicitly but they will get a warning
> at the end of configure for their troubles. This also drops any builds
> of ppc64abi32 from our CI tests.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  configure | 46 +++++++++++++++++++++++++++-------------------
>  1 file changed, 27 insertions(+), 19 deletions(-)
> 
> diff --git a/configure b/configure
> index 4231d56bcc0..2b5492a0d63 100755
> --- a/configure
> +++ b/configure
> @@ -542,6 +542,8 @@ gettext=""
>  bogus_os="no"
>  malloc_trim=""
>  
> +deprecated_features=""
> +
>  # parse CC options first
>  for opt do
>    optarg=$(expr "x$opt" : 'x[^=]*=\(.*\)')
> @@ -1720,26 +1722,25 @@ if [ "$bsd_user" = "yes" ]; then
>      mak_wilds="${mak_wilds} $source_path/default-configs/*-bsd-user.mak"
>  fi
>  
> -if test -z "$target_list_exclude"; then
> -    for config in $mak_wilds; do
> -        default_target_list="${default_target_list} $(basename "$config" .mak)"
> -    done
> -else
> -    exclude_list=$(echo "$target_list_exclude" | sed -e 's/,/ /g')
> -    for config in $mak_wilds; do
> -        target="$(basename "$config" .mak)"
> -        exclude="no"
> -        for excl in $exclude_list; do
> -            if test "$excl" = "$target"; then
> -                exclude="yes"
> -                break;
> -            fi
> -        done
> -        if test "$exclude" = "no"; then
> -            default_target_list="${default_target_list} $target"
> +if test -z "$target_list_exclude" -a -z "$target_list"; then
> +    # if the user doesn't specify anything lets skip deprecating stuff
> +    target_list_exclude=ppc64abi32-linux-user
> +fi
> +
> +exclude_list=$(echo "$target_list_exclude" | sed -e 's/,/ /g')
> +for config in $mak_wilds; do
> +    target="$(basename "$config" .mak)"
> +    exclude="no"
> +    for excl in $exclude_list; do
> +        if test "$excl" = "$target"; then
> +            exclude="yes"
> +            break;
>          fi
>      done
> -fi
> +    if test "$exclude" = "no"; then
> +        default_target_list="${default_target_list} $target"
> +    fi
> +done
>  
>  # Enumerate public trace backends for --help output
>  trace_backend_list=$(echo $(grep -le '^PUBLIC = True$' "$source_path"/scripts/tracetool/backend/*.py | sed -e 's/^.*\/\(.*\)\.py$/\1/'))
> @@ -7557,7 +7558,7 @@ TARGET_SYSTBL=""
>  case "$target_name" in
>    i386)
>      mttcg="yes"
> -	gdb_xml_files="i386-32bit.xml"
> +    gdb_xml_files="i386-32bit.xml"
>      TARGET_SYSTBL_ABI=i386
>      TARGET_SYSTBL=syscall_32.tbl
>    ;;
> @@ -7667,6 +7668,7 @@ case "$target_name" in
>      TARGET_SYSTBL_ABI=common,nospu,32
>      echo "TARGET_ABI32=y" >> $config_target_mak
>      gdb_xml_files="power64-core.xml power-fpu.xml power-altivec.xml power-spe.xml power-vsx.xml"
> +    deprecated_features="ppc64abi32 ${deprecated_features}"
>    ;;
>    riscv32)
>      TARGET_BASE_ARCH=riscv
> @@ -8011,6 +8013,12 @@ fi
>  touch ninjatool.stamp
>  fi
>  
> +if test -n "${deprecated_features}"; then
> +    echo "Warning, deprecated features enabled."
> +    echo "Please see docs/system/deprecated.rst"
> +    echo "  features: ${deprecated_features}"
> +fi

Nice!

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> +
>  # Save the configure command line for later reuse.
>  cat <<EOD >config.status
>  #!/bin/sh
> 

