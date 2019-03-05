Received: from eggs.gnu.org ([209.51.188.92]:58996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ndevos@redhat.com>) id 1h1Boc-0001kn-9j
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 10:17:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ndevos@redhat.com>) id 1h1Boa-0003Fd-2g
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 10:17:09 -0500
Date: Tue, 5 Mar 2019 16:16:57 +0100
From: Niels de Vos <ndevos@redhat.com>
Message-ID: <20190305151657.GC16424@ndevos-x270>
References: <20190304162103.18912-1-ndevos@redhat.com>
	<20190304162103.18912-2-ndevos@redhat.com>
	<20190304164144.GR4239@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190304164144.GR4239@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] block/gluster: Handle changed
 glfs_ftruncate signature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-block@nongnu.org, integration@gluster.org, Prasanna Kumar Kalever <prasanna.kalever@redhat.com>, qemu-devel@nongnu.org, Cole Robinson <crobinso@redhat.com>

On Mon, Mar 04, 2019 at 04:41:44PM +0000, Daniel P. Berrang=E9 wrote:
> On Mon, Mar 04, 2019 at 05:21:02PM +0100, Niels de Vos wrote:
> > From: Prasanna Kumar Kalever <prasanna.kalever@redhat.com>
> >=20
> > New versions of Glusters libgfapi.so have an updated glfs_ftruncate()
> > function that returns additional 'struct stat' structures to enable
> > advanced caching of attributes. This is useful for file servers, not =
so
> > much for QEMU. Nevertheless, the API has changed and needs to be
> > adopted.
> >=20
> > Signed-off-by: Prasanna Kumar Kalever <prasanna.kalever@redhat.com>
> > Signed-off-by: Niels de Vos <ndevos@redhat.com>
> >=20
> > ---
> > v4: rebase to current master branch
> > v3: define old backwards compatible glfs_ftruncate() macro, from Eric=
 Blake
> > v2: do a compile check as suggested by Eric Blake
> > ---
> >  block/gluster.c | 11 +++++++++--
> >  configure       | 18 ++++++++++++++++++
> >  2 files changed, 27 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/block/gluster.c b/block/gluster.c
> > index af64330211..86e5278524 100644
> > --- a/block/gluster.c
> > +++ b/block/gluster.c
> > @@ -20,6 +20,10 @@
> >  #include "qemu/option.h"
> >  #include "qemu/cutils.h"
> > =20
> > +#ifdef CONFIG_GLUSTERFS_LEGACY_FTRUNCATE
> > +# define glfs_ftruncate(fd, offset, _u1, _u2) glfs_ftruncate(fd, off=
set)
> > +#endif
>=20
> I don't much like this approach as it sets up a trapdoor. If future
> QEMU passes a non-NULL value for the 3rd/4th argument it will be
> silently ignored depending on glfs version built against which can
> result in incorrect behaviour at runtime. If we reverse it:
>=20
>  #ifndef CONFIG_GLUSTERFS_LEGACY_FTRUNCATE
>  # define glfs_ftruncate(fd, offset) glfs_ftruncate(fd, offset, NULL, N=
ULL)
>  #endif
>=20
> then it ensures we can't silently do the wrong thing in future. Anyone
> who wants to use the 3rd/4th args will have to make an explicit effort
> to ensure it works correctly with old glfs APIs. An added benefit is
> that it avoids the following patch chunks.

Thanks for the suggestion. All makes sense and I'll update the patch
accordingly.

Niels
