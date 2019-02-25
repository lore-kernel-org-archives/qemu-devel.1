Received: from eggs.gnu.org ([209.51.188.92]:37805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gyDh6-0000b6-7O
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 05:41:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gyDh5-0001ts-7j
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 05:41:08 -0500
Date: Mon, 25 Feb 2019 10:40:50 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190225104050.GF29260@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190219125044.5416-1-berrange@redhat.com>
	<20190219125044.5416-3-berrange@redhat.com>
	<8b0ac3aa-259e-da75-e2d0-d5e72959cdbf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8b0ac3aa-259e-da75-e2d0-d5e72959cdbf@redhat.com>
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
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

On Fri, Feb 22, 2019 at 08:21:26PM +0100, Max Reitz wrote:
> On 19.02.19 13:50, Daniel P. Berrang=C3=A9 wrote:
> > During creation we write a minimal qcow2 header and then update it wi=
th
> > extra features. If the updating fails for some reason we might still =
be
> > left with a valid qcow2 image that will be mistakenly used for I/O. W=
e
> > cannot delete the image, since we don't know if we created the
> > underlying storage or not. Thus we mark the header as corrupt to
> > prevents its later usage.
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

...snip...

> Or maybe Eric's suggestion really is for the best, i.e. mark the image
> corrupt from the start and then clean that after we're all done.  You
> don't need a new flag for that, we already have BDRV_O_CHECK.

Ah, I didn't realize that is what BDRV_O_CHECK could do. I'll try this
approach as it is nicer.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
