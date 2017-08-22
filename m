Received: from eggs.gnu.org ([2001:4830:134:3::10]:34442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dk9jA-000681-BQ
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 10:00:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dk9j4-0005q0-Sn
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 10:00:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47022)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dk9j4-0005pX-MX
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 10:00:14 -0400
Date: Tue, 22 Aug 2017 22:00:00 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170822140000.GF3210@lemon>
References: <20170822044155.2451-1-famz@redhat.com>
	<20170822044155.2451-4-famz@redhat.com>
	<51a26b62-8ce8-6733-908b-3481a110663e@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <51a26b62-8ce8-6733-908b-3481a110663e@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 03/10] tests: Add vm test lib
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, pbonzini@redhat.com, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, eblake@redhat.com, Kamil Rytarowski <kamil@netbsd.org>

On Tue, 08/22 08:19, Philippe Mathieu-Daud=E9 wrote:
> > +    def add_source_dir(self, data_dir):
> > +        name =3D "data-" + hashlib.sha1(data_dir).hexdigest()[:5]
> > +        tarfile =3D os.path.join(self._tmpdir, name + ".tar")
> > +        logging.debug("Creating archive %s for data dir: %s", tarfil=
e, data_dir)
> > +        subprocess.check_call(["tar", "--exclude-vcs",
>=20
> --exclude-vcs-ignores will process .gitignore,

Sounds useful, thanks!

> you can also list with 'git ls-files',
> or generate tarball with scripts/make-release

They won't handle submodules, will they?

>=20
> > +                               "--exclude=3Dtests/vm/*.img",
> > +                               "--exclude=3Dtests/vm/*.img.*",
> > +                               "--exclude=3D*.d",
> > +                               "--exclude=3D*.o",
> > +                               "--exclude=3Ddocker-src.*",
> > +                               "-cf", tarfile, '.'], cwd=3Ddata_dir,
> > +                              stdin=3Dself._devnull, stdout=3Dself._=
stdout)
> > +        self._data_args +=3D ["-drive",
> > +                            "file=3D%s,if=3Dnone,id=3D%s,cache=3Dwri=
teback,format=3Draw" % \
> > +                                    (tarfile, name),
> > +                            "-device",
> > +                            "virtio-blk,drive=3D%s,serial=3D%s,booti=
ndex=3D1" % (name, name)]
>=20
> what about mounting readonly via '-device virtio-9p-pci' (not using
> tarball)?
>=20

It doesn't work. That way an out-of-tree build is required in the guest, =
but if
an in-tree build has been done in host side, out-of-tree builds fail.  Al=
so the
performance will be much worse, I believe: untar is sequential read, and =
after
that everything is in the guest page cache; with virtio-9p, there will be=
 a
large amount of "random" requests between guest and host.

Fam
