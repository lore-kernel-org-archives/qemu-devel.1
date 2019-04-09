Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD56C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 16:44:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37F94206B7
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 16:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cse.mrt.ac.lk header.i=@cse.mrt.ac.lk header.b="MnC7bCdB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37F94206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cse.mrt.ac.lk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46344 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDtrG-0003AJ-Gb
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 12:44:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aruna.15@cse.mrt.ac.lk>) id 1hDtq6-0002Qt-5c
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:43:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aruna.15@cse.mrt.ac.lk>) id 1hDtq4-00009B-US
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:43:14 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34526)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aruna.15@cse.mrt.ac.lk>)
	id 1hDtq4-00008d-Hb
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:43:12 -0400
Received: by mail-wr1-x441.google.com with SMTP id p10so21820436wrq.1
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 09:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cse.mrt.ac.lk; s=google;
	h=mime-version:references:from:date:message-id:subject:to:cc;
	bh=dTvVACmQAZrKGduOM7oEX/HC59IdVfFjdfTsLRuhSAk=;
	b=MnC7bCdBYn3X9COpKjHnNsRN4Bw8dHFX4JIEVTCcudCACZO1OhyVaLVPpKJDG3BBBu
	5xdT9VIV4+61Esfvta3H6AVH7R6XK8H9XlthUB7AYW5dyC+PM+QmbP8GGDDHOVWAIi/b
	JfvtzKa/G7kI2SxhB28zZjDQR24T47RS46OX2chb4IGqkYqU2CUhAGq0Q5MbX7LSX3QX
	GDPuYJJbqQ++pCiOyYJRTYxINwanAK5+CbdQ8uKePNVcFqEfHXkXh/qmvbH9rBy6//BZ
	cRCzZJty2aAvVPw949wdsbsvD7jqqlj5Y15NM87OL47ofthIdUFlpClWCHWeN3+3X8z9
	Gflg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:from:date:message-id
	:subject:to:cc;
	bh=dTvVACmQAZrKGduOM7oEX/HC59IdVfFjdfTsLRuhSAk=;
	b=LuWylW39i4k4ZVsdkCHIaKrfNNuI6QnC3zRGPSsx/VKGGJyQReUqOtd9cgKx2aQuxT
	Oe0kTnL+8l32h1TO/oHhvRh0WW663F7dU9IzGpRCEHNTazVoNuqcdebkrBJo3rVR2+vT
	+SbzPSKVTiNPA7XpWLPPhWv0XKqYF6chufHcBoPBr02ctxQBX78I2+EKExvfePbjByjV
	uU/WsoLh0xfVXoR0fOe/NhHtvogY5/LvIro5YTOjGd7M9PRsoT5E2IWMT5iTPDkPBIH3
	OiIzpa9NKVr4p8gPDBbpqvbmWRXMHhNQkY4qjZtY4vLJYvUWeT28gnziIqkGw3Mcr2/L
	BRuQ==
X-Gm-Message-State: APjAAAVgmbdHNO8MjrmERxP3XelnC43pABA8jd6ZXHyZxnDlkyJfvcxh
	DSPhuIBhnq9hhDRQg4GN87/6JkBM8Md53V0Gmb0KWtkX6ng=
X-Google-Smtp-Source: APXvYqxVLuzEXBbh3wG07hDzXxv8WnwMKcBrh1sZwk63PzhsgPnca9z9VbgPyuMGyFFs4VxHbvpIXmNNPB41lNDdLI4=
X-Received: by 2002:adf:b6a4:: with SMTP id j36mr23046488wre.55.1554828191368; 
	Tue, 09 Apr 2019 09:43:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190409155635.10276-1-aruna.15@cse.mrt.ac.lk>
	<CAFEAcA-k0KEsjb0VvbhhkpvTN7nFBDNtqKwx-Lai5uYbCkztJA@mail.gmail.com>
	<CAH95U0j6rHGdZj4B8DK-Ty-SqZHMb3Kmg16w+j3jx5bdkeijLQ@mail.gmail.com>
From: Aruna Jayasena <aruna.15@cse.mrt.ac.lk>
Date: Tue, 9 Apr 2019 22:12:59 +0530
Message-ID:
 <CAH95U0grFVf3jL3UXRGUH4ft+pC=qOEhj2zaNn2=-AEqZB6iuQ@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 0/4] Header cleanups
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
	qemu-stable <qemu-stable@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409164259.uleV2VLk8L8JLnSb8g1V41is4LWXJ00PQrFB4bhpDJU@z>

Thank you

On Tue, Apr 9, 2019 at 10:12 PM, Aruna Jayasena <aruna.15@cse.mrt.ac.lk>
wrote:

> Yeah this is a stand alone patch.
>
> On Tue, Apr 9, 2019 at 10:10 PM, Peter Maydell <peter.maydell@linaro.org>
> wrote:
>
>> On Tue, 9 Apr 2019 at 16:58, Aruna Jayasena <aruna.15@cse.mrt.ac.lk>
>> wrote:
>> >
>> > Removed unwanted includes from cpu-common.h
>> > This task was under https://wiki.qemu.org/Contribute/BiteSizedTasks
>> >
>> > Signed-off-by: Aruna Jayasena <aruna.15@cse.mrt.ac.lk>
>> >
>> > ---
>> >  include/exec/cpu-common.h | 2 --
>> >  1 file changed, 2 deletions(-)
>> >
>> > diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
>> > index cef8b88a2a..a3594f3f50 100644
>> > --- a/include/exec/cpu-common.h
>> > +++ b/include/exec/cpu-common.h
>> > @@ -7,8 +7,6 @@
>> >  #include "exec/hwaddr.h"
>> >  #endif
>> >
>> > -#include "qemu/bswap.h"
>> > -#include "qemu/queue.h"
>> >  #include "qemu/fprintf-fn.h"
>> >
>>
>> I was surprised that no .c files are implicitly relying
>> on these includes, but apparently none are, so we can
>> safely remove them.
>>
>> A couple of notes:
>>  * this doesn't need to go to qemu-stable as it's just a
>>    code cleanup
>>  * did something go wrong with your sending of this patch?
>>    Its subject is "PATCH 0/4" which would usually indicate
>>    a cover letter for a four-patch series, but this seems
>>    to be a stand-alone patch.
>>
>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>>
>> thanks
>> -- PMM
>>
> --
> *Aruna* Jayasena
> Embedded Systems and Computer Science Engineering Undergraduate
> University of Moratuwa
> *=E2=9C=86 **+94719872152 *
> =E2=9C=89 <aruna.15@cse.mrt.ac.lk> =E2=8C=A8 <http://archfx.github.io> in
> <https://www.linkedin.com/in/arunajayasena/>
>
>
> --
*Aruna* Jayasena
Embedded Systems and Computer Science Engineering Undergraduate
University of Moratuwa
*=E2=9C=86 **+94719872152 *
=E2=9C=89 <aruna.15@cse.mrt.ac.lk> =E2=8C=A8 <http://archfx.github.io> in
<https://www.linkedin.com/in/arunajayasena/>
