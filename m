Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A21FC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 20:16:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2580520674
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 20:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vi42Pd4A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2580520674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv4rv-0004Z5-Em
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 16:16:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36394)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jv4rE-000415-Vz
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 16:15:25 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42086)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jv4rD-0008J5-AH
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 16:15:24 -0400
Received: by mail-wr1-x442.google.com with SMTP id o11so18219920wrv.9
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 13:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=k7DPCYQx572bkc9WwhMkLsvPaoXCN9yZVp6NJ6XcYXs=;
 b=Vi42Pd4AEK5hSjAMgqFMzWcuzQ5wP2LNwSmfIdV1lKW++f7yTGikJ9FbAZ6Cd3JYeS
 pOBPk7RPHD2nRBW/qGT7QHP5hEy9eP/5nQgRcaVpip37qy4pkhg2hvgJhXECCnLY2Yak
 1iYHUJsfGPKX9LjBfLpaAAoIj1nFEYBHNlAj+KcnPp1ohEcez7s/Gl0oVz+ChSgOdxhr
 EMQwd9Yqr/XDbdq5GS5YVFxNc8pDBbDVhcgw6DnYuLUnlDs+vGMHGLbr3b5EQ3mnJfbA
 3mnVB7SAuiVyQYrY2QR6ojY67EjRH3RVw7Tb1lwywqIo61a2Nz/7cnShRjkgK8Cs64+l
 l8DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=k7DPCYQx572bkc9WwhMkLsvPaoXCN9yZVp6NJ6XcYXs=;
 b=berqGBT7NJt59LCIKeIw9cyNrNbmrlmGKrtB/FmNfuH/lk4ufh7LrQH5VvnTHpaWU2
 Ot4BU5zpeQn5fStPEfbIlA0bgQYmDxZj0NAiE0n2VobVSdTWTTz0U8/vfoqXj47hMSuU
 LJqRML3tIDTS0GiiPW1viV1SfH4RT0XP0ptRskHZTDSFbfr8kTHIFzYLck3ix1uDsVRC
 TibctPtsHDlTmmXKMUHCLKlNzwj0GjVwE/T3YpKX/LpSzYmKJsKEJiOAx4VWO+G6A7um
 VaTJSmVEmkwUy5WYY5uM9/XHQDQK5fWWJZggH7PcpX+JgHiRscWkQ2xdnBTsuGzp/o8f
 motA==
X-Gm-Message-State: AOAM533yyXIGfPhL2Ey4XBkJr4fQdMXKmXmqipsUfpxjX70i8L/jd8RU
 jnvF4b/1g05EZVALFD4X5og=
X-Google-Smtp-Source: ABdhPJzGYY+EeZAyphhVKGa1aifN2Y4cOJGJrtxxziiDOc4X9rzDyBREREu1+iypVVGcsZvrwUlExQ==
X-Received: by 2002:adf:e90d:: with SMTP id f13mr1177481wrm.146.1594671321488; 
 Mon, 13 Jul 2020 13:15:21 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id 2sm841749wmo.44.2020.07.13.13.15.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2020 13:15:20 -0700 (PDT)
Subject: Re: [PATCH v2 01/11] configure: remove all dependencies on a
 (re)configure
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200713200415.26214-1-alex.bennee@linaro.org>
 <20200713200415.26214-2-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5de536a4-bef7-c8bc-e6a1-dbaf95e58d51@amsat.org>
Date: Mon, 13 Jul 2020 22:15:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200713200415.26214-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: fam@euphon.net, berrange@redhat.com, robert.foley@linaro.org,
 richard.henderson@linaro.org, robhenry@microsoft.com,
 aaron@os.amperecomputing.com, cota@braap.org, peter.puhov@linaro.org,
 kuhn.chenqun@huawei.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/13/20 10:04 PM, Alex Bennée wrote:
> The previous code was brittle and missed cases such as the mipn32
> variants which for some reason has the 64 bit syscalls. This leads to
> a number of binary targets having deps lines like:
> 
>   all.clang-sanitizer/mipsn32el-linux-user/linux-user/signal.d
>   140:  /home/alex/lsrc/qemu.git/linux-user/mips64/syscall_nr.h \
>   455:/home/alex/lsrc/qemu.git/linux-user/mips64/syscall_nr.h:
> 
>   all.clang-sanitizer/mipsn32el-linux-user/linux-user/syscall.d
>   146:  /home/alex/lsrc/qemu.git/linux-user/mips64/syscall_nr.h \
>   485:/home/alex/lsrc/qemu.git/linux-user/mips64/syscall_nr.h:
> 
> which in turn would trigger the re-generation of syscall_nr.h in the
> source tree (thanks to generic %/syscall_nr.h rules). The previous
> code attempts to clean it out but misses edge cases but fails.
> 
> After spending a day trying to understand how this was happening I'm
> unconvinced that there are not other such breakages possible with this
> "caching". As we add more auto-generated code to the build it is likely
> to trip up again. Apply a hammer to the problem.
> 
> Fixes: 91e5998f18 (which fixes 5f29856b852d and 4d6a835dea47)
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  configure | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/configure b/configure
> index bc3b9ad931..e1de2f5b24 100755
> --- a/configure
> +++ b/configure
> @@ -1955,23 +1955,20 @@ EOF
>  exit 0
>  fi
>  
> -# Remove old dependency files to make sure that they get properly regenerated
> -rm -f */config-devices.mak.d
> -
>  # Remove syscall_nr.h to be sure they will be regenerated in the build
>  # directory, not in the source directory
>  for arch in alpha hppa m68k xtensa sh4 microblaze arm ppc s390x sparc sparc64 \
>      i386 x86_64 mips mips64 ; do
>      # remove the file if it has been generated in the source directory
>      rm -f "${source_path}/linux-user/${arch}/syscall_nr.h"
> -    # remove the dependency files
> -    for target in ${arch}*-linux-user ; do
> -        test -d "${target}" && find "${target}" -type f -name "*.d" \
> -             -exec grep -q "${source_path}/linux-user/${arch}/syscall_nr.h" {} \; \
> -             -print | while read file ; do rm "${file}" "${file%.d}.o" ; done
> -    done
>  done
>  
> +# Clean out all old dependency files. As more files are generated we
> +# run the risk of old dependencies triggering generation in the wrong
> +# places. Previous brittle attempts to be surgical tend to miss edge
> +# cases leading to wasted time and much confusion.
> +find -type f -name "*.d" -exec rm -f {} \;
> +
>  if test -z "$python"
>  then
>      error_exit "Python not found. Use --python=/path/to/python"
> 

