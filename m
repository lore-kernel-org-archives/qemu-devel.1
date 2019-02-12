Received: from eggs.gnu.org ([209.51.188.92]:42716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gtVXh-0007Zo-7Z
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 05:43:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gtVXf-0007Ye-PA
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 05:43:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52442)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gtVXd-0007KE-VG
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 05:43:55 -0500
Date: Tue, 12 Feb 2019 10:43:35 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190212104335.GB2715@work-vm>
References: <20190208181226.24052-1-marcandre.lureau@redhat.com>
	<20190211110907.GP27585@redhat.com>
	<CAMxuvaz4w75CmN1o0E4y4+pTLk5cks-oGu+FnyUWUbvBqC-jUA@mail.gmail.com>
	<20190211222227.npdkrikdjxpzqxkn@function>
	<20190212103115.GF9386@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190212103115.GF9386@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/1] RFC: net/slirp: link with libslirp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Samuel Thibault <samuel.thibault@gnu.org>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

* Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> On Mon, Feb 11, 2019 at 11:22:27PM +0100, Samuel Thibault wrote:
> > Marc-Andr=E9 Lureau, le lun. 11 f=E9vr. 2019 12:34:47 +0100, a ecrit:
> > > On Mon, Feb 11, 2019 at 12:09 PM Daniel P. Berrang=E9 <berrange@red=
hat.com> wrote:
> > > >
> > > > On Fri, Feb 08, 2019 at 07:12:26PM +0100, Marc-Andr=E9 Lureau wro=
te:
> > > > > Once libslirp has received its first release, we can link with =
the
> > > > > external libslirp library.
> > > > >
> > > > > The migration data should be compatible with current and older =
qemu
> > > > > versions (same compatibility as today). See "slirp: add state
> > > > > saving/loading" patch. However, the content should be treated a=
s a
> > > > > blob, as the format may change eventually in the future.
> > > >
> > > > How are we going to manage live migration compat if libslirp chan=
ges
> > > > the blob content ?
> > > >
> > > > Bear in mind that we need to support all existing QEMU releases l=
ive
> > > > migrating to effectively all future QEMU releases, with all futur=
e
> > > > libslirp releases, in *both* directions. ie arbitrarily newer
> > > > libslirp needs to be able to emit a blob format that can be read
> > > > by arbitrarily older slirp inside QEMU.
> > >=20
> > > Right, this is all supported currently with the proposed patch set,
> > > since it is effectively the same code.
> > >=20
> > > So register_savevm_live() get passed slirp_state_version() (current=
ly =3D=3D 4)
> > >=20
> > > & slirp_state_load() get the version_id from QEMU.
> >=20
> > Mmm, but do we guarantee that the current version of slirp will be ab=
le
> > to read blobs produced by future versions of slirp?
> >=20
> > Future extensions of the format would have to be so that the current
> > version could discard their content without issues.
> >=20
> > Perhaps qemu should actually explicitly pass 4 to
> > register_savevm_live(), for that function to only record that format
> > (and thus get compatibility of course) and only bump to greater value=
s
> > when qemu is modified to make use of a functionality which requires
> > extending the blob format, which then makes it unreadable by older qe=
mu
> > releases, but that is fine for qemu.
>=20
> If QEMU wants to make use of functionality that requires the new blob
> format, it would have to restrict that based on machine type. That way
> it can ensure full compatibility with old  QEMU.

Library compatibility for migration blobs is messy;  we've had the same
problem with usbredir.

It's very difficult to keep track of; for example lets say that libslirp
gets used by 3 or 4 different projects, and the package maintainer for
libslirp in your favorite distro updates it - it's not necessarily
obvious to them that doing so could break qemu migration.

The ideal way is to work in terms of features and not versions; so that
a machine type can enable libslirp-feature-foo in the new machine type
and only then will the migration contents change.

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
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
