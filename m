Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1726ECE58C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 14:16:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CFAC206BB
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 14:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Blht6MNz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CFAC206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHTo3-00062z-NC
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 10:16:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38420)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iHTn4-0005Px-GZ
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 10:15:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iHTn3-0004IB-H7
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 10:15:10 -0400
Received: from mail-yw1-xc43.google.com ([2607:f8b0:4864:20::c43]:38719)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iHTn3-0004I4-CO
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 10:15:09 -0400
Received: by mail-yw1-xc43.google.com with SMTP id s6so5162538ywe.5
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2019 07:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=KRgBJxZK6iBuT/CcMbiDw89iBtp15koM2kwiNVbKbXI=;
 b=Blht6MNzjupd2wjA8M2Uzlk/eL2n8lqg6xeaAglWnCRkl/67mDvRUeFMi+EJliJAtX
 UVMFnvZ3jsTyNrWbgsCzmWlHbgjBGa2wALWQZ3nu+oXoMRi6s7QJ+MYPAkHfYKUF4wE+
 gSjazYV3FKMShG80BzyRPyKfj51R8SrgFAc9qMM1CAG1dKBNq7uU+DVqNxyhaeX8pDpw
 mT3i3bddrC9dSipRKwXPJU0JzrodMuxnTWnXGJrbdO06GV7ISow8SbPMuNgjBN1u/zw5
 oq0ckSdw9vFxF3KlgZ6pY/4XJpawz94zFrHUZXT3Ugl/0FS0XEXVvrw0IqfQ6etRSA/H
 xwSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KRgBJxZK6iBuT/CcMbiDw89iBtp15koM2kwiNVbKbXI=;
 b=Twu6F/zcd1R9tX7n9Y3Km8IlD+Us431naYJs1ivMsU+63DgV8wFvxRr5QOE2VXRV3+
 RXBST66rb95VRqF2nofiYQ+Cf7GFFn4Ec51ZPum6V8FtKduTqiaRKlLIdySEhh24eVrU
 bQh0obbo6uCzl5+OBtEYrBZXRmyfoXLw4e9FsA3Aw9K7oCzZqlsfKD7BvSvkXX4zMXJ2
 aIr5Mdw6USL/Rk36dB00dXokTBzX74C1WjpCAlncMD1EQW7UhqXSySmmQAkg3uCsq2S4
 5r99dygRcNLQpcbti5h+d4/9J2ezns8zSekvIqc6iTa8zjQwNunlFJ9AL342Z0imt9Ql
 6Gow==
X-Gm-Message-State: APjAAAWa6yS367TYivFYfj9G7JHjWydAucb/YsxEHMmbFkFVtOLkXo8g
 YaPjIQ6AAXjVFEGWQH539Oxvqw==
X-Google-Smtp-Source: APXvYqwXWYxIrxHayNdUv/4cVr7d0Y/MFUcC3ITtz4dUddTzngC6czuB4SjZCyHCkgmdfGzi3Oy4aw==
X-Received: by 2002:a81:3c81:: with SMTP id
 j123mr19838806ywa.393.1570457708770; 
 Mon, 07 Oct 2019 07:15:08 -0700 (PDT)
Received: from [192.168.1.44] (67.216.144.16.pool.hargray.net. [67.216.144.16])
 by smtp.gmail.com with ESMTPSA id u69sm4108700ywu.93.2019.10.07.07.15.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 07 Oct 2019 07:15:08 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH v2 07/15] target/arm/arm-semi: Factor out
 implementation of SYS_CLOSE
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190916141544.17540-1-peter.maydell@linaro.org>
 <20190916141544.17540-8-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <9c71ae7c-fed1-d48c-2114-30177511246d@linaro.org>
Date: Mon, 7 Oct 2019 10:15:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190916141544.17540-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c43
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/16/19 7:15 AM, Peter Maydell wrote:
> Currently for the semihosting calls which take a file descriptor
> (SYS_CLOSE, SYS_WRITE, SYS_READ, SYS_ISTTY, SYS_SEEK, SYS_FLEN)
> we have effectively two implementations, one for real host files
> and one for when we indirect via the gdbstub. We want to add a
> third one to deal with the magic :semihosting-features file.
> 
> Instead of having a three-way if statement in each of these
> cases, factor out the implementation of the calls to separate
> functions which we dispatch to via function pointers selected
> via the GuestFDType for the guest fd.
> 
> In this commit, we set up the framework for the dispatch,
> and convert the SYS_CLOSE call to use it.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/arm-semi.c | 44 ++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 37 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


