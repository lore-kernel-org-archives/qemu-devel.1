Received: from eggs.gnu.org ([209.51.188.92]:49443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gmegk-0002eB-9M
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 08:05:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gmegi-00048Y-B2
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 08:04:58 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:34349)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gmegi-000486-3o
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 08:04:56 -0500
Received: by mail-ot1-x341.google.com with SMTP id t5so5169472otk.1
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 05:04:55 -0800 (PST)
MIME-Version: 1.0
References: <1548334069-9158-1-git-send-email-frederic.konrad@adacore.com>
In-Reply-To: <1548334069-9158-1-git-send-email-frederic.konrad@adacore.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 Jan 2019 13:04:42 +0000
Message-ID: <CAFEAcA8UeNa-EAZO70CJKoCBDoM+pSAa5USqBwZ1FexGNZGePw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] gdbstub: shutdown guest when the target is
 killed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: KONRAD Frederic <frederic.konrad@adacore.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, Edgar Iglesias <edgar.iglesias@xilinx.com>, Alistair Francis <alistair.francis@wdc.com>, Luc Michel <luc.michel@greensocs.com>

On Thu, 24 Jan 2019 at 12:47, KONRAD Frederic
<frederic.konrad@adacore.com> wrote:
>
> Under MinGW when the target is killed no "W00" packet are received by GDB
> because gdbstub takes the "exit(0)" path.

Why is this a problem? The gdb protocol documentation for the 'k'
packet says:

# If the target system immediately closes the connection in response to 'k',
# GDB does not consider the lack of packet acknowledgment to be an error,
# and assumes the kill was successful.

So it shouldn't matter whether we send the W00 packet or not.
(In fact it's not clear to me that it's right to send the W00
packet unconditionally -- W00 is a "stop reply packet" so it's
only correct to send it on QEMU exit if the stub was currently
executing one of the continue/run commands, not if the guest CPU
was already stopped.)

This also isn't specific to mingw as far as I can see -- we behave
the same on all hosts for system emulation.

> So replace the "exit(0)" call by
> a normal guest shutdown so the "W00" packet has a chance to be sent in
> "gdb_cleanup".

On the other hand I think that triggering a clean shutdown in
system emulation mode is arguably a more reasonable choice than
just bailing out immediately. I'm just not clear on what the
problem is that you're trying to solve with the change...

> Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
> ---
>  gdbstub.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/gdbstub.c b/gdbstub.c
> index bfc7afb..c91a909 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1389,7 +1389,12 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
>      case 'k':
>          /* Kill the target */
>          error_report("QEMU: Terminated via GDBstub");

I think we could usefully expand the comment.
    /*
     * Kill the target. The protocol does not specify the exact effect
     * of this packet, but notes that usually for a single-process target
     * it will kill the process, and for a bare-metal target it may
     * power-cycle or reset the system, so we follow that suggestion.
     * Note that this packet has no reply.
     */

> +#ifdef CONFIG_USER_ONLY
>          exit(0);
> +#else
> +        qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
> +#endif
> +        break;
>      case 'D':
>          /* Detach packet */
>          pid = 1;

thanks
-- PMM
