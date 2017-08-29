Received: from eggs.gnu.org ([2001:4830:134:3::10]:38996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dmfMW-0001Bi-If
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 08:11:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dmfMT-0003SC-TZ
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 08:11:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46084)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dmfMT-0003R0-Jb
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 08:11:17 -0400
Date: Tue, 29 Aug 2017 13:11:00 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170829121100.GA25801@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170828174707.20786-1-famz@redhat.com>
	<20170828174707.20786-4-famz@redhat.com>
	<de606e2a-7f5e-0625-79dd-a828ea3d5fe9@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <de606e2a-7f5e-0625-79dd-a828ea3d5fe9@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 03/10] tests: Add vm test lib
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, pbonzini@redhat.com, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, eblake@redhat.com, Kamil Rytarowski <kamil@netbsd.org>

On Tue, Aug 29, 2017 at 09:06:48AM -0300, Philippe Mathieu-Daud=C3=A9 wro=
te:
> Hi Fam,
>=20
> On 08/28/2017 02:47 PM, Fam Zheng wrote:
> > This is the common code to implement a "VM test" to
> >=20
> >    1) Download and initialize a pre-defined VM that has necessary
> >    dependencies to build QEMU and SSH access.
> >=20
> >    2) Archive $SRC_PATH to a .tar file.
> >=20
> >    3) Boot the VM, and pass the source tar file to the guest.
> >=20
> >    4) SSH into the VM, untar the source tarball, build from the sourc=
e.
> >=20
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > ---
> >   tests/vm/basevm.py | 287 ++++++++++++++++++++++++++++++++++++++++++=
+++++++++++
> >   1 file changed, 287 insertions(+)
> >   create mode 100755 tests/vm/basevm.py
> >=20
> > diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> > new file mode 100755
> > index 0000000000..d0095c5332
> > --- /dev/null
> > +++ b/tests/vm/basevm.py

> > +    def add_source_dir(self, data_dir):
> > +        name =3D "data-" + hashlib.sha1(data_dir).hexdigest()[:5]
> > +        tarfile =3D os.path.join(self._tmpdir, name + ".tar")
> > +        logging.debug("Creating archive %s for data dir: %s", tarfil=
e, data_dir)
> > +        if subprocess.call("type gtar", stdout=3Dself._devnull,
> > +                           stderr=3Dself._devnull, shell=3DTrue) =3D=
=3D 0:
> > +            tar_cmd =3D "gtar"
> > +        else:
> > +            tar_cmd =3D "tar"
> > +        subprocess.check_call([tar_cmd,
> > +                               "--exclude-vcs",
> > +                               "--exclude=3Dtests/vm/*.img",
> > +                               "--exclude=3Dtests/vm/*.img.*",
> > +                               "--exclude=3D*.d",
> > +                               "--exclude=3D*.o",
> > +                               "--exclude=3Ddocker-src.*",
> > +                               "-cf", tarfile, '.'], cwd=3Ddata_dir,
>=20
> I'm not happy with this command :/
> My distrib uses tmpfs for /tmp and suddently the whole X window became
> irresponsive until this script failing after filling 8G of /tmp and swa=
p:
>=20
> ...
> DEBUG:root:Creating archive /tmp/qemu-vm-F7CY9O/data-3a52c.tar for data=
 dir:
> .
> tar: /tmp/qemu-vm-F7CY9O/data-3a52c.tar: Wrote only 4096 of 10240 bytes
> tar: Error is not recoverable: exiting now
> Failed to prepare guest environment
>=20
> Then I figured out my workdir is full of testing stuff, debug images,
> firmwares, coredumps, etc.
>=20
> I'll think of another way.

Yeah, /tmp should never be used for anything which has significant
size. Could go for /var/tmp instead, but IMHO just use the QEMU build
dir, as is done for (almost) all other build & test artifacts and
thus avoid any global dirs.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
