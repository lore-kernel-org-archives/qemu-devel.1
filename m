Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02D2C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 15:59:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AF6A2072F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 15:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xgxi7Osy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AF6A2072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHrO1-00065C-LF
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 11:59:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57865)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jHrMw-0005Ss-Sr
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 11:58:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jHrMv-0001Qi-BW
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 11:58:02 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:37747)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jHrMu-0001M3-Pm
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 11:58:01 -0400
Received: by mail-wm1-x344.google.com with SMTP id d1so12892262wmb.2
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 08:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=MF8+Qqd2msWxCv20WFpcmq2jjN+E730xXd4UvxVFy7Y=;
 b=Xgxi7Osyz9ZRKFquXR2vWeXbWJI5hiB9unCQro35JX+s0CMuSqATFI2ArcFQDPTjmL
 /4yQMBGhqd5BYd2CtxxWv4p0IPZfPhpFeBuC82nTlkrSCoa0S26ZvbIKALVJFnB7+N5/
 eZ48nGZ/SEHuBdHQguWmqAZcTw256GKZD3m7dE5K21TpHmHiFglFmFwvcNEveXT7173l
 Iphhjq+tHCD0c3D6tNJN+j4F8y8CFzHb6k7EjtV9CT4PL0P3K+3CdJfgI8aTnkH53sbj
 blYuLigws2IIhWUL740Z73j5lfx0IbwoNu7GYdN4c01uvOKmosXel9a0gFtkhn0MeDaF
 eozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=MF8+Qqd2msWxCv20WFpcmq2jjN+E730xXd4UvxVFy7Y=;
 b=cL1QOiDs2zag8nbeoFCi+5BvwdWUVJ1gnKj3vBoI+T39VptLyyru4zNq3PjHIzG5SN
 jBCv6VXf30Q5pTZYsZesa62ZHQtMYMD87d+80+BGTB9BWWX4M99ekVBCfvxRQ9tw6WkM
 PZ60ihRBQYZns/uPPTzIyT+LgORSqIqep65JV48vzFn9KyI0FYkYMgUkK7caTVX7wzPv
 bqYZs75+2lNVRoaXpj/k+hPSSbTVKlWVOIWcVpnJj+ZZTHpjiTp+miR3t6B+adMAR6Yt
 KpMik/7Hg0xuxOWoSKjYqHtq6vsLBIJhr8l/fP+E02ujLCV5YQ3RFBGZ1P+82mxqbCUM
 jm0Q==
X-Gm-Message-State: ANhLgQ2+D3qLmYbFIQ9DtzsJunZfDokOa9kWb4QGbXs3oac2byEZnWrr
 NFqhpiT9rP24uU835oACW6ydmw==
X-Google-Smtp-Source: ADFU+vvt0RMATKPPlkR9oBd+TSfuiQ8AEThSb1kzKSIaH10TCr2rCJn0Wx3KmXAbqwlPrf8NplikDQ==
X-Received: by 2002:a1c:3885:: with SMTP id f127mr2999439wma.134.1585324677519; 
 Fri, 27 Mar 2020 08:57:57 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n1sm8756576wrj.77.2020.03.27.08.57.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2020 08:57:56 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D392E1FF7E;
 Fri, 27 Mar 2020 15:57:54 +0000 (GMT)
References: <20200326134316.36059-1-roger.pau@citrix.com>
 <f71f7cf8-af7d-7b45-a026-8ab87e106759@linaro.org>
 <20200327101600.GA28583@Air-de-Roger> <87sghum3zv.fsf@linaro.org>
 <20200327140839.GB28583@Air-de-Roger> <878sjln6og.fsf@linaro.org>
 <20200327154844.GN1619@redhat.com>
User-agent: mu4e 1.3.10; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH] qemu-user: fix build with LLVM lld 10
In-reply-to: <20200327154844.GN1619@redhat.com>
Date: Fri, 27 Mar 2020 15:57:54 +0000
Message-ID: <875zepn62l.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Dimitry Andric <dim@freebsd.org>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Roger Pau =?utf-8?Q?Monn=C3=A9?= <roger.pau@citrix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Fri, Mar 27, 2020 at 03:44:47PM +0000, Alex Benn=C3=A9e wrote:
>>=20
>> Roger Pau Monn=C3=A9 <roger.pau@citrix.com> writes:
>>=20
>> > On Fri, Mar 27, 2020 at 11:28:04AM +0000, Alex Benn=C3=A9e wrote:
>> >>=20
>> >> Roger Pau Monn=C3=A9 <roger.pau@citrix.com> writes:
>> >>=20
>> >> > On Thu, Mar 26, 2020 at 09:56:38AM -0700, Richard Henderson wrote:
>> >> >> On 3/26/20 6:43 AM, Roger Pau Monne wrote:
>> >> >> > lld 10.0.0 introduced a new linker option --image-base equivalen=
t to
>> >> >> > the GNU -Ttext-segment one, hence use it when available.
>> >> >> >=20
>> >> >> > This fixes the build of QEMU on systems using lld 10 or greater.
>> >> >> >=20
>> >> >> > Signed-off-by: Dimitry Andric <dim@FreeBSD.org>
>> >> >> > Signed-off-by: Roger Pau Monn=C3=A9 <roger.pau@citrix.com>
>> >> >> > ---
>> >> >> > Cc: Laurent Vivier <laurent@vivier.eu>
>> >> >> > Cc: Richard Henderson <richard.henderson@linaro.org>
>> >> >> > Cc: "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com>
>> >> >> > Cc: Paolo Bonzini <pbonzini@redhat.com>
>> >> >> > Cc: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
>> >> >> > ---
>> >> >>=20
>> >> >> The Plan is still to drop this whole section of code.
>> >> >>=20
>> >> >> However, it's still blocked on getting the x86_64 vsyscall patches=
 upstream.
>> >> >
>> >> > While this doesn't materialize, could it be possible to get this pa=
tch
>> >> > accepted?
>> >> >
>> >> > This is currently blocking the build of QEMU on FreeBSD HEAD, which
>> >> > has already switched to LLVM 10.0.0.
>> >>=20
>> >> I think the vsyscall patch has just been merged, however way I don't
>> >> think targeting HEAD of a OS release during the rc phase is appropria=
te.
>> >
>> > I'm not sure I understand what you mean. If QEMU doesn't build on
>> > FreeBSD HEAD it won't build on the next release. Also the LLVM
>> > toolchain used is not a development version AFAIK, but the actual
>> > 10.0.0 release, which QEMU should aim to support?
>>=20
>> QEMU's supported build platforms are based on what is currently shipping
>> as stable versions:
>>=20
>>   https://www.qemu.org/docs/master/system/build-platforms.html
>
> FWIW, when I wrote that my intention was *not* to exclude the bleeding
> edge distro development branches.
>
> Obviously we can break on those distros at any time as they're moving
> targets, but IMHO we should treat bugs as we would for any other
> released distros and aim to fix them promptly when bugs occurr.

Sure - I think there are now patches incoming from Richard to delete the
linker code which should meet the criteria for an RC fix, especially if
they solve the LLVM 10.0 problem as well.=20

--=20
Alex Benn=C3=A9e

