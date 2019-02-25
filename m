Received: from eggs.gnu.org ([209.51.188.92]:36818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gyDdI-0006Nn-Ms
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 05:37:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gyDdH-0003we-Mb
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 05:37:12 -0500
Date: Mon, 25 Feb 2019 10:36:58 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190225103658.GD29260@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190219125044.5416-1-berrange@redhat.com>
	<20190219125044.5416-2-berrange@redhat.com>
	<f70b06ee-d5db-f1cc-35f4-5e34226b429c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f70b06ee-d5db-f1cc-35f4-5e34226b429c@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] qcow2: fail if encryption opts are
 provided to non-encrypted image
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

On Fri, Feb 22, 2019 at 08:17:40PM +0100, Max Reitz wrote:
> On 19.02.19 13:50, Daniel P. Berrang=C3=A9 wrote:
> > If the qcow2 image does not have any encryption method specified in i=
ts
> > header, the user should not be providing any encryption options when
> > opening it. We already detect this if the user had set "encrypt.forma=
t"
> > but this field is optional so must consider any "encrypt.*" option to=
 be
> > an error.
> >=20
> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > ---
> >  block/qcow2.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >=20
> > diff --git a/block/qcow2.c b/block/qcow2.c
> > index 65a54c9ac6..ecc577175f 100644
> > --- a/block/qcow2.c
> > +++ b/block/qcow2.c
> > @@ -1045,6 +1045,12 @@ static int qcow2_update_options_prepare(BlockD=
riverState *bs,
> >              ret =3D -EINVAL;
> >              goto fail;
> >          }
> > +        if (encryptopts && qdict_size(encryptopts)) {
> > +            error_setg(errp, "No encryption in image header, but enc=
ryption "
> > +                       "options provided");
> > +            ret =3D -EINVAL;
> > +            goto fail;
> > +        }
>=20
> Doesn't this make the block right before this one a bit superfluous?

Yes, in the sense that we'll still get an error if we removed the
prior block. The prior block has a more useful error message which
will help diagnosis though, so I thought it worth keeping both.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
