Received: from eggs.gnu.org ([2001:4830:134:3::10]:44055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fpUda-0004Km-6T
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 04:25:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fpUdZ-0005DJ-Aj
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 04:25:10 -0400
Date: Tue, 14 Aug 2018 10:24:59 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180814082459.GC5025@dhcp-200-186.str.redhat.com>
References: <20180814072551.15465-1-famz@redhat.com>
	<20180814072749.GB5057@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180814072749.GB5057@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] luks: Allow share-rw=on
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Am 14.08.2018 um 09:27 hat Daniel P. Berrang=E9 geschrieben:
> On Tue, Aug 14, 2018 at 03:25:51PM +0800, Fam Zheng wrote:
> > Format drivers such as qcow2 don't allow sharing the same image betwe=
en
> > two QEMU instances in order to prevent image corruptions, because of
> > metadata cache. LUKS driver don't modify metadata except for when
> > creating image, so it is safe to relax the permission. This makes
> > share-rw=3Don property work on virtual devices.
> >=20
> > Suggested-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > ---
> >  block/crypto.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/block/crypto.c b/block/crypto.c
> > index 146d81c90a..33ee01bebd 100644
> > --- a/block/crypto.c
> > +++ b/block/crypto.c
> > @@ -627,7 +627,9 @@ BlockDriver bdrv_crypto_luks =3D {
> >      .bdrv_probe         =3D block_crypto_probe_luks,
> >      .bdrv_open          =3D block_crypto_open_luks,
> >      .bdrv_close         =3D block_crypto_close,
> > -    .bdrv_child_perm    =3D bdrv_format_default_perms,
> > +    /* This driver doesn't modify LUKS metadata except when creating=
 image.
> > +     * Allow share-rw=3Don as a special case. */
> > +    .bdrv_child_perm    =3D bdrv_filter_default_perms,
> >      .bdrv_co_create     =3D block_crypto_co_create_luks,
> >      .bdrv_co_create_opts =3D block_crypto_co_create_opts_luks,
> >      .bdrv_co_truncate   =3D block_crypto_co_truncate,
>=20
> Reviewed-by: Daniel P. Berrang=E9 <berrange@redhat.com>

Thanks, applied to the block branch.

Kevin
