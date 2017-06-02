Received: from eggs.gnu.org ([2001:4830:134:3::10]:33018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dGmBg-0004ce-5E
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 09:00:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dGmBa-0000SP-Co
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 09:00:20 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:35049)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dGmBa-0000RQ-5A
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 09:00:14 -0400
Received: by mail-wm0-x22b.google.com with SMTP id b84so25195511wmh.0
	for <qemu-devel@nongnu.org>; Fri, 02 Jun 2017 06:00:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1494860396-24930-1-git-send-email-Milos.Stojanovic@rt-rk.com>
References: <1494860396-24930-1-git-send-email-Milos.Stojanovic@rt-rk.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Jun 2017 13:59:52 +0100
Message-ID: <CAFEAcA_mdff9cLQYv76_0HLUX9Fs3iaGNVR73QZE+Yv=k=+=eg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 00/16] Augment support for signal
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWlsb8WhIFN0b2phbm92acSH?= <Milos.Stojanovic@rt-rk.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>, Miodrag.Dinic@rt-rk.com, Laurent Vivier <laurent@vivier.eu>, Petar Jovanovic <Petar.Jovanovic@rt-rk.com>, Aleksandar Markovic <Aleksandar.Markovic@rt-rk.com>, Yongbok Kim <yongbok.kim@imgtec.com>

On 15 May 2017 at 15:59, Milo=C5=A1 Stojanovi=C4=87 <Milos.Stojanovic@rt-rk=
.com> wrote:
> D. Add support for larger target signal range (RFC patches 10-16):
>
>    Add target signal mask tracking and multiplexing of target signals out
>    of the host range. The patches are marked as RFC because they introduc=
e
>    significant new functionalities regarding signal handling in QEMU.
>
>    Currently, QEMU has a copy of the host signal and suspend masks and
>    that is usually enough, since most of the time the signal mask of the
>    target architecture is either the same length or narrower. If however
>    the signal mask is wider, then part of it won't be tracked. The signal=
s
>    that are in the target range but out of the host range were treated li=
ke
>    faulty signals and couldn't be used. This problem is solved by enablin=
g
>    the usage of one of the host signals as a multiplex for all the target
>    signals that are out of range. In order to have the target signal mask=
s
>    available, tracking of target signal masks is implemented.
>
>    The rt_sigqueueinfo()/rt_tgsigqueueinfo() system calls multiplex targe=
t
>    signals by setting the si_errno value to the actual value of the signa=
l
>    and sending the signal to a predefined host signal number.
>    The host_signal_handler() will pull out the multiplexed signals and se=
t
>    their signal number to the correct value. The si_errno field is used
>    here but this implementation can be replaced with any other unused fie=
ld
>    in the uinfo structure. Using this implementation both rt_sigqueueinfo=
(),
>    rt_tgsigqueueinfo(), as well as kill() (for pid > 0) and tgkill() can =
be
>    emulated.
>
>    The tkill() system call and kill() with the argument pid <=3D 0 couldn=
't
>    be implemented simply using this method because it requires acquiring
>    information about, and sending simultaneous signals to multiple thread=
s
>    or processes. These functionalities are out of the scope of
>    rt_sigqueueinfo()/rt_tgsigqueueinfo().

This certainly sounds good -- can it fix our problems with clashes
between the host libc and guest libc use of signals?

I do wonder if this is opening up subtle bugs, though: if the
guest does:
  * block signal X
  * some syscall
  * unblock X

then we shouldn't interrupt the syscall if signal X arrives.
That works when we use host signal X for guest signal X because
we just block host signal X. But I don't see how it works if X
has to be multiplexed.

As an implementation point: I see you've implemented this with
ifdefs. I think that if we're going to do it we should do it
always, because it's always the case that there are guest signals
that we can't directly represent with host signals, because of
the host libc stealing a couple for its internal use, so we always
need to multiplex at least a few signals. It also makes it easier
to reason about and test if everything is using the same code paths.

thanks
-- PMM
