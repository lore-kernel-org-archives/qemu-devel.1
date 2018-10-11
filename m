Received: from eggs.gnu.org ([2001:4830:134:3::10]:57156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gAcZq-0003Rs-T5
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 11:08:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gAcZp-0003PX-2p
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 11:08:38 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:46158)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <artem.k.pisarenko@gmail.com>)
	id 1gAcZo-0003P6-OB
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 11:08:36 -0400
Received: by mail-oi1-x243.google.com with SMTP id k64-v6so7295555oia.13
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 08:08:36 -0700 (PDT)
MIME-Version: 1.0
References: <20181010133333.24538.53169.stgit@pasha-VirtualBox>
	<20181010133522.24538.48800.stgit@pasha-VirtualBox>
In-Reply-To: <20181010133522.24538.48800.stgit@pasha-VirtualBox>
From: Artem Pisarenko <artem.k.pisarenko@gmail.com>
Date: Thu, 11 Oct 2018 21:08:23 +0600
Message-ID: <CANzW0msTj3-F2WmqBfWQEBxcbZ684gOsKWUvQp0TEWatJ426Lg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 19/19] replay: document development rules
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, war2jordan@live.com, mst@redhat.com, jasowang@redhat.com, zuban32s@gmail.com, kraxel@redhat.com, thomas.dullien@googlemail.com, quintela@redhat.com, ciro.santilli@gmail.com, armbru@redhat.com, dovgaluk@ispras.ru, dgilbert@redhat.com, boost.lists@gmail.com, alex.bennee@linaro.org, rth@twiddle.net, kwolf@redhat.com, crosthwaite.peter@gmail.com, mreitz@redhat.com, maria.klimushenkova@ispras.ru, pbonzini@redhat.com

Great! I'm voting with all my fingers up for such rules. But I would
suggest even more generic rules which prevent breaking determinism in a
more wide sense. At least, where such breakage is trivial to avoid.

Currently I'm working on modification, which extends conditions where guest
execution is kept deterministic, above such narrow set like "only rtc
clock=3Dvm, no serial devices, no network, no external communication
interfaces at all, etc...". Also I'm dealing with bugs (features?), which
prevents advertised determinism even in such restricted conditions. I found
that my work involves very similar efforts as Pavel's work. And this is
extra hard work. I'm feeling like fighting with hundreds of maintainers and
contributors, whose efforts are in opposite direction. They starting from
qemu underlying core, encouraging asyncronous  processing (aio, threads,
virtio ioeventfd, etc.), and ending with particular modules or hardware
models, which negligently uses any kind of non-blocking calls, callbacks,
and even inappropriate QEMUClockType. Nobody cares about synchronization
with vcpu thread, except Pavel, me and, possibly, 1-2 more persons in a
whole world. I can understand why. Main reason is that it might greatly
degradate performance of emulation, which might be avoided by introducing
very high complexity. So, my words shouldn't be treated as any kind of
criticism. I perfectly understand that it's a complex issue.

Key difference of record/replay is that it solves problem by hooking calls
of any source of asynchrony at low level and just replaying it. In other
words, it deals with end effects, whereas non-record/replay use case
doesn't allow such solution and have to eliminate source of undesired
asynchrony by design. As such, record/replay have strong immunity to
violation of 'generic determinism' rules and even to hidden and tricky bugs
in any module which affects guest state. And that's why development rules
Pavel imposes are so democratic (relative to generic ones, I would like to
exist).

Anyway, it's just generic idea for discussion. I know, it needs to be more
specific. But, if nobody will express interest, I see no reason to continue=
.

P.S. Trivial example of how qemu could extend conditions for deterministic
execution. =D0=A1hardev would perform writing to backend using blocking cal=
ls,
thus making possible deterministic execution in use cases, where guest has
only one serial port which outputs data to console and have no interaction
with user. At least it would provide user with option, selecting between
better performance and determinism.


=D1=81=D1=80, 10 =D0=BE=D0=BA=D1=82. 2018 =D0=B3. =D0=B2 19:32, Pavel Dovga=
lyuk <Pavel.Dovgaluk@ispras.ru>:

> This patch introduces docs/devel/replay.txt which describes the rules
> that should be followed to make virtual devices usable in record/replay
> mode.
>
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgauk@ispras.ru>
> ---
>  docs/devel/replay.txt |   45 +++++++++++++++++++++++++++++++++++++++++++=
++
>  1 file changed, 45 insertions(+)
>  create mode 100644 docs/devel/replay.txt
>
> diff --git a/docs/devel/replay.txt b/docs/devel/replay.txt
> new file mode 100644
> index 0000000..61dac1b
> --- /dev/null
> +++ b/docs/devel/replay.txt
> @@ -0,0 +1,45 @@
> +Record/replay mechanism, that could be enabled through icount mode,
> expects
> +the virtual devices to satisfy the following requirements.
> +
> +The main idea behind this document is that everything that affects
> +the guest state during execution in icount mode should be deterministic.
> +
> +Timers
> +=3D=3D=3D=3D=3D=3D
> +
> +All virtual devices should use virtual clock for timers that change the
> guest
> +state. Virtual clock is deterministic, therefore such timers are
> deterministic
> +too.
> +
> +Virtual devices can also use realtime clock for the events that do not
> change
> +the guest state directly. When the clock ticking should depend on VM
> execution
> +speed, use virtual ext clock. It is not deterministic, but its speed
> depends
> +on the guest execution. This clock is used by the virtual devices (e.g.,
> +slirp routing device) that lie outside the replayed guest.
> +
> +Bottom halves
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Bottom half callbacks, that affect the guest state, should be invoked
> through
> +replay_bh_schedule_event or replay_bh_schedule_oneshot_event functions.
> +Their invocations are saved in record mode and synchronized with the
> existing
> +log in replay mode.
> +
> +Saving/restoring the VM state
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> +
> +All fields in the device state structure (including virtual timers)
> +should be restored by loadvm to the same values they had before savevm.
> +
> +Avoid accessing other devices' state, because the order of
> saving/restoring
> +is not defined. It means that you should not call functions like
> +'update_irq' in post_load callback. Save everything explicitly to avoid
> +the dependencies that may make restoring the VM state non-deterministic.
> +
> +Stopping the VM
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Stopping the guest should not interfere with its state (with the excepti=
on
> +of the network connections, that could be broken by the remote timeouts)=
.
> +VM can be stopped at any moment of replay by the user. Restarting the VM
> +after that stop should not break the replay by the unneeded guest state
> change.
>
> --

=D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC,
  =D0=90=D1=80=D1=82=D0=B5=D0=BC =D0=9F=D0=B8=D1=81=D0=B0=D1=80=D0=B5=D0=BD=
=D0=BA=D0=BE
