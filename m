Received: from eggs.gnu.org ([209.51.188.92]:48246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goQHC-0002eZ-3n
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 05:05:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goQH8-0004jO-DU
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 05:05:52 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:37579)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1goQH1-0004Nn-7v
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 05:05:46 -0500
Received: by mail-ot1-x343.google.com with SMTP id s13so17374699otq.4
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 02:05:22 -0800 (PST)
MIME-Version: 1.0
References: <20181207090135.7651-1-luc.michel@greensocs.com>
	<20181207090135.7651-8-luc.michel@greensocs.com>
	<CAMo8Bf+siB=vdjK+WPKvRCqKS59OVGOcAoH0HtN6VSvFyOc9gQ@mail.gmail.com>
In-Reply-To: <CAMo8Bf+siB=vdjK+WPKvRCqKS59OVGOcAoH0HtN6VSvFyOc9gQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Jan 2019 10:05:10 +0000
Message-ID: <CAFEAcA9uVMs8aGTcbUpz+EGGyFBXtCNVMT-_t5eYPBjJF_4Rrw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 07/16] gdbstub: add multiprocess support
 to (f|s)ThreadInfo and ThreadExtraInfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: Luc Michel <luc.michel@greensocs.com>, qemu-devel <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, Alistair Francis <alistair@alistair23.me>, Mark Burton <mark.burton@greensocs.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Sai Pavan Boddu <saipava@xilinx.com>, Edgar Iglesias <edgari@xilinx.com>, qemu-arm <qemu-arm@nongnu.org>

On Tue, 29 Jan 2019 at 04:56, Max Filippov <jcmvbkbc@gmail.com> wrote:
>
> Hello,
>
> On Fri, Dec 7, 2018 at 1:04 AM Luc Michel <luc.michel@greensocs.com> wrot=
e:
> >
> > Change the thread info related packets handling to support multiprocess
> > extension.
> >
> > Add the CPUs class name in the extra info to help differentiate
> > them in multiprocess mode.
> >
> > Signed-off-by: Luc Michel <luc.michel@greensocs.com>
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> > ---
> >  gdbstub.c | 37 +++++++++++++++++++++++++++----------
> >  1 file changed, 27 insertions(+), 10 deletions(-)
>
> Starting with this commit it is no longer possible to kill QEMU
> with the 'kill' command from the gdb. This was a nice feature,
> was this removal intentional, or is it just an implementation
> bug?

That sounds like a bug. I think with the multiprocess extensions
available gdb may switch from killing using the 'k' packet to using
the 'vKill;pid' packet, which we don't implement? Looking at
what gdb is sending ('set debug remote 1' turns on logging in
gdb of remote protocol packets) would let us check that theory.
It's not clear how our implementation should deal with being asked
to kill just one process if we have more than one, though...

thanks
-- PMM
