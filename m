Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3611AECE58C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 21:18:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02C7620867
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 21:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="T89o6JQz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02C7620867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHaOW-0005EI-2u
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 17:18:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44510)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jimw@sifive.com>) id 1iHaNI-0004cQ-Vh
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 17:17:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jimw@sifive.com>) id 1iHaNH-000778-HE
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 17:17:00 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:37666)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jimw@sifive.com>) id 1iHaNH-00076s-9o
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 17:16:59 -0400
Received: by mail-pl1-x642.google.com with SMTP id u20so7447262plq.4
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2019 14:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=katVuAhmvu3Pqz8FzvCmsgKw4pFmRYZqkjKzNJMiDk4=;
 b=T89o6JQzfrEXYci73vfjDrZR3JC/Ex39CXExTn5KMc2sdEirUiRO0Fg3z3JXE2Xtdj
 E/hceRjJoU1ejAZ5j/U3qpXXQm9SE6Nlz7rSCc260afl8nzuMoIxnWSIxlaE7gR8boSc
 ush0g7yRZed5XhTJwosBnMgqwBnAR5bjowpgN3djum3KUQh13NVyK1WZhIhtmkPSBwzz
 YPCW5JfwcPycNE+ifVSRSosm0cx15A11I3CltM16hRgoXEYpy/dTTN+X6NpHTkgTqViC
 xiXr/5lJNflNvi40BObiHve6OtJO2VSga9tXHfhAjuCODtvsDKEhhxFEH88jMj//OPOz
 tMfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=katVuAhmvu3Pqz8FzvCmsgKw4pFmRYZqkjKzNJMiDk4=;
 b=j5MwXvapEcJD+djsFfoo222DTOgADCcc6u9eZ9iZV24kbxmkbqZze+hOQNrcvxSsQI
 yxyoYSmt3qAXPKoUY9c9LpZkVXiFcIwUIiq7r20TolEanehbWFGkUbq8yQ8gSrlPIHWF
 Ff5GadOzP7oAGFyMvCkQ/qDlGH8v0ACTjDIi3KOPNtyGmpSzidr8QLvepred+m4U/S88
 zt0E2JQJ9/IQp7yV1qxgc9g1tW+6qU9v85xWLffQrggFkfDPJN8AGb811Inw8vsw64aK
 TygBMA8nHzGN7qPGWFJv0cP6wZBlXSB42ZwbfLTn+14IfGx4jFWbIv6srOedYqLM8RQP
 obDg==
X-Gm-Message-State: APjAAAVIkgvJiGpwxbqTRgHL3dBTdpXBbjSFMcRjln51aFT4Z1mfvOis
 GcexscLa0IAUkzpwen8KAfTy2g==
X-Google-Smtp-Source: APXvYqxB5uFnrbRYoagnAAjyIWQlPDUydyA30pUIijwPVWm3itxc1CUbaJf1fgNJucQgjWEBlbQbfA==
X-Received: by 2002:a17:902:ff08:: with SMTP id
 f8mr22768763plj.309.1570483017954; 
 Mon, 07 Oct 2019 14:16:57 -0700 (PDT)
Received: from [10.17.0.102] ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id i74sm19200018pfe.28.2019.10.07.14.16.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 07 Oct 2019 14:16:57 -0700 (PDT)
Subject: Re: [PATCH v2] target/riscv: Expose "priv" register for GDB
To: Jonathan Behrens <jonathan@fintelia.io>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <20191004151614.81516-1-jonathan@fintelia.io>
From: Jim Wilson <jimw@sifive.com>
Message-ID: <5393a150-71b6-a729-7530-a50df05353bd@sifive.com>
Date: Mon, 7 Oct 2019 14:16:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191004151614.81516-1-jonathan@fintelia.io>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Palmer Dabbelt <palmer@sifive.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/4/19 8:16 AM, Jonathan Behrens wrote:
> diff --git a/gdb-xml/riscv-32bit-cpu.xml b/gdb-xml/riscv-32bit-cpu.xml
> index 0d07aaec85..d6d76aafd8 100644
> --- a/gdb-xml/riscv-32bit-cpu.xml
> +++ b/gdb-xml/riscv-32bit-cpu.xml
> @@ -44,4 +44,5 @@
>     <reg name="t5" bitsize="32" type="int"/>
>     <reg name="t6" bitsize="32" type="int"/>
>     <reg name="pc" bitsize="32" type="code_ptr"/>
> +  <reg name="priv" bitsize="32" type="int"/>
>   </feature>

Adding this to the cpu register set means that the gdb "info registers" 
command will now list a value for the mysterious undocumented "priv" 
register.  That is likely to result in user confusion, and a few gdb bug 
reports.

Gdb incidentally already has support for a virtual priv register.  From 
gdb/riscv-tdep.c:

static const struct riscv_register_feature riscv_virtual_feature =
{
  "org.gnu.gdb.riscv.virtual",
  {
    { RISCV_PRIV_REGNUM, { "priv" }, false }
  }
};

So the correct way to fix this is to add a 
gdb-xml/riscv-32bit-virtual.xml file, along with code to handle this new 
xml file and the registers in it.  Likewise for the 64-bit support.

The main advantage of doing things this way is that only people that 
care about the priv register will see it, and this will interoperate 
with other RISC-V debuggers and targets (if any) that already have 
virtual priv register support.

Jim

