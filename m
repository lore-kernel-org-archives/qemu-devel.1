Received: from eggs.gnu.org ([2001:4830:134:3::10]:37114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fyGYB-0003U2-3o
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 09:11:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fyGY9-0007ts-SZ
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 09:11:51 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:37855)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fyGY9-0007rP-G5
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 09:11:49 -0400
Received: by mail-wm0-x22b.google.com with SMTP id n11-v6so14564347wmc.2
	for <qemu-devel@nongnu.org>; Fri, 07 Sep 2018 06:11:49 -0700 (PDT)
MIME-Version: 1.0
References: <20180713130916.4153-1-marcandre.lureau@redhat.com>
	<20180829095035.GI31005@redhat.com>
	<CAMxuvayUDC+dZegONEwto36qTqaJFUEF9UrvNiY+1HJ_6nrzYg@mail.gmail.com>
In-Reply-To: <CAMxuvayUDC+dZegONEwto36qTqaJFUEF9UrvNiY+1HJ_6nrzYg@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 7 Sep 2018 17:11:36 +0400
Message-ID: <CAJ+F1CKcSkd6aKPBss6eNtaD8-NonafNdyLB_66BsH5sKParPA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 00/29] vhost-user for input & GPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: David Airlie <airlied@redhat.com>, QEMU <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

 Hi

On Wed, Aug 29, 2018 at 4:00 PM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Hi
>
> On Wed, Aug 29, 2018 at 11:50 AM, Daniel P. Berrang=C3=A9
> <berrange@redhat.com> wrote:
> > On Fri, Jul 13, 2018 at 03:08:47PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> >> Hi,
> >>
> >> vhost-user allows to drive a virtio device in a seperate
> >> process. After vhost-user-net, we have seen
> >> vhost-user-{scsi,blk,crypto} added more recently.
> >>
> >> This series, initially proposed 2 years ago
> >> (https://lists.gnu.org/archive/html/qemu-devel/2016-06/msg01905.html)
> >> contributes with vhost-user-input and vhost-user-gpu.
> >>
> >> Additionally, to factor out common code and ease the usage, a
> >> vhost-user-backend is introduced as an intermediary object between the
> >> backend and the qemu device.
> >>
> >> You may start a vhost-user-gpu with virgl rendering in a separate
> >> process like this:
> >>
> >> $ ./vhost-user-gpu --virgl -s vgpu.sock &
> >> $ qemu...
> >>   -chardev socket,id=3Dchr,path=3Dvgpu.sock
> >>   -object vhost-user-backend,id=3Dvug,chardev=3Dchr
> >>   -device vhost-user-vga,vhost-user=3Dvug
> >>
> >> You may also specify the backend command and the arguments as part of
> >> vhost-user-backend qemu arguments. For example, to start a
> >> vhost-user-input backend on input device /dev/input/event19:
> >>
> >> -object vhost-user-backend,id=3Dvuid,cmd=3D"vhost-user-input /dev/inpu=
t/event19"
> >> -device virtio-input-host-pci,vhost-user=3Dvuid
> >>
> >> The vhost-user-gpu backend requires virgl from git.
> >>
> >> The libvirt support is on-going work:
> >> https://github.com/elmarco/libvirt/commits/vhost-user-gpu
> >>
> >> The GPU benchmarks are encouraging, giving up to x5 performance on
> >> Unigine Heaven 4.0.
> >
> > What is the main driving motivation behind this featureset ? Is it aime=
d
> > at providing performance, or security, or allowing arbitrary out of tre=
e
> > backends, or all three ?
>
> Mainly security/stability & performance. Allowing arbitrary out of
> tree backends is a bonus for me, I don't care much if we don't allow
> it.
>
> > Although we've got a number of vhost-user backends I'm pretty concerned
> > about the direction this is taking QEMU overall.
> >
> > Managing QEMU is non-trivial for a number of reasons. We've done a lot =
of
> > work to provide standardized modelling of CLI args, guest ABI stability
> > via association with machine types, migration data stream stability,
> > QEMU feature capabilities detection and so on.
> >
> > The move to outsource backends to external binaries is discarding some
> > or all of these items, rewinding alot of progress we've made in the
> > managability of QEMU. Each external binary has to now reinvent the
> > things that are already solved in QEMU, and you can be sure each impl
> > will reinvent the concepts differently.
> >
> > I can't help feeling that we are shooting ourselves in the foot here
> > long term.
>
> I have a bit of the same feeling. For ex, I was a bit reluctant having
> the TPM emulator as an external process (new protocol, external
> binaries, with various management work, "opaque" migration). But in
> the end, the integration with libvirt makes thing quite easy for the
> user. So I changed a bit my mind, and I think this is one task that
> libvirt can be really good at.
>
> >
> > We've always rejected the idea of having loadable modules in QEMU, but
> > as a result we've end up with outsourcing the backend entirely via the
> > vhost-user framework, so the end result is even more opaque than if we
> > had loadable modules, and is unable to take advantage of our standardiz=
ed
> > modelling frameworks & capabilities :-(
>
> I agree, that's one of the reason I put together libvhostuser in the
> first place. If qemu ships its own backend, there is no reason we
> don't share modelling & code etc.
>
> For ex, I hope more vhost-users will use the -object
> vhost-user-backend to do basic connection and virtio setup. (in the
> series, -gpu and -input, I didn't really investigate -crypto, -net,
> -blk etc)
>
> > If we just look at performance & security, and ignore 3rd party impls
> > for a minute, I really don't like that to gain perf + security  we have
> > to change from:
> >
> >  $ qemu...
> >    -device virtio-vga
> >
> > To
> >
> >  $ ./vhost-user-gpu --virgl -s vgpu.sock &
> >  $ qemu...
> >    -chardev socket,id=3Dchr,path=3Dvgpu.sock
> >    -object vhost-user-backend,id=3Dvug,chardev=3Dchr
> >    -device vhost-user-vga,vhost-user=3Dvug
> >
>
> That's a bit incovenient for qemu command line users. But who runs
> qemu this way but some developers? (others have higher-level scripts /
> tools or libvirt)
>
> > Once we have the ability to run the backend via an external process,
> > to gain performance & security benefits, assuming feature parity is
> > achieved, I question why anyone would want to continue with the old
> > in-process approach ? IOW the goal should be that the original args
> >
> >  $ qemu...
> >    -device virtio-vga
> >
> > should "do the right thing" to launch the external process when you
> > have upgraded to a new enough QEMU, so that everyone immediately
> > benefits from the more secure & performant architecture.
>
>
> That's not incompatible with having the lengthy version. But this
> comes with some downside atm, since migration is not implemented for
> ex (for 2d, virgl doesn't have migration).
>
> And seccomp spawn rule disable forking.
>
> And libvirt will probably want to manage the external process for
> security/resource/tweaking reasons.

I would like to make progress on this, but I feel a bit stuck. As
explained earlier, libvirt will have to manage the external processes.
So what we would like to see, is a stable interface for the various
vhost-user backends.

I suggest the vhost-user binary (vhost-user-gpu or vhost-user-input
etc), the default binary be in the system PATH, so that libvirt & co
can find it. Host administrator can use update-alternative or such if
they are other implementations. (other selections mechanisms can be
added later)

I thinks the vhost-user backends could have the following common
options handling:
- take a "--fd=3DFDNUM" argument, that would indicate which fd the
socket has been passed on.
- OR take a "--socket-path=3DPATH"
- optionally? take a "--pid=3DPATH" argument, to write out the process PID

We probably need a way to list the capabilities of the backend.:
--dump-caps, could list known keywords, one per line? (grab, virgl,
opengles, etc...)

Other options may vary based on the backend type, for ex:
- vhost-user-input EVDEV-PATH (required)
- vhost-user-gpu --render-node=3DPATH (optional)

I am not sure how this should be documented.

Any help appreciated!
thanks

--=20
Marc-Andr=C3=A9 Lureau
