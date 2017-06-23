Received: from eggs.gnu.org ([2001:4830:134:3::10]:44370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dOMmz-0000vC-8k
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 07:30:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dOMmv-00074I-Bp
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 07:30:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51024)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dOMmv-00071e-6B
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 07:30:09 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F3A38B9AC3
	for <qemu-devel@nongnu.org>; Fri, 23 Jun 2017 11:30:06 +0000 (UTC)
Date: Fri, 23 Jun 2017 08:29:53 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170623112953.GD20956@localhost.localdomain>
References: <20170621140219.4568-1-marcandre.lureau@redhat.com>
	<84972d96-ea88-01e4-c146-8cbe3143c571@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <84972d96-ea88-01e4-c146-8cbe3143c571@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 0/3] Add memfd memory backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, imammedo@redhat.com

On Thu, Jun 22, 2017 at 11:58:14AM +0200, David Hildenbrand wrote:
> On 21.06.2017 16:02, Marc-Andr=E9 Lureau wrote:
> > Add a new Linux-specific memory backend, similar to hostmem-file,
> > except that it doesn't need file path. It also try to enforce memory
> > sealing if available. It is thus slightly easier and secure, and is
> > compatible with transparent huge-pages since Linux 4.8.
> >=20
> > v4:
> > - rebased, now that preliminary patches are merged
> >=20
> > v3:
> > - make vhost-user-test use memfd only if possible
> > - rebased
> >=20
> > v1->v2:
> > - make it linux-specific
> > - minor changes and commit message tweaks
> >=20
> > Marc-Andr=E9 Lureau (3):
> >   memfd: split qemu_memfd_alloc()
> >   Add memfd based hostmem
> >   tests: use memfd in vhost-user-test
> >=20
> >  include/qemu/memfd.h     |  2 ++
> >  backends/hostmem-memfd.c | 67 ++++++++++++++++++++++++++++++++++++++=
+++++++++
> >  tests/vhost-user-test.c  | 68 +++++++++++++++++++++++++++++++-------=
----------
> >  util/memfd.c             | 42 ++++++++++++++++++------------
> >  backends/Makefile.objs   |  2 ++
> >  qemu-options.hx          | 11 ++++++++
> >  6 files changed, 151 insertions(+), 41 deletions(-)
> >  create mode 100644 backends/hostmem-memfd.c
> >=20
>=20
> Just wondering if it would make more sense to add a new parameter to th=
e
> ram backend. Sorry if this has already been discussed.

That was my first thought, too.  But although it requires more
boilerplate code, a separate class gives us better input
specification/validation for free: e.g. if we add memfd-specific options
in the future, we don't even need to document them as "valid only in
memfd mode", because they will exist only in the memfd class.

--=20
Eduardo
