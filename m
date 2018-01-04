Received: from eggs.gnu.org ([2001:4830:134:3::10]:36246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eWv8Z-0002yE-II
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 21:20:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eWv8W-0007kk-Ct
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 21:20:07 -0500
Date: Thu, 4 Jan 2018 10:19:59 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180104021959.GB23237@lemon.usersys.redhat.com>
References: <20171226065300.9890-1-famz@redhat.com>
	<4c7f0e5a-a49c-fc67-7185-5f07cca0f62d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4c7f0e5a-a49c-fc67-7185-5f07cca0f62d@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] osdep: Retry SETLK upon EINTR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-stable@nongnu.org, qemu-block@nongnu.org

On Wed, 01/03 16:57, Eric Blake wrote:
> On 12/26/2017 12:53 AM, Fam Zheng wrote:
> > We could hit lock failure if there is a signal that makes fcntl retur=
n
> > -1 and errno set to EINTR. In this case we should retry.
>=20
> Did you hit this in practice?  In 'man fcntl' on my Fedora 27 box, the
> DESCRIPTION section only mentions EINTR as possible for F_[OFD_]SETLKW,
> but we don't appear to be using that one (just SETLK and GETLK).  On th=
e
> other hand, the ERRORS section of the same document mentions:
>=20
>=20
>        EINTR  cmd  is  F_SETLKW  or  F_OFD_SETLKW and the operation was
> inter=E2=80=90
>               rupted by a signal; see signal(7).
>=20
>        EINTR  cmd is F_GETLK, F_SETLK, F_OFD_GETLK, or  F_OFD_SETLK,
> and  the
>               operation  was  interrupted  by  a  signal  before  the
> lock was
>               checked or acquired.  Most likely when  locking  a  remot=
e
>  file
>               (e.g., locking over NFS), but can sometimes happen locall=
y.
>=20
> (I hate it when information differs between two places in the same
> document, especially if I only read the first place)

Yes, our QE found it when hammering qemu-img convert with SIGUSR1. So bot=
h SETLK
and SETLKW can get EINTR.

>=20
> >=20
> > Cc: qemu-stable@nongnu.org
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > ---
> >  util/osdep.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/util/osdep.c b/util/osdep.c
> > index 1231f9f876..a73de0e1ba 100644
> > --- a/util/osdep.c
> > +++ b/util/osdep.c
> > @@ -244,7 +244,9 @@ static int qemu_lock_fcntl(int fd, int64_t start,=
 int64_t len, int fl_type)
> >          .l_type   =3D fl_type,
> >      };
> >      qemu_probe_lock_ops();
> > -    ret =3D fcntl(fd, fcntl_op_setlk, &fl);
> > +    do {
> > +        ret =3D fcntl(fd, fcntl_op_setlk, &fl);
> > +    } while (ret =3D=3D -1 && errno =3D=3D EINTR);
>=20
> The change makes sense from a maintenance point of view, whether or not
> you hit it in practice.

Thank you for reviewing!

Fam
