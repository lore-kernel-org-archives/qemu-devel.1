Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CAC2C52D4E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 14:03:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC8D121D7E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 14:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rOIYDx9S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC8D121D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7JlD-0005mt-V1
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 09:03:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41777)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7Jju-0003l1-2b
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:02:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7Jjt-0001U0-18
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:02:09 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:38600)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7Jjs-0001Tg-SN
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:02:08 -0500
Received: by mail-ot1-x341.google.com with SMTP id z9so2978539oth.5
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 06:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=22KaIear6xIEnGroBWg6UeeMh91yrfJHfWiBXjHZB9o=;
 b=rOIYDx9S/h1v2rkP/VhRrprXyDmrecYpHWndwnDSEXji1FNHQ8cryHdsTXbLDNJDsY
 BFNELhwYryobH0FaoqtYVTcWNkDessK+27LJylu90IFYJZ1jxNj0hARsjFC9XqJLg/Xt
 tsoacFGTtgb5fsMwThQ+G5EoEhhy+pJmp3vJgvGRsvU8OPBSKvV7d9xnb1jXvYY6gKAf
 rfbl2olcYHlWOK89OvY7aE71yyJPYM0h2QWF9dnyCpH0UUTl/KPtk9TkJIFZuNeNk4EC
 +Fmi7W6wPXS1huJttRBfS/e2NRHVK7fsBT2nkODmDjyqT7UUBWJrGjokrPcvQuzKdsBG
 RYYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=22KaIear6xIEnGroBWg6UeeMh91yrfJHfWiBXjHZB9o=;
 b=I5a7e6HhM6gGwu1/GwA2WcDNzk9oTHgDpr/ISjxoEAmsCdUIcnSu3/Sw9NCiU9nlLN
 tAec5vNsc9i85xSbnPmKqcWj1s4gkGnsTIdYS726spXN54wsMPj5oFBv7qV5TEJU3g6F
 GVxDv7pkaTYsbawmBXIIHHac7w2Y+Of66M2p8wubefAP46aijhniFm+M3LjFAk7IoLqr
 IMxWP4cuB0rcZq5Z6DgnpTyXSbUM35T/nLGV309yRYf3nZ0Vkxknl5HtcoSHvUQHOhhU
 Bf3hLQZuVLLvbyzUlB0TDgQ5pkOc5cqV9PSLoIxHfdHJGN3mP920QtzUruk2wzhrB4jT
 sQiw==
X-Gm-Message-State: APjAAAUiperDvaFJqEB4bO6FDa33XZYdVzqgb6CPSvcAiiP+5Md5uNfs
 OGERrXnMDsy7UzSL8j7CKgo2BYtlTc0B2F5QzUeDwg==
X-Google-Smtp-Source: APXvYqxtsEhy6e2vN2yURHT3lZrBK2iEY+BSQt8n0WKBKksE8wYH+WXX+DJGv8WQpbYUCiX1vASL+PI99KzLxxIkaxM=
X-Received: by 2002:a05:6830:1184:: with SMTP id
 u4mr3241402otq.221.1582812127592; 
 Thu, 27 Feb 2020 06:02:07 -0800 (PST)
MIME-Version: 1.0
References: <20200226113034.6741-1-pbonzini@redhat.com>
 <20200226113034.6741-15-pbonzini@redhat.com>
In-Reply-To: <20200226113034.6741-15-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Feb 2020 14:01:56 +0000
Message-ID: <CAFEAcA8Ts30UXsexhTgaEFTDV06nV6SrZsLjpayH1PNFd=f+Bg@mail.gmail.com>
Subject: Re: [PATCH 14/18] docs/system: Convert qemu-cpu-models.texi to rST
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Kashyap Chamarthy <kchamart@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 26 Feb 2020 at 11:30, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> From: Kashyap Chamarthy <kchamart@redhat.com>
>
> This doc was originally written by Daniel P. Berrang=C3=A9
> <berrange@redhat.com>, introduced via commit[1]: 2544e9e4aa (docs: add
> guidance on configuring CPU models for x86, 2018-06-27).

> diff --git a/docs/system/defs.rst.inc b/docs/system/defs.rst.inc
> new file mode 100644
> index 0000000000..bf50b442b2
> --- /dev/null
> +++ b/docs/system/defs.rst.inc
> @@ -0,0 +1,2 @@
> +.. |qemu_system| replace:: ``qemu-system-x86_64``
> +.. |qemu_system_x86| replace:: ``qemu_system_x86``

Just noticed that you define qemu_system_x86 but never use it.

thanks
-- PMM

