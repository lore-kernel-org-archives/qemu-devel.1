Received: from eggs.gnu.org ([2001:4830:134:3::10]:54010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d9mI8-0003aI-6B
	for qemu-devel@nongnu.org; Sun, 14 May 2017 01:42:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d9mI3-0002zf-GI
	for qemu-devel@nongnu.org; Sun, 14 May 2017 01:42:04 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:34441)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d9mI3-0002zQ-AO
	for qemu-devel@nongnu.org; Sun, 14 May 2017 01:41:59 -0400
Received: by mail-qk0-x242.google.com with SMTP id u75so13034630qka.1
	for <qemu-devel@nongnu.org>; Sat, 13 May 2017 22:41:59 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170514051820.15985-1-n54@gmx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ccaec2d6-49d5-045a-219d-9d6e5deb6c79@amsat.org>
Date: Sun, 14 May 2017 02:41:55 -0300
MIME-Version: 1.0
In-Reply-To: <20170514051820.15985-1-n54@gmx.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] libvixl: Correct build failures on NetBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, claudio.fontana@gmail.com

On 05/14/2017 02:18 AM, Kamil Rytarowski wrote:
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

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

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
>
>  common-obj-$(CONFIG_ARM_A64_DIS) += $(libvixl_OBJS)
>
