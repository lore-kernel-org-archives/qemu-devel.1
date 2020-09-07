Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8663C43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 16:03:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 061D32080A
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 16:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ldNa37Il"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 061D32080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFJbk-0003PA-Uw
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 12:03:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39714)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kFJZW-0008SO-CS
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 12:00:46 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54704)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kFJZT-0003Ya-M6
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 12:00:45 -0400
Received: by mail-wm1-x344.google.com with SMTP id s13so14783361wmh.4
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 09:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=r0k1JDUDnuLVZEcpkQFx9izm83l0K+K3seip2uQwMoc=;
 b=ldNa37IlSrhM7iuyMQjfCgUHLixKFWmI3oDutNNx+av4tF+lzx7TuUyU6tU/S4hPAr
 4GRVg5wW1phtyX1CbdOeqve114LgW6EmCU4sSJA5QWMXKAC8V41tP8Bu4zMZTmRicyHc
 JhV2R2iafirlkRnFKezkPnKhL8tGNGM6cG3c+f7uexyAaZBKMqyQ6d64xU5Nx6ceMlws
 bmp4/r9+B38WPNOjmwlpX9CuYlEi86ebOxWGbkFJieHeJV+aXpxacH0WFpzQfuSapfcQ
 dPUeiJHNQd6KDENx1RaWy+NxtB6SpgNMKLFB1zNyNadBTs6zK4R/JoX2kFTz4PokN1WW
 0PHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=r0k1JDUDnuLVZEcpkQFx9izm83l0K+K3seip2uQwMoc=;
 b=rohcsKJopKp49fb6UC4Cjb5pHcQmS8rWCS2/Bz7zTTauoGfhDTyUvZ4FebmlNticIO
 hyr6d9+F3mwT7jpGL+orOc0spOb96aZgPq6UmDtEymVEyYhvJ5Ish8uf7UGY5k4Yc9nZ
 FQThQ+RprFs1SoSa/U3DSsuLm/JN/zAhRpLtM41Uxo/i4XXnH5PEboBXaZr6Oyy49Djj
 4lJ624IhR9WN8RG1fZ/biW0R2pamLpbT4Fnj2SpmF5nfuKfIe3kwfOej/N7kGR3r2R+9
 7vAvNRyrXTAMt1vKuPN0iRgZtR4f7ooBoU8UYAJ59P8uzcqjIfEbS+lNhvZCbovq/iCJ
 mvOQ==
X-Gm-Message-State: AOAM530UQ+1LV1ypM/VyDjCFODxVAS4z865kqjOGoVucccKStjfvEUWp
 WBzE+bjyQwIgPhecaU1/whJpeQ==
X-Google-Smtp-Source: ABdhPJyj2vFpkBrNX4z2NPgVzBjlLN91dexr1dOgIuf2b3cpK0+sH0JgFMbDuontXxYSPP+o1jJBYw==
X-Received: by 2002:a1c:b608:: with SMTP id g8mr38716wmf.106.1599494441603;
 Mon, 07 Sep 2020 09:00:41 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u66sm2420101wme.1.2020.09.07.09.00.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2020 09:00:40 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DDD4E1FF7E;
 Mon,  7 Sep 2020 17:00:39 +0100 (BST)
References: <159903454714.28509.7439453309116734374.stgit@pasha-ThinkPad-X280>
 <159903457617.28509.2649326029575134141.stgit@pasha-ThinkPad-X280>
 <87k0x5r4jg.fsf@linaro.org>
 <1afbeab2-e363-9be3-a751-2692263e80d2@ispras.ru>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
Subject: Re: [PATCH v3 05/15] iotests: update snapshot test for new output
 format
In-reply-to: <1afbeab2-e363-9be3-a751-2692263e80d2@ispras.ru>
Date: Mon, 07 Sep 2020 17:00:39 +0100
Message-ID: <87h7s9r2zc.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, wrampazz@redhat.com, ehabkost@redhat.com,
 mtosatti@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 stefanha@redhat.com, crosa@redhat.com, pbonzini@redhat.com, mreitz@redhat.com,
 philmd@redhat.com, zhiwei_liu@c-sky.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru> writes:

> On 07.09.2020 18:26, Alex Benn=C3=A9e wrote:
>>=20
>> Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru> writes:
>>=20
>>> From: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>
>>>
>>> This patch updates iotests that verify qemu monitor output.
>>> New output format for snapshot listing include ICOUNT column.
>>=20
>> I was curious if the monitor should still function during replay. In my
>> setup:
>>=20
>>    ./qemu-system-aarch64 -cpu cortex-a53 -display none -serial mon:stdio=
 -machine virt -kernel zephyr.elf -net none -icount shift=3D6,align=3Doff,s=
leep=3Doff,rr=3Dreplay,rrfile=3Drecord.out -drive file=3Drecord.qcow2,if=3D=
none,snapshot,id=3Drr -s -S
>>    *** Booting Zephyr OS build zephyr-v2.3.0-1183-ge5628ad0faf3  ***
>>    Hello World! qemu_cortex_a53
>>    qemu-system-aarch64: Missing character write event in the replay log
>
> And what about -monitor stdio instead of -serial mon:stdio?

Well I switched to:

  -monitor telnet:127.0.0.1:4444

and controlled that way. I appreciate having a multiplexed
serial/monitor is a tricky edge case but I'm curious as to why it broke.


>
>>=20
>> although technically the C-a shouldn't be a character that ever makes it
>> to the guest.
>>=20
>>>
>>> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
>>> ---
>>>   tests/qemu-iotests/267.out |   48 ++++++++++++++++++++++-------------=
---------
>>>   1 file changed, 24 insertions(+), 24 deletions(-)
>>>
>>> diff --git a/tests/qemu-iotests/267.out b/tests/qemu-iotests/267.out
>>> index 215902b3ad..27471ffae8 100644
>>> --- a/tests/qemu-iotests/267.out
>>> +++ b/tests/qemu-iotests/267.out
>>> @@ -33,8 +33,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
>>>   (qemu) savevm snap0
>>>   (qemu) info snapshots
>>>   List of snapshots present on all disks:
>>> -ID        TAG                 VM SIZE                DATE       VM CLO=
CK
>>> ---        snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.0=
00
>>> +ID        TAG               VM SIZE                DATE     VM CLOCK  =
   ICOUNT
>>> +--        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000
>>>   (qemu) loadvm snap0
>>>   (qemu) quit
>>>=20=20=20
>>> @@ -44,8 +44,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
>>>   (qemu) savevm snap0
>>>   (qemu) info snapshots
>>>   List of snapshots present on all disks:
>>> -ID        TAG                 VM SIZE                DATE       VM CLO=
CK
>>> ---        snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.0=
00
>>> +ID        TAG               VM SIZE                DATE     VM CLOCK  =
   ICOUNT
>>> +--        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000
>>>   (qemu) loadvm snap0
>>>   (qemu) quit
>>>=20=20=20
>>> @@ -69,8 +69,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
>>>   (qemu) savevm snap0
>>>   (qemu) info snapshots
>>>   List of snapshots present on all disks:
>>> -ID        TAG                 VM SIZE                DATE       VM CLO=
CK
>>> ---        snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.0=
00
>>> +ID        TAG               VM SIZE                DATE     VM CLOCK  =
   ICOUNT
>>> +--        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000
>>>   (qemu) loadvm snap0
>>>   (qemu) quit
>>>=20=20=20
>>> @@ -94,8 +94,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
>>>   (qemu) savevm snap0
>>>   (qemu) info snapshots
>>>   List of snapshots present on all disks:
>>> -ID        TAG                 VM SIZE                DATE       VM CLO=
CK
>>> ---        snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.0=
00
>>> +ID        TAG               VM SIZE                DATE     VM CLOCK  =
   ICOUNT
>>> +--        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000
>>>   (qemu) loadvm snap0
>>>   (qemu) quit
>>>=20=20=20
>>> @@ -105,8 +105,8 @@ QEMU X.Y.Z monitor - type 'help' for more informati=
on
>>>   (qemu) savevm snap0
>>>   (qemu) info snapshots
>>>   List of snapshots present on all disks:
>>> -ID        TAG                 VM SIZE                DATE       VM CLO=
CK
>>> ---        snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.0=
00
>>> +ID        TAG               VM SIZE                DATE     VM CLOCK  =
   ICOUNT
>>> +--        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000
>>>   (qemu) loadvm snap0
>>>   (qemu) quit
>>>=20=20=20
>>> @@ -119,8 +119,8 @@ QEMU X.Y.Z monitor - type 'help' for more informati=
on
>>>   (qemu) savevm snap0
>>>   (qemu) info snapshots
>>>   List of snapshots present on all disks:
>>> -ID        TAG                 VM SIZE                DATE       VM CLO=
CK
>>> ---        snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.0=
00
>>> +ID        TAG               VM SIZE                DATE     VM CLOCK  =
   ICOUNT
>>> +--        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000
>>>   (qemu) loadvm snap0
>>>   (qemu) quit
>>>=20=20=20
>>> @@ -134,8 +134,8 @@ QEMU X.Y.Z monitor - type 'help' for more informati=
on
>>>   (qemu) savevm snap0
>>>   (qemu) info snapshots
>>>   List of snapshots present on all disks:
>>> -ID        TAG                 VM SIZE                DATE       VM CLO=
CK
>>> ---        snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.0=
00
>>> +ID        TAG               VM SIZE                DATE     VM CLOCK  =
   ICOUNT
>>> +--        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000
>>>   (qemu) loadvm snap0
>>>   (qemu) quit
>>>=20=20=20
>>> @@ -145,15 +145,15 @@ QEMU X.Y.Z monitor - type 'help' for more informa=
tion
>>>   (qemu) savevm snap0
>>>   (qemu) info snapshots
>>>   List of snapshots present on all disks:
>>> -ID        TAG                 VM SIZE                DATE       VM CLO=
CK
>>> ---        snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.0=
00
>>> +ID        TAG               VM SIZE                DATE     VM CLOCK  =
   ICOUNT
>>> +--        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000
>>>   (qemu) loadvm snap0
>>>   (qemu) quit
>>>=20=20=20
>>>   Internal snapshots on overlay:
>>>   Snapshot list:
>>> -ID        TAG                 VM SIZE                DATE       VM CLO=
CK
>>> -1         snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.0=
00
>>> +ID        TAG               VM SIZE                DATE     VM CLOCK  =
   ICOUNT
>>> +1         snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000
>>>   Internal snapshots on backing file:
>>>=20=20=20
>>>   =3D=3D=3D -blockdev with NBD server on the backing file =3D=3D=3D
>>> @@ -166,17 +166,17 @@ QEMU X.Y.Z monitor - type 'help' for more informa=
tion
>>>   (qemu) savevm snap0
>>>   (qemu) info snapshots
>>>   List of snapshots present on all disks:
>>> -ID        TAG                 VM SIZE                DATE       VM CLO=
CK
>>> ---        snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.0=
00
>>> +ID        TAG               VM SIZE                DATE     VM CLOCK  =
   ICOUNT
>>> +--        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000
>>>   (qemu) loadvm snap0
>>>   (qemu) quit
>>>=20=20=20
>>>   Internal snapshots on overlay:
>>>   Snapshot list:
>>> -ID        TAG                 VM SIZE                DATE       VM CLO=
CK
>>> -1         snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.0=
00
>>> +ID        TAG               VM SIZE                DATE     VM CLOCK  =
   ICOUNT
>>> +1         snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000
>>>   Internal snapshots on backing file:
>>>   Snapshot list:
>>> -ID        TAG                 VM SIZE                DATE       VM CLO=
CK
>>> -1         snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.0=
00
>>> +ID        TAG               VM SIZE                DATE     VM CLOCK  =
   ICOUNT
>>> +1         snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000
>>>   *** done
>>=20
>>=20


--=20
Alex Benn=C3=A9e

