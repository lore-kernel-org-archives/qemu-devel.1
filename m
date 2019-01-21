Received: from eggs.gnu.org ([209.51.188.92]:56914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1glcEn-0001SQ-T3
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 11:15:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1glcEl-0002iK-UN
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 11:15:49 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:39259)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1glcEj-0002fR-UD
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 11:15:47 -0500
Received: by mail-oi1-x241.google.com with SMTP id i6so14954173oia.6
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 08:15:44 -0800 (PST)
MIME-Version: 1.0
References: <20190119140000.11767-1-luc.michel@greensocs.com>
	<CAFEAcA8h+rX_v+BBuhCr0t1sPSg56CsTnVGteFV5mgYa7HYJMw@mail.gmail.com>
In-Reply-To: <CAFEAcA8h+rX_v+BBuhCr0t1sPSg56CsTnVGteFV5mgYa7HYJMw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Jan 2019 16:15:33 +0000
Message-ID: <CAFEAcA96dNVoq5hTkDMcjrfLmp0iYuNKMzVULM=bB1BgNbVBNA@mail.gmail.com>
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

On Mon, 21 Jan 2019 at 13:53, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Sat, 19 Jan 2019 at 14:00, Luc Michel <luc.michel@greensocs.com> wrote:
> >
> > a TID or PID value means "any thread" (resp. "any process"). This commit
> > fixes the different combinations when at least one value is 0.
> >
> > When both are 0, the function now returns the first attached CPU,
> > instead of the CPU with TID 1, which is not necessarily attached or even
> > existent.
> >
> > When PID is specified but TID is 0, the function returns the first CPU
> > in the process, or NULL if the process does not exist or is not
> > attached.
> >
> > In other cases, it returns the corresponding CPU, while ignoring the PID
> > check when PID is 0.
> >
> > Reported-by: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Luc Michel <luc.michel@greensocs.com>
> > ---
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>
> I've tracked down why my code was running into this, incidentally:
> it turned out to be because I wasn't getting the parenting of the CPU
> objects into the container correct, so the gdbstub ended up with
> three processes, of which the first two were empty (and the CPUs
> in the third default process). So the first thread (cpu 0) wasn't
> in the first process, but in the last one.



Applied to target-arm.next, thanks.

-- PMM
