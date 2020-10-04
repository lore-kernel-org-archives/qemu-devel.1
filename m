Return-Path: <SRS0=Kewn=DL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E750DC4727D
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 21:13:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F5402078A
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 21:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MzF0yqxJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F5402078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPBJl-0003Uq-CF
	for qemu-devel@archiver.kernel.org; Sun, 04 Oct 2020 17:13:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41482)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1kPBHw-0002Uw-9a
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 17:11:24 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:43860)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1kPBHu-00035e-HT
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 17:11:24 -0400
Received: by mail-ed1-x543.google.com with SMTP id dn5so7243355edb.10
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2020 14:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=hxHqf08Z0ANSc25AC4iUF/u1Jmsa7L0qrGpKbcnosyY=;
 b=MzF0yqxJqQ3lUGsm7MIr2R0v4t3KbSNw09LRjzikGQRhxxyiMV5mORkQwS9w8s41om
 YdMtIXOvcO+WmGU0+a89Ew9zQK+JpyUIZ6qW7+1d6bVNpJaM4mA9Tta60FDrGUDIRPop
 kVH1Wiccj4JKUf3/sxSWaO90gCdB2rzLWucH5b6yReeB8MhrhKSclnfBlRz/cC1vuUBZ
 7q5GwuqgtmxUU/Hl7hTpPePiRVLt1ectvrB0BSh0y5tEncIWglQ1QqDJ01KDd0DSZvto
 mlzu69MWHumyt6v+F4/CfITsqMs5Bgh8tRfw7MCbqM+gkYBFMerJwMtkwRV/0+Uy4sUg
 nZbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=hxHqf08Z0ANSc25AC4iUF/u1Jmsa7L0qrGpKbcnosyY=;
 b=Vfb9QlCBYB+Pgsbl9cRzfoKzthaPxm2SSD9caKKh005nbr4VWzJfKq+KK8YS7da5Xf
 W1n43kk6FFthyx4XZtOBL7bd/RKUtE8D9fqHpiTpio8NzJkwIQ9NWeNQTNyY1QWrzIO8
 5TjiKiqT3T+TQBWJTbG4FePCpTVh7vSe+btWOgSatHbdjTnjAttoNBdI2xIOTTZuruYl
 /yKHT+NYyBhdJ8P8kIgP9ET68CCEX84t31dAPU2j3YrBascy6mztRTVo9LDSTA/xETG2
 AOifMRLUOEl2eO9CPxRDHsuFWwjvS4RXNSHzTn8ELdZ8lLu3ff1mfA3wMre5om9NN9Z9
 bv6Q==
X-Gm-Message-State: AOAM531j2WIpm/qWZrJt52bNphpVQ3z8KU3fP+qyzJkIkX84tbcfgymv
 82eUHYw1CfmRWhitSZWBxF6Bk6FHVbedy06GsRc=
X-Google-Smtp-Source: ABdhPJxs5Gyxxx395mA1i+Yha+ieA5BPna5M8SUygL3zheJmvFCP1xjQ3U+IAbn0KbBocywfw3mcvOhe4QD4Pll9Vt8=
X-Received: by 2002:a05:6402:1c10:: with SMTP id
 ck16mr14007076edb.7.1601845880401; 
 Sun, 04 Oct 2020 14:11:20 -0700 (PDT)
MIME-Version: 1.0
References: <20201004182506.2038515-1-f4bug@amsat.org>
 <CAPan3Wqatde4qoskcf9uiUECpNP+9KR4VfgTXPWO=S2cd73sbw@mail.gmail.com>
In-Reply-To: <CAPan3Wqatde4qoskcf9uiUECpNP+9KR4VfgTXPWO=S2cd73sbw@mail.gmail.com>
From: David CARLIER <devnexen@gmail.com>
Date: Sun, 4 Oct 2020 22:11:09 +0100
Message-ID: <CA+XhMqy8Cm7kKRgqg2-UjwEPbDEq7PJ-o7iYNd_FaP-xNrtmOA@mail.gmail.com>
Subject: Re: [RFC PATCH] contrib/gitdm: Add more individual contributors
To: Niek Linnenbank <nieklinnenbank@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=devnexen@gmail.com; helo=mail-ed1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: James Hogan <jhogan@kernel.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>, Paul Zimmerman <pauldzim@gmail.com>,
 Sven Schnelle <svens@stackframe.org>, Paul Burton <paulburton@kernel.org>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Finn Thain <fthain@telegraphics.com.au>,
 Ahmed Karaman <ahmedkhaledkaraman@gmail.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?B?S8WRdsOhZ8OzIFpvbHTDoW4=?= <dirty.ice.hu@gmail.com>,
 Guenter Roeck <linux@roeck-us.net>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, Stefan Weil <sw@weilnetz.de>,
 Alistair Francis <alistair@alistair23.me>, Michael Rolnik <mrolnik@gmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Acked-by: David Carlier <devnexen@gmail.com>

On Sun, 4 Oct 2020 at 22:07, Niek Linnenbank <nieklinnenbank@gmail.com> wro=
te:
>
> Acked-by: Niek Linnenbank <nieklinnenbank@gmail.com>
>
>
> Op zo 4 okt. 2020 20:25 schreef Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.=
org>:
>>
>> These individual contributors have a number of contributions,
>> add them to the 'individual' group map.
>>
>> Cc: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
>> Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
>> Cc: Alistair Francis <alistair@alistair23.me>
>> Cc: Artyom Tarasenko <atar4qemu@gmail.com>
>> Cc: David Carlier <devnexen@gmail.com>
>> Cc: Finn Thain <fthain@telegraphics.com.au>
>> Cc: Guenter Roeck <linux@roeck-us.net>
>> Cc: Helge Deller <deller@gmx.de>
>> Cc: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
>> Cc: James Hogan <jhogan@kernel.org>
>> Cc: Jean-Christophe Dubois <jcd@tribudubois.net>
>> Cc: K=C5=91v=C3=A1g=C3=B3 Zolt=C3=A1n <dirty.ice.hu@gmail.com>
>> Cc: Laurent Vivier <laurent@vivier.eu>
>> Cc: Michael Rolnik <mrolnik@gmail.com>
>> Cc: Niek Linnenbank <nieklinnenbank@gmail.com>
>> Cc: Paul Burton <paulburton@kernel.org>
>> Cc: Paul Zimmerman <pauldzim@gmail.com>
>> Cc: Stefan Weil <sw@weilnetz.de>
>> Cc: Subbaraya Sundeep <sundeep.lkml@gmail.com>
>> Cc: Sven Schnelle <svens@stackframe.org>
>> Cc: Thomas Huth <huth@tuxfamily.org>
>> Cc: Volker R=C3=BCmelin <vr_qemu@t-online.de>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>> To the developers Cc'ed: If you agree with your entry, please
>> reply with a Reviewed-by/Acked-by tag. If you disagree or doesn't
>> care, please either reply with Nack-by or ignore this patch.
>> I'll repost in 2 weeks as formal patch (not RFC) with only the
>> entries acked by their author.
>> ---
>>  contrib/gitdm/group-map-individuals | 22 ++++++++++++++++++++++
>>  contrib/gitdm/group-map-redhat      |  1 -
>>  2 files changed, 22 insertions(+), 1 deletion(-)
>>
>> diff --git a/contrib/gitdm/group-map-individuals b/contrib/gitdm/group-m=
ap-individuals
>> index cf8a2ce367..b478fd4576 100644
>> --- a/contrib/gitdm/group-map-individuals
>> +++ b/contrib/gitdm/group-map-individuals
>> @@ -16,3 +16,25 @@ aurelien@aurel32.net
>>  balaton@eik.bme.hu
>>  e.emanuelegiuseppe@gmail.com
>>  andrew.smirnov@gmail.com
>> +sw@weilnetz.de
>> +huth@tuxfamily.org
>> +laurent@vivier.eu
>> +atar4qemu@gmail.com
>> +hpoussin@reactos.org
>> +deller@gmx.de
>> +alistair@alistair23.me
>> +fthain@telegraphics.com.au
>> +svens@stackframe.org
>> +aleksandar.qemu.devel@gmail.com
>> +jhogan@kernel.org
>> +paulburton@kernel.org
>> +vr_qemu@t-online.de
>> +nieklinnenbank@gmail.com
>> +devnexen@gmail.com
>> +jcd@tribudubois.net
>> +dirty.ice.hu@gmail.com
>> +mrolnik@gmail.com
>> +pauldzim@gmail.com
>> +linux@roeck-us.net
>> +sundeep.lkml@gmail.com
>> +ahmedkhaledkaraman@gmail.com
>> diff --git a/contrib/gitdm/group-map-redhat b/contrib/gitdm/group-map-re=
dhat
>> index d15db2d35e..4a8ca84b36 100644
>> --- a/contrib/gitdm/group-map-redhat
>> +++ b/contrib/gitdm/group-map-redhat
>> @@ -3,6 +3,5 @@
>>  #
>>
>>  david@gibson.dropbear.id.au
>> -laurent@vivier.eu
>>  pjp@fedoraproject.org
>>  armbru@pond.sub.org
>> --
>> 2.26.2
>>

