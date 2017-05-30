Received: from eggs.gnu.org ([2001:4830:134:3::10]:34095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dFejE-0005jj-3R
	for qemu-devel@nongnu.org; Tue, 30 May 2017 06:50:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dFejA-0005fv-77
	for qemu-devel@nongnu.org; Tue, 30 May 2017 06:50:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48472)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dFej9-0005ff-VF
	for qemu-devel@nongnu.org; Tue, 30 May 2017 06:50:16 -0400
Date: Tue, 30 May 2017 18:50:11 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170530105011.GB27787@lemon.lan>
References: <1496048740-26578-1-git-send-email-groug@kaod.org>
	<20170530094212.GL11362@stefanha-x1.localdomain>
	<20170530122112.2dc44db9@bahia.ttt.fr.ibm.com>
	<20170530102622.GG21566@redhat.com>
	<20170530123329.4342ba5d@bahia.ttt.fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170530123329.4342ba5d@bahia.ttt.fr.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/11] 9pfs patches for 2.10 20170525
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On Tue, 05/30 12:33, Greg Kurz wrote:
> On Tue, 30 May 2017 11:26:22 +0100
> "Daniel P. Berrange" <berrange@redhat.com> wrote:
>=20
> > On Tue, May 30, 2017 at 12:21:12PM +0200, Greg Kurz wrote:
> > > On Tue, 30 May 2017 10:42:12 +0100
> > > Stefan Hajnoczi <stefanha@gmail.com> wrote:
> > >  =20
> > > > On Mon, May 29, 2017 at 11:05:29AM +0200, Greg Kurz wrote: =20
> > > > > The following changes since commit 9964e96dc9999cf7f7c936ee854a=
795415d19b60:
> > > > >=20
> > > > >   Merge remote-tracking branch 'jasowang/tags/net-pull-request'=
 into staging (2017-05-23 15:01:31 +0100)
> > > > >=20
> > > > > are available in the git repository at:
> > > > >=20
> > > > >   https://github.com/gkurz/qemu.git tags/for-upstream
> > > > >=20
> > > > > for you to fetch changes up to f0a4da86cff2e600255324793daddd7c=
e59b9862:
> > > > >=20
> > > > >   9pfs: local: metadata file for the VirtFS root (2017-05-25 10=
:30:14 +0200)
> > > > >=20
> > > > > ---------------------------------------------------------------=
-
> > > > > Various bugfixes and code cleanups. Most notably, it fixes meta=
data handling in
> > > > > mapped-file security mode (especially for the virtfs root).   =20
> > > >=20
> > > > Please fix the compiler warning reported by patchew.
> > > >  =20
> > >=20
> > > In file included from /var/tmp/patchew-tester-tmp-3cnydauu/src/hw/9=
pfs/9p-local.c:18:0:
> > > /var/tmp/patchew-tester-tmp-3cnydauu/src/hw/9pfs/9p-local.c: In fun=
ction =E2=80=98local_set_mapped_file_attrat=E2=80=99:
> > > /var/tmp/patchew-tester-tmp-3cnydauu/src/hw/9pfs/9p-util.h:19:5: er=
ror: =E2=80=98map_dirfd=E2=80=99 may be used uninitialized in this functi=
on [-Werror=3Dmaybe-uninitialized]
> > >      close(fd);
> > >      ^~~~~~~~~
> > > /var/tmp/patchew-tester-tmp-3cnydauu/src/hw/9pfs/9p-local.c:235:9: =
note: =E2=80=98map_dirfd=E2=80=99 was declared here
> > >      int map_dirfd, map_fd;
> > >          ^~~~~~~~~
> > > cc1: all warnings being treated as errors
> > >=20
> > > This is a false positive: map_dirfd is necessarily initialized, but=
 I guess
> > > gcc isn't smart enough to see that :-\
> > >=20
> > > It is acceptable to close(-1) so I guess I'll just do:
> > >=20
> > > -    int map_dirfd, map_fd;
> > > +    int map_dirfd =3D -1, map_fd; =20
> >=20
> > By 'acceptable' I guess you mean it'll return EBADF. I would not
> > be surprised, however, if coverity were to then complain if it sees
> > code path where we pass -1 to close, since it is indicative of a
> > potential bug. So in addition to your initialization, also protecting
> > the close() call with '!=3D -1' condition is a safer approach.
> >=20
>=20
> Thanks for the tip, I'll do that as well.
>=20
> BTW is there a way to run patchew without posting to the list ?

Not for the s390 test because there isn't unlimited machine resources,
unfortunately. :)

Fam
