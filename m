Received: from eggs.gnu.org ([209.51.188.92]:46219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gw87P-0003Xm-Jg
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 11:19:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gw87O-0006Nz-Hi
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 11:19:39 -0500
Date: Tue, 19 Feb 2019 16:19:28 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190219161928.GP7154@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190219125044.5416-1-berrange@redhat.com>
	<20190219125044.5416-3-berrange@redhat.com>
	<42f0ea75-99c6-6e6d-2fd5-b3b59f4a781c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <42f0ea75-99c6-6e6d-2fd5-b3b59f4a781c@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] qcow2: mark image as corrupt if
 failing during create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Tue, Feb 19, 2019 at 10:11:58AM -0600, Eric Blake wrote:
> On 2/19/19 6:50 AM, Daniel P. Berrang=C3=A9 wrote:
> > During creation we write a minimal qcow2 header and then update it wi=
th
> > extra features. If the updating fails for some reason we might still =
be
> > left with a valid qcow2 image that will be mistakenly used for I/O. W=
e
> > cannot delete the image, since we don't know if we created the
> > underlying storage or not. Thus we mark the header as corrupt to
> > prevents its later usage.
>=20
> Should we unconditionally mark the image as corrupt at the time we writ=
e
> the minimal qcow2 header, and then update the image to non-corrupt on
> the final update?

That's a nice idea, but we call blk_new_open() half way through to
qcow2_co_create method to open the minimal image. If we mark it
corrupt upfront we'll never be able to open this minimal image.

Adding a flag to allow blk_new_open to ignore the "corrupt" marker
feels unplesant to me.

>=20
> >=20
> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > ---
> >  block/qcow2.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >=20
> > diff --git a/block/qcow2.c b/block/qcow2.c
> > index ecc577175f..338513e652 100644
> > --- a/block/qcow2.c
> > +++ b/block/qcow2.c
> > @@ -3104,6 +3104,9 @@ qcow2_co_create(BlockdevCreateOptions *create_o=
ptions, Error **errp)
> > =20
> >      ret =3D 0;
> >  out:
> > +    if (ret < 0) {
> > +        qcow2_mark_corrupt(blk_bs(blk));
> > +    }
>=20
> If ret < 0 because of an EIO error, this may also fail to write the
> change to the header. Hence my question as to whether this is too late.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
