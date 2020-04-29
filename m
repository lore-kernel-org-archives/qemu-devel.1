Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 816A0C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 09:29:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 448CE20731
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 09:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ji5XwNsM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 448CE20731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTj2K-0008UE-GU
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 05:29:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33878)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jTj1d-00083o-6z
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 05:29:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jTj1c-0006Rh-Hx
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 05:29:05 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39997)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jTj1c-0006RI-4f
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 05:29:04 -0400
Received: by mail-wm1-x344.google.com with SMTP id u16so1232117wmc.5
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 02:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=7enXGeO/1KR66fSPg8u4TxZfNClgKNpxyJ7WcKkmSG0=;
 b=ji5XwNsMg0wGOyD+zYzxTEoC/K3rFFqxwwX3a5HPUQ2nZhUChslltvVWv8zxcy74wB
 2+sNglEUVApuPTLBAQhtoBYAKQZGXFAmEkfcmnhZaLtqfnedsovkTNweyo6MjiWkwb+p
 WzyQYSwYcvtvyORi7DdRJeN2mpkmWhv8FUqXst5jE5LPduJO1c5POsSzyGIYKKEAZgV0
 CKmXSbP/6aLBU+rowrUuiTtb4vcuwu9lnvTtHp/0tvaAeocdTiR02fCXw3sm/6sFAKSa
 b1lanam1rSBpC2wlkPX2G8obIv1+z6iJTjzR9uB05uxI8rgN5rKeDJRYXxMqstRreh9S
 4bYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=7enXGeO/1KR66fSPg8u4TxZfNClgKNpxyJ7WcKkmSG0=;
 b=pSA96/S2gh4mKg9wfhsVCHypLTW8d45qKIq2v/hHq+o3Y8maDYSfcViBS0L7Hi2TUZ
 G9k1JOMXFgL0DQXnct4EoFm7bnpz/gEad4FS7rtUnU+Q74kAkBsn5onUpUus3zGie6Vx
 lz6KtRggSWaLlfKmBBbj8+HaBPzxdarfXqQ7glq4Cr0YLcigtIo253U6adE76Ik7y1pD
 aJCTJAfr+fu/xCobTwQD67iw5WapZziT+tW1h2FWXjaA7I2msCcQ5lBUnKT0gcrcSEdi
 fdoSzlXkirk/OESyuQYGZuj83klI/oAgFvKAIUXD90n1//5tEoyIJrprJc8KWjBRCdIU
 pnbg==
X-Gm-Message-State: AGi0Pua4lZFHUQJaDulu8NLqbOhJKhMWsAWMnlBaeM7CQWc5VPk8KmrP
 92oO3MZG7GlOm14n/pQdY1Lzmvgq4hM=
X-Google-Smtp-Source: APiQypJ7HryCz+EKklH86px/9Lc1rRF1VxeWFfvKetsDCGygeTFy25bHlil8Ap/Dnd35DAIt2h9hcQ==
X-Received: by 2002:a05:600c:2218:: with SMTP id
 z24mr2182184wml.82.1588152541468; 
 Wed, 29 Apr 2020 02:29:01 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t2sm6904625wmt.15.2020.04.29.02.28.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2020 02:29:00 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3B5D01FF7E;
 Wed, 29 Apr 2020 10:28:59 +0100 (BST)
References: <1588094279-17913-1-git-send-email-frederic.konrad@adacore.com>
 <1588094279-17913-3-git-send-email-frederic.konrad@adacore.com>
 <d565528d-426f-bf00-5974-5653eaf5cd25@vivier.eu>
User-agent: mu4e 1.4.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH 2/2] target/m68k: fix gdb for m68xxx
In-reply-to: <d565528d-426f-bf00-5974-5653eaf5cd25@vivier.eu>
Date: Wed, 29 Apr 2020 10:28:59 +0100
Message-ID: <877dxyljxg.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::344
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
Cc: KONRAD Frederic <frederic.konrad@adacore.com>, philmd@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Laurent Vivier <laurent@vivier.eu> writes:

> Le 28/04/2020 =C3=A0 19:17, KONRAD Frederic a =C3=A9crit :
>> Currently "cf-core.xml" is sent to GDB when using any m68k flavor.  Thin=
g is
>> it uses the "org.gnu.gdb.coldfire.core" feature name and gdb 8.3 then ex=
pects
>> a coldfire FPU instead of the default m68881 FPU.
>>=20
>> This is not OK because the m68881 floats registers are 96 bits wide so it
>> crashes GDB with the following error message:
>>=20
>> (gdb) target remote localhost:7960
>> Remote debugging using localhost:7960
>> warning: Register "fp0" has an unsupported size (96 bits)
>> warning: Register "fp1" has an unsupported size (96 bits)
>> ...
>> Remote 'g' packet reply is too long (expected 148 bytes, got 180 bytes):=
    \
>>   00000000000[...]0000
>>=20
>> With this patch: qemu-system-m68k -M none -cpu m68020 -s -S
>>=20
>> (gdb) tar rem :1234
>> Remote debugging using :1234
>> warning: No executable has been specified and target does not support
>> determining executable automatically.  Try using the "file" command.
>> 0x00000000 in ?? ()
>> (gdb) p $fp0
>> $1 =3D nan(0xffffffffffffffff)
>>=20
>> Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
>> ---
>>  configure             |  2 +-
>>  gdb-xml/m68k-core.xml | 29 ++++++++++++++++++++++++++++
>>  target/m68k/cpu.c     | 52 ++++++++++++++++++++++++++++++++++++--------=
-------
>>  3 files changed, 67 insertions(+), 16 deletions(-)
>>  create mode 100644 gdb-xml/m68k-core.xml
>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>

Are you going to take this through your tree or do you want me to add it
to my small pile of gdbstub fixes?

--=20
Alex Benn=C3=A9e

