Received: from eggs.gnu.org ([2001:4830:134:3::10]:51426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephane.duverger@gmail.com>) id 1fcr4O-0007PY-Hv
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 07:44:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephane.duverger@gmail.com>) id 1fcr4M-0005bU-UI
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 07:44:36 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:41283)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stephane.duverger@gmail.com>)
	id 1fcr4M-0005bO-Nx
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 07:44:34 -0400
Received: by mail-oi0-x244.google.com with SMTP id k12-v6so41936438oiw.8
	for <qemu-devel@nongnu.org>; Tue, 10 Jul 2018 04:44:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180709125452.7utyomtsxr6xaxdi@vm.localdomain>
	<878t6ke7qh.fsf@linaro.org>
In-Reply-To: <878t6ke7qh.fsf@linaro.org>
From: stephane duverger <stephane.duverger@gmail.com>
Date: Tue, 10 Jul 2018 13:44:22 +0200
Message-ID: <CAGF1vyGaPwZ9nBFJYJjJQPG8g8Ahdf1Y8USGnRr=-6DibJxxHg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] fix gdbserver_state pointer validation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.bennee@linaro.org, qemu-devel@nongnu.org

Hi Alex,

There don't seem to be any other patches attached? I would NACK a patch
> that isn't actually used in-tree.


No there isn't ! I should have not been so prolix. Actually the patch
corrects a
possible null pointer dereference in the gdbserver code. That's all folks.

Below is how I discovered it and why it matters, imho, to be fixed
(out of a pending issue).

This null deref does not happen in normal operation because of the way
gdbserver is initialized. However what I was telling you, is that it may be
really interesting to be able to take benefit of some gdb features
internally
without starting a gdbserver and the overhead of the gdb protocol when
there is no need for a client/server interaction while debugging.

For instance, I developed a special purpose x86 board where I needed to
break at some instructions, do some automation (snapshots, vm memory
access, cpu analysis) and then resume the VM. Implementing a
"vm_change_state handler" and dealing with RUN_STATE_DEBUG was
perfect for my need.

The debug events (#BP, #DB) are tied to the gdbserver stub, at some point
when "cpu_handle_guest_debug()" is called, a call to "gdb_set_stop_cpu()"
triggers the NULL deref because the gdbserver is not initialized.

My little fix addresses this error and allows to make use of the following
Qemu
breakpoint functions without touching "cpus.c" or "exec.c":
- cpu_breakpoint_remove/insert()
- kvm_remove/insert_breakpoint()

Notice, that in the particular case of KVM, I had to async_run_on_cpu() my
debug handler instead of directly executing it in the context of
vm_change_state(). The vCPU started to significantly slow down
(low irq rate), while this never happens with the TCG.

Is that more clear to you Alex ? (and hopefully lead to patch ACK :)

Regards,

stephane

> Signed-off-by: Stephane Duverger <stephane.duverger@gmail.com>
> > ---
> >  gdbstub.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/gdbstub.c b/gdbstub.c
> > index d6ab95006c..788fd625ab 100644
> > --- a/gdbstub.c
> > +++ b/gdbstub.c
> > @@ -1412,6 +1412,9 @@ static int gdb_handle_packet(GDBState *s, const
> char *line_buf)
> >
> >  void gdb_set_stop_cpu(CPUState *cpu)
> >  {
> > +    if (!gdbserver_state) {
> > +        return;
> > +    }
> >      gdbserver_state->c_cpu =3D cpu;
> >      gdbserver_state->g_cpu =3D cpu;
> >  }
>
>
> --
> Alex Benn=C3=A9e
>
