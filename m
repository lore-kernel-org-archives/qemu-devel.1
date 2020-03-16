Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082A2C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:40:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C01A720679
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tKap6BSH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C01A720679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDufA-0005R0-SM
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 14:40:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50326)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jDue5-0003gG-AW
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:39:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jDue4-0008IH-5a
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:39:25 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:38136)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jDue3-0008AA-Up
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:39:24 -0400
Received: by mail-pf1-x441.google.com with SMTP id z5so10437946pfn.5
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 11:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=0wzF9vMw6f5nTA/Nbg/JR2KLmEi6Uo/vA08JyDqlmF4=;
 b=tKap6BSHPxRtzWRQRyVvCdrETNrZp2ygGeaeTj6FDjUZbBgmgGMmwCsCAuXIFrbTRN
 JvZQGtEuHrBCGXggxB2tWUanWg8Ms56qzMsNRpYi6kOAD80LFoI7Nyj0PilkSmfVsWCn
 NTb9J7AW8P5dNW+VopS7GoO+Ki2QGvVxGIDeJpm8rJHIAD6rPG3/gSLfE9jyjsTRPS9V
 lF2B1jhqKE3eGZ9ilSWvo2KexcqmZeZAvbKSyFUjl6ku6c/EBNrIN2Tmi1T9bI05ulU3
 M3BDU2+iCxvG6xmNDBlHMknRAzzyJJO20pzc5Lx93Hq4/XrC0LWqF4eSZJpSPa0PmVbr
 hEIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0wzF9vMw6f5nTA/Nbg/JR2KLmEi6Uo/vA08JyDqlmF4=;
 b=cr0/uAeSSrCX8m6mWFetUvucCMygNVJA8sH4hqX9lUu6IzdGGNwtZzuyk4wvgibUb8
 EIAU7TqyTL3VLnxaN0h5cCpVm0QBjvlcgGYnI9ILje6ZsJuCsYOvftevDX3YJhFYsuVu
 9YNC86Q3+Q+/BN+AyZRoIIr36tJ2qMoriaUpH2NViYKwXscgkK/dZO7FnAaq1ualasRi
 EzU13GzqerUh0lDasYNiYLEGirmNfCMqqqsXrSTgv65XhpXSjFH1FctX2IZO822pwSL5
 2lXihzHx9G+MaX1blFnNkED/Y7HWsAIXdga8Bpsc0oaVDF861TsWGwdtDJViN+2ssRB0
 o2hw==
X-Gm-Message-State: ANhLgQ3ItygKM3WB/jBOXlPwTKdzKwNFx745mi8vZQqwqH6YCS3Qnp84
 X5j2PjkH1L/z+SkZa0PQj9h/jA==
X-Google-Smtp-Source: ADFU+vvI2Y6xc+RlFRfAKmwOg7f9fSD6QgJ22FPdcwwaT2J+dabkZbBsCENcoUFBy9Hks+WxK1X7hA==
X-Received: by 2002:a63:5d04:: with SMTP id r4mr1095296pgb.241.1584383962897; 
 Mon, 16 Mar 2020 11:39:22 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 d6sm453479pjz.39.2020.03.16.11.39.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2020 11:39:22 -0700 (PDT)
Subject: Re: [PATCH v2 2/9] hw/core/qdev-properties: Use qemu_strtoul() in
 set_pci_host_devaddr()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200316001111.31004-1-philmd@redhat.com>
 <20200316001111.31004-3-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <862623fe-1c15-8e51-67b8-c4477e37d1ab@linaro.org>
Date: Mon, 16 Mar 2020 11:39:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200316001111.31004-3-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/15/20 5:11 PM, Philippe Mathieu-Daudé wrote:
> Replace strtoul() by qemu_strtoul() so checkpatch.pl won't
> complain if we move this code later. Increase the slot and
> func local variables to unsigned long so that the range check
> isn't truncated. Remove the 'e == p' test which is done in
> check_strtox_error(), called by qemu_strtoul().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> v2: drop the e == p test, do not do modify range check (rth)
> ---
>  hw/core/qdev-properties.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

