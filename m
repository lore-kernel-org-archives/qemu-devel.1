Received: from eggs.gnu.org ([209.51.188.92]:52348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gla1h-0008V3-Ln
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 08:54:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gla1g-000746-Ho
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 08:54:09 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:39643)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gla1g-00073n-Bo
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 08:54:08 -0500
Received: by mail-ot1-x344.google.com with SMTP id n8so20568927otl.6
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 05:54:08 -0800 (PST)
MIME-Version: 1.0
References: <20190119140000.11767-1-luc.michel@greensocs.com>
In-Reply-To: <20190119140000.11767-1-luc.michel@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Jan 2019 13:53:55 +0000
Message-ID: <CAFEAcA8h+rX_v+BBuhCr0t1sPSg56CsTnVGteFV5mgYa7HYJMw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] gdbstub: fix gdb_get_cpu(s, pid,
 tid) when pid and/or tid are 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luc Michel <luc.michel@greensocs.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Alistair Francis <alistair.francis@wdc.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, Mark Burton <mark.burton@greensocs.com>

On Sat, 19 Jan 2019 at 14:00, Luc Michel <luc.michel@greensocs.com> wrote:
>
> a TID or PID value means "any thread" (resp. "any process"). This commit
> fixes the different combinations when at least one value is 0.
>
> When both are 0, the function now returns the first attached CPU,
> instead of the CPU with TID 1, which is not necessarily attached or even
> existent.
>
> When PID is specified but TID is 0, the function returns the first CPU
> in the process, or NULL if the process does not exist or is not
> attached.
>
> In other cases, it returns the corresponding CPU, while ignoring the PID
> check when PID is 0.
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Luc Michel <luc.michel@greensocs.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

I've tracked down why my code was running into this, incidentally:
it turned out to be because I wasn't getting the parenting of the CPU
objects into the container correct, so the gdbstub ended up with
three processes, of which the first two were empty (and the CPUs
in the third default process). So the first thread (cpu 0) wasn't
in the first process, but in the last one.


thanks
-- PMM
