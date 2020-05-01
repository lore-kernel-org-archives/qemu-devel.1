Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57D5C47253
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 15:17:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9194120708
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 15:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQbGWN+f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9194120708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUXPy-0002ZO-J0
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 11:17:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43192)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jUXNN-0007xS-Nn
 for qemu-devel@nongnu.org; Fri, 01 May 2020 11:15:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jUXFU-0001lo-8Z
 for qemu-devel@nongnu.org; Fri, 01 May 2020 11:09:53 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39997)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jUXFT-0001gA-QF
 for qemu-devel@nongnu.org; Fri, 01 May 2020 11:06:43 -0400
Received: by mail-wr1-x442.google.com with SMTP id e16so6710537wra.7
 for <qemu-devel@nongnu.org>; Fri, 01 May 2020 08:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=iAIqMU9LmID+cSHS0iUuzYTqB9gHpn79/fvbxh9e0dA=;
 b=RQbGWN+f8xELUQ1mastSVuakh8lBg3lgAAFaGT2XZeVC2l/JYzdhNaeQ2cnM/Rucq6
 7qVnQR6t/C3P9Dz0QqH61+2r8SKxHaKpEe+MyKhzh/RsSeStYm/kN6lRiM/PZPQs21kZ
 VPw3sOONJK3kmQTNxTeMUyqonk7/GdgpcBhz1adkqMWT3TuDD+/cIou2ZYvT+TBzJ15j
 QqX25ABD4/OF7YREhMrxL0QJtd05+Jo8ftdZugbBIlQAFOcR4m7919mW8aAvrCSRiqK6
 FNdOy/f1RqK8W7RJeUeCV2mNI976CrTI+eXLk6ePE+YiYpKD774WAJhzPCm5Czw6Yw7i
 AMcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iAIqMU9LmID+cSHS0iUuzYTqB9gHpn79/fvbxh9e0dA=;
 b=DroBcwgTJt/g0L+1kcDNAMFy1G/FXJtZJQVNxhZNIl26aXVUlX7Tj0aS1rOoWb8fBS
 Jh90LeS80CqWIvGjAcRmRWS67CKEIRymhgypZGN2/l0maG5cEA1hNX1t3qRRV9PsDbzZ
 uv8S1QHiLA/UKggfu6OgvzikxI9LMQ904DRkXJsoBld1S4RD59apTFn5LyNBXYa57Cl9
 t4UXNOZAB0uni8ZWJlnhJTK3X1mJGZGPadWa7SrKa42J2pl3cb4KJcURDxjKF0HmstKK
 uYqvabyQ9C/40XSsj7YRT5WA05rPI4pbMzPPpyjGYifE/vFxW80UvoZkchcxIje9CDvi
 hfgA==
X-Gm-Message-State: AGi0PuZb6N2aQLUQ8yX1qGxYC30xPgOks431mk9BCB77Be7YOssrarGx
 sR9IMnlSrzmH+fjvPo2r4Ik=
X-Google-Smtp-Source: APiQypInwwzdTKf0928oaI5fBUEvT5cQjqF8bCmp/pdlEL0Tusl6TKns8BGimrQfARZ1w3zLXwusmA==
X-Received: by 2002:adf:f5ce:: with SMTP id k14mr4975974wrp.39.1588345602033; 
 Fri, 01 May 2020 08:06:42 -0700 (PDT)
Received: from [192.168.1.39] (137.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.137])
 by smtp.gmail.com with ESMTPSA id r17sm4749078wrn.43.2020.05.01.08.06.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 May 2020 08:06:41 -0700 (PDT)
Subject: Re: [PATCH] linux-user/strace.list: fix epoll_create{,1} -strace
 output
To: Sergei Trofimovich <slyfox@gentoo.org>, qemu-devel@nongnu.org
References: <20200416175957.1274882-1-slyfox@gentoo.org>
 <20200430235934.210904e7@sf>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <073e188a-8911-6c32-d0a3-d3f4f78c2208@amsat.org>
Date: Fri, 1 May 2020 17:06:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200430235934.210904e7@sf>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Helge Deller <deller@gmx.de>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+ Helge & Aleksandar.

On 5/1/20 12:59 AM, Sergei Trofimovich wrote:
> On Thu, 16 Apr 2020 18:59:57 +0100
> Sergei Trofimovich <slyfox@gentoo.org> wrote:
> 
>> Fix syscall name and parameters priinter.
>>
>> Before the change:
>>
>> ```
>> $ alpha-linux-user/qemu-alpha -strace -L /usr/alpha-unknown-linux-gnu/ /tmp/a
>> ...
>> 1274697 %s(%d)(2097152,274903156744,274903156760,274905840712,274877908880,274903235616) = 3

Oops...

>> 1274697 exit_group(0)
>> ```
>>
>> After the change:
>>
>> ```
>> $ alpha-linux-user/qemu-alpha -strace -L /usr/alpha-unknown-linux-gnu/ /tmp/a
>> ...
>> 1273719 epoll_create1(2097152) = 3
>> 1273719 exit_group(0)
>> ```
>>

Cc: qemu-stable@nongnu.org
Fixes: 9cbc0578cb6 ("Improve output of various syscalls")

>> Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
>> CC: Riku Voipio <riku.voipio@iki.fi>
>> CC: Laurent Vivier <laurent@vivier.eu>
>> ---
>>   linux-user/strace.list | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/linux-user/strace.list b/linux-user/strace.list
>> index d49a1e92a8..9281c0a758 100644
>> --- a/linux-user/strace.list
>> +++ b/linux-user/strace.list
>> @@ -125,10 +125,10 @@
>>   { TARGET_NR_dup3, "dup3" , "%s(%d,%d,%d)", NULL, NULL },
>>   #endif
>>   #ifdef TARGET_NR_epoll_create
>> -{ TARGET_NR_epoll_create, "%s(%d)", NULL, NULL, NULL },
>> +{ TARGET_NR_epoll_create, "epoll_create", "%s(%d)", NULL, NULL },
>>   #endif
>>   #ifdef TARGET_NR_epoll_create1
>> -{ TARGET_NR_epoll_create1, "%s(%d)", NULL, NULL, NULL },
>> +{ TARGET_NR_epoll_create1, "epoll_create1", "%s(%d)", NULL, NULL },
>>   #endif
>>   #ifdef TARGET_NR_epoll_ctl
>>   { TARGET_NR_epoll_ctl, "epoll_ctl" , NULL, NULL, NULL },
>> -- 
>> 2.26.1
>>
> 
> Should it be handled differently?

No, you are correct, we missed this when reviewing commit 9cbc0578cb6.

Thanks for your patch!

Too bad it missed the 5.0 release :/

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

