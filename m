Received: from eggs.gnu.org ([2001:4830:134:3::10]:55200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evLuV-00088z-LB
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 07:46:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evLuU-0005mQ-Hz
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 07:46:35 -0400
Date: Mon, 12 Mar 2018 11:46:06 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180312114606.GM3493@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180309172713.26318-1-kwolf@redhat.com>
	<20180309172713.26318-2-kwolf@redhat.com>
	<20180312113526.GH3493@redhat.com>
	<20180312114347.GA31537@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180312114347.GA31537@localhost.localdomain>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/6] luks: Separate image file creation
 from formatting
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

On Mon, Mar 12, 2018 at 12:43:47PM +0100, Kevin Wolf wrote:
> Am 12.03.2018 um 12:35 hat Daniel P. Berrang=C3=A9 geschrieben:
> > On Fri, Mar 09, 2018 at 06:27:08PM +0100, Kevin Wolf wrote:
> > > The crypto driver used to create the image file in a callback from =
the
> > > crypto subsystem. If we want to implement .bdrv_co_create, this nee=
ds to
> > > go away because that callback will get a reference to an already
> > > existing block node.
> > >=20
> > > Move the image file creation to block_crypto_create_generic().
> > >=20
> > > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > > ---
> > >  block/crypto.c | 37 +++++++++++++++++--------------------
> > >  1 file changed, 17 insertions(+), 20 deletions(-)
> > >=20
> > > diff --git a/block/crypto.c b/block/crypto.c
> > > index e6095e7807..77871640cc 100644
> > > --- a/block/crypto.c
> > > +++ b/block/crypto.c
> > > @@ -71,8 +71,6 @@ static ssize_t block_crypto_read_func(QCryptoBloc=
k *block,
> > > =20
> > > =20
> > >  struct BlockCryptoCreateData {
> > > -    const char *filename;
> > > -    QemuOpts *opts;
> > >      BlockBackend *blk;
> > >      uint64_t size;
> > >  };
> > > @@ -103,27 +101,13 @@ static ssize_t block_crypto_init_func(QCrypto=
Block *block,
> > >                                        Error **errp)
> > >  {
> > >      struct BlockCryptoCreateData *data =3D opaque;
> > > -    int ret;
> > > =20
> > >      /* User provided size should reflect amount of space made
> > >       * available to the guest, so we must take account of that
> > >       * which will be used by the crypto header
> > >       */
> > > -    data->size +=3D headerlen;
> > > -
> > > -    qemu_opt_set_number(data->opts, BLOCK_OPT_SIZE, data->size, &e=
rror_abort);
> > > -    ret =3D bdrv_create_file(data->filename, data->opts, errp);
> > > -    if (ret < 0) {
> > > -        return -1;
> > > -    }
> > > -
> > > -    data->blk =3D blk_new_open(data->filename, NULL, NULL,
> > > -                             BDRV_O_RDWR | BDRV_O_PROTOCOL, errp);
> > > -    if (!data->blk) {
> > > -        return -1;
> > > -    }
> > > -
> > > -    return 0;
> > > +    return blk_truncate(data->blk, data->size + headerlen, PREALLO=
C_MODE_OFF,
> > > +                        errp);
> > >  }
> >=20
> > I wonder if we should pass in the value of the PREALLOC_MODE from the
> > block_crypto_create_generic() function via BlockCryptoCreateData, so
> > that we honour it. By using PREALLOC_MODE_OFF here, all LUKS volumes
> > created with PREALLOC_MODE_FULL are going to have several MB of
> > unallocated extents at the end of the file.
>=20
> That would be an easy way to implement preallocation support. But you
> can't create LUKS volumes with PREALLOC_MODE_FULL today because it
> doesn't support preallocation at all (there's no option for it in
> &block_crypto_create_opts_luks), so implementing that is matter for a
> different patch.

Hah, ops, I forgot that ! In that case,

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
