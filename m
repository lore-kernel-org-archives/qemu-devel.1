Received: from eggs.gnu.org ([2001:4830:134:3::10]:37472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dmteu-0005VO-NU
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 23:27:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dmter-0006aY-Jk
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 23:27:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54944)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dmter-0006aK-A0
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 23:27:13 -0400
Date: Wed, 30 Aug 2017 11:27:04 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170830032704.GB4208@lemon.lan>
References: <20170828174707.20786-1-famz@redhat.com>
	<20170828174707.20786-4-famz@redhat.com>
	<de606e2a-7f5e-0625-79dd-a828ea3d5fe9@amsat.org>
	<20170829121100.GA25801@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170829121100.GA25801@redhat.com>
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
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, pbonzini@redhat.com, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, eblake@redhat.com, Kamil Rytarowski <kamil@netbsd.org>

On Tue, 08/29 13:11, Daniel P. Berrange wrote:
> On Tue, Aug 29, 2017 at 09:06:48AM -0300, Philippe Mathieu-Daud=E9 wrot=
e:
> > Hi Fam,
> >=20
> > On 08/28/2017 02:47 PM, Fam Zheng wrote:
> > > This is the common code to implement a "VM test" to
> > >=20
> > >    1) Download and initialize a pre-defined VM that has necessary
> > >    dependencies to build QEMU and SSH access.
> > >=20
> > >    2) Archive $SRC_PATH to a .tar file.
> > >=20
> > >    3) Boot the VM, and pass the source tar file to the guest.
> > >=20
> > >    4) SSH into the VM, untar the source tarball, build from the sou=
rce.
> > >=20
> > > Signed-off-by: Fam Zheng <famz@redhat.com>
> > > ---
> > >   tests/vm/basevm.py | 287 ++++++++++++++++++++++++++++++++++++++++=
+++++++++++++
> > >   1 file changed, 287 insertions(+)
> > >   create mode 100755 tests/vm/basevm.py
> > >=20
> > > diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> > > new file mode 100755
> > > index 0000000000..d0095c5332
> > > --- /dev/null
> > > +++ b/tests/vm/basevm.py
>=20
> > > +    def add_source_dir(self, data_dir):
> > > +        name =3D "data-" + hashlib.sha1(data_dir).hexdigest()[:5]
> > > +        tarfile =3D os.path.join(self._tmpdir, name + ".tar")
> > > +        logging.debug("Creating archive %s for data dir: %s", tarf=
ile, data_dir)
> > > +        if subprocess.call("type gtar", stdout=3Dself._devnull,
> > > +                           stderr=3Dself._devnull, shell=3DTrue) =3D=
=3D 0:
> > > +            tar_cmd =3D "gtar"
> > > +        else:
> > > +            tar_cmd =3D "tar"
> > > +        subprocess.check_call([tar_cmd,
> > > +                               "--exclude-vcs",
> > > +                               "--exclude=3Dtests/vm/*.img",
> > > +                               "--exclude=3Dtests/vm/*.img.*",
> > > +                               "--exclude=3D*.d",
> > > +                               "--exclude=3D*.o",
> > > +                               "--exclude=3Ddocker-src.*",
> > > +                               "-cf", tarfile, '.'], cwd=3Ddata_di=
r,
> >=20
> > I'm not happy with this command :/
> > My distrib uses tmpfs for /tmp and suddently the whole X window becam=
e
> > irresponsive until this script failing after filling 8G of /tmp and s=
wap:
> >=20
> > ...
> > DEBUG:root:Creating archive /tmp/qemu-vm-F7CY9O/data-3a52c.tar for da=
ta dir:
> > .
> > tar: /tmp/qemu-vm-F7CY9O/data-3a52c.tar: Wrote only 4096 of 10240 byt=
es
> > tar: Error is not recoverable: exiting now
> > Failed to prepare guest environment
> >=20
> > Then I figured out my workdir is full of testing stuff, debug images,
> > firmwares, coredumps, etc.
> >=20
> > I'll think of another way.
>=20
> Yeah, /tmp should never be used for anything which has significant
> size. Could go for /var/tmp instead, but IMHO just use the QEMU build
> dir, as is done for (almost) all other build & test artifacts and
> thus avoid any global dirs.

Thanks, I'll fix it. Using current dir would be fine.

Fam

>=20
>=20
> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberr=
ange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange=
.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberr=
ange :|
