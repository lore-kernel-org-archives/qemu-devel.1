Received: from eggs.gnu.org ([209.51.188.92]:40001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkBNi-00008u-FT
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:23:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkBNh-0000th-Lg
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:23:06 -0500
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:43538)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkBNh-0000nm-5i
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:23:05 -0500
Received: by mail-ot1-x32e.google.com with SMTP id a11so11786751otr.10
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 09:23:03 -0800 (PST)
MIME-Version: 1.0
References: <20190107163117.16269-1-peter.maydell@linaro.org>
	<20190107163117.16269-11-peter.maydell@linaro.org>
In-Reply-To: <20190107163117.16269-11-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Jan 2019 17:22:50 +0000
Message-ID: <CAFEAcA864X=Ga+c5-Dg1tajZDc0Z3dTKyB-5XMZquH0okVq01A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 10/37] gdbstub: add multiprocess support to
 Xfer:features:read:
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Luc Michel <luc.michel@greensocs.com>

On Mon, 7 Jan 2019 at 16:31, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> From: Luc Michel <luc.michel@greensocs.com>
>
> Change the Xfer:features:read: packet handling to support the
> multiprocess extension. This packet is used to request the XML
> description of the CPU. In multiprocess mode, different descriptions can
> be sent for different processes.
>
> This function now takes the process to send the description for as a
> parameter, and use a buffer in the process structure to store the
> generated description.
>
> It takes the first CPU of the process to generate the description.

> @@ -1650,14 +1655,15 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
>              const char *xml;
>              target_ulong total_len;
>
> -            cc = CPU_GET_CLASS(first_cpu);
> +            process = gdb_get_cpu_process(s, s->g_cpu);
> +            cc = CPU_GET_CLASS(s->g_cpu);
>              if (cc->gdb_core_xml_file == NULL) {
>                  goto unknown_command;
>              }
>
>              gdb_has_xml = true;
>              p += 19;
> -            xml = get_feature_xml(p, &p, cc);
> +            xml = get_feature_xml(s, p, &p, process);
>              if (!xml) {
>                  snprintf(buf, sizeof(buf), "E00");
>                  put_packet(s, buf);

I've just run in to a segv in the gdbstub code in this bit,
because s->g_cpu is NULL.

Looking at the protocol trace from the gdb end:
(gdb) set debug remote 1
(gdb) target remote :1234
Remote debugging using :1234
Sending packet:
$qSupported:multiprocess+;swbreak+;hwbreak+;qRelocInsn+;fork-events+;vfork-events+;exec-events+;vContSupported+;QThreadEvents+;no-resumed+;xmlRegisters=i386#6a...Ack
Packet received: PacketSize=1000;qXfer:features:read+;multiprocess+
Packet qSupported (supported-packets) is supported
Sending packet: $vMustReplyEmpty#3a...Ack
Packet received:
Sending packet: $Hgp0.0#ad...Ack
Packet received: E22
Sending packet: $qXfer:features:read:target.xml:0,ffb#79...Ack
[here is where QEMU crashes]

What seems to happen is that GDB's attempt to set the
current thread with the "Hg" command fails because
gdb_get_cpu() fails[*], and so we return an E22 error status.
GDB (incorrectly) ignores this and issues a general command
anyway, and then QEMU crashes because we don't handle s->g_cpu
being NULL in this command's handling code.

[*] This happens with an out-of-tree board model I'm working
on that uses the cpu cluster stuff, so it's probably a bug in
my code that causes it.

I think it would be nice to do something more robust in these
cases, even if it does only happen when a QEMU bug and a GDB
bug collide :-)

thanks
-- PMM
