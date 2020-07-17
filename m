Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FFAC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 10:49:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9998720734
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 10:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nibep0JQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9998720734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwNvv-0003J8-Tz
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 06:49:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43152)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jwNvK-0002pO-8K; Fri, 17 Jul 2020 06:49:02 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:34209)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jwNvI-0003Fh-Of; Fri, 17 Jul 2020 06:49:01 -0400
Received: by mail-ej1-x642.google.com with SMTP id y10so10262252eje.1;
 Fri, 17 Jul 2020 03:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=6aVyHH7l5KzLnYteuefcNp89RgKZlledU/BNuMdkoDE=;
 b=Nibep0JQzrSx9D8wfXT8NcnJhXJrLmTbGh2ey3wtLc3pg2OjYcumJqvzIIauwNKV6D
 EJG1QoeKZ3GF4eL3RVDfJVrbi1BqZQIsQ3XMYJRpL8BmxTDEanIXNHqE4cohEyGh7lNe
 c1Jb5G26Az/DjuiEFE1JGpi5DeH3rKYo2HoYJ7rC9hceKVeLb/SCXpv4w9vyV3m+5Jtt
 1jDZli3oRM6yfzAhldZVqdehc4gUSnvtvHIKv1YhSLTc2mkMtvlQxZRe0P1KsXZQtNUp
 Jp01wBT6ldSwTqTLyj653Nq4/jh1Uu42qrc5u43gQZ3LLr7JArwb0iC/XMCdVN0KfQCF
 Iseg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6aVyHH7l5KzLnYteuefcNp89RgKZlledU/BNuMdkoDE=;
 b=YJTMZ5/OOARiNk4/XyC3oPWqGe8wbpYfVg0Awv6PphNBfXxA4xq4denChibi9K/DZJ
 uBS2SixghBAg7oN4f5M3oCo2GUKQzcvzCy0nI5ZcUyvoLZrGfQgt3mcspvuL0j65FYqe
 E8NrQmMFjavHV2EBbrh7210aLJaxBK0wVYNO+IXmfzhndPJsL1hgFo0K6g8T4jF1FIWO
 ZoQVlwtHGeSC6v8/wlbgXzpF5vblJp0qMCf2HbmckhLtGP0sjYZ1xm51Pjr8aNcr7HUt
 lZBf8vVYmX18aLYuUQBVEZZbE6cll+ZyGxaxRzTZIwE5CmHXx/aSL/1QQW1BYXNZt0Ql
 PVlA==
X-Gm-Message-State: AOAM532uCXD1RtmSWpn+YyNtj+ZSl7AbObvmEb9TV/wBiOErZ3CpnGT5
 DB+f7lyjbhDCsRysBrfP5ctl3qpZWIY=
X-Google-Smtp-Source: ABdhPJzYY/iLnLEgfySGPsRdQqYKc1k9Jos0/Ie5toRTdSLxd9fgct33MG5H/uM7k1vhMgjKPcdEDw==
X-Received: by 2002:a17:906:69d3:: with SMTP id
 g19mr8328126ejs.402.1594982938698; 
 Fri, 17 Jul 2020 03:48:58 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id cq7sm7957148edb.66.2020.07.17.03.48.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jul 2020 03:48:57 -0700 (PDT)
Subject: Re: [RFC PATCH-for-5.1] hw/ide: Avoid #DIV/0! FPU exception by
 setting CD-ROM sector count
To: qemu-devel@nongnu.org
References: <20200717101659.20031-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <76c86b18-e14c-dc65-71f0-bb9fbd9e988f@amsat.org>
Date: Fri, 17 Jul 2020 12:48:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200717101659.20031-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x642.google.com
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
Cc: Alexander Bulekov <alxndr@bu.edu>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/17/20 12:16 PM, Philippe Mathieu-Daudé wrote:
> libFuzzer found an undefined behavior (#DIV/0!) in ide_set_sector()
> when using a CD-ROM (reproducer available on the BugLink):
> 
>   UndefinedBehaviorSanitizer:DEADLYSIGNAL
>   ==12163==ERROR: UndefinedBehaviorSanitizer: FPE on unknown address 0x5616279cffdc (pc 0x5616279cffdc bp 0x7ffcdaabae90 sp 0x7ffcdaabae30 T12163)
> 
> Fix by initializing the CD-ROM number of sectors in ide_dev_initfn().
> 
> Reported-by: Alexander Bulekov <alxndr@bu.edu>
> Fixes: b2df431407 ("ide scsi: Mess with geometry only for hard disk devices")
> BugLink: https://bugs.launchpad.net/qemu/+bug/1887309
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/ide/qdev.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c
> index 27ff1f7f66..6ce7fc317c 100644
> --- a/hw/ide/qdev.c
> +++ b/hw/ide/qdev.c
> @@ -201,6 +201,15 @@ static void ide_dev_initfn(IDEDevice *dev, IDEDriveKind kind, Error **errp)
>                                errp)) {
>              return;
>          }
> +    } else {
> +        uint64_t nb_sectors;
> +
> +        blk_get_geometry(dev->conf.blk, &nb_sectors);
> +        if (!nb_sectors) {
> +            error_setg(errp, "CD-ROM size can not be zero");

Hmm this doesn't work because for some machines configure_blockdev()
creates blocks of zero size under your feet:

    default_drive(default_cdrom, snapshot,
machine_class->block_default_type, 2,
                  CDROM_OPTS);

> +            return;
> +        }
> +        dev->conf.secs = nb_sectors;
>      }
>      if (!blkconf_apply_backend_options(&dev->conf, kind == IDE_CD,
>                                         kind != IDE_CD, errp)) {
> 

