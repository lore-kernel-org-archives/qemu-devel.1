Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B9D3C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 08:09:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5C052072F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 08:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJ9JVcKs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5C052072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg1yn-0003ja-53
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 04:09:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jg1yD-0003I3-RM
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 04:08:25 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54080)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jg1yC-0005Dt-PE
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 04:08:25 -0400
Received: by mail-wm1-x344.google.com with SMTP id l26so1952975wme.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 01:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=wXk+kUKrtM8M+eoU+6lt8HtHguvlxEBcGGqtFLOulaQ=;
 b=TJ9JVcKsNX7iApzM38Z7JLrK4GElAekFPGlsiYEJKl0kbw9d4ii3SydbJyLgXkUUy+
 Dluza0oPQSA2AN/OqUqTZyHlsdfu3gL6YXIxSn5lL1Pcv55uDfhwdQSI6mA6IBePELru
 W2waZo8u72sgxIz65EEXUpbvZOuP427Ow4oJcpK/tctE83BE9Ho+xaCR4Den7/xOgIQw
 2+VR9SW3V6NMZrVrc41tNZbPseEUDceWbLaCQnpvTazXucQjlOmk5tIFTBzKGKRg6moD
 nHZno7mpEs0qd7Xchwl2kFSX25goR/1zgQYqgeJsqdTi+5P2QqhLpUhNuXNGhPs2D+s0
 eL3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wXk+kUKrtM8M+eoU+6lt8HtHguvlxEBcGGqtFLOulaQ=;
 b=md5zExj+ZogcJ7fVk0J8hK65M3OOP6jqnQn5GZ35gH5Hz/Mmc+CMTVDNkDKNXzWGkO
 cFKtWtd0w8HjblACFZA9TtyOp5RMZKFUZtk1CCP8G8h+rz/9uGoFE4B+3f4VCLdFl2By
 2FNe22v1lBxXQUv20PlAbPyfmdPQue7nTOrNKXvr6Q8nl+43zFrRdplcVKXYr7Are6bJ
 AJxysThjr8W5/kpGswGuLUD3fmoPkiPSDs3LKeWH5igd1q48tu5D3RNYcwX9b0oX+4qQ
 MkO+1UGAggdxXw3MJGRTBdaJsmob/jlKQNXdnizK31CE6X0MO4lmIqYS8O9ZiD4VTq2o
 DwjQ==
X-Gm-Message-State: AOAM532WNLNRIlPgv+zDA1YyFSKA+00FCFb3qEoi25BKFFbosRTFcztP
 w8G/57lH8ftcCLNi4+02Ctk=
X-Google-Smtp-Source: ABdhPJz0A00Hhw5Vli8TVeEtRfiPZYsxG5ITyA5LmAEgWeGC9ZLGa+BC1gOQ/ZV1CEKAVIE0Ns5pzg==
X-Received: by 2002:a7b:cb4e:: with SMTP id v14mr3272198wmj.54.1591085303314; 
 Tue, 02 Jun 2020 01:08:23 -0700 (PDT)
Received: from [192.168.1.43] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id u4sm2365640wmb.48.2020.06.02.01.08.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jun 2020 01:08:22 -0700 (PDT)
Subject: Re: [PATCH] MAINTAINERS: Volunteer for maintaining the Renesas
 hardware
To: Markus Armbruster <armbru@redhat.com>
References: <20200601092057.10555-1-f4bug@amsat.org>
 <87imga7wy8.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <fcf6ea98-d440-3275-8c8d-431ecf428238@amsat.org>
Date: Tue, 2 Jun 2020 10:08:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87imga7wy8.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/2/20 9:23 AM, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
> 
>> I don't have much clue about the Renesas hardware, but at least
>> I know now the source files a little bit, so I volunteer to pick
>> up patches and send pull-requests for them during my scarce
>> hobbyist time, until someone else with more knowledge steps up
>> to do this job instead.
>>
>> Suggested-by: Alex Bennée <alex.bennee@linaro.org>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  MAINTAINERS | 15 +++++++++++++--
>>  1 file changed, 13 insertions(+), 2 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 0944d9c731..cbba3ac757 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -298,9 +298,7 @@ SH4 TCG CPUs
>>  M: Aurelien Jarno <aurelien@aurel32.net>
>>  S: Odd Fixes
>>  F: target/sh4/
>> -F: hw/sh4/
>>  F: disas/sh4.c
>> -F: include/hw/sh4/
>>  
>>  SPARC TCG CPUs
>>  M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> @@ -1238,6 +1236,18 @@ F: pc-bios/canyonlands.dt[sb]
>>  F: pc-bios/u-boot-sam460ex-20100605.bin
>>  F: roms/u-boot-sam460ex
>>  
>> +Renesas Hardware
>> +----------------
>> +SH4 Hardware
>> +M: Aurelien Jarno <aurelien@aurel32.net>
>> +M: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> +S: Odd Fixes
>> +F: hw/sh4/
>> +F: hw/char/sh_serial.c
>> +F: hw/intc/sh_intc.c
>> +F: hw/timer/sh_timer.c
>> +F: include/hw/sh4/
>> +
>>  SH4 Machines
>>  ------------
>>  R2D
>> @@ -1246,6 +1256,7 @@ S: Maintained
>>  F: hw/sh4/r2d.c
>>  F: hw/intc/sh_intc.c
>>  F: hw/timer/sh_timer.c
>> +F: include/hw/sh4/sh_intc.h
>>  
>>  Shix
>>  M: Magnus Damm <magnus.damm@gmail.com>
> 
> hw/sh4 include/hw/sh4/ is Aurelien's "SH4 TCG CPUs" less target/sh4
> disas/sh4.c.  Aurelien is fine with this overlap, so no problem.

See the History, generic coverage in SVN commit b6f97c14f59, then commit
fd5d5c566af keep all under target-sh4/, in ddb13561ac4 Aurelien steps
in, 2c9b7d1ab4e degraded to odd-fixes, the in fcf5ef2ab52 Thomas Huth
split hw/ VS target/.

I can read datasheets, so I am confident I can keep an eye to the
hardware and avoid its code to bitrot, highlighting I can only spend
humble hobby time on this.

I have less interest in the TCG code, so I prefer not touch it (thus,
left to Aurelien).

> 
> hw/sh4/r2d.c hw/sh4/shix.c hw/intc/sh_intc.c hw/timer/sh_timer.c overlap
> with "R2D" and "Shix".  You pointed out that Magnus hasn't been active
> in years.  Having MAINTAINERS claim him even as "odd fixer" is
> misleading then.  Have we tried to contact Magnus?

Well, he is automatically Cc'ed when these files are modified, but I
haven't seen him make comment on the list.

> 
> Say we can't reach him, or he instructs us to remove him from
> MAINTAINERS.
> 
> The only parts of these two sections your new section doesn't claim is
> hw/sh4/r2d.c and hw/sh4/shix.c.  Would you be willing to serve as odd
> fixer for them, too?  Yes, I understand you don't have access to the
> hardware, but how much worse is that for these too files than for the
> remainder of hw/sh4/?

As a side note, I once told Yoshinori that Renesas SH4 and Renesas RX
were having almost identical peripheral cores, and he recently sent a
nice series merging both hw:
https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg08584.html

Which is why an unique 'Renesas Hardware' entry might make sense, and I
welcome Yoshinori if he wants to maintain it.

Then SH4/RX machines would be different entries.

After that, hw/sh4/r2d.c and hw/sh4/shix.c are indeed the only files
left in hw/sh4/. I am confident I can keep them in good shape.

I still want to insist that this will be during hobbyist time, based on
best effort. If someone else has time to do this, or can even be paid by
a company to look a it, I am more than happy to let him/her takes the role.

Regards,

Phil.

