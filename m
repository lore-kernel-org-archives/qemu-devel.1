Received: from eggs.gnu.org ([2001:4830:134:3::10]:48066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dn2pZ-00041t-QM
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 09:14:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dn2pU-0007vb-OJ
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 09:14:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47932)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dn2pU-0007vM-Fb
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 09:14:48 -0400
Date: Wed, 30 Aug 2017 21:14:41 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170830131441.GB8076@lemon.lan>
References: <20170828174707.20786-1-famz@redhat.com>
	<20170828174707.20786-4-famz@redhat.com>
	<de606e2a-7f5e-0625-79dd-a828ea3d5fe9@amsat.org>
	<edd3bb01-dcb5-4741-3fe4-a20a5f64af88@amsat.org>
	<f2a66875-06e8-9304-b20d-aa10e848a245@gmx.com>
	<c91157c7-6378-579c-b66e-19db518cd58a@amsat.org>
	<20170830101658.GN4208@lemon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170830101658.GN4208@lemon.lan>
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
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Kamil Rytarowski <kamil@netbsd.org>, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, pbonzini@redhat.com, Kamil Rytarowski <n54@gmx.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>

On Wed, 08/30 18:16, Fam Zheng wrote:
> On Tue, 08/29 10:35, Philippe Mathieu-Daud=E9 wrote:
> > On 08/29/2017 10:22 AM, Kamil Rytarowski wrote:
> > > On 29.08.2017 15:10, Philippe Mathieu-Daud=E9 wrote:
> > > > Hi Fam, Kamil,
> > > >=20
> > > > > On 08/28/2017 02:47 PM, Fam Zheng wrote:
> > > > [...]
> > > > > > +        subprocess.check_call([tar_cmd,
> > > > > > +                               "--exclude-vcs",
> > > > > > +                               "--exclude=3Dtests/vm/*.img",
> > > > > > +                               "--exclude=3Dtests/vm/*.img.*=
",
> > > > > > +                               "--exclude=3D*.d",
> > > > > > +                               "--exclude=3D*.o",
> > > > > > +                               "--exclude=3Ddocker-src.*",
> > > > > > +                               "-cf", tarfile, '.'], cwd=3Dd=
ata_dir,
> > > > >=20
> > > > > I'm not happy with this command :/
> > > > > My distrib uses tmpfs for /tmp and suddently the whole X window=
 became
> > > > > irresponsive until this script failing after filling 8G of /tmp=
 and swap:
> > > > >=20
> > > > > ...
> > > > > DEBUG:root:Creating archive /tmp/qemu-vm-F7CY9O/data-3a52c.tar =
for
> > > > > data dir: .
> > > > > tar: /tmp/qemu-vm-F7CY9O/data-3a52c.tar: Wrote only 4096 of 102=
40 bytes
> > > > > tar: Error is not recoverable: exiting now
> > > > > Failed to prepare guest environment
> > > > >=20
> > > > > Then I figured out my workdir is full of testing stuff, debug i=
mages,
> > > > > firmwares, coredumps, etc.
> > > > >=20
> > > > > I'll think of another way.
> > > >=20
> > > > Using:
> > > >=20
> > > > (git ls-files; git submodule foreach --recursive "git ls-files | =
sed
> > > > s_^_\$sm_path/_" | sed /^Entering/d) > files.txt
> > > >=20
> > > > and:
> > > >=20
> > > >          subprocess.check_call([tar_cmd,
> > > >                                 "-cf", tarfile,
> > > >                                 "-v" if self.debug else "",
> > > >                                 "-T", "files.txt"], cwd=3Ddata_di=
r,
> > > >                                stdin=3Dself._devnull, stdout=3Dse=
lf._stdout)
> > > >=20
> > > > Current /master and submodules generated tarball is ~305MB uncomp=
ressed.
> > > >=20
> > > > Kamil do you mind testing this command on NetBSD?
> > > >=20
> > > > (obviously 'files.txt' goes in tmpdir).
> > > >=20
> > >=20
> > > Result:
> > >=20
> > > http://www.netbsd.org/~kamil/qemu/files.txt
> >=20
> > \o/
> >=20
> > > I've tested this command line on a checkout from Jul 17th rev. 7703=
1ee1ce4c
> >=20
> > Thanks Kamil :)
> >=20
> > Fam are you OK using this command instead?
>=20
> Looks good, will use it! Thanks.

Hmm, there is a complication. "git ls-files" output includes submodule na=
mes,
which are directory names from the "tar -T" PoV, and the whole directory =
is
archived.

I'm going to stop fighting on this and refactor the docker tests's "git a=
rchive"
rules, to reuse in this script.

Fam
