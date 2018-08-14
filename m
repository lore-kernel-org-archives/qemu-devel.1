Received: from eggs.gnu.org ([2001:4830:134:3::10]:42228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fpYam-0002EQ-Ur
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 08:38:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fpYal-0007y2-UM
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 08:38:32 -0400
Date: Tue, 14 Aug 2018 13:38:22 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180814123822.GC24997@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180814093551.2749-1-berrange@redhat.com>
	<20180814113824.GI5025@dhcp-200-186.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180814113824.GI5025@dhcp-200-186.str.redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qemu-img: fix regression copying secrets
 during convert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-stable@nongnu.org

On Tue, Aug 14, 2018 at 01:38:24PM +0200, Kevin Wolf wrote:
> Am 14.08.2018 um 11:35 hat Daniel P. Berrang=C3=A9 geschrieben:
> > When the convert command is creating an output file that needs
> > secrets, we need to ensure those secrets are passed to both the
> > blk_new_open and bdrv_create API calls.
> >=20
> > This is done by qemu-img extracting all opts matching the name
> > suffix "key-secret". Unfortunately the code doing this was run after =
the
> > call to bdrv_create(), which meant the QemuOpts it was extracting
> > secrets from was now empty.
> >=20
> > Previously this worked by luks as a bug meant the "key-secret"
> > parameters were not purged from the QemuOpts. This bug was fixed in
> >=20
> >   commit b76b4f604521e59f857d6177bc55f6f2e41fd392
> >   Author: Kevin Wolf <kwolf@redhat.com>
> >   Date:   Thu Jan 11 16:18:08 2018 +0100
> >=20
> >     qcow2: Use visitor for options in qcow2_create()
> >=20
> > Exposing the latent bug in qemu-img. This fix simply moves the copyin=
g
> > of secrets to before the bdrv_create() call.
> >=20
> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>=20
> Cc: qemu-stable@nongnu.org
>=20
> > @@ -2461,9 +2458,9 @@ out:
> >          qemu_progress_print(100, 0);
> >      }
> >      qemu_progress_end();
> > -    qemu_opts_del(opts);
>=20
> Why don't we need to free opts any more?

Urgh, that's a mistake, I deleted the wrong line. v2 arriving soon....

>=20
> >      qemu_opts_free(create_opts);
> >      qemu_opts_del(sn_opts);
> > +    qobject_unref(open_opts);
> >      blk_unref(s.target);
> >      if (s.src) {
> >          for (bs_i =3D 0; bs_i < s.src_num; bs_i++) {

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
