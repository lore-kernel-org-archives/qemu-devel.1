Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87E4C00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 03:45:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D4842070A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 03:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ydW1ICm4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D4842070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip2Ho-0002iT-HM
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 22:45:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47402)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2Go-0001z4-5T
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:44:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2Gm-0001Uz-5a
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:44:33 -0500
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:38615)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ip2Gl-0001TD-V3
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:44:32 -0500
Received: by mail-pj1-x1042.google.com with SMTP id l35so469262pje.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 19:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=t9nsho0Y4J3wU6LI4fcqMlN7D6a6PFi25xdf9ScGT/s=;
 b=ydW1ICm4QmEBVlMm9uu9G704okVm2bGGtE05iQRs7PEcuPSbgEcuEa8IXlP8/GS1Yb
 2BhnzvP8RwBgvgMbzxWltQNq+1Rd25oFo7bcOabF4awl5g2lX3r3C+Se2B8vo0j6qN5q
 L+XplDC5lvk9N9FBBiRxiknS91v4BYhaZt96l0sGD+/qyfnTublUMYm9c9gKZ/stY2G+
 PNBdQAZ0v9AzHYWfr2NBh43ZiP5RFfHCOKQRQ5BC4wKY1VMW87Xg0nhPZK+hvfdHNjjW
 CxvtxFYqMM07nVY+Pbk8MR2DONvYXOpLrEqaU1MH6oFlBJ1uA8z9LaWsaSPzdFd7VK7A
 QRaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=t9nsho0Y4J3wU6LI4fcqMlN7D6a6PFi25xdf9ScGT/s=;
 b=HjGQtQbrMcNOAycu+N5EOQ7CP/O5CLepSVZgbFdkUo5QiF0SZJaLqKZTe3FJibYMVh
 nfNuX4uLDmk/Kmja2J+8y/CG7g1WPd+wrzB45MXWh2rBh4ynX3Ow6XQ90exw4CCidsEM
 ZCpQMZuSgGu7dZsWKSUKR08KEJYGSHPHw3faxMhhQqLHjBEEjmvc2AxthYFX5/mv2mYZ
 ttcoET/iLRwY1LFnr2+qITnVvxt0ZcplvHihblvN9Arney3U7fqmAvXfCJyZeieOggtO
 j9n8sGEifTN33GZd9SKiyI+zalRNMx0H6i1spRQVfQcpnDudhKCu3o+wxn6rvXkt1eqO
 9LBA==
X-Gm-Message-State: APjAAAVQ7oN/uFZXgma+LMK3SUlVcTKxW7MPjN/MxDH7iKumtll0k41a
 7j0CtIMe28BRmsz6NJtV8WQFpw==
X-Google-Smtp-Source: APXvYqyvQLIbI/uDDoS3sAPsl1GQVMKUw8wdunn8lOO3UUFOef8j6mPhwG6Hvg6WYYOloRYjpWo0lQ==
X-Received: by 2002:a17:902:59cd:: with SMTP id
 d13mr3274960plj.146.1578455070625; 
 Tue, 07 Jan 2020 19:44:30 -0800 (PST)
Received: from [192.168.15.12] (alanje.lnk.telstra.net. [120.151.179.201])
 by smtp.gmail.com with ESMTPSA id j9sm1124255pff.6.2020.01.07.19.44.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2020 19:44:29 -0800 (PST)
Subject: Re: [PATCH v2] nbd: fix uninitialized variable warning
To: pannengyuan@huawei.com, eblake@redhat.com
References: <20200108025132.46956-1-pannengyuan@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f26f8785-9523-c37a-17bf-74c65faac85d@linaro.org>
Date: Wed, 8 Jan 2020 13:44:24 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200108025132.46956-1-pannengyuan@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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
Cc: qemu-trivial@nongnu.org, Euler Robot <euler.robot@huawei.com>,
 zhang.zhanghailiang@huawei.com, qemu-block@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/8/20 12:51 PM, pannengyuan@huawei.com wrote:
> From: Pan Nengyuan <pannengyuan@huawei.com>
> 
> Fixes:
> /mnt/sdb/qemu/nbd/server.c: In function 'nbd_handle_request':
> /mnt/sdb/qemu/nbd/server.c:2313:9: error: 'ret' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>      int ret;
> 
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> ---
> Changes v2 to v1:
> - change 'if(client->export_meta.bitmap)' into 'else' to fix uninitialized warning and clean up pointless code (suggested by Eric Blake)
> ---
>  nbd/server.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

