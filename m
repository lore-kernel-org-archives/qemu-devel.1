Received: from eggs.gnu.org ([2001:4830:134:3::10]:54722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dspdA-0001Bt-FR
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 08:22:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dspd6-0004JI-Gm
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 08:22:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50636)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dspd6-0004Ij-8B
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 08:21:56 -0400
Date: Fri, 15 Sep 2017 20:21:53 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170915122153.GK17199@lemon>
References: <20170915090253.12201-1-famz@redhat.com>
	<CAFEAcA_b71j3v5Ag7uSTPBgUT2_Qej+KJxH57cKV+6QdRgCw9A@mail.gmail.com>
	<20170915114001.GG13610@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170915114001.GG13610@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v4 00/38] Test and build patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Fri, 09/15 12:40, Daniel P. Berrange wrote:
> On Fri, Sep 15, 2017 at 11:55:44AM +0100, Peter Maydell wrote:
> > On 15 September 2017 at 10:02, Fam Zheng <famz@redhat.com> wrote:
> > > The following changes since commit 04ef33052c205170c92df21ca0b4be4f=
3b102188:
> > >
> > >   tcg/tci: do not use ldst label (never implemented) (2017-09-11 19=
:24:05 +0100)
> > >
> > > are available in the git repository at:
> > >
> > >   git://github.com/famz/qemu.git tags/test-and-build-pull-request
> > >
> > > for you to fetch changes up to be78fe670401af14e6d63fce5c5467f75120=
7871:
> > >
> > >   buildsys: Move rdma libs to per object (2017-09-15 15:05:24 +0800=
)
> > >
> > > ----------------------------------------------------------------
> > >
> > > ----------------------------------------------------------------
> > >
> > > Alex Benn=E9e (4):
> > >   docker: ensure NOUSER for travis images
> > >   docker: docker.py make --no-cache skip checksum test
> > >   docker: don't install device-tree-compiler build-deps in travis.d=
ocker
> > >   docker: reduce noise when building travis.docker
> > >
> > > Fam Zheng (34):
> > >   docker: Update ubuntu image
> > >   docker: Enable features explicitly in test-full
> > >   tests/docker: Clean up paths
> > >   gitignore: Ignore vm test images
> > >   qemu.py: Add "wait()" method
> > >   scripts: Add archive-source.sh
> > >   tests: Add a test key pair
> >=20
> > So, before I commit an ssh private key to our git repo,
> > can you explain why it's ok that this is public? The
> > commit message for the relevant patch doesn't really say.
>=20
> IIUC, the public part of the key gets exposed to the guest images via
> cloud-init metadata. During boot the guest read this metadata and add
> the public key to authorized_keys. The private key is used by the test
> suite on the host so that it can now login to the guests.
>=20
> So the risk here is that if these guests were exposed to the LAN in any
> way, someone could grab our private key and login to these guests.
>=20
> What saves us is that the VMs are run with user mode slirp networking
> so AFAICT, aren't exposed to the LAN.  So as long as we don't change
> this to any kind of real networking, I think its acceptable to have
> the private key in it and doesn't expose developer's workstations to
> undue risk and avoids consuming system entropy to generate new keys
> during build.

The hostfwd does listen on a dynamic port on 0.0.0.0, so does vnc. I didn=
't
really care since it's for temporary guests and for me convenience outwei=
ghed a
bit.  The VM test is indeed less restricted than the docker ones such as =
in that
network is always available. Should it be a problem?

We can probably add restrict=3Don to slirp and listen on loopback.

Fam
