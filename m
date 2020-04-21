Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A796CC2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 07:18:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72F5E20661
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 07:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ly1PlnZX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72F5E20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQnBB-0001dm-El
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 03:18:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36408)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQnAG-00017M-OT
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 03:17:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQnAF-00061m-8f
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 03:17:51 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43804)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQnAD-0005uf-4r; Tue, 21 Apr 2020 03:17:49 -0400
Received: by mail-wr1-x444.google.com with SMTP id i10so15165879wrv.10;
 Tue, 21 Apr 2020 00:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UGRsIZp9V1QUY9cbupvYe647v8o+mrR0MEP8yx0xYQk=;
 b=Ly1PlnZXb/YSIofjdPLW9LHn0PFLieVn3y9+/NYIMtvNqZsB7QdJ2x/T4w5v0hy3d5
 wa/qqNZtqzucq4AZgkj08L2ahE+Lmmvw4NJJO2BYprDO3lQkDui5fn8/bc4amJhLwVyk
 MKJFu951/ONazGyOefH6TAEgX/XvtD3y3rXvpY7sFAP6MKwtJdnfjuqw2nH02jqRUxcO
 yFe93dYUKlDmpQdItngon2QPiHgd2ZNQBwNXggX2WS3XZ+QHOQm6lfTft+n1lDFBUgTR
 yL9yXCoTYy5/60Rr22GOaDL9F4G3gTw8D+vTppEFE2Ws+tWu9XH31Mq6cJ5WP1JGIkEH
 SYGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=UGRsIZp9V1QUY9cbupvYe647v8o+mrR0MEP8yx0xYQk=;
 b=cTaR5hql6RfhAr29xkUSSGUebH27X0ih3rBxJqSV+u0o1FEVojS4vess2L3V0T5tWy
 LizJximTanA5VDWaJSIjMJW6E/Niw3lMNcutm4Vdl4OSiRwANlYWN+a5hP6S453zk+AE
 sgxyKItBHOaBWdU+qbK/zts+nl+5Nciq00aH3GPbRGhn2p2Hm667jCSfDh3wlw0sRTxg
 ah4W+s1VaczLwuqqggU2xqp74JrsRC2X0nyOHU6R/Ub2rPlpKf9sOo2rQ6Qcrif6RiyK
 A3ebnS+lr91gFAHIgAdjxL2hyD9n0lz1EKpm+/o6VCBP+VA1wYN3fZM3zYpcDqzzloNb
 Sotw==
X-Gm-Message-State: AGi0PubD1d5wN2p/Qesai3XKhqTCFYo0WkwMwjRwbiMFN7WrRfHH9uh7
 1SeHrO5yNoUIZGrTs4lT2X8=
X-Google-Smtp-Source: APiQypJtpjNM01NqWt2jWuRLS2uvcyzy0nBDUbMyBsU6pasCJg6aiCbn+xR83Q6klzUpz4oBfxbYrA==
X-Received: by 2002:a5d:5391:: with SMTP id d17mr21879446wrv.215.1587453466983; 
 Tue, 21 Apr 2020 00:17:46 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id u7sm2520581wmg.41.2020.04.21.00.17.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Apr 2020 00:17:46 -0700 (PDT)
Subject: Re: [PATCH-for-5.0?] target/ppc: Fix TCG temporary leaks in
 gen_slbia()
To: Dennis Clarke <dclarke@blastwave.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200417090749.14310-1-f4bug@amsat.org>
 <CAFEAcA-aj77=19d+8jmoWYXBDdm=U8eV8CsHpovMN8bE9uNSvg@mail.gmail.com>
 <dcf67e87-da27-68ee-0dd8-5b94edb84291@blastwave.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Autocrypt: addr=f4bug@amsat.org; keydata=
 mQINBDU8rLoBEADb5b5dyglKgWF9uDbIjFXU4gDtcwiga9wJ/wX6xdhBqU8tlQ4BroH7AeRl
 u4zXP0QnBDAG7EetxlQzcfYbPmxFISWjckDBFvDbFsojrZmwF2/LkFSzlvKiN5KLghzzJhLO
 HhjGlF8deEZz/d/G8qzO9mIw8GIBS8uuWh6SIcG/qq7+y+2+aifaj92EdwU79apZepT/U3vN
 YrfcAuo1Ycy7/u0hJ7rlaFUn2Fu5KIgV2O++hHYtCCQfdPBg/+ujTL+U+sCDawCyq+9M5+LJ
 ojCzP9rViLZDd/gS6jX8T48hhidtbtsFRj/e9QpdZgDZfowRMVsRx+TB9yzjFdMO0YaYybXp
 dg/wCUepX5xmDBrle6cZ8VEe00+UQCAU1TY5Hs7QFfBbjgR3k9pgJzVXNUKcJ9DYQP0OBH9P
 ZbZvM0Ut2Bk6bLBO5iCVDOco0alrPkX7iJul2QWBy3Iy9j02GnA5jZ1Xtjr9kpCqQT+sRXso
 Vpm5TPGWaWljIeLWy/qL8drX1eyJzwTB3A36Ck4r3YmjMjfmvltSZB1uAdo1elHTlFEULpU/
 HiwvvqXQ9koB15U154VCuguvx/Qnboz8GFb9Uw8VyawzVxYVNME7xw7CQF8FYxzj6eI7rBf2
 Dj/II6wxWPgDEy3oUzuNOxTB7sT3b/Ym76yOJzWX5BylXQIJ5wARAQABtDFQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoRjRCVUcpIDxmNGJ1Z0BhbXNhdC5vcmc+iQJVBBMBCAA/AhsPBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgBYhBPqr514SkXIh3P1rsuPjLCzercDeBQJd660aBQks
 klzgAAoJEOPjLCzercDe2iMP+gMG2dUf+qHz2uG8nTBGMjgK0aEJrKVPodFA+iedQ5Kp3BMo
 jrTg3/DG1HMYdcvQu/NFLYwamUfUasyor1k+3dB23hY09O4xOsYJBWdilkBGsJTKErUmkUO2
 3J/kawosvYtJJSHUpw3N6mwz/iWnjkT8BPp7fFXSujV63aZWZINueTbK7Y8skFHI0zpype9s
 loU8xc4JBrieGccy3n4E/kogGrTG5jcMTNHZ106DsQkhFnjhWETp6g9xOKrzZQbETeRBOe4P
 sRsY9YSG2Sj+ZqmZePvO8LyzGRjYU7T6Z80S1xV0lH6KTMvq7vvz5rd92f3pL4YrXq+e//HZ
 JsiLen8LH/FRhTsWRgBtNYkOsd5F9NvfJtSM0qbX32cSXMAStDVnS4U+H2vCVCWnfNug2TdY
 7v4NtdpaCi4CBBa3ZtqYVOU05IoLnlx0miKTBMqmI05kpgX98pi2QUPJBYi/+yNu3fjjcuS9
 K5WmpNFTNi6yiBbNjJA5E2qUKbIT/RwQFQvhrxBUcRCuK4x/5uOZrysjFvhtR8YGm08h+8vS
 n0JCnJD5aBhiVdkohEFAz7e5YNrAg6kOA5IVRHB44lTBOatLqz7ntwdGD0rteKuHaUuXpTYy
 CRqCVAKqFJtxhvJvaX0vLS1Z2dwtDwhjfIdgPiKEGOgCNGH7R8l+aaM4OPOd
Message-ID: <1918bd79-2e30-a578-c34e-683eab724c67@amsat.org>
Date: Tue, 21 Apr 2020 09:17:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <dcf67e87-da27-68ee-0dd8-5b94edb84291@blastwave.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-ppc <qemu-ppc@nongnu.org>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/21/20 12:53 AM, Dennis Clarke wrote:
> On 4/20/20 6:56 PM, Peter Maydell wrote:
>> On Fri, 17 Apr 2020 at 10:08, Philippe Mathieu-Daudé <f4bug@amsat.org>
>> wrote:
>>>
>>> This fixes:
>>>
>>>    $ qemu-system-ppc64 \
>>>    -machine pseries-4.1 -cpu power9 \
>>>    -smp 4 -m 12G -accel tcg ...
>>>    ...
>>>    Quiescing Open Firmware ...
>>>    Booting Linux via __start() @ 0x0000000002000000 ...
>>>    Opcode 1f 12 0f 00 (7ce003e4) leaked temporaries
>>>    Opcode 1f 12 0f 00 (7ce003e4) leaked temporaries
>>>    Opcode 1f 12 0f 00 (7ce003e4) leaked temporaries
>>>
>>> [*] https://www.mail-archive.com/qemu-discuss@nongnu.org/msg05400.html
>>>
>>> Fixes: 0418bf78fe8 ("Fix ISA v3.0 (POWER9) slbia implementation")
>>> Reported-by: Dennis Clarke <dclarke@blastwave.org>
>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>
>> I propose to apply this patch for 5.0 rc4 (as well as the
>> ppc pullreq already sent), since the iscsi bugfix means
>> we need an rc4 anyway. Any objections?
>>
> 
> I have been running rc3 with this patch fine for some days now.  Both
> with and without a debug enabled build wherein the performance
> difference between the two is obvious.

Thanks for testing it! Can we use your:

Tested-by: Dennis Clarke <dclarke@blastwave.org>

tag?

> 
> However, I do see warnings from 5.0.0-rc3 that worry me :
> 
> $ /usr/local/bin/qemu-system-ppc64 \
>> -machine pseries-4.1 -cpu power9 -smp 4 -m 12G -accel tcg \
>> -drive file=/home/ppc64/ppc64le.qcow2 \
>> -device virtio-net-pci,netdev=usernet \
>> -netdev user,id=usernet,hostfwd=tcp::10000-:22 \
>> -serial stdio -display none -vga none
> qemu-system-ppc64: warning: TCG doesn't support requested feature,
> cap-cfpc=workaround
> qemu-system-ppc64: warning: TCG doesn't support requested feature,
> cap-sbbc=workaround
> qemu-system-ppc64: warning: TCG doesn't support requested feature,
> cap-ibs=workaround
> 
> 
> SLOF **********************************************************************
> QEMU Starting
>  Build Date = Mar 27 2020 13:57:26
>  FW Version = git-8e012d6fddb62be8
>  Press "s" to enter Open Firmware.
> 
> Populating /vdevice methods
> Populating /vdevice/vty@71000000
> Populating /vdevice/nvram@71000001
> Populating /vdevice/v-scsi@71000002
>        SCSI: Looking for devices
>           8000000000000000 DISK     : "QEMU     QEMU HARDDISK    2.5+"
>           8200000000000000 CD-ROM   : "QEMU     QEMU CD-ROM      2.5+"
> Populating /pci@800000020000000
>                      00 0000 (D) : 1af4 1000    virtio [ net ]
> No NVRAM common partition, re-initializing...
> Scanning USB
> Using default console: /vdevice/vty@71000000
> 
>   Welcome to Open Firmware
> 
>   Copyright (c) 2004, 2017 IBM Corporation All rights reserved.
>   This program and the accompanying materials are made available
>   under the terms of the BSD License available at
>   http://www.opensource.org/licenses/bsd-license.php
> 
> 
> Trying to load:  from: /vdevice/v-scsi@71000002/disk@8000000000000000
> ...   Successfully loaded
> 
> 
> etc etc etc
> 
> What shall I do with "TCG doesn't support requested feature,
> cap-cfpc=workaround" ??
> 

