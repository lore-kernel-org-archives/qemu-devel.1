Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	PDS_TONAME_EQ_TOLOCAL_SHORT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81597C4727F
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:39:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F067E2064B
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JrPlDEu8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F067E2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNZW8-0002hR-0o
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 06:39:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kNZHv-0002Bc-Gp; Wed, 30 Sep 2020 06:24:43 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54085)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kNZHu-0006kq-4Q; Wed, 30 Sep 2020 06:24:43 -0400
Received: by mail-wm1-x344.google.com with SMTP id x23so1107137wmi.3;
 Wed, 30 Sep 2020 03:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=BlVBM30xDksoO4gB+K5g69bdupxVY7+6HPcPWe/AX1Q=;
 b=JrPlDEu8BKCG2LxYxl2Cnhz/GRSV1JD3k2g8OavSAM8kspmDDU1WSN1/Vhaoc/hTKN
 mwGOnqTNl2fHkEOds7nbHxVMSWGi1l5mF/qZ4EG/VKzN59B+vLcneZsBSUHEAXiESsLH
 YS6/U8jqNNkCpQuFuN5e6f9frEwJ3HMly1faEBCl29Szzv952yVGdzE2XH8UjmXbvuSm
 kfIOUqE6xPFH17jliWoc0zA8oocoemQV5qByRQw8PAIhEpkPcV2Pif757Fsk9U7rIzbX
 yJKTCsCKoNdOYrS5Bqn3Vx+Ugl9cxUvfmeOYne6mteTNORK4h0+rc8JifFy3g0xQMYBq
 126g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BlVBM30xDksoO4gB+K5g69bdupxVY7+6HPcPWe/AX1Q=;
 b=taggIzOTWCFu6723usNflqDY4iSd6sxreD9pYS1HZuWiTqCt9Fimjp1srtKI5708jb
 R/ahOPTaBrp90w7k2ft3PocVjWdLJuCPAo09zv3qZFhUrOcVBtWbVXmy0r6j+NwXvUdP
 qFjS5cM9GxWoPLbFTF/aBxW+IXUzyqHrgsW99Tmj9i4d1eC0tvvxUPf+FgIOhFF5z9rI
 zaZV+aHnFDJB5xjIbzW7gV/jlb6bbHKsBA40PE7RO59zeLgXrwFa8DR15gPxwbuX1rKe
 8oIQAYGxQ6pOpvG/V5qCubcvdhkYi6DE0aQEYDiW2HTFiwhjU8a7Hg/zMAh63wgGvr7+
 D2kQ==
X-Gm-Message-State: AOAM532ORNv3qPQGNbLAyBqh1VAMQquk/ThMb7LgrnvEACk5VD9iBC+4
 StcQr/zw5L2SytR7l//wV4ReJ3JUrlY=
X-Google-Smtp-Source: ABdhPJxLrNFMkjiNdc4uOLTG3jz+ZrzkcuilZl0UQp9I4YsGTw6RDbiwm6mbClXOS73g3OXVfDyeBA==
X-Received: by 2002:a7b:ce89:: with SMTP id q9mr2192921wmj.65.1601461479092;
 Wed, 30 Sep 2020 03:24:39 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id q13sm1976686wra.93.2020.09.30.03.24.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2020 03:24:38 -0700 (PDT)
Subject: Re: [PATCH RFC 11/14] avr/: fix some comment spelling errors
To: zhaolichang <zhaolichang@huawei.com>, qemu-trivial@nongnu.org
References: <20200930095321.2006-1-zhaolichang@huawei.com>
 <20200930095321.2006-12-zhaolichang@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <40fbcca9-2ec1-b73b-fc12-7bfbc0cb9b49@amsat.org>
Date: Wed, 30 Sep 2020 12:24:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200930095321.2006-12-zhaolichang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.199, NICE_REPLY_A=-0.001,
 PDS_TONAME_EQ_TOLOCAL_SHORT=1.999, RCVD_IN_DNSWL_NONE=-0.0001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/30/20 11:53 AM, zhaolichang wrote:
> I found that there are many spelling errors in the comments of qemu/target/avr.
> I used spellcheck to check the spelling errors and found some errors in the folder.
> 
> Signed-off-by: zhaolichang <zhaolichang@huawei.com>
> ---
>  target/avr/helper.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

