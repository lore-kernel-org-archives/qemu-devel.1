Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B7AC04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 09:20:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 773D62669E
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 09:20:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 773D62669E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39057 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWdiN-0004iV-EG
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 05:20:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mrezanin@redhat.com>) id 1hWdhP-0004FX-8P
	for qemu-devel@nongnu.org; Fri, 31 May 2019 05:19:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mrezanin@redhat.com>) id 1hWdhO-0003Fq-3p
	for qemu-devel@nongnu.org; Fri, 31 May 2019 05:19:43 -0400
Received: from 212-4-128-36.cust.selfnet.cz ([212.4.128.36]:60036
	helo=workimage.localdomain) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mrezanin@redhat.com>)
	id 1hWdhL-0003CD-1C; Fri, 31 May 2019 05:19:39 -0400
Received: by workimage.localdomain (Postfix, from userid 1000)
	id 12A541C3399; Fri, 31 May 2019 11:12:05 +0200 (CEST)
Date: Fri, 31 May 2019 11:12:04 +0200
From: Miroslav Rezanina <mrezanin@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Message-ID: <20190531091204.tjmq622gw457xbdr@lws.brq.redhat.com>
References: <20190514155301.16123-1-alex.bennee@linaro.org>
	<20190514155301.16123-7-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190514155301.16123-7-alex.bennee@linaro.org>
User-Agent: NeoMutt/20180716
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.4.128.36
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

On Tue, May 14, 2019 at 04:52:56PM +0100, Alex Benn=E9e wrote:
> Now we have a common semihosting console interface use that for our
> string output. However ARM is currently unique in also supporting
> semihosting for linux-user so we need to replicate the API in
> linux-user. If other architectures gain this support we can move the
> file later.
>=20
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> ---
>  linux-user/Makefile.objs  |  2 ++
>  linux-user/arm/semihost.c | 24 ++++++++++++++++++++++++
>  target/arm/arm-semi.c     | 31 ++++++-------------------------
>  3 files changed, 32 insertions(+), 25 deletions(-)
>  create mode 100644 linux-user/arm/semihost.c
>=20
> diff --git a/linux-user/Makefile.objs b/linux-user/Makefile.objs
> index 769b8d83362..285c5dfa17a 100644
> --- a/linux-user/Makefile.objs
> +++ b/linux-user/Makefile.objs
> @@ -6,4 +6,6 @@ obj-y =3D main.o syscall.o strace.o mmap.o signal.o \
>  obj-$(TARGET_HAS_BFLT) +=3D flatload.o
>  obj-$(TARGET_I386) +=3D vm86.o
>  obj-$(TARGET_ARM) +=3D arm/nwfpe/
> +obj-$(TARGET_ARM) +=3D arm/semihost.o
> +obj-$(TARGET_AARCH64) +=3D arm/semihost.o
>  obj-$(TARGET_M68K) +=3D m68k-sim.o
> diff --git a/linux-user/arm/semihost.c b/linux-user/arm/semihost.c
> new file mode 100644
> index 00000000000..9554102a855
> --- /dev/null
> +++ b/linux-user/arm/semihost.c
> @@ -0,0 +1,24 @@
> +/*
> + * ARM Semihosting Console Support
> + *
> + * Copyright (c) 2019 Linaro Ltd
> + *
> + * Currently ARM is unique in having support for semihosting support
> + * in linux-user. So for now we implement the common console API but
> + * just for arm linux-user.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "cpu.h"
> +#include "hw/semihosting/console.h"
> +#include "qemu.h"
> +
> +int qemu_semihosting_console_out(CPUArchState *env, target_ulong addr,=
 int len)
> +{
> +    void *s =3D lock_user_string(addr);
> +    len =3D write(STDERR_FILENO, s, len ? len : strlen(s));
> +    unlock_user(s, addr, 0);
> +    return len;
> +}
> diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
> index 9e5a414dd89..253c66b172a 100644
> --- a/target/arm/arm-semi.c
> +++ b/target/arm/arm-semi.c
> @@ -27,6 +27,7 @@
> =20
>  #include "cpu.h"
>  #include "hw/semihosting/semihost.h"
> +#include "hw/semihosting/console.h"
>  #ifdef CONFIG_USER_ONLY
>  #include "qemu.h"
> =20
> @@ -314,32 +315,12 @@ target_ulong do_arm_semihosting(CPUARMState *env)
>              return set_swi_errno(ts, close(arg0));
>          }
>      case TARGET_SYS_WRITEC:
> -        {
> -          char c;
> -
> -          if (get_user_u8(c, args))
> -              /* FIXME - should this error code be -TARGET_EFAULT ? */
> -              return (uint32_t)-1;
> -          /* Write to debug console.  stderr is near enough.  */
> -          if (use_gdb_syscalls()) {
> -                return arm_gdb_syscall(cpu, arm_semi_cb, "write,2,%x,1=
", args);
> -          } else {
> -                return write(STDERR_FILENO, &c, 1);
> -          }
> -        }
> +    {
> +        qemu_semihosting_console_out(env, args, 1);
> +        return 0xdeadbeef;
> +    }
>      case TARGET_SYS_WRITE0:
> -        if (!(s =3D lock_user_string(args)))
> -            /* FIXME - should this error code be -TARGET_EFAULT ? */
> -            return (uint32_t)-1;
> -        len =3D strlen(s);
> -        if (use_gdb_syscalls()) {
> -            return arm_gdb_syscall(cpu, arm_semi_cb, "write,2,%x,%x",
> -                                   args, len);
> -        } else {
> -            ret =3D write(STDERR_FILENO, s, len);
> -        }
> -        unlock_user(s, args, 0);
> -        return ret;
> +        return qemu_semihosting_console_out(env, args, 0);
>      case TARGET_SYS_WRITE:
>          GET_ARG(0);
>          GET_ARG(1);
> --=20
> 2.20.1
>=20
>=20

Hi Alex,

this patch breaks build for softmmu target when CONFIG_SEMIHOSTING is not=
 enabled as qemu_semihosting_console_out
is not defined in such case - neither linux-user/arm/semihost.c nor hw/se=
mihosting/console.c compiled and function
is not in stubs/semihost.c=20

Mirek

