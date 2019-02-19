Received: from eggs.gnu.org ([209.51.188.92]:51571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gw4sI-0006aF-Dz
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 07:51:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gw4s9-0008Is-Qi
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 07:51:44 -0500
Date: Tue, 19 Feb 2019 12:51:16 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190219125116.GH7154@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1550058881-16351-1-git-send-email-thuth@redhat.com>
	<3374c532-c885-d26e-2d34-0454943c3905@redhat.com>
	<28c77705-33c2-f10b-9dae-331bc15c9596@redhat.com>
	<20190219075333.GA4727@localhost.localdomain>
	<d7a55ce9-a83c-12fe-fd16-d45dff67630a@redhat.com>
	<20190219093716.GF4727@localhost.localdomain>
	<20190219110626.GC7154@redhat.com>
	<20190219113141.GJ4727@localhost.localdomain>
	<20190219120128.GF7154@redhat.com>
	<20190219121657.GL4727@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190219121657.GL4727@localhost.localdomain>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Failing iotests in CI (was: Add a gitlab-ci file
 for Continuous Integration testing on Gitlab)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Qemu-block <qemu-block@nongnu.org>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

On Tue, Feb 19, 2019 at 01:16:57PM +0100, Kevin Wolf wrote:
> Am 19.02.2019 um 13:01 hat Daniel P. Berrang=C3=A9 geschrieben:
> > On Tue, Feb 19, 2019 at 12:31:41PM +0100, Kevin Wolf wrote:
> > > Am 19.02.2019 um 12:06 hat Daniel P. Berrang=C3=A9 geschrieben:
> > > > On Tue, Feb 19, 2019 at 10:37:16AM +0100, Kevin Wolf wrote:
> > > > > Am 19.02.2019 um 10:04 hat Thomas Huth geschrieben:
> > > > > >=20
> > > > > >  https://gitlab.com/huth/qemu/-/jobs/163680780
> > > > > >=20
> > > > > > Some of them apparently need encryption to be enabled (as alr=
eady
> > > > > > mentioned by Cleber in his patch) - thus should they really b=
e in the
> > > > > > quick check, too? Or could they at least check whether QEMU h=
as been
> > > > > > built with encryption?
> > > > >=20
> > > > > The correct solution would be that they detect the situation
> > > > > automatically and skip the test by calling _notrun.
> > > > >=20
> > > > > I'm not sure how to detect if a given QEMU binary supports encr=
yption,
> > > > > but Dan might know.
> > > >=20
> > > > It isn't easy & depends which encryption feature you're trying to=
 use.
> > > >=20
> > > > For TLS related features you can do something gross like
> > > >=20
> > > >     qemu-img info --object tls-creds-anon,id=3Ddummy README 2>&1
> > > >     test $? !=3D 0 && exit 0
> > > >=20
> > > > This relies on fact that 'tls-creds-anon' object type will report=
 a
> > > > runtime error during initialization if gnutls isn't enabled.
> > > >=20
> > > > For more general ciphers you pretty much have to just try the hig=
her level
> > > > feature and see if it fails.
> > >=20
> > > Actually, I think for test cases we should see 'qemu-img create' fa=
iling
> > > and could just skip the test if it returns a non-zero exit code.
> > >=20
> > > But then I looked at Thomas' output again:
> > >=20
> > >     --- /builds/huth/qemu/tests/qemu-iotests/188.out	2019-02-19 08:=
23:54.000000000 +0000
> > >     +++ /builds/huth/qemu/tests/qemu-iotests/188.out.bad	2019-02-19=
 08:34:54.000000000 +0000
> > >     @@ -1,4 +1,5 @@
> > >      QA output created by 188
> > >     +qemu-img: TEST_DIR/t.IMGFMT: No crypto library supporting PBKD=
F in this build: Function not implemented
> > >      Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D16777216 e=
ncrypt.format=3Dluks encrypt.key-secret=3Dsec0 encrypt.iter-time=3D10
> > >=20
> > >      =3D=3D reading whole image =3D=3D--- /builds/huth/qemu/tests/q=
emu-iotests/188.out	2019-02-19 08:23:54.000000000 +0000
> > >=20
> > > What is it actually doing there? There's clearly an error message, =
but
> > > it almost looks like it's creating some kind of image anyway? The
> > > following I/O works fine (i.e. this created image can even be opene=
d
> > > again with the luks driver), except that you can also access the im=
age
> > > with the wrong password.
> > >=20
> > > Is this a real bug in either qcow2 or luks?
> >=20
> > It is an artifact of the way qcow2 image creation happens in multiple
> > phases. qcow2_co_create first creates a minimal qcow2 file, and then
> > opens it and updates it to add in the various extra features, includi=
ng
> > luks encryption. We fail to create the luks encryption, but enough of
> > the qcow2 file has been created that it is able to still do plain tex=
t
> > I/O.
>=20
> But why doesn't qcow2_update_options_prepare() fail then? If you pass
> encryption options like 188 does, but the image isn't encrypted, then
> the function at least attempts to error out. Where is this failing?

Oh, its because we check for "encrypt.format", but we made that field
optional when opening the image, allowing other encrypt.* fields to be
set and just pulling format from the header. I'v sent a patch for this.

> > Essentially the problem is that qcow2_co_create() doesn't unlink() th=
e
> > partially created image when things fail. This is a generic problem
> > which can affect any part of qcow2_co_create that might fail, but it
> > is especially problematic with luks.
> >=20
> > The complication in fixing this is that can't just do an unlink() as
> > we can't assume a local file. We need to have a bdrv_unlink() driver
> > callback we can use to delegate to the right block driver APIs for
> > deletion.
>=20
> .bdrv_co_create can't unlink at all, because that would be undoing
> something that it didn't even do itself. If I created a file (local or
> on a remote server that is accessed over a network protocol) and my
> blockdev-create command to create the qcow2 layer fails, I certainly
> don't expect the resource that I manually created to go away.

Oh, I forgot that we unconditionally call bdrv_create_file even if
we might have a pre-existing file, expecting it to be a no-op.

> What .bdrv_co_create could and probably should do is make the header
> invalid so that it's still recognised as qcow2 (to avoid probing it as
> raw), but opening it fails.

Yes, good idea. I've sent a patch for this too

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
