Received: from eggs.gnu.org ([2001:4830:134:3::10]:49778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fuxks-0000Hc-8f
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 06:31:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fuxc2-00089F-9b
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 06:22:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44812 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fuxc1-00087Y-UI
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 06:22:10 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 870487788D
	for <qemu-devel@nongnu.org>; Wed, 29 Aug 2018 10:22:08 +0000 (UTC)
Date: Wed, 29 Aug 2018 11:22:01 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180829102201.GA2660@work-vm>
References: <20180713130916.4153-1-marcandre.lureau@redhat.com>
	<20180829095035.GI31005@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180829095035.GI31005@redhat.com>
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
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, airlied@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com

* Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> On Fri, Jul 13, 2018 at 03:08:47PM +0200, Marc-Andr=E9 Lureau wrote:
> > Hi,
> >=20
> > vhost-user allows to drive a virtio device in a seperate
> > process. After vhost-user-net, we have seen
> > vhost-user-{scsi,blk,crypto} added more recently.
> >=20
> > This series, initially proposed 2 years ago
> > (https://lists.gnu.org/archive/html/qemu-devel/2016-06/msg01905.html)
> > contributes with vhost-user-input and vhost-user-gpu.
> >=20
> > Additionally, to factor out common code and ease the usage, a
> > vhost-user-backend is introduced as an intermediary object between th=
e
> > backend and the qemu device.
> >=20
> > You may start a vhost-user-gpu with virgl rendering in a separate
> > process like this:
> >=20
> > $ ./vhost-user-gpu --virgl -s vgpu.sock &
> > $ qemu...
> >   -chardev socket,id=3Dchr,path=3Dvgpu.sock
> >   -object vhost-user-backend,id=3Dvug,chardev=3Dchr
> >   -device vhost-user-vga,vhost-user=3Dvug
> >=20
> > You may also specify the backend command and the arguments as part of
> > vhost-user-backend qemu arguments. For example, to start a
> > vhost-user-input backend on input device /dev/input/event19:
> >=20
> > -object vhost-user-backend,id=3Dvuid,cmd=3D"vhost-user-input /dev/inp=
ut/event19"
> > -device virtio-input-host-pci,vhost-user=3Dvuid
> >=20
> > The vhost-user-gpu backend requires virgl from git.
> >=20
> > The libvirt support is on-going work:
> > https://github.com/elmarco/libvirt/commits/vhost-user-gpu
> >=20
> > The GPU benchmarks are encouraging, giving up to x5 performance on
> > Unigine Heaven 4.0.
>=20
> What is the main driving motivation behind this featureset ? Is it aime=
d
> at providing performance, or security, or allowing arbitrary out of tre=
e
> backends, or all three ?
>=20
> Although we've got a number of vhost-user backends I'm pretty concerned
> about the direction this is taking QEMU overall.
>=20
> Managing QEMU is non-trivial for a number of reasons. We've done a lot =
of
> work to provide standardized modelling of CLI args, guest ABI stability
> via association with machine types, migration data stream stability,
> QEMU feature capabilities detection and so on.
>=20
> The move to outsource backends to external binaries is discarding some
> or all of these items, rewinding alot of progress we've made in the
> managability of QEMU. Each external binary has to now reinvent the
> things that are already solved in QEMU, and you can be sure each impl
> will reinvent the concepts differently.
>=20
> I can't help feeling that we are shooting ourselves in the foot here
> long term.
>=20
> We've always rejected the idea of having loadable modules in QEMU, but
> as a result we've end up with outsourcing the backend entirely via the
> vhost-user framework, so the end result is even more opaque than if we
> had loadable modules, and is unable to take advantage of our standardiz=
ed
> modelling frameworks & capabilities :-(
>=20
> If we just look at performance & security, and ignore 3rd party impls
> for a minute, I really don't like that to gain perf + security  we have
> to change from:
>=20
>  $ qemu...
>    -device virtio-vga
> =20
> To
>=20
>  $ ./vhost-user-gpu --virgl -s vgpu.sock &
>  $ qemu...
>    -chardev socket,id=3Dchr,path=3Dvgpu.sock
>    -object vhost-user-backend,id=3Dvug,chardev=3Dchr
>    -device vhost-user-vga,vhost-user=3Dvug
>=20
> Once we have the ability to run the backend via an external process,
> to gain performance & security benefits, assuming feature parity is
> achieved, I question why anyone would want to continue with the old
> in-process approach ? IOW the goal should be that the original args=20
>=20
>  $ qemu...
>    -device virtio-vga
>=20
> should "do the right thing" to launch the external process when you
> have upgraded to a new enough QEMU, so that everyone immediately
> benefits from the more secure & performant architecture.=20

But which external process should it run, under what privilieges
and with sockets placed where?
While it's true it would be good to have a nice simple way, often
the qemu process might not have the privs to run that external process
or know where to put the sockets; that's exactly the type of thing
we're happy to leave to libvirt to wire up.

Dave

> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberr=
ange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange=
.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberr=
ange :|
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
