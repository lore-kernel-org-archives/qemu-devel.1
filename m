Received: from eggs.gnu.org ([2001:4830:134:3::10]:36484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dFewc-0001uT-GU
	for qemu-devel@nongnu.org; Tue, 30 May 2017 07:04:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dFewb-0000zV-DR
	for qemu-devel@nongnu.org; Tue, 30 May 2017 07:04:10 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:36586)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dFewb-0000zP-6E
	for qemu-devel@nongnu.org; Tue, 30 May 2017 07:04:09 -0400
Received: by mail-wm0-x22b.google.com with SMTP id 7so87191979wmo.1
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 04:04:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170514051820.15985-1-n54@gmx.com>
References: <20170514051820.15985-1-n54@gmx.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 May 2017 12:03:47 +0100
Message-ID: <CAFEAcA8UOBtspVJ7nVDYKy95uf5Ua2RjMPW2Uky8YYjngGtgeQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] libvixl: Correct build failures on NetBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "claudio.fontana" <claudio.fontana@gmail.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 14 May 2017 at 06:18, Kamil Rytarowski <n54@gmx.com> wrote:
> Ensure that C99 macros are defined regardless of the inclusion order of
> headers in vixl. This is required at least on NetBSD.
>
> The vixl/globals.h headers defines __STDC_CONSTANT_MACROS and must be
> included before other system headers.
>
> This file defines unconditionally the following macros, without altering
> the original sources:
>  - __STDC_CONSTANT_MACROS
>  - __STDC_LIMIT_MACROS
>  - __STDC_FORMAT_MACROS
>
> Signed-off-by: Kamil Rytarowski <n54@gmx.com>
> ---
>  disas/libvixl/Makefile.objs | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/disas/libvixl/Makefile.objs b/disas/libvixl/Makefile.objs
> index bbe7695fdb..860fb7f384 100644
> --- a/disas/libvixl/Makefile.objs
> +++ b/disas/libvixl/Makefile.objs
> @@ -7,5 +7,8 @@ libvixl_OBJS = vixl/utils.o \
>  # The -Wno-sign-compare is needed only for gcc 4.6, which complains about
>  # some signed-unsigned equality comparisons which later gcc versions do not.
>  $(addprefix $(obj)/,$(libvixl_OBJS)): QEMU_CFLAGS := -I$(SRC_PATH)/disas/libvixl $(QEMU_CFLAGS) -Wno-sign-compare
> +# Ensure that C99 macros are defined regardless of the inclusion order of
> +# headers in vixl. This is required at least on NetBSD.
> +$(addprefix $(obj)/,$(libvixl_OBJS)): QEMU_CFLAGS += -D__STDC_CONSTANT_MACROS -D__STDC_LIMIT_MACROS -D__STDC_FORMAT_MACROS

Thanks for this patch -- I have applied it to target-arm.next.

I've also reported the underlying libvixl bug upstream so hopefully
it will be fixed in a future libvixl version too.

thanks
-- PMM
