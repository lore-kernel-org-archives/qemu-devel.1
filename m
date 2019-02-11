Received: from eggs.gnu.org ([209.51.188.92]:53794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gtJyF-00013R-8w
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 17:22:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gtJyE-0007Ca-1E
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 17:22:35 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:36864)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gtJyD-00077Q-L2
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 17:22:33 -0500
Date: Mon, 11 Feb 2019 23:22:27 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20190211222227.npdkrikdjxpzqxkn@function>
References: <20190208181226.24052-1-marcandre.lureau@redhat.com>
	<20190211110907.GP27585@redhat.com>
	<CAMxuvaz4w75CmN1o0E4y4+pTLk5cks-oGu+FnyUWUbvBqC-jUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMxuvaz4w75CmN1o0E4y4+pTLk5cks-oGu+FnyUWUbvBqC-jUA@mail.gmail.com>
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
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Jason Wang <jasowang@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Marc-Andr=C3=A9 Lureau, le lun. 11 f=C3=A9vr. 2019 12:34:47 +0100, a ecri=
t:
> On Mon, Feb 11, 2019 at 12:09 PM Daniel P. Berrang=C3=A9 <berrange@redh=
at.com> wrote:
> >
> > On Fri, Feb 08, 2019 at 07:12:26PM +0100, Marc-Andr=C3=A9 Lureau wrot=
e:
> > > Once libslirp has received its first release, we can link with the
> > > external libslirp library.
> > >
> > > The migration data should be compatible with current and older qemu
> > > versions (same compatibility as today). See "slirp: add state
> > > saving/loading" patch. However, the content should be treated as a
> > > blob, as the format may change eventually in the future.
> >
> > How are we going to manage live migration compat if libslirp changes
> > the blob content ?
> >
> > Bear in mind that we need to support all existing QEMU releases live
> > migrating to effectively all future QEMU releases, with all future
> > libslirp releases, in *both* directions. ie arbitrarily newer
> > libslirp needs to be able to emit a blob format that can be read
> > by arbitrarily older slirp inside QEMU.
>=20
> Right, this is all supported currently with the proposed patch set,
> since it is effectively the same code.
>=20
> So register_savevm_live() get passed slirp_state_version() (currently =3D=
=3D 4)
>=20
> & slirp_state_load() get the version_id from QEMU.

Mmm, but do we guarantee that the current version of slirp will be able
to read blobs produced by future versions of slirp?

Future extensions of the format would have to be so that the current
version could discard their content without issues.

Perhaps qemu should actually explicitly pass 4 to
register_savevm_live(), for that function to only record that format
(and thus get compatibility of course) and only bump to greater values
when qemu is modified to make use of a functionality which requires
extending the blob format, which then makes it unreadable by older qemu
releases, but that is fine for qemu.

Samuel
