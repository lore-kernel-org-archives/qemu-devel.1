Received: from eggs.gnu.org ([2001:4830:134:3::10]:47330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suda.kyoto@gmail.com>) id 1gNWOF-0003FQ-SJ
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 00:10:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <suda.kyoto@gmail.com>) id 1gNWOE-00063W-My
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 00:09:59 -0500
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a]:36512)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <suda.kyoto@gmail.com>)
	id 1gNWOE-000639-GT
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 00:09:58 -0500
Received: by mail-ot1-x32a.google.com with SMTP id k98so20299261otk.3
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 21:09:58 -0800 (PST)
MIME-Version: 1.0
References: <20181114123643.24091-1-marcandre.lureau@redhat.com>
	<20181114134503.GO19298@redhat.com> <875zwycmm4.fsf@redhat.com>
In-Reply-To: <875zwycmm4.fsf@redhat.com>
From: Akihiro Suda <suda.kyoto@gmail.com>
Date: Fri, 16 Nov 2018 13:09:46 +0800
Message-ID: <CAG8fp8TfWGmmqtgH0RmG2ty3rdWUnbWzCbkkGEk4iBpERXSZ=A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 00/41] RFC: slirp: make it again a
 standalone project
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: gscrivan@redhat.com
Cc: marcandre.lureau@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org, samuel.thibault@ens-lyon.org, rjones@redhat.com, stefanha@redhat.com, renzo@cs.unibo.it

> One change I am aware of in the forked version is the possibility
to tweak the MTU and AFAIK this is the only blocker from adopting
libslirp immediately.
> Akihiro, is there anything more that could block slirp4netns from
just using libslirp once it is available?

No, the only blocker is MTU (which significantly improves the bandwidth
from 1.07 Gbps to 9.21 Gbps :
https://github.com/rootless-containers/slirp4netns/tree/19ec5cf6b8f562ebaed=
6d4004c8b172907ea6adb#benchmarks
)

In future I think we want to support checksum offloading and
multiqueue/multithread, but these can be experimented and discussed after
we get support for the standalone libslirp.
https://github.com/rootless-containers/slirp4netns/issues/16
https://github.com/rootless-containers/slirp4netns/issues/17


2018=E5=B9=B411=E6=9C=8816=E6=97=A5(=E9=87=91) 0:49 Giuseppe Scrivano <gscr=
ivan@redhat.com>:

> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>
> > On Wed, Nov 14, 2018 at 04:36:02PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> >> Hi,
> >>
> >> Based-on: https://people.debian.org/~sthibault/qemu.git/ slirp branch
> >>
> >> This series goal is to allow building libslirp as an independent
> library.
>
> Marc-Andr=C3=A9, thanks for working on this!
>
>
> > At least half of the patches in this series are deleting unused or
> > unreachable code. I'd suggest you send all of those as a non-RFC
> > series, as they are things we could merge straight away regardless
> > of whether/when slirp becomes a separate library.
> >
> >> While looking at making SLIRP a seperate running process, I thought
> >> that having an independent library from QEMU would be a first step.
> >>
> >> There has been some attempts to make slirp a seperate project in the
> past.
> >> (https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg01092.html)
> >> Unfortunately, they forked from QEMU and didn't provide enough
> >> compatibility for QEMU to make use of it (in particular, vmstate
> >> handling was removed, they lost git history etc). Furthermore, they
> >> are not maintained as far as I can see.
> >
> > More recently there is this fun project which just pulled in the
> > QEMU code and chopped out everything todo with slirp:
> >
> >   https://github.com/rootless-containers/slirp4netns
>
> to give a little bit of background on slirp4netns:
>
> slirp4netns is used for setting up the network in a network namespace
> without requiring root privileges.
>
> It is already used by Podman and Buildah to set up the network for
> rootless containers, so they won't be limited to run in the host network
> namespace or require a suid helper.
>
> Coincidentally just today I was working on a slirp4netns change for
> spawning a QEMU process instead of using the forked version.
> I'd prefer to not rely on the slirp forked version, but this costs the
> access to the underlying knobs.  With a separate libslirp project, this
> is not needed anymore.
>
> One change I am aware of in the forked version is the possibility to
> tweak the MTU and AFAIK this is the only blocker from adopting libslirp
> immediately.
> Akihiro, is there anything more that could block slirp4netns from just
> using libslirp once it is available?
>
> Regards,
> Giuseppe
>
