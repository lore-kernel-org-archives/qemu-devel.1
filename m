Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80649C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 19:48:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE008208D5
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 19:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQf+tia8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE008208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSQHI-0005A0-Iw
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 15:48:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44938)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSQGY-0004KE-Dj; Tue, 13 Oct 2020 15:47:22 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46969)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSQGW-0003Cf-T9; Tue, 13 Oct 2020 15:47:22 -0400
Received: by mail-wr1-x441.google.com with SMTP id n6so742986wrm.13;
 Tue, 13 Oct 2020 12:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ByAfKo+5VVPKvT058Rn/lXBnIE1/MamkgDFAYgvaxyA=;
 b=RQf+tia8BskaElCLiHtOFB/E72U1Wz7T/6S40CbX68g8MAHMMdAEM2i1QiACfiChDY
 mJ6lUWhuxWX1g35d/G0ynlNz+pHaXf7z0Ax33ISC/GXlBBAdaX5EOWOHMqH4DPXK3Nfh
 jReyJCQR6WUTUoEz119EpWlz3rzFmE6u+TfIWLFTknNrrtPkhRBMfQ68TsQrB6tOuiiA
 gWoFrNg7AewZ5gIisSaIspA6qf5JVzpLwR/fCWZ6SZ6QXfYPCUh4YuuI52neHTtKcooG
 P5fnK4WFpUpCzBxO+LpKiGwkM/zTN4nbL+M3YwYZ8gUXTX3/4cFacRlpsjLXwXY3ZQQT
 +EEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ByAfKo+5VVPKvT058Rn/lXBnIE1/MamkgDFAYgvaxyA=;
 b=EpslVvIAFGhurz47jNRU0kXPY6UspvSYUhxLs6KNGu8j/B+2FAml2J/jF46K5hSkJc
 /Th7AjwREAqZFSDCl2IywMcumwDyrK9xzZo3XXzL9NcABNlIyLUNlg2eZ8EB/pyZ+TSw
 geH54e4EJ2qzRYkxuJY8Doj0lKPZZFkpcoYJIW12qAtAkOeGx9lR5SaqRO0OlDNJ4YxA
 fi2uyWlwkkowSVMvXKH8+hTrLQ6s0wFXzDEfDXUILv8vmbomLhMNE3RVwYSpwTACOg+f
 SKMhfHKZLg5AeSt56LbCQUcJHUY7YTnp86FDIncCqpKco49KbzSWQIO9MH/vYzmYEH+a
 ZGXA==
X-Gm-Message-State: AOAM533Ek3Vw6cogtVlPNMnJY9C8YC03+aOaImLvnG9FovINPpmSoiCl
 7tLuLwT1keCM2d04GkaXA5k=
X-Google-Smtp-Source: ABdhPJzUb/yc6M+5TRHQU3lJs4OzGY54qB0K5gDF0MTa08uaATJpDlRwRNieBaiglyUk4GbVC+K8/w==
X-Received: by 2002:adf:fe81:: with SMTP id l1mr1359196wrr.11.1602618438979;
 Tue, 13 Oct 2020 12:47:18 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id a15sm807508wrp.90.2020.10.13.12.47.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2020 12:47:18 -0700 (PDT)
Subject: Re: [PATCH v7 4/8] mac_oldworld: Drop some variables
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <cover.1593456926.git.balaton@eik.bme.hu>
 <5e9db897c3b48bce89891599c55752acfae1b892.1593456926.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5942e63c-e2cb-84e9-9f44-750de9da6790@amsat.org>
Date: Tue, 13 Oct 2020 21:47:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <5e9db897c3b48bce89891599c55752acfae1b892.1593456926.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: David Gibson <david@gibson.dropbear.id.au>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Howard Spoelstra <hsp.cat7@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/29/20 8:55 PM, BALATON Zoltan wrote:
> Values not used frequently enough may not worth putting in a local
> variable, especially with names almost as long as the original value
> because that does not improve readability, to the contrary it makes it
> harder to see what value is used. Drop a few such variables.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/ppc/mac_oldworld.c | 33 ++++++++++++++++-----------------
>   1 file changed, 16 insertions(+), 17 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

