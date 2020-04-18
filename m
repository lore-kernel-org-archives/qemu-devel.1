Return-Path: <SRS0=r7Ry=6C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61914C2D0EF
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 10:47:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21E6721D82
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 10:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWjnuXPQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21E6721D82
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPl0D-00080D-Bv
	for qemu-devel@archiver.kernel.org; Sat, 18 Apr 2020 06:47:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47541)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <npiggin@gmail.com>) id 1jPkzZ-0007al-S7
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 06:46:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1jPkzY-0001Vl-KO
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 06:46:33 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:41630)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1jPkzY-0001VB-Ez; Sat, 18 Apr 2020 06:46:32 -0400
Received: by mail-pg1-x543.google.com with SMTP id h69so2430930pgc.8;
 Sat, 18 Apr 2020 03:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :message-id:content-transfer-encoding;
 bh=7mqV1p0Nt77G49UyNiZx6Bi2R2qRxhbDDLmCM7ehfmg=;
 b=EWjnuXPQRrrEY3AFU+qkwmkhYEvEBx359eLEgyf+o//zu++/dqBDWRhM+EwSjNiFDs
 N2LIjgLQM6P2lD0jVkBlptlpUTJ3RKIGrmyvoRpIyofQcZvfMehwPZjWo3VBPZzthtIT
 9no55ITp1Qln21A0NLuC2A5mxpTmNblY+5DOcl9VId5dTMMro0tylbdL7biyG0n4ge+W
 S5GVoEJariK3Zze/11dNW4v3nQ4SZRcpltfeWBg2quGovXSxq3Hjw26uiZy9PU5gM23l
 w8nbTmmm2Cc8nmJQ+Rqo1yxZAF0tcRsXkFMIqvlkslbNK7CcqSIh5d5bN6tbOfnJrP8u
 6mLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:message-id:content-transfer-encoding;
 bh=7mqV1p0Nt77G49UyNiZx6Bi2R2qRxhbDDLmCM7ehfmg=;
 b=TcnxGuSpUBgQ0+P9w9E8bYe3FFANWee4EdAyeqCORvj1UxL15+eS49ysqLizAH8hMa
 EC9/q+xNoy3oYGD0ikZ19w2yjltdhNY23eDQ4ct+qzSaDJQSSVHyUeZUjRlLqcAwf+/U
 lAGFphxr7jDkJ7+lAXcN1Tu8GVeKQONUI6uolx0gnFoAf8dI11qsoR9opxhl1rHAQx8C
 EzvwW8g3FzHgYiSiricSRYh9Bh+8uQUlVcDXlUW5763qgA7H9l6c51UtbkkU4Rk5jECI
 yoO2kCIZEMHpRFNV9cCeP/m2UWmSVCYqOh1mDJg4/zFrP+SrYVi3NKIEF2JtsTVYVusJ
 vwNA==
X-Gm-Message-State: AGi0PubtAlZX+4+2o3y0npdO9M4PncBeMr9qRszJSjRfyiE7XldJdBUb
 kfaGEEJCZS2ts7gFbWmy0kQ=
X-Google-Smtp-Source: APiQypKEyxihvy+H25jh4pbiCteUNASY49nUGz8RUqP5dzzblDtZ5fBAFXVAvVTLBebp0wHzjhD24w==
X-Received: by 2002:a62:144c:: with SMTP id 73mr7835121pfu.37.1587206790870;
 Sat, 18 Apr 2020 03:46:30 -0700 (PDT)
Received: from localhost (220-244-86-41.tpgi.com.au. [220.244.86.41])
 by smtp.gmail.com with ESMTPSA id n8sm9922278pfq.213.2020.04.18.03.46.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Apr 2020 03:46:30 -0700 (PDT)
Date: Sat, 18 Apr 2020 20:45:44 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH-for-5.0?] target/ppc: Fix TCG temporary leaks in
 gen_slbia()
To: Philippe =?iso-8859-1?q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200417090749.14310-1-f4bug@amsat.org>
 <1587120086.g7mzwaexlz.astroid@bobo.none>
 <a7ff1611-6273-f42e-d67d-bec10e6b4b0e@amsat.org>
In-Reply-To: <a7ff1611-6273-f42e-d67d-bec10e6b4b0e@amsat.org>
MIME-Version: 1.0
Message-Id: <1587206719.dnd7j2vc3t.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
Cc: qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Dennis Clarke <dclarke@blastwave.org>,
 =?iso-8859-1?q?C=E9dric?= Le Goater <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Excerpts from Philippe Mathieu-Daud=C3=A9's message of April 17, 2020 9:00 =
pm:
> On 4/17/20 12:51 PM, Nicholas Piggin wrote:
>> Excerpts from Philippe Mathieu-Daud=C3=A9's message of April 17, 2020 7:=
07 pm:
>>> This fixes:
>>>
>>>   $ qemu-system-ppc64 \
>>>   -machine pseries-4.1 -cpu power9 \
>>>   -smp 4 -m 12G -accel tcg ...
>>>   ...
>>>   Quiescing Open Firmware ...
>>>   Booting Linux via __start() @ 0x0000000002000000 ...
>>>   Opcode 1f 12 0f 00 (7ce003e4) leaked temporaries
>>>   Opcode 1f 12 0f 00 (7ce003e4) leaked temporaries
>>>   Opcode 1f 12 0f 00 (7ce003e4) leaked temporaries
>>>
>>> [*] https://www.mail-archive.com/qemu-discuss@nongnu.org/msg05400.html
>>>
>>> Fixes: 0418bf78fe8 ("Fix ISA v3.0 (POWER9) slbia implementation")
>>> Reported-by: Dennis Clarke <dclarke@blastwave.org>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>=20
>> Thank you, brown bag required. Looks like I should be testing
>> this stuff with --enable-debug, sorry I didn't realise it.
>=20
> Is that an implicit:
>=20
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Yes sure :) If not already merged,=20

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>


