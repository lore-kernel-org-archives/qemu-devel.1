Received: from eggs.gnu.org ([2001:4830:134:3::10]:56502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evLyw-00033W-PI
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 07:51:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evLys-0005AX-LZ
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 07:51:10 -0400
Date: Mon, 12 Mar 2018 11:50:58 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180312115058.GO3493@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180309172713.26318-1-kwolf@redhat.com>
	<20180309172713.26318-4-kwolf@redhat.com>
	<20180312114009.GI3493@redhat.com>
	<20180312114721.GB31537@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180312114721.GB31537@localhost.localdomain>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/6] luks: Support .bdrv_co_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

On Mon, Mar 12, 2018 at 12:47:21PM +0100, Kevin Wolf wrote:
> Am 12.03.2018 um 12:40 hat Daniel P. Berrang=C3=A9 geschrieben:
> > On Fri, Mar 09, 2018 at 06:27:10PM +0100, Kevin Wolf wrote:
> > > This adds the .bdrv_co_create driver callback to luks, which enable=
s
> > > image creation over QMP.
> > >=20
> > > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > > ---
> > >  qapi/block-core.json | 17 ++++++++++++++++-
> > >  block/crypto.c       | 34 ++++++++++++++++++++++++++++++++++
> > >  2 files changed, 50 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > > index 524d51567a..07039bfe9c 100644
> > > --- a/qapi/block-core.json
> > > +++ b/qapi/block-core.json
> > > @@ -3452,6 +3452,21 @@
> > >              '*preallocation':   'PreallocMode' } }
> > > =20
> > >  ##
> > > +# @BlockdevCreateOptionsLUKS:
> > > +#
> > > +# Driver specific image creation options for LUKS.
> > > +#
> > > +# @file             Node to create the image format on
> > > +# @size             Size of the virtual disk in bytes
> > > +#
> > > +# Since: 2.12
> > > +##
> > > +{ 'struct': 'BlockdevCreateOptionsLUKS',
> > > +  'data': { 'file':             'BlockdevRef',
> > > +            'qcrypto':          'QCryptoBlockCreateOptionsLUKS',
> > > +            'size':             'size' } }
> >=20
> > s/qcrypto/crypto/ in this field.
> >=20
> > I do wonder about whether instead of embedding QCryptoBlockCreateOpti=
onsLUKS
> > as a field, we could instead use QCryptoBlockCreateOptionsLUKS as the
> > base struct and just inherit from it to add file/size.
> >=20
> > I'm not really fussed, but I wonder if you/Eric have any thoughts on =
the pros
> > or cons of inheritance vs embedding in this case.
>=20
> I don't think QAPI has a way to embed it in JSON, but still provide a
> QCryptoBlockCreateOptionsLUKS C object. Originally I wanted to use
> inheritance, but instead of having the struct type reused, you get all
> field definitions copied. I guess you could then manually cast to the
> base type and it would still work, but it didn't really feel clean.

IIRC, QAPI generates a method

   $BASETYPE *qapi_$TYPENAME_base(const $TYPENAME *obj)

which just does the blind cast to the base type.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
