Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD8CC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 06:49:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11FEA20714
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 06:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3aW2nGZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11FEA20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jy8ZV-0008LS-C4
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 02:49:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jy8Yu-0007rJ-Gl
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 02:49:08 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:45627)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jy8Ys-0001hZ-WD
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 02:49:08 -0400
Received: by mail-ed1-x544.google.com with SMTP id d16so780945edz.12
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 23:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=bEpqDMbsJ3CyxAXXiTqOosllIjKxqU7go4mt46yt1SQ=;
 b=W3aW2nGZ+78U+Y5ck+HcdjEzOxMYFwMYhzIfrfHFJLha+CwcRWrxgwkMfPdpBOL5/j
 VdODCvRFmOQ+IZ4XSa2cRyQKa6cbPR+NETqri0mnWMjaTa89IEc2w0tlYk29VZs3R0Dw
 H9IAvMy/uckmCcNEj9rMqtFrC96vqe3Q689KkPdsx8QuGUtuw7pzrDgASr9hbIA+yFae
 ZTyA02qURrmL7y/3VaxIKJX4PhutIX/yJMrdw79H2D9l/Bq9J4kv3n9keAAyPGG6ou7l
 pDp/osj3jXiterq1nKcYquCVO/ejQ7/BfEeiizMFOfmAxgo7Nzn598jBO96+6t1vmFHP
 VANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bEpqDMbsJ3CyxAXXiTqOosllIjKxqU7go4mt46yt1SQ=;
 b=D1IXuGR9VKv8w7hJiuVw3HBsQV/aI/hxEBJyvjwV/6mgGmMWHEgTgxpXM7g1ghNSfY
 ZBmo/NoBe8pvas1pYkt4hKXt/tBYkzRvdSAJj8fsk04ZI7zjXyH3yi08Ki2JqR6aynmx
 qqQETxRyJhO4uahdK1gRVEmTPMWnKZK2d//HpQ82TH9J2tmyyX/TGuknf+rqHNLHUm1C
 lnG6jQsMif+cMm4wb1p3VGAT0gfFP2X+DjCRulg+oSLPhyisd45O7iNJPglfJ6tyVFOO
 Ww+UFklKpS1Q0HlgI5TBIxkPZ+hyEgDfzPLNnWfJR4Ljo079D79TexvgIzevAvFrLe3o
 r8sQ==
X-Gm-Message-State: AOAM530eIQ+9NSSTrkEqap9QrzgyTuY0osx+EHzozrLsz1BKV/z/V6kp
 UZqKVIDC7bJVCxpYfCCfCr0=
X-Google-Smtp-Source: ABdhPJzFJZRI2MmvFbZXxPTR5ZCJzYS3A4DIdeGodMrKAAHEfFKJj+WP7r4G7xeVxMORgzQfrBb6UQ==
X-Received: by 2002:a05:6402:1c96:: with SMTP id
 cy22mr28793783edb.79.1595400545312; 
 Tue, 21 Jul 2020 23:49:05 -0700 (PDT)
Received: from [192.168.1.36] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id b4sm18547483edx.96.2020.07.21.23.49.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2020 23:49:04 -0700 (PDT)
Subject: Re: [PATCH v2 05/12] util/oslib-win32: add qemu_get_host_physmem
 implementation
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200722062902.24509-1-alex.bennee@linaro.org>
 <20200722062902.24509-6-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <64bfc75d-542b-203c-af9b-9acc441f56c4@amsat.org>
Date: Wed, 22 Jul 2020 08:49:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200722062902.24509-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x544.google.com
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
Cc: fam@euphon.net, berrange@redhat.com, Stefan Weil <sw@weilnetz.de>,
 richard.henderson@linaro.org, cota@braap.org, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/22/20 8:28 AM, Alex Bennée wrote:
> It seems GetPhysicallyInstalledSystemMemory isn't available in the
> MinGW headers so we have to declare it ourselves. Compile tested only.
> 
> Cc: Stefan Weil <sw@weilnetz.de>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  util/oslib-win32.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/util/oslib-win32.c b/util/oslib-win32.c
> index 31030463cc9..f0f94833197 100644
> --- a/util/oslib-win32.c
> +++ b/util/oslib-win32.c
> @@ -43,6 +43,8 @@
>  /* this must come after including "trace.h" */
>  #include <shlobj.h>
>  
> +WINBASEAPI BOOL WINAPI GetPhysicallyInstalledSystemMemory (PULONGLONG);
> +
>  void *qemu_oom_check(void *ptr)
>  {
>      if (ptr == NULL) {
> @@ -831,6 +833,15 @@ char *qemu_get_host_name(Error **errp)
>  
>  size_t qemu_get_host_physmem(void)
>  {
> -    /* currently unimplemented */
> -    return 0;
> +    ULONGLONG mem;
> +
> +    if (GetPhysicallyInstalledSystemMemory(&mem)) {
> +        if (mem > SIZE_MAX) {
> +            return SIZE_MAX;
> +        } else {
> +            return mem;
> +        }
> +    } else {
> +        return 0;
> +    }
>  }
> 

