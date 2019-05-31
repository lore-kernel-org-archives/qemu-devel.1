Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6EA1C04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 13:18:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B1B225F9D
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 13:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A67LB/aL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B1B225F9D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43493 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWhQW-0008C6-DA
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 09:18:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWhOq-0007Ja-VA
	for qemu-devel@nongnu.org; Fri, 31 May 2019 09:16:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWhOp-0007S6-1m
	for qemu-devel@nongnu.org; Fri, 31 May 2019 09:16:48 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35987)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hWhOn-0007Iq-97
	for qemu-devel@nongnu.org; Fri, 31 May 2019 09:16:46 -0400
Received: by mail-wm1-x342.google.com with SMTP id v22so5935131wml.1
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 06:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=CsQ+UFVAKSBoEQamGKVb82auvk9jwiqvCpPp9xn++Ag=;
	b=A67LB/aLZW9JsCt2UBZ7NYZ8gXM2AR4Up2cGo7yBYyhctzIkxS7iCA1BV/fS/bG/eN
	emFVuFUd4zlhoTIo12wbEohuzJIEoCJHt5P2xTkgB5N87qdgyNSrlSy9gk9E7GizrT6T
	09XsPH0vZL0Pvz61vK3PmRJvLfiqmmD/6hT7eD9xigupcn3YzriND1lAeGutCAiw2O69
	vI0A8Wd9IR+Dxn79gj0S2NarA/ebhO5vmvzRnLCgEg5HMvkFEp/fqXeJK669UrowurMG
	kTjRUd3K1D8i79uh/v4N0fEyyk/IVR66BpFcdFlzxXBDV+uocIuznXBJIDQA3EmzWFj8
	cHMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=CsQ+UFVAKSBoEQamGKVb82auvk9jwiqvCpPp9xn++Ag=;
	b=Amlapus1PrLWI63wSegljxx+KZAliTXm+0YO/SSPEOdUQsRxV8S+5FysaSO9S0Bv4N
	TAkC7z5Li1vISPlFNSt6Nqszah45GEiNJYaALTe1xPMMc4eLMh8rPujI9vrI3+yOY3z5
	1fjzyjuGQxcpCXbU2C7UnCY/7ygapTy3Lh+AbGiE0Nfp/W5kDoAR0Bs15d8Dobw0+zMb
	fDP+mNz6Z5vBAY4KgcG5lhGmPb3/7WS7CeVhEFDRUBTOvpQQpEXPHQOM2bt8lS/pxW8Q
	w0BEEWwqI2SgNqBFkNah3rK3lzknSO84AsfcAr5Ok1bD6Aeyoz7KQYw4T0cDhaMfO/GE
	OR2A==
X-Gm-Message-State: APjAAAU1Fs5sBtbMK2lLuGwfoLh/DQcg3qjhgWKBQMCqs4Ap+Pf6XZ5p
	m/sKETpFyeb1wRIylYxQuCl02w==
X-Google-Smtp-Source: APXvYqyg5Z3APCBxF+K0RQwDMjapwoZFYkuYtrAk4SRIe3OZU96y5/2ipavXX0S5KpkL5YqtMDMqoA==
X-Received: by 2002:a1c:7c17:: with SMTP id x23mr5682769wmc.45.1559308601004; 
	Fri, 31 May 2019 06:16:41 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	65sm11454653wro.85.2019.05.31.06.16.39
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Fri, 31 May 2019 06:16:39 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id EDF501FF87;
	Fri, 31 May 2019 14:16:38 +0100 (BST)
References: <20190514155301.16123-1-alex.bennee@linaro.org>
	<20190514155301.16123-7-alex.bennee@linaro.org>
	<20190531091204.tjmq622gw457xbdr@lws.brq.redhat.com>
	<87sgsu51bd.fsf@zen.linaroharston>
	<833530119.25503992.1559302089822.JavaMail.zimbra@redhat.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Miroslav Rezanina <mrezanin@redhat.com>
In-reply-to: <833530119.25503992.1559302089822.JavaMail.zimbra@redhat.com>
Date: Fri, 31 May 2019 14:16:38 +0100
Message-ID: <874l5aahmx.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [RFC PATCH 06/11] target/arm: use the common
 interface for WRITE0/WRITEC in arm-semi
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>,
	qemu-devel@nongnu.org, qemu-arm@nongnu.org,
	Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Miroslav Rezanina <mrezanin@redhat.com> writes:

> ----- Original Message -----
>> From: "Alex Benn=C3=A9e" <alex.bennee@linaro.org>
>> To: "Miroslav Rezanina" <mrezanin@redhat.com>
>> Cc: qemu-devel@nongnu.org, "Peter Maydell" <peter.maydell@linaro.org>, "=
Riku Voipio" <riku.voipio@iki.fi>,
>> qemu-arm@nongnu.org, "Laurent Vivier" <laurent@vivier.eu>
>> Sent: Friday, May 31, 2019 1:08:06 PM
>> Subject: Re: [Qemu-devel] [RFC PATCH 06/11] target/arm: use the common i=
nterface for WRITE0/WRITEC in arm-semi
>>
>>
>> Miroslav Rezanina <mrezanin@redhat.com> writes:
>>
>> > On Tue, May 14, 2019 at 04:52:56PM +0100, Alex Benn=C3=A9e wrote:
>> >> Now we have a common semihosting console interface use that for our
>> >> string output. However ARM is currently unique in also supporting
>> >> semihosting for linux-user so we need to replicate the API in
>> >> linux-user. If other architectures gain this support we can move the
>> >> file later.
>> >>
>> >> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> >> ---
>> >>  linux-user/Makefile.objs  |  2 ++
>> >>  linux-user/arm/semihost.c | 24 ++++++++++++++++++++++++
>> >>  target/arm/arm-semi.c     | 31 ++++++-------------------------
>> >>  3 files changed, 32 insertions(+), 25 deletions(-)
>> >>  create mode 100644 linux-user/arm/semihost.c
>> >>
>> >> diff --git a/linux-user/Makefile.objs b/linux-user/Makefile.objs
>> >> index 769b8d83362..285c5dfa17a 100644
>> >> --- a/linux-user/Makefile.objs
>> >> +++ b/linux-user/Makefile.objs
>> >> @@ -6,4 +6,6 @@ obj-y =3D main.o syscall.o strace.o mmap.o signal.o \
>> >>  obj-$(TARGET_HAS_BFLT) +=3D flatload.o
>> >>  obj-$(TARGET_I386) +=3D vm86.o
>> >>  obj-$(TARGET_ARM) +=3D arm/nwfpe/
>> >> +obj-$(TARGET_ARM) +=3D arm/semihost.o
>> >> +obj-$(TARGET_AARCH64) +=3D arm/semihost.o
>> >>  obj-$(TARGET_M68K) +=3D m68k-sim.o
>> >> diff --git a/linux-user/arm/semihost.c b/linux-user/arm/semihost.c
>> >> new file mode 100644
>> >> index 00000000000..9554102a855
>> >> --- /dev/null
>> >> +++ b/linux-user/arm/semihost.c
>> >> @@ -0,0 +1,24 @@
>> >> +/*
>> >> + * ARM Semihosting Console Support
>> >> + *
>> >> + * Copyright (c) 2019 Linaro Ltd
>> >> + *
>> >> + * Currently ARM is unique in having support for semihosting support
>> >> + * in linux-user. So for now we implement the common console API but
>> >> + * just for arm linux-user.
>> >> + *
>> >> + * SPDX-License-Identifier: GPL-2.0-or-later
>> >> + */
>> >> +
>> >> +#include "qemu/osdep.h"
>> >> +#include "cpu.h"
>> >> +#include "hw/semihosting/console.h"
>> >> +#include "qemu.h"
>> >> +
>> >> +int qemu_semihosting_console_out(CPUArchState *env, target_ulong add=
r,
>> >> int len)
>> >> +{
>> >> +    void *s =3D lock_user_string(addr);
>> >> +    len =3D write(STDERR_FILENO, s, len ? len : strlen(s));
>> >> +    unlock_user(s, addr, 0);
>> >> +    return len;
>> >> +}
>> >> diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
>> >> index 9e5a414dd89..253c66b172a 100644
>> >> --- a/target/arm/arm-semi.c
>> >> +++ b/target/arm/arm-semi.c
>> >> @@ -27,6 +27,7 @@
>> >>
>> >>  #include "cpu.h"
>> >>  #include "hw/semihosting/semihost.h"
>> >> +#include "hw/semihosting/console.h"
>> >>  #ifdef CONFIG_USER_ONLY
>> >>  #include "qemu.h"
>> >>
>> >> @@ -314,32 +315,12 @@ target_ulong do_arm_semihosting(CPUARMState *en=
v)
>> >>              return set_swi_errno(ts, close(arg0));
>> >>          }
>> >>      case TARGET_SYS_WRITEC:
>> >> -        {
>> >> -          char c;
>> >> -
>> >> -          if (get_user_u8(c, args))
>> >> -              /* FIXME - should this error code be -TARGET_EFAULT ? =
*/
>> >> -              return (uint32_t)-1;
>> >> -          /* Write to debug console.  stderr is near enough.  */
>> >> -          if (use_gdb_syscalls()) {
>> >> -                return arm_gdb_syscall(cpu, arm_semi_cb, "write,2,%x=
,1",
>> >> args);
>> >> -          } else {
>> >> -                return write(STDERR_FILENO, &c, 1);
>> >> -          }
>> >> -        }
>> >> +    {
>> >> +        qemu_semihosting_console_out(env, args, 1);
>> >> +        return 0xdeadbeef;
>> >> +    }
>> >>      case TARGET_SYS_WRITE0:
>> >> -        if (!(s =3D lock_user_string(args)))
>> >> -            /* FIXME - should this error code be -TARGET_EFAULT ? */
>> >> -            return (uint32_t)-1;
>> >> -        len =3D strlen(s);
>> >> -        if (use_gdb_syscalls()) {
>> >> -            return arm_gdb_syscall(cpu, arm_semi_cb, "write,2,%x,%x",
>> >> -                                   args, len);
>> >> -        } else {
>> >> -            ret =3D write(STDERR_FILENO, s, len);
>> >> -        }
>> >> -        unlock_user(s, args, 0);
>> >> -        return ret;
>> >> +        return qemu_semihosting_console_out(env, args, 0);
>> >>      case TARGET_SYS_WRITE:
>> >>          GET_ARG(0);
>> >>          GET_ARG(1);
>> >> --
>> >> 2.20.1
>> >>
>> >>
>> >
>> > Hi Alex,
>> >
>> > this patch breaks build for softmmu target when CONFIG_SEMIHOSTING is =
not
>> > enabled as qemu_semihosting_console_out
>> > is not defined in such case - neither linux-user/arm/semihost.c nor
>> > hw/semihosting/console.c compiled and function
>> > is not in stubs/semihost.c
>>
>> How do you do that? I tried ../../configure --without-default-devices
>> and that still builds for me.
>
> It's usual RHEL way - use --without-default-devices and use specific
> list of enabled devices (this mean disable CONFIG_SEMIHOSTING in
> default_config/* file).

OK - so from the upstream source tree CONFIG_SEMIHOSTING is still =3Dy
(but I can see most of them are now =3Dn). Isn't the simplest solution to
fix-up your version of the default_config file to include SEMIHOSTING?

Is this an out-of-tree RHEL addition?

>>
>> But I suspect what's needed is to change:
>>
>> #ifndef CONFIG_USER_ONLY
>>
>> to
>>
>> #ifdef CONFIG_SEMIHOSTING
>>
>> to the relevant headers and helper bits.
>
> Yeah, have to find out what are relevant pieces.
>
> Mirek
>
>>
>> >
>> > Mirek
>>
>>
>> --
>> Alex Benn=C3=A9e
>>


--
Alex Benn=C3=A9e

