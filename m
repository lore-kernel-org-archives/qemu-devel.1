Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA9E0C54FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 20:55:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A33052073A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 20:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HYxBO9Io"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A33052073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRisH-0000eW-PM
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 16:55:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32918)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jRilH-0001fi-EB
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 16:47:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jRilD-0007St-IK
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 16:47:55 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:40378)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jRilD-0007RT-1f
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 16:47:51 -0400
Received: by mail-ot1-x342.google.com with SMTP id i27so8572618ota.7
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 13:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=yuRNKYOyrXq31eODqoSQA8Il9L22mdjCutxbVpqukMo=;
 b=HYxBO9IocyV36w6tRGQlKtMJmW0UhLb9qOx9X2XuLJZu2XFkDJVvo0ZgLSoknvtt6v
 wCFLvSs7lsksmQB+zEJGHDFgjzFzgu2qb2SYZritGipdlRspy3HoxEvqSki9X2PXpmET
 wvp1ke/3ovYrBMJcQx3KBbj32aYU0RgXTkAgBcIBu8dONQSBNCXm+djdSrNQq9qW0SuM
 Z9V2RYOHgJPyQrWIH4+5syBL6QDntfDPPfb4XuaNjtYX8VjhqvoSHMRY0ZWK/23Xm2xQ
 +1kuGWtKMf0aGFckBieoRIFWgWY27oIdAgxc3wAUOrPaqWVY4AogdeQ6Ay/gZaSL21uC
 KuSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=yuRNKYOyrXq31eODqoSQA8Il9L22mdjCutxbVpqukMo=;
 b=bN2yBEWs6UPG22/16sB/ovKdrna5r01A+5u9jPjdgTwz0LV+VaY/kRmVs/3RVOZRZd
 x47zfhU3bgRIDGIsB305eOVwPRGE4tIFz5CtddwizLdIRqvgG393qvdIvowl/R4bvOjE
 dzjvpJXTI8ssaYOvI/Mw5u7LLWTwTvTnoBvgP4QBU6dWvOIF3ZWBXWd04s/2hG/K1C7h
 Jq1uop4OYVEbLUxN/xeQlyuOwlRft24fvCy4cU7ECJf6oIR5GhiRutbwdFwemLFvEQUe
 UJjkeKgJIIkP3drwhxf3Y7IbmnzgYYZPZRUsMP0Cxd3Fq74nmy0E4y79MtB0sy2pOP30
 tn5A==
X-Gm-Message-State: AGi0PuaIl4/4kLNNHFurSC484H+J8wSwt0sPkz4OeKJpCa5fJjh7w7f6
 vu7Qkz/GYXccSar7OeeBfQ2ag2CTiifVb1CrtAsIFg==
X-Google-Smtp-Source: APiQypLLJB0eckpV1phYkzfJtZrxZDdfSfHj5Q1EzFGoIucRTfYxasmJHAIVrrjNWAlKc6ajxzlXo4zHSXt2Sxy7xHA=
X-Received: by 2002:aca:3441:: with SMTP id b62mr3172454oia.146.1587674869774; 
 Thu, 23 Apr 2020 13:47:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200423202011.32686-1-peter.maydell@linaro.org>
 <d9e2c1cf-30e5-a889-3e87-eed6480610ab@redhat.com>
In-Reply-To: <d9e2c1cf-30e5-a889-3e87-eed6480610ab@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Apr 2020 21:47:38 +0100
Message-ID: <CAFEAcA8XBsfZvxsjXVFbcHwcBYx3ohyfhntAKTTEWKcCw9xSCg@mail.gmail.com>
Subject: Re: [PATCH] elf_ops: Don't try to g_mapped_file_unref(NULL)
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Randy Yates <yates@ieee.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 23 Apr 2020 at 21:25, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> On 4/23/20 10:20 PM, Peter Maydell wrote:
> > This will fix the assertion; for the specific case of the generic
> > loader it will then fall back from "guess this is an ELF file" to
> > "maybe it's a uImage or a hex file" and eventually to "just load as
> > a raw data file".

> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Thanks; as a side note "let me just load this as a raw data file"
is not a very user-friendly way to report issues with the ELF
file like "seems to be truncated" or "has no program headers".
Not sure what to do about that...

thanks
-- PMM

