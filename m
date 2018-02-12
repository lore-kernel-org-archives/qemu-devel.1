Received: from eggs.gnu.org ([2001:4830:134:3::10]:56727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1elDYH-00047O-LU
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 07:49:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1elDYG-00012d-Q0
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 07:49:45 -0500
Date: Mon, 12 Feb 2018 12:49:32 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180212124932.GO4071@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180207162920.28386-1-pbonzini@redhat.com>
	<84467de4-5563-8293-9838-a5d48878597f@redhat.com>
	<b1278b08-0881-1dec-05c7-22da222cab93@redhat.com>
	<20180212100247.GG4071@redhat.com>
	<20180212124211.GC5103@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180212124211.GC5103@localhost.localdomain>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block: early check for
 blockers on drive-mirror
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

On Mon, Feb 12, 2018 at 01:42:11PM +0100, Kevin Wolf wrote:
> Am 12.02.2018 um 11:02 hat Daniel P. Berrang=C3=A9 geschrieben:
> > On Mon, Feb 12, 2018 at 10:58:31AM +0100, Paolo Bonzini wrote:
> > > On 10/02/2018 00:07, John Snow wrote:
> > > >> +    /* Early check to avoid creating target */
> > > >> +    if (bdrv_op_is_blocked(bs, BLOCK_OP_TYPE_MIRROR_SOURCE, err=
p)) {
> > > >> +        return;
> > > >> +    }
> > > >> +
> > > >>      aio_context =3D bdrv_get_aio_context(bs);
> > > >>      aio_context_acquire(aio_context);
> > > >> =20
> > > >>
> > > > What's the implication of the temporarily-extant target node that=
 it
> > > > needs to be avoided so strictly?
> > > >=20
> > >=20
> > > Creating a file on disk, that no one will ever remvoe. :)
> >=20
> > Fortunately libvirt's SELinux policy will probably prevent QEMU creat=
ing
> > it in the first place :-)
>=20
> Well, calling drive-mirror without allowing QEMU to create the target
> image would be a bit pointless, so I think we can assume that libvirt
> did set up the file permission so that QEMU can create it. (Unless
> mode=3Dexisting is used, but I understand that libvirt doesn't want to
> create images with qemu-img, so that doesn't seem to be the case...)

We use either mode=3Dexisting or mode=3Dabsolute-paths depending on what
the mgmt app asked for in the API call to libvirt. I'm still kind of
suprised if mode=3Dabsolute-paths will work because we ought to be
blocking the creation of the file AFAIK and we can't pre-label a file
that doesn't exist yet.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
