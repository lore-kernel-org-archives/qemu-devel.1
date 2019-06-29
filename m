Return-Path: <SRS0=rHaa=U4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0011CC4321A
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2019 14:41:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B56422075B
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2019 14:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="steS/+cr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B56422075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhEXw-0007Cg-GZ
	for qemu-devel@archiver.kernel.org; Sat, 29 Jun 2019 10:41:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60596)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hhEWn-0006hy-2P
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 10:40:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hhEWl-0005sN-50
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 10:40:33 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33634)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hhEWk-0005r5-UC
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 10:40:31 -0400
Received: by mail-wr1-x444.google.com with SMTP id n9so9194942wru.0
 for <qemu-devel@nongnu.org>; Sat, 29 Jun 2019 07:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:openpgp:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iMHIumVRvoVn7VJYnBzlz0yuwsNk+c26EI4iSaOI2o0=;
 b=steS/+crJhZRKaCP21btdKOq4nyEwlItMqxr8cvUXRVQUPQyegdpI8SDlrxiVL631W
 ZGKR4wbD1qvun5HjFBGwkdovgmEvtR0UobvPlMLFT/vCh4dIZHaTKmdJBlhmbBStco/V
 LDF70V+q+cWHRSueKwGwah9v9/9232dIbG00FGRobQYlryuwhSPGxv71o6Bvigtd7hZ2
 kLLPG6yoEK51HX8QMpyBczZWmD/6yR1lZk8IzExJZVZuOuvTYBCQUUCeDGPA4XpYA+1/
 0A/zDvNyAup00i+vCaYwvFrENFMzLpsJbkUExXglXpfUZJPxvDIK3G7Glk36jfumsHEJ
 DU9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=iMHIumVRvoVn7VJYnBzlz0yuwsNk+c26EI4iSaOI2o0=;
 b=trKDpe6o75HtCZB6udABYxBhWwxydslGtXLPcRKWY3bHWZohvYT8KGr/a2j0U19fKx
 PyKlQjaByML/8gYBYQpJwWP/R9iBFhqp5wrrFrHp6me4nVzKo8dkGaz6KwohmQbNyWLS
 Ukq437hMNL8u5QuSEc84M+roh0SB0H/e/1Q7ga7Z/CqFjj2RW/rc2wnuuLH3KlRroGJg
 wYIB6psudcaoSLShWRIOVj7o0lJ9QqCFOY8tv5eHIl5a9LPpAtkKwjD67ttDrr0GRsIE
 siLh3MSQzimAf/KAf4NvUSWY5EXGKJuKDN+8jgN44ZOf/BoHMZo80WciCeeq1WoKHffC
 k7IA==
X-Gm-Message-State: APjAAAV4teaOIwjL+YMm1ydYEbrtzHeRi4KRb4Fym/BwX34MZ3ClbYhC
 EbpV3dcMlVSo0y9QPjkI8uY=
X-Google-Smtp-Source: APXvYqwyne8jSztdWPRiflydOShGTqpq54BMq4ctxlpHPUj/NJAtjhOT2HcVESZ3bdoEv1AgI5JXDw==
X-Received: by 2002:a5d:528d:: with SMTP id c13mr11853940wrv.247.1561819228663; 
 Sat, 29 Jun 2019 07:40:28 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id v4sm5096511wmg.22.2019.06.29.07.40.27
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Sat, 29 Jun 2019 07:40:27 -0700 (PDT)
To: Thomas Huth <huth@tuxfamily.org>, qemu-devel@nongnu.org
References: <20190628181536.13729-1-huth@tuxfamily.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Openpgp: url=http://pgp.mit.edu/pks/lookup?op=get&search=0xE3E32C2CDEADC0DE
Message-ID: <f5c2d6f7-c6a7-3c90-1043-14353bfe57dd@amsat.org>
Date: Sat, 29 Jun 2019 16:40:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190628181536.13729-1-huth@tuxfamily.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH v2 0/4] m68k: Add basic support for the
 NeXTcube machine
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/28/19 8:15 PM, Thomas Huth wrote:
> Bryce apparently never got around to work on this again, so I'll have
> another try now ...
> 
> During Google Summer of Code 2011, Bryce Lanham added the possibility to
> emulate the NeXTcube machine in QEMU, e.g. see this URL for some details:
> 
> https://wiki.qemu.org/Google_Summer_of_Code_2011#NeXT_machines_system_emulation

I'm not sure you used the correct URL, the GSoC entry is not very
useful. I found this one more helpful (v1):
https://lists.gnu.org/archive/html/qemu-devel/2011-08/msg02158.html

> But since the machine requires a 68040 CPU and this was not included in
> upstream QEMU in 2011 yet, the patches have never been merged to upstream.
> 
> Then, during the last years, Laurent completed the full 680x0 support in
> upstream QEMU, so we could finally merge the NeXTcube support, too.
> 
> The QEMU interfaces changed a lot since 2011, so I had to modify the
> sources quite a bit, but with the attached patches, it is now possible
> to boot up to the firmware monitor again.
> 
> Note that boot device emulation is either still missing (network and SCSI),
> so you can not boot any operating systems with this machine yet. I have
> the patches for these devices in my brach here:
> 
>  https://gitlab.com/huth/qemu/commits/next-cube
> 
> ... but they are not quite working yet, so I'll submit them later once
> they have been fixed and the basic support patches of this series have
> been merged.
> 
> v2:
>  - Don't use memory_region_allocate_system_memory() for the framebuffer
>    device anymore
>  - Turn the keyboard device into a proper QOM device
>  - Put the global variables in the third patch into the machine state
>    structure
>  - Got rid of the "//" C++ comments

