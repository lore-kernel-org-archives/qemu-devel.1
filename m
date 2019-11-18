Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72547C43215
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 08:12:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4269A2084C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 08:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iGntKKhw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4269A2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWc8v-0007MS-E2
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 03:12:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48606)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iWc7g-0006uJ-0Z
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 03:11:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iWc7f-0000rJ-0f
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 03:10:59 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45765)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iWc7e-0000q3-Pb
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 03:10:58 -0500
Received: by mail-wr1-x441.google.com with SMTP id z10so18208034wrs.12
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 00:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=kvt/HK84Ww3jt/sKiCLq5XZan5ng1buJr/Jl9DyAlVY=;
 b=iGntKKhwbmtJnU0xcLag3RgVSSv8Zf1FN7GyINK4zi2wDT3rptKPjI1HtM7m1GJtmf
 u5LqfDQ9Nv31BRDpqb4tlY5eEEzAGJJ9P7/iFoigcjQjZqsOedmPWSq/21B7zCtFbiRi
 sxjySFhm2/Oc5PCUuyVaWiCDTjjycANimpvWt/BWfbs55WToS06TZJvIlGoyXHwkqe09
 0266V8iF57n2/riKczNymI4oxIZy2Nmw11dTO160axgMpb2GEmrm7JIXD+zOYu3V9I4D
 m2QBQzXHeEPGH9SvjmO2HtBS4rZdq41tTc5o2128/Tlqq2GHinn3Ctd/HqT6GF7oaQWa
 J6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kvt/HK84Ww3jt/sKiCLq5XZan5ng1buJr/Jl9DyAlVY=;
 b=h3/oTlgJdZBnnluzhJVj1JS/TIXur4MfWovxeTUOtfV+UO4PuBGuwtQ4QU1S5cQbSO
 UJKqXMaYpE+yCzNnjlvshFjX+ZfkHIqSvUAXxRmgFDEugQicOj6mwdNVjGx4Z1lxp87j
 fqVE8Xiw8mPNpw7l+jgQlVpwnQz6gX+yQJ/hz3hN9L5KMkapnn9aKjSPzPqRrkNKR5Z8
 lOur7izNlAPfSf2tDy1r2RC8DxWlUdBGRxKtMwqVFtVga/qhv6T84S4iKFCi6Y8CmyFB
 di+MK677vrBJPrZEd62RybjqJ32n9lVbPzXtv3FDdthnl2SoLlm1mrZDOt29ZIUXV87W
 jBwA==
X-Gm-Message-State: APjAAAXjRCHwmJLeZef9/k7T/YO3wWpO4+yIGwDaXesRZdBUQcS31YVy
 ryW7xdWyKyR3JOsF1LT3reW1VA==
X-Google-Smtp-Source: APXvYqxW2qLOxadYdAhbmtyDLDHervnaaAsv/+j98e/g12SNrz1zU/hh4piF1hSjDgcGif8qzcRw5w==
X-Received: by 2002:adf:de86:: with SMTP id w6mr28323612wrl.220.1574064657636; 
 Mon, 18 Nov 2019 00:10:57 -0800 (PST)
Received: from [192.168.8.102] (65.red-79-149-41.dynamicip.rima-tde.net.
 [79.149.41.65])
 by smtp.gmail.com with ESMTPSA id d7sm22552371wrx.11.2019.11.18.00.10.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 18 Nov 2019 00:10:57 -0800 (PST)
Subject: Re: [RFC PATCH 04/11] gdbstub: move mem_buf to GDBState and use
 GByteArray
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191115173000.21891-1-alex.bennee@linaro.org>
 <20191115173000.21891-5-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <68cd7b1a-310b-62f8-36e6-0d93a8daf9a8@linaro.org>
Date: Mon, 18 Nov 2019 09:10:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191115173000.21891-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: damien.hedde@greensocs.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 luis.machado@linaro.org, alan.hayward@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/15/19 6:29 PM, Alex Bennée wrote:
> This is in preparation for further re-factoring of the register API
> with the rest of the code. Theoretically the read register function
> could overwrite the MAX_PACKET_LENGTH buffer although currently all
> registers are well within the size range.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  gdbstub.c | 52 +++++++++++++++++++++++++++++++---------------------
>  1 file changed, 31 insertions(+), 21 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

