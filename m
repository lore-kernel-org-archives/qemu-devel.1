Received: from eggs.gnu.org ([209.51.188.92]:34341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gw3d6-0006br-T7
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 06:32:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gw3d5-0005RL-Tk
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 06:32:04 -0500
Date: Tue, 19 Feb 2019 12:31:41 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190219113141.GJ4727@localhost.localdomain>
References: <1550058881-16351-1-git-send-email-thuth@redhat.com>
	<3374c532-c885-d26e-2d34-0454943c3905@redhat.com>
	<28c77705-33c2-f10b-9dae-331bc15c9596@redhat.com>
	<20190219075333.GA4727@localhost.localdomain>
	<d7a55ce9-a83c-12fe-fd16-d45dff67630a@redhat.com>
	<20190219093716.GF4727@localhost.localdomain>
	<20190219110626.GC7154@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190219110626.GC7154@redhat.com>
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
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Qemu-block <qemu-block@nongnu.org>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>

Am 19.02.2019 um 12:06 hat Daniel P. Berrang=E9 geschrieben:
> On Tue, Feb 19, 2019 at 10:37:16AM +0100, Kevin Wolf wrote:
> > Am 19.02.2019 um 10:04 hat Thomas Huth geschrieben:
> > >=20
> > >  https://gitlab.com/huth/qemu/-/jobs/163680780
> > >=20
> > > Some of them apparently need encryption to be enabled (as already
> > > mentioned by Cleber in his patch) - thus should they really be in t=
he
> > > quick check, too? Or could they at least check whether QEMU has bee=
n
> > > built with encryption?
> >=20
> > The correct solution would be that they detect the situation
> > automatically and skip the test by calling _notrun.
> >=20
> > I'm not sure how to detect if a given QEMU binary supports encryption=
,
> > but Dan might know.
>=20
> It isn't easy & depends which encryption feature you're trying to use.
>=20
> For TLS related features you can do something gross like
>=20
>     qemu-img info --object tls-creds-anon,id=3Ddummy README 2>&1
>     test $? !=3D 0 && exit 0
>=20
> This relies on fact that 'tls-creds-anon' object type will report a
> runtime error during initialization if gnutls isn't enabled.
>=20
> For more general ciphers you pretty much have to just try the higher le=
vel
> feature and see if it fails.

Actually, I think for test cases we should see 'qemu-img create' failing
and could just skip the test if it returns a non-zero exit code.

But then I looked at Thomas' output again:

    --- /builds/huth/qemu/tests/qemu-iotests/188.out	2019-02-19 08:23:54.=
000000000 +0000
    +++ /builds/huth/qemu/tests/qemu-iotests/188.out.bad	2019-02-19 08:34=
:54.000000000 +0000
    @@ -1,4 +1,5 @@
     QA output created by 188
    +qemu-img: TEST_DIR/t.IMGFMT: No crypto library supporting PBKDF in t=
his build: Function not implemented
     Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D16777216 encrypt=
.format=3Dluks encrypt.key-secret=3Dsec0 encrypt.iter-time=3D10

     =3D=3D reading whole image =3D=3D--- /builds/huth/qemu/tests/qemu-io=
tests/188.out	2019-02-19 08:23:54.000000000 +0000

What is it actually doing there? There's clearly an error message, but
it almost looks like it's creating some kind of image anyway? The
following I/O works fine (i.e. this created image can even be opened
again with the luks driver), except that you can also access the image
with the wrong password.

Is this a real bug in either qcow2 or luks?

Kevin
