Received: from eggs.gnu.org ([2001:4830:134:3::10]:46307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fH6q2-0001rN-7J
	for qemu-devel@nongnu.org; Fri, 11 May 2018 08:07:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fH6q0-0002Xw-T1
	for qemu-devel@nongnu.org; Fri, 11 May 2018 08:07:54 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:34442)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fH6q0-0002Xd-Ni
	for qemu-devel@nongnu.org; Fri, 11 May 2018 08:07:52 -0400
Received: by mail-ot0-x242.google.com with SMTP id i5-v6so5962086otf.1
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 05:07:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180510222601.19944-6-laurent@vivier.eu>
References: <20180510222601.19944-1-laurent@vivier.eu>
	<20180510222601.19944-6-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 11 May 2018 13:07:31 +0100
Message-ID: <CAFEAcA_VvSXcOo2WJXmDxb0ekb5ixjR1YouGLC_o_kLzvfLgSg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 5/5] linux-user: copy sparc/sockbits.h
 definitions from linux
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Riku Voipio <riku.voipio@iki.fi>, Yongbok Kim <yongbok.kim@mips.com>, Richard Henderson <rth@twiddle.net>

On 10 May 2018 at 23:26, Laurent Vivier <laurent@vivier.eu> wrote:
> Values defined for sparc are not correct.
> Copy the content of "arch/sparc/include/uapi/asm/socket.h"
> to fix them.
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  linux-user/sparc/sockbits.h | 161 ++++++++++++++++++++++++--------------------
>  1 file changed, 89 insertions(+), 72 deletions(-)
>
> diff --git a/linux-user/sparc/sockbits.h b/linux-user/sparc/sockbits.h
> index 385061c8b0..0a822e3e1f 100644
> --- a/linux-user/sparc/sockbits.h
> +++ b/linux-user/sparc/sockbits.h
> @@ -8,87 +8,104 @@
>  #ifndef SPARC_SOCKBITS_H
>  #define SPARC_SOCKBITS_H
>
> -/** sock_type - Socket types
> - *
> - * Please notice that for binary compat reasons SPARC has to
> - * override the enum sock_type in include/linux/net.h, so
> - * we define ARCH_HAS_SOCKET_TYPES here.
> - *
> - * @SOCK_DGRAM - datagram (conn.less) socket
> - * @SOCK_STREAM - stream (connection) socket
> - * @SOCK_RAW - raw socket
> - * @SOCK_RDM - reliably-delivered message
> - * @SOCK_SEQPACKET - sequential packet socket
> - * @SOCK_DCCP - Datagram Congestion Control Protocol socket
> - * @SOCK_PACKET - linux specific way of getting packets at the dev level.
> - *                For writing rarp and other similar things on the user
> - *                level.
> - * @SOCK_CLOEXEC - sets the close-on-exec (FD_CLOEXEC) flag.
> - * @SOCK_NONBLOCK - sets the O_NONBLOCK file status flag.
> - */
> +/* For setsockopt(2) */
> +#define TARGET_SOL_SOCKET      0xffff
>
> -#define ARCH_HAS_SOCKET_TYPES          1

This is what the kernel does, but for QEMU it will result
in the wrong value for TARGET_SOCK_CLOEXEC (though it does
fix the value for TARGET_SOCK_NONBLOCK).
This is because in QEMU the default values are hardcoded:

           TARGET_SOCK_CLOEXEC     = 02000000,
           TARGET_SOCK_NONBLOCK    = 04000,

whereas in linux's include/linux/net.h they are defined in terms
of other arch-specific constants:
#define SOCK_CLOEXEC    O_CLOEXEC
#ifndef SOCK_NONBLOCK
#define SOCK_NONBLOCK   O_NONBLOCK
#endif

Cleaning up QEMU so its ARCH_HAS_SOCKET_TYPES has the same
semantics as the kernel is probably the right way to go.

thanks
-- PMM
