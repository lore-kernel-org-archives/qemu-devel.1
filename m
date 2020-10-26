Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A08C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 18:20:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7946B2087C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 18:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="inRePWB1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7946B2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX76y-0006Oo-Dh
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 14:20:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36436)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kX6yk-0007L9-05
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 14:12:23 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:36185)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kX6yi-0007Lj-Cr
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 14:12:21 -0400
Received: by mail-ed1-x544.google.com with SMTP id l16so10447825eds.3
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 11:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=7wie3mbh5QjJrRbG1ENHKuVZbS3cZFbHzZHqedr7NKo=;
 b=inRePWB1ZHYuO+8XrhFEg9MlZxsPLxPp9JvcPeCD0xhQTz0tPaY9bCm2O22s/SQFJU
 emCHygSD0X3CDWFpBfmiLRx6jUZIt2bWNrm7rK+xl1O8YqM5/TSkAZPCvYo61E6F+lSu
 f9j63QEasayjRypETDht1Zj46V3cAGfTCpMww9ZcilT2DLoW87K1MJBJwR7YZGGsD8Kd
 kCSI3FMYCKBp9okEPDQQNmjkJ1dw3SexfMM13dSpTM+/e8/FsE5wrWH1NV5k1gLTgEMe
 LSfnIKm0Z0SKJ6GKvLvLwGKrX4HjlbCF2v/riB7C8FHjMzRmggH7xmaiK6+pTGBbfWY4
 GxZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7wie3mbh5QjJrRbG1ENHKuVZbS3cZFbHzZHqedr7NKo=;
 b=d3BBu+FcJMQMRVOLdMxr2HwNZimTZNU/bdqxKwnESPPfOTAtcf2wsZuplCOgi4rCaA
 B2NWwxfon/PbTmxar0Wif3rI/nO+GW+R7fSXOADSgwi//vBOA56duCUn5Li5UgjUrx6i
 qIlNgLiYUtsQIp3tyUI7YGuj5bk+s8opf/lyFuKVwC890iHaL7eRUvlmcsXW67/dDWI8
 nUuU9mO4PILNDoCAhbPvaf7nZko2ho43wfLf4EUkuDbw6NPmOP4R82oMPAkiiyQvjahX
 vAM1uRhSxo1ly2WxYGvIAEHSBVO1POHPk+miEqwSdNeZe8rUvJwqm3XGU4qp1iFI8Qms
 fK7Q==
X-Gm-Message-State: AOAM533yhaLAv9tVkXR4IRQXL6W6cfbRbuV0Hv/SeaAhdCPGE5rmGd8b
 mjIVzYPoY4U8K4lwgZgwUC4=
X-Google-Smtp-Source: ABdhPJxYaLi0RINbrIRdP5TsznW0+Cz9QKPd6k9Ub7/xpKpvLhrvV1bJEhHyyYSJXu2n5kc+S54JDg==
X-Received: by 2002:aa7:c948:: with SMTP id h8mr16380850edt.171.1603735938982; 
 Mon, 26 Oct 2020 11:12:18 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id hb6sm6354318ejb.65.2020.10.26.11.12.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2020 11:12:18 -0700 (PDT)
Subject: Re: [PATCH 06/15] lm32: remove bios_name
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20201026143028.3034018-1-pbonzini@redhat.com>
 <20201026143028.3034018-7-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <083ba247-f06b-354b-1d66-5f60769eabb8@amsat.org>
Date: Mon, 26 Oct 2020 19:12:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201026143028.3034018-7-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x544.google.com
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
Cc: Michael Walle <michael@walle.cc>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/26/20 3:30 PM, Paolo Bonzini wrote:
> Cc: Michael Walle <michael@walle.cc>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/lm32/milkymist.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/hw/lm32/milkymist.c b/hw/lm32/milkymist.c
> index 9f8fe9fef1..c5d3d77a2b 100644
> --- a/hw/lm32/milkymist.c
> +++ b/hw/lm32/milkymist.c
> @@ -108,6 +108,7 @@ static void
>   milkymist_init(MachineState *machine)
>   {
>       MachineClass *mc = MACHINE_GET_CLASS(machine);
> +    const char *bios_name = machine->firmware ? BIOS_FILENAME:

Does that build?

>       const char *kernel_filename = machine->kernel_filename;
>       const char *kernel_cmdline = machine->kernel_cmdline;
>       const char *initrd_filename = machine->initrd_filename;
> @@ -162,9 +163,6 @@ milkymist_init(MachineState *machine)
>       }
>   
>       /* load bios rom */
> -    if (bios_name == NULL) {
> -        bios_name = BIOS_FILENAME;
> -    }
>       bios_filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
>   
>       if (bios_filename) {
> 


