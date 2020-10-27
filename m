Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2443C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 09:28:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19A942224E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 09:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJIGd+Oz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19A942224E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXLH9-0008Ss-TI
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 05:28:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kXLGa-00083d-1b
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 05:27:44 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:44810)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kXLGY-0005yF-E4
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 05:27:43 -0400
Received: by mail-ej1-x641.google.com with SMTP id d6so1169368ejb.11
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 02:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=53oEN06JDzpQL3apqX7mw4OjEE0a5HWogjYJacXpOps=;
 b=mJIGd+OzIWqEerczSHo+iBl7WXXQT7DfGVSny0alG+Y19gG8LZOtjHz6PZ8ly3rK82
 KfVVW0oPqe/OOCYMRbNVXJ/Xxnb1rTclDfIrkIyRuSgYer0ogMTXqsY38QJSTbd8XbWE
 GSi3HxRvhGytjqfO6NRknsLA3+3F3w3/o5geNTid/x9ysC7/+UhZj50rDuxSO4YkgUHA
 xpdlxGWxStEcokpEGtyqvPBY3UvQPnqh14BKRd8yjxWTc2rEVX9hyzmqKjCmDdl2if5D
 VrLxdd29iHjvh1ye5+5sXdnpK2p9ovqdh4z+MnT9Puq+/bTX7FuO2hWMxEwB8eu3h6d5
 q2QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=53oEN06JDzpQL3apqX7mw4OjEE0a5HWogjYJacXpOps=;
 b=MG+KcWFl3amiNCB1t7+JnF1GoXj9CeKfi51GECNTryKRNy0nVYqL0e0ekjh5nkSaJh
 XMugKG+8AdpKcEskRVJklWwYNh83sMQ7JM38ocNd2k9PyYIKOEPtrkMI4TCPd5qyskTT
 ZPB/7g/BEqaenFScuApOXErAdIHqi/PstZqbwzwAuJuL/QR20wnVqTM6IYrUQ8Ye2WiW
 Lx3N4EeOCT8p8RylCAjFBMhuqDMrhDA85lU/qowvuFBgcJFX2o+bD4CZA4fzh6Y23I0W
 smaQdaeQQVQovU8TpLHL6GFXqUis/mi2AF1w1SVLvwgnSrle34HRZPFAO5a6Lu+BcGJo
 dZzA==
X-Gm-Message-State: AOAM533jg+Y+hP40jedyz+L6VSW7XfQDXfzkrhY/ffrde4l1W5unedoz
 UjtUCrU6jJfzSw79I5oU9Hg=
X-Google-Smtp-Source: ABdhPJzJchgFAY83BuZ5pW+q5JjfIlTbenlll74Fnmwa1SzyM7T4673wWYag1SxrF6WLUf0O6hnbYw==
X-Received: by 2002:a17:906:b055:: with SMTP id
 bj21mr1452150ejb.334.1603790860286; 
 Tue, 27 Oct 2020 02:27:40 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id e16sm651199ejr.91.2020.10.27.02.27.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2020 02:27:39 -0700 (PDT)
Subject: Re: [PULL 01/17] build: fix macOS --enable-modules build
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20201026135131.3006712-1-pbonzini@redhat.com>
 <20201026135131.3006712-2-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d87ec2b2-225e-353f-e561-e46c2d15b7b1@amsat.org>
Date: Tue, 27 Oct 2020 10:27:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201026135131.3006712-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-2.167,
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
Cc: Thomas Huth <thuth@redhat.com>, Emmanuel Blot <eblot.ml@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/26/20 2:51 PM, Paolo Bonzini wrote:
> Apple's nm implementation includes empty lines in the output that are not
> found in GNU binutils.  This confuses scripts/undefsym.py, though it did
> not confuse the scripts/undefsym.sh script that it replaced.  To fix
> this, ignore lines that do not have two fields.
> 
> Reported-by: Emmanuel Blot <eblot.ml@gmail.com>
> Tested-by: Emmanuel Blot <eblot.ml@gmail.com>
> Fixes: 604f3e4e90 ("meson: Convert undefsym.sh to undefsym.py", 2020-09-08)
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  .cirrus.yml         |  2 +-
>  scripts/undefsym.py | 11 +++++------
>  2 files changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/.cirrus.yml b/.cirrus.yml
> index 81a2960b1a..900437dd2a 100644
> --- a/.cirrus.yml
> +++ b/.cirrus.yml
> @@ -40,7 +40,7 @@ macos_xcode_task:
>    script:
>      - mkdir build
>      - cd build
> -    - ../configure --extra-cflags='-Wno-error=deprecated-declarations'
> +    - ../configure --extra-cflags='-Wno-error=deprecated-declarations' --enable-modules
>                     --enable-werror --cc=clang || { cat config.log meson-logs/meson-log.txt; exit 1; }

I'm confused as this broke the catalina-xcode test:

PASS 5 qtest-aarch64/device-introspect-test
/aarch64/device/introspect/abstract-interfaces
missing object type 'virtio-gpu-device'
Broken pipe
../tests/qtest/libqtest.c:176: kill_qemu() detected QEMU death from
signal 6 (Abort trap: 6)
ERROR qtest-aarch64/device-introspect-test - too few tests run (expected
6, got 5)
gmake: *** [Makefile.mtest:905: run-test-111] Error 1

