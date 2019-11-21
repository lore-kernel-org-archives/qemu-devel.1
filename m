Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58814C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 12:06:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 225A620855
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 12:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="od6R9XHn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 225A620855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXlEF-0001OS-7q
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 07:06:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37412)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iXlCn-0008Vw-6d
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 07:05:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iXlCm-0007qI-2j
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 07:05:00 -0500
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:38105)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iXlCl-0007pu-S1
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 07:05:00 -0500
Received: by mail-il1-x141.google.com with SMTP id u17so3012537ilq.5
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 04:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=i7HCJorl23pNbxxgf8KYDfR2k9rJ+ABzj44MlG/OcTo=;
 b=od6R9XHnnuRjbCnJKizs5X1PnAS47mJq0W7GM55qNm7vPJHG4vw8OqsgAcBVslNGuy
 di98k8Z80xSG4EBkk22dGAULy8ik+pIbCviXaPeRt37G6jeNAkU2ky6wgNFZBP4eC1rv
 TjUDSwiFX0woT75u1cALLvxWcN64m0RWwrWlueJtNmlp+lV7grZP9Q7vBwpctQRKNewp
 PkGk//TpyzgeEMKIvJZcCQ4mgfLcOjAphyWbmlLdLS+xiqYsVhNcVYUg1gL+LzMw6RUX
 FnqZwJ9ziqZunBruhvWROtWuvTqMogzFDjN4RtjufgLZUoAotSxd7QH7Uo8qiKZHK1Ad
 QQlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=i7HCJorl23pNbxxgf8KYDfR2k9rJ+ABzj44MlG/OcTo=;
 b=hd4uFSutDZBE6caCkvlBgQDGjwOCJcfJ0L9SgUWYtbtJMYy9fZeOMh0KaRvpcAi/zk
 GJpTwywpXuitSfrBXFZh0SLhGrjmU25LCHwT5HIO6Nk/0fu5OTbf+OfbUoHA4UteVqMr
 I6XE01Clo5PF7xMmBrVVPEqiMfb5MAB3EJlzpek4Bp4lYCMiZKRbD2O2p1UEnQK/Zkh4
 OZJPprRUhnU2C60E8/cO/++uEiTEKnQuePMRo4hRfGMX6ZYkI3FzY7gOCxzBzGRhcync
 UqNG7fOkCRRw+nokxNKrxwH+vCZtZ8tzvi0uLGNYQALiwktK8RoefYdER7BbXcs3kTpU
 o4xQ==
X-Gm-Message-State: APjAAAUv9jQg0xsNuAjFTJossTm3c9nzT3/WzqiWwnaok6+J0c/9qfRd
 Tg7pXdyInzgdwbX+zIRp9IQb8ezeyXdMOA==
X-Google-Smtp-Source: APXvYqxKXQ+uhnSnk7jIL9l5HluIsjLK8v3o4abPPOlQptMmJfMtMwl8c9PCWOwcyRKnttYmI8/ikw==
X-Received: by 2002:a92:9a17:: with SMTP id t23mr9757392ili.40.1574337899105; 
 Thu, 21 Nov 2019 04:04:59 -0800 (PST)
Received: from [192.168.44.35] ([172.58.139.152])
 by smtp.gmail.com with ESMTPSA id l63sm810544ioa.19.2019.11.21.04.04.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 21 Nov 2019 04:04:58 -0800 (PST)
Subject: Re: [PATCH v2] linux-user/strace: Add missing signal strings
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
References: <20191120145555.GA15154@ls3530.fritz.box>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <17b6f4ce-5d71-9ab8-ffc6-f2ab0109e8a7@linaro.org>
Date: Thu, 21 Nov 2019 13:04:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191120145555.GA15154@ls3530.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::141
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/20/19 3:55 PM, Helge Deller wrote:
> Add the textual representations of some missing target signals.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

