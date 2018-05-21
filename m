Received: from eggs.gnu.org ([2001:4830:134:3::10]:38553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fKgya-0004te-JD
	for qemu-devel@nongnu.org; Mon, 21 May 2018 05:19:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fKgyZ-0002FS-LZ
	for qemu-devel@nongnu.org; Mon, 21 May 2018 05:19:32 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:44828)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fKgyZ-0002FK-GX
	for qemu-devel@nongnu.org; Mon, 21 May 2018 05:19:31 -0400
Received: by mail-ot0-x241.google.com with SMTP id g7-v6so16085677otj.11
	for <qemu-devel@nongnu.org>; Mon, 21 May 2018 02:19:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180519092956.15134-7-laurent@vivier.eu>
References: <20180519092956.15134-1-laurent@vivier.eu>
	<20180519092956.15134-7-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 May 2018 10:19:10 +0100
Message-ID: <CAFEAcA8Wc2boEtJQC2feZ_N07no-ErGGk-Hhwyyuo91kGaTc2w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 6/8] linux-user: update
 ARCH_HAS_SOCKET_TYPES use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Yongbok Kim <yongbok.kim@mips.com>, Riku Voipio <riku.voipio@iki.fi>, Richard Henderson <rth@twiddle.net>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 19 May 2018 at 10:29, Laurent Vivier <laurent@vivier.eu> wrote:
> to be like in the kernel and rename it TARGET_ARCH_HAS_SOCKET_TYPES

You could note in the commit message that this fixes our
incorrect definition of TARGET_SOCK_CLOEXEC for SPARC.

> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  linux-user/alpha/sockbits.h | 36 +++-----------------------
>  linux-user/hppa/sockbits.h  | 33 +++---------------------
>  linux-user/mips/sockbits.h  |  9 ++++---
>  linux-user/socket.h         | 62 +++++++++++++++++++++++----------------------
>  linux-user/sparc/sockbits.h | 36 --------------------------
>  5 files changed, 44 insertions(+), 132 deletions(-)
>
> diff --git a/linux-user/alpha/sockbits.h b/linux-user/alpha/sockbits.h
> index 4db3e52b67..f5397dd875 100644
> --- a/linux-user/alpha/sockbits.h
> +++ b/linux-user/alpha/sockbits.h
> @@ -75,39 +75,9 @@
>  /* Instruct lower device to use last 4-bytes of skb data as FCS */
>  #define TARGET_SO_NOFCS     43
>
> -/** sock_type - Socket types
> - *
> - * Please notice that for binary compat reasons ALPHA has to
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
> +/* TARGET_O_NONBLOCK clashes with the bits used for socket types.  Therefore we
> + * have to define SOCK_NONBLOCK to a different value here.
>   */
> +#define TARGET_SOCK_NONBLOCK   0x40000000

This new value is different from the old value in the enum:

> -#define ARCH_HAS_SOCKET_TYPES          1
> -
> -enum sock_type {
> -       TARGET_SOCK_STREAM      = 1,
> -       TARGET_SOCK_DGRAM       = 2,
> -       TARGET_SOCK_RAW         = 3,
> -       TARGET_SOCK_RDM         = 4,
> -       TARGET_SOCK_SEQPACKET   = 5,
> -       TARGET_SOCK_DCCP        = 6,
> -       TARGET_SOCK_PACKET      = 10,
> -       TARGET_SOCK_CLOEXEC     = 010000000,
> -       TARGET_SOCK_NONBLOCK    = 010000000000,

...does it matter?

Neither are the same as Alpha's actual SOCK_NONBLOCK value,
which as far as I can tell is 4. The comment suggests that we're
deliberately avoiding a clash with the socket-type values, but
do you know how this works? I don't see how we can do the right
thing if we're not using the actual bit values the guest wants...

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
