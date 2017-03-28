Received: from eggs.gnu.org ([2001:4830:134:3::10]:38831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1csqCh-0003Wq-8e
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 08:26:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1csqCg-0000qj-8d
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 08:26:27 -0400
Date: Tue, 28 Mar 2017 20:26:13 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170328122613.GD5207@lemon.lan>
References: <20170316212351.13797-1-jsnow@redhat.com>
	<CAJSP0QU1g9iijqMnrf27Yp5BTr_U4c--+GqYTnvnVtyud0O2Gw@mail.gmail.com>
	<bb9eafce-797e-3d94-d6da-4b519772fcaf@redhat.com>
	<20170324152755.GR12560@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170324152755.GR12560@stefanha-x1.localdomain>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 0/3] block: pause block
 jobs for bdrv_drain_begin/end
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>

On Fri, 03/24 15:27, Stefan Hajnoczi wrote:
> On Thu, Mar 23, 2017 at 06:57:14PM +0100, Paolo Bonzini wrote:
> >=20
> >=20
> > On 23/03/2017 18:44, Stefan Hajnoczi wrote:
> > >> It's possible to wedge QEMU if the guest tries to reset a virtio-p=
ci
> > >> device as QEMU is also using the drive for a blockjob. This patchs=
et
> > >> aims to allow us to safely pause/resume jobs attached to individua=
l
> > >> nodes in a manner similar to how bdrv_drain_all_begin/end do.
> > >=20
> > > Weird, I thought the 0 nanosecond sleep that block jobs do in their
> > > main loop allows aio_poll() loops to finish.
> >=20
> > The 0 nanosecond sleep is now done in the BDS AioContext rather than =
in=20
> > the "non-aio_poll-aware" main loop:
> >=20
> >     commit 0b9caf9b3166c8deb3c4f3a774c2384b069dc29c
> >     Author: Fam Zheng <famz@redhat.com>
> >     Date:   Tue Aug 26 15:15:43 2014 +0800
> >=20
> >     coroutine: Drop co_sleep_ns
> >    =20
> >     block_job_sleep_ns is the only user. Since we are moving towards
> >     AioContext aware code, it's better to use the explicit version an=
d drop
> >     the old one.
> >    =20
> >     Signed-off-by: Fam Zheng <famz@redhat.com>
> >     Reviewed-by: Beno=EEt Canet <benoit.canet@nodalink.com>
> >     Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> But we hold the AioContext lock and are calling aio_poll(), so I would
> expect our loop to terminate.  The blockjob coroutine should still be
> leaving this little gap in activity during which the aio_poll() loop
> finishes.

I am not sure, but at each gap, aio_poll() is free to fire the 0 nanoseco=
nd
sleep timer cb already, which will generate more I/O. The correct thing i=
s, like
in this series, set the pause flag.

Fam
