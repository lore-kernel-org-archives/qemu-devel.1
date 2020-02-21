Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40111C11D00
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 00:09:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AC412071E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 00:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aESKIlG1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AC412071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4vsn-0007Ad-8A
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 19:09:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60803)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <changbin.du@gmail.com>) id 1j4vry-0006EJ-Ad
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 19:08:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <changbin.du@gmail.com>) id 1j4vrx-0005qS-EN
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 19:08:38 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:33842)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <changbin.du@gmail.com>)
 id 1j4vrx-0005ps-8w
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 19:08:37 -0500
Received: by mail-pf1-x444.google.com with SMTP id i6so253172pfc.1
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 16:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=GQtNGQ9Bv1cPDj4IFgA6xzvn6OmngCJCSfVzdnqFxjM=;
 b=aESKIlG1JzKlYogrq/ee2w2EOwCkXDKaRkNe0AH7cSBWTNPa3rqC1EQNOcPnlZjwGB
 sB2HIApD+CweDE+awyjo6CM9XgzjZjBzMlsUaUZUhBcvxeGdUrVPaxK1gKQIUsLOMtok
 7r8OYP1DJEZH4/cVgyOjmdfAFEpQ7xo/AdZqInyEkKt4Jx/dQS0+J/G10j5UVYvn3re/
 MaF8ggWJ51moAMEjwfR8wSGdn+faF5LUCmkQpuPTZQTJKGuYiPvY+hQ5xI05Om3JB6YL
 nVYC0wJxoq/qZ2uqpQ6G6rnHLUyXg/0asjcdCr774X8lS/3u6ryZhb5wid7O8ZIT3UD4
 MQTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=GQtNGQ9Bv1cPDj4IFgA6xzvn6OmngCJCSfVzdnqFxjM=;
 b=Jajr40DlOah87eAl5rJsDV/zXifJyERri0/moXwU2IlNnMzoMKtDNM8lnkXfzJDwhS
 3hiAOPKuXMeZj9O5s8Jz9+iBbVQm8ltRz0nNvBwQI0IVDpm36GbekX772CNNwMXQ9Ze8
 /Yjsfq0XxUlb5WwKc5BN8Zzj3mrSBHFdk3MGfzTEdIgSIUfM9UGZFjhbDw4x9PjBh5NI
 Q38/q/CVEf1OpLgM5jrWc6yjKar2dxipUVkwQm7awR7M+yUfCWBG4oRktanfAlwJheEU
 4PMcaoyaiA1u5QHbS7bJld04iMPAs1ZxNvZgT1V9jr8ElaODYaAjhXqhQagHxRYXkVsG
 uwDA==
X-Gm-Message-State: APjAAAVbHKRMMPS3GGtVx0lZme2BuLtd7LHJr762z1+rowWzZTtJkBMz
 LCIg1VaHfFPMPA7/jU5mPvI=
X-Google-Smtp-Source: APXvYqwHtEv/qyN0G+xxd0BEvCnocSkYlV8V6LBDs+MPE9e0E5Q5dBTvvbObd6O1RBkpKtCFMXAP4A==
X-Received: by 2002:a63:18d:: with SMTP id 135mr9818771pgb.32.1582243716166;
 Thu, 20 Feb 2020 16:08:36 -0800 (PST)
Received: from mail.google.com ([149.248.10.52])
 by smtp.gmail.com with ESMTPSA id q8sm686576pfs.161.2020.02.20.16.08.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2020 16:08:35 -0800 (PST)
Date: Fri, 21 Feb 2020 08:08:30 +0800
From: Changbin Du <changbin.du@gmail.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH] tcg: gdbstub: Fix single-step issue on arm target
Message-ID: <20200221000830.vj3mcjobqeb4vjpq@mail.google.com>
References: <20200220155834.21905-1-changbin.du@gmail.com>
 <269f16b4-e843-1058-4c3b-f11de45b04e1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <269f16b4-e843-1058-4c3b-f11de45b04e1@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: alex.bennee@linaro.org, qemu-devel@nongnu.org,
 Changbin Du <changbin.du@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 20, 2020 at 06:47:26PM +0100, Philippe Mathieu-Daudé wrote:
> On 2/20/20 4:58 PM, Changbin Du wrote:
> > Recently when debugging an arm32 system on qemu, I found sometimes the
> > single-step command (stepi) is not working. This can be reproduced by
> > below steps:
> >   1) start qemu-system-arm -s -S .. and wait for gdb connection.
> >   2) start gdb and connect to qemu. In my case, gdb gets a wrong value
> >      (0x60) for PC.
> >   3) After connected, type 'stepi' and expect it will stop at next ins.
> > 
> > But, it has never stopped. This because:
> >   1) We doesn't report ‘vContSupported’ feature to gdb explicitly and gdb
> >      think we do not support it. In this case, gdb use a software breakpoint
> >      to emulate single-step.
> >   2) Since gdb gets a wrong initial value of PC, then gdb inserts a
> >      breakpoint to wrong place (PC+4).
> > 
> > Since we do support ‘vContSupported’ query command, so let's tell gdb that
> > we support it.
> > 
> > Before this change, gdb send below 'Z0' packet to implement single-step:
> > gdb_handle_packet: Z0,4,4
> > 
> > After this change, gdb send "vCont;s.." which is expected:
> > gdb_handle_packet: vCont?
> > put_packet: vCont;c;C;s;S
> > gdb_handle_packet: vCont;s:p1.1;c:p1.-1
> 
> You actually fixed this for all architectures :)
> 
> This has been annoying me on MIPS since more than a year...
> 
> I haven't checked the GDB protocol spec, but so far:
> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>
Thanks for your feedback. :)

-- 
Cheers,
Changbin Du

