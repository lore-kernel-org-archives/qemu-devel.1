Received: from eggs.gnu.org ([2001:4830:134:3::10]:51371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dQZaf-0003xn-5y
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:34:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dQZad-00053P-LC
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:34:37 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:35617)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dQZad-00051c-9m
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:34:35 -0400
Received: by mail-lf0-x241.google.com with SMTP id n136so7701714lfn.2
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 06:34:35 -0700 (PDT)
MIME-Version: 1.0
References: <20170621140219.4568-1-marcandre.lureau@redhat.com>
	<20170621140219.4568-3-marcandre.lureau@redhat.com>
	<20170623210845.GA10776@localhost.localdomain>
	<CAJ+F1CLUHM2+hMQqCmN04nwWEMDDDK8104=vK9rnoTsetw9JVg@mail.gmail.com>
	<20170628182943.GJ12152@localhost.localdomain>
In-Reply-To: <20170628182943.GJ12152@localhost.localdomain>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 29 Jun 2017 13:34:22 +0000
Message-ID: <CAJ+F1C+79Hfd+7J2nS7=+4awjW6nqGSaVrWDx9P8O-8FCuBsdQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 2/3] Add memfd based hostmem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: imammedo@redhat.com, qemu-devel@nongnu.org

Hi

On Wed, Jun 28, 2017 at 8:29 PM Eduardo Habkost <ehabkost@redhat.com> wrote=
:

> On Tue, Jun 27, 2017 at 08:23:03AM +0000, Marc-Andr=C3=A9 Lureau wrote:
> > Hi Eduardo
> >
> > On Fri, Jun 23, 2017 at 11:09 PM Eduardo Habkost <ehabkost@redhat.com>
> > wrote:
> >
> > > On Wed, Jun 21, 2017 at 04:02:18PM +0200, Marc-Andr=C3=A9 Lureau wrot=
e:
> > > > Add a new memory backend, similar to hostmem-file, except that it
> > > > doesn't need to create files. It also enforces memory sealing.
> > > >
> > > > This backend is mainly useful for sharing the memory with other
> > > > processes.
> > >
> > > How exactly can the memfd be used to share memory?  Is there an
> existing
> > > mechanism for sharing the memfd file descriptor with another process
> >
> >
> >
> > Since there is no backing file, the traditional mechanism is by passing
> fd,
> > via socket ancillary data or forking etc.. Both ivshmem and vhost-user
> have
> > such messages, with eventually details for the memory map usage.
>
> The documentation is very similar to memory-backend-file, so it sounded
> like there was a generic mechanism to ask QEMU to share the backend FD.
> Maybe it would be interesting to mention on which cases the FD can
> actually be shared.  Are ivshmem and vhost-user the only existing cases?
>
>
Actually, vhost-user may be the only way today to get the fd outside of
qemu process.

(ivshmem needs the server to provide the fd)

We could quite easily add or extend QMP messages for that in the future.

Do you want this detail to be written in the commit message or elsewhere?


> >
> >
> > > >
> > > > Note that Linux supports transparent huge-pages of shmem/memfd memo=
ry
> > > > since 4.8. It is relatively easier to set up THP than a dedicate
> > > > hugepage mount point by using "madvise" in
> > > > /sys/kernel/mm/transparent_hugepage/shmem_enabled.
> > > >
> > > > Usage:
> > > > -object memory-backend-memfd,id=3Dmem1,size=3D1G
> > > >
> > > > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > > > ---
> > > >  backends/hostmem-memfd.c | 67
> > > ++++++++++++++++++++++++++++++++++++++++++++++++
> > > >  backends/Makefile.objs   |  2 ++
> > > >  qemu-options.hx          | 11 ++++++++
> > > >  3 files changed, 80 insertions(+)
> > > >  create mode 100644 backends/hostmem-memfd.c
> > > >
> > > [...]
> > >
> > > --
> > > Eduardo
> > >
> > > --
> > Marc-Andr=C3=A9 Lureau
>
> --
> Eduardo
>
--=20
Marc-Andr=C3=A9 Lureau
