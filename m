Received: from eggs.gnu.org ([2001:4830:134:3::10]:53659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ch0Pq-0003JV-Ik
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 15:55:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ch0Pm-0000HT-L4
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 15:55:06 -0500
Received: from 5.mo6.mail-out.ovh.net ([46.105.54.31]:50678)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ch0Pm-0000H8-FA
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 15:55:02 -0500
Received: from player761.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id E29ADB049F
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 21:55:00 +0100 (CET)
Date: Thu, 23 Feb 2017 21:54:54 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170223215454.6b2d8da2@bahia.lan>
In-Reply-To: <20170223134441.GG30636@stefanha-x1.localdomain>
References: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
	<148760161575.31154.505252736798591155.stgit@bahia.lan>
	<20170223134441.GG30636@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/WD+LVhFxAv+bpaw743iG906";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH 07/29] 9pfs: local: introduce
 symlink-attack safe xattr helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Jann Horn <jannh@google.com>, Prasad J Pandit <prasad@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>

--Sig_/WD+LVhFxAv+bpaw743iG906
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 23 Feb 2017 13:44:41 +0000
Stefan Hajnoczi <stefanha@gmail.com> wrote:

> On Mon, Feb 20, 2017 at 03:40:15PM +0100, Greg Kurz wrote:
> > +static ssize_t do_xattrat_op(int op_type, int dirfd, const char *path,
> > +                             const char *name, void *value, size_t siz=
e,
> > +                             int flags)
> > +{
> > +    struct xattrat_data *data;
> > +    pid_t pid;
> > +    ssize_t ret =3D -1;
> > +    int wstatus;
> > +
> > +    data =3D mmap(NULL, sizeof(*data) + size, PROT_READ | PROT_WRITE,
> > +                MAP_SHARED | MAP_ANONYMOUS, -1, 0);
> > +    if (data =3D=3D MAP_FAILED) {
> > +        return -1;
> > +    }
> > +    data->ret =3D -1;
> > +
> > +    pid =3D fork();
> > +    if (pid < 0) {
> > +        goto err_out;
> > +    } else if (pid =3D=3D 0) {
> > +        if (fchdir(dirfd) =3D=3D 0) {
> > +            switch (op_type) {
> > +            case XATTRAT_OP_GET:
> > +                data->ret =3D lgetxattr(path, name, data->value, size);
> > +                break;
> > +            case XATTRAT_OP_LIST:
> > +                data->ret =3D llistxattr(path, data->value, size);
> > +                break;
> > +            case XATTRAT_OP_SET:
> > +                data->ret =3D lsetxattr(path, name, value, size, flags=
);
> > +                break;
> > +            case XATTRAT_OP_REMOVE:
> > +                data->ret =3D lremovexattr(path, name);
> > +                break;
> > +            default:
> > +                g_assert_not_reached();
> > +            }
> > +        }
> > +        data->serrno =3D errno;
> > +        _exit(0);
> > +    }
> > +    assert(waitpid(pid, &wstatus, 0) =3D=3D pid && WIFEXITED(wstatus));
> > +
> > +    ret =3D data->ret;
> > +    if (ret < 0) {
> > +        errno =3D data->serrno;
> > +        goto err_out;
> > +    }
> > +    if (value) {
> > +        memcpy(value, data->value, data->ret);
> > +    }
> > +err_out:
> > +    munmap_preserver_errno(data, sizeof(*data) + size);
> > +    return ret;
> > +} =20
>=20
> Forking is ugly since QEMU is a multi-threaded program.  We brainstormed

Yeah, forking is ugly and it completely ruins metadata performance (x30
slower in passthrough mode and x300 slower in mapped-xattr mode).

> alternatives on IRC like using /proc/self/fd/$fd to work around the
> missing getxattrat() API.
>=20

This should do the trick indeed. If we have to call getxattr()
on some untrusted $path that may be modified by the guest. We
can do:

dirfd =3D openat_nofollow($mount_fd, dirname($path))
filename =3D basename($path)

and then we can safely call:

lgetxattr("/proc/self/fd/$dirfd/$filename")

since "/proc/self/fd/$dirfd" is trusted.

> Stefan


--Sig_/WD+LVhFxAv+bpaw743iG906
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlivTB4ACgkQAvw66wEB28IzjgCeLjyAPWFDE5/ajriVlmhr0Kiq
CkQAn1OrGILWlYbhdAphyOWW9xjk7Wf3
=EHwr
-----END PGP SIGNATURE-----

--Sig_/WD+LVhFxAv+bpaw743iG906--
