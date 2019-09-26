Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF4EC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 15:57:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFA35222C6
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 15:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cu2GyEQR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFA35222C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDW8h-00009e-UN
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 11:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59236)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iDVyi-0005fv-Tb
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 11:46:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iDVyg-00027A-GU
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 11:46:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25076
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iDVyf-00025l-83
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 11:46:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1569512803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=p38RHuHiAhJzu1eXf58t+Tzf+ExjvrEimUGYhmagwlU=;
 b=Cu2GyEQRhXSK+YVL2SDFgS68Pt3xBqUbT48fqJwz5mgefjYiEZeYYEDsVEmuf0GG6wqW4Y
 x+uJuJMgTjXiXjkrGmLrNCmJFuUx2Omb5BJ4bI2VVC/f68QDCafiqLET+2/QexpeSsckYB
 b1nY5ssiX0u+ypHSnFD2DHRphZV8wpM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-r-Ecg--AP-uHKbnOOcXZaA-1; Thu, 26 Sep 2019 11:46:40 -0400
Received: by mail-wr1-f69.google.com with SMTP id j3so1112859wrn.7
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 08:46:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oY7yT3amDi6IeriWDluI3BY6J+7rlZ38FY/VaUOHlxM=;
 b=jG4uC4Um8Kem1GceCOIQNkURR30fMO5sBQPjMYo6uxVOG4HFB1AE785Ne3k2f+81mI
 CH/0fLs6zEbOiJ2qFnVbnYY3pZsxvuroV9Qw3ueBmhg8Mg6uTXYdfw1tX7SnRY5qV1jY
 0RNRFXmIti8R/6WWfzdsdEJoChJIIYN9W8oRlTL8SVWiBo2qkQTqytm6JDSQYlg3oX7M
 jkgT02+z0RlM8z6AjvIK2+6Kq7I2ZtFiBmDDDOqWdB6DwHRSc5Jh1duRchAtfo8CIGGi
 iE5zlFe/5NvvLYnfXDwcsSMre1FXiaIXUaXslvDJ4rgKsxlvIo6vTqBkYvn2ytbfmB+7
 UZxA==
X-Gm-Message-State: APjAAAXzc8X3cYCIUvUS8p7MQxFo7pyZbiWb0b2Yh69cjbxk4GuyUuci
 HzdPiAAJ6e7pPs5HODbCA/9BLcFOd1I9DS+g5SUzviFw0FIdIxVNt9lFwgPUH1DxZ1IU/hob4F5
 3IjqUtblebc48NA0=
X-Received: by 2002:a1c:9ecb:: with SMTP id h194mr3402612wme.35.1569512799784; 
 Thu, 26 Sep 2019 08:46:39 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwhuUrGnI1fF8NdDMbOLGYW/BWEHAygRtuDJ0e3VwL2XSX6mGsk12XH8cpTtnp7OdJfLwZGDA==
X-Received: by 2002:a1c:9ecb:: with SMTP id h194mr3402598wme.35.1569512799594; 
 Thu, 26 Sep 2019 08:46:39 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id y12sm3382411wrn.74.2019.09.26.08.46.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Sep 2019 08:46:38 -0700 (PDT)
Subject: Re: illegal hardware instruction during MIPS-I ELF linux useremulation
To: Libo Zhou <zhlb29@foxmail.com>,
 "Peter&#38;nbsp;Maydell" <peter.maydell@linaro.org>
References: <tencent_5D6D8ED31E83C5675AB8AA3C@qq.com>
 <c722d11e-e0ff-8a91-d8f3-ee0a31f1df33@redhat.com>
 <tencent_7AB3CDCC529EAE38265539A9@qq.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <66b6b01d-f2b9-7715-982d-ae8106e40dc7@redhat.com>
Date: Thu, 26 Sep 2019 17:46:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <tencent_7AB3CDCC529EAE38265539A9@qq.com>
Content-Language: en-US
X-MC-Unique: r-Ecg--AP-uHKbnOOcXZaA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: qemu-devel <qemu-devel@nongnu.org>, "Aleksandar&#38; nbsp;
 Markovic" <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/26/19 4:31 PM, Libo Zhou wrote:
>> If you look at the mips_defs[] array in
>> target/mips/translate_init.inc.c, the older ISA implemented is MIPS-II:
>=20
>> $ git grep .insn_flags target/mips/translate_init.inc.c
>> translate_init.inc.c:75:        .insn_flags =3D CPU_MIPS32,
>> translate_init.inc.c:97:        .insn_flags =3D CPU_MIPS32 | ASE_MIPS16,
>> translate_init.inc.c:117:        .insn_flags =3D CPU_MIPS32,
>> translate_init.inc.c:137:        .insn_flags =3D CPU_MIPS32 | ASE_MIPS16=
,
>> translate_init.inc.c:158:        .insn_flags =3D CPU_MIPS32R2,
>> translate_init.inc.c:179:        .insn_flags =3D CPU_MIPS32R2 | ASE_MIPS=
16,
>> translate_init.inc.c:201:        .insn_flags =3D CPU_MIPS32R2 | ASE_MIPS=
16,
>> translate_init.inc.c:223:        .insn_flags =3D CPU_MIPS32R2 | ASE_MIPS=
16 | ASE_DSP,
>> translate_init.inc.c:249:        .insn_flags =3D CPU_MIPS32R2 | ASE_MIPS=
16,
>> translate_init.inc.c:297:        .insn_flags =3D CPU_MIPS32R2 | ASE_MIPS=
16 | ASE_DSP | ASE_MT,
>> translate_init.inc.c:323:        .insn_flags =3D CPU_MIPS32R2 | ASE_MIPS=
16 | ASE_DSP | ASE_DSP_R2,
>> translate_init.inc.c:343:        .insn_flags =3D CPU_MIPS32R2 | ASE_MICR=
OMIPS,
>> translate_init.inc.c:364:        .insn_flags =3D CPU_MIPS32R2 | ASE_MICR=
OMIPS,
>> translate_init.inc.c:410:        .insn_flags =3D CPU_MIPS32R5 | ASE_MSA,
>> translate_init.inc.c:449:        .insn_flags =3D CPU_MIPS32R6 | ASE_MICR=
OMIPS,
>> translate_init.inc.c:488:        .insn_flags =3D CPU_NANOMIPS32 | ASE_DS=
P | ASE_DSP_R2 | ASE_DSP_R3 |
>> translate_init.inc.c:511:        .insn_flags =3D CPU_MIPS3,
>> translate_init.inc.c:531:        .insn_flags =3D CPU_VR54XX,
>> translate_init.inc.c:552:        .insn_flags =3D CPU_MIPS64,
>> translate_init.inc.c:578:        .insn_flags =3D CPU_MIPS64,
>> translate_init.inc.c:607:        .insn_flags =3D CPU_MIPS64 | ASE_MIPS3D=
,
>> translate_init.inc.c:636:        .insn_flags =3D CPU_MIPS64R2 | ASE_MIPS=
3D,
>> translate_init.inc.c:657:        .insn_flags =3D CPU_MIPS64R2,
>> translate_init.inc.c:681:        .insn_flags =3D CPU_MIPS64R2,
>> translate_init.inc.c:721:        .insn_flags =3D CPU_MIPS64R6 | ASE_MSA,
>> translate_init.inc.c:761:        .insn_flags =3D CPU_MIPS64R6 | ASE_MSA,
>> translate_init.inc.c:781:        .insn_flags =3D CPU_LOONGSON2E,
>> translate_init.inc.c:801:        .insn_flags =3D CPU_LOONGSON2F,
>> translate_init.inc.c:830:        .insn_flags =3D CPU_MIPS64R2 | ASE_DSP =
| ASE_DSP_R2,
>=20
>> So currently there is no MIPS-I only CPU.
>> Note that the code got written with MIPS32 in mind, and implementing
>> MIPS-I requires a considerable amount of change in the codebase.
>=20
> Hi Philippe,
>=20
> I just figured out what the problem was. The custom compiler I used just =
modified the opcode fields of sw and lw instructions of MIPS, so QEMU didn'=
t recognize them out of the box.
> I just added the support in decode_opc function in translate.c, and I als=
o added my own CPU model in translate_init.inc.c. However, the illegal inst=
ruction exception is still there.
>=20
> I am suspecting that the way I added my own CPU model in translate_init.i=
nc.c is wrong. Below is what I added:
> ...
> +{
> +    .name =3D "MyCPU",
> +    .insn_flags =3D CPU_MIPS1 | INSN_MYCPU,
> +},
> ...
> I just need to simulate it's instruction set in linux user emulation, I d=
idn't include CP0* items in the list. Is this good enough to add a new CPU =
model?

Something like that might be acceptable for linux-user.
You should at least set CP0_PRid/Config0/Status_mask.

Look at this patch where Aleksandar accepted the R5900 CPU:
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3Ded4f49ba9bb56

Can you share what is your CPU?


