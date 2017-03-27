Received: from eggs.gnu.org ([2001:4830:134:3::10]:40291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1csOGx-00024r-IC
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 02:37:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1csOGu-0001d6-CP
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 02:36:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54586)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1csOGu-0001d1-49
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 02:36:56 -0400
Date: Mon, 27 Mar 2017 14:36:51 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170327063651.GD2226@lemon.lan>
References: <CAFEAcA9pqDoCWrPAJ+KVxLC_eRy-xRg36oYuARYg2YP8VpGpBg@mail.gmail.com>
	<c46ff864-fc8b-aeba-30f4-4c773f879786@redhat.com>
	<85b94581-70ec-3e7e-1f2f-dd70204fb68c@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <85b94581-70ec-3e7e-1f2f-dd70204fb68c@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] rawhide gcc failures [was: Proposal for
 deprecating unsupported host OSes & architecutures]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Eric Blake <eblake@redhat.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Wed, 03/22 16:39, Philippe Mathieu-Daud=C3=A9 wrote:
> so lovely...
>=20
> as a start point for bleeding edge stuff this can go in CI as a complem=
ent
> of debian images in tests/docker/... using the official fedora:rawhide =
base
> image.

That is an interesting question. Current patchew tester setup never updat=
es the
docker image which means fedora:latest or fedora:rawhide won't get "refre=
shed"
at each test run, over time they get out-of-date. We should have a way to
periodically update it..

I can also work on a patch to add fedora:rawhide to tests/docker, but I'm=
 not
100% sure that we want to add it to the first class test combinations - t=
here
could be noise if something regresses in rawhide.

Still, we can make one move a time.  Thanks,

Fam

>=20
> On 03/22/2017 04:07 PM, Eric Blake wrote:
> > On 03/16/2017 10:23 AM, Peter Maydell wrote:
> > > OK, here's a concrete proposal for deprecating/dropping out of
> > > date host OS and architecture support.
> > >=20
> > > We'll put this in the ChangeLog 'Future incompatible changes'
> > > section:
> > > -----
> > > * Removal of support for untested host OS and architectures:
> >=20
> > Tangentially-related: do we officially support bleeding-edge OS build=
s?
> > For example, current rawhide has a new-enough gcc that gives some
> > (possibly-useful) new warnings (-Werror=3Dformat-truncation) that fir=
e
> > when formatting what can be easily proven to be larger than a
> > fixed-width buffer will hold.  If rawhide is not a current target, th=
en
> > I don't need to spend any time on this (yet); but if rawhide builds A=
RE
> > supported, then we want this patched before 2.9:
> >=20
> >=20
> >   CC      block/blkdebug.o
> > block/blkdebug.c: In function =E2=80=98blkdebug_refresh_filename=E2=80=
=99:
> > block/blkdebug.c:693:31: error: =E2=80=98%s=E2=80=99 directive output=
 may be truncated
> > writing up to 4095 bytes into a region of size 4086
> > [-Werror=3Dformat-truncation=3D]
> >                   "blkdebug:%s:%s", s->config_file ?: "",
> >                                ^~
> > block/blkdebug.c:692:9: note: =E2=80=98snprintf=E2=80=99 output 11 or=
 more bytes
> > (assuming 4106) into a destination of size 4096
> >          snprintf(bs->exact_filename, sizeof(bs->exact_filename),
> >          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >                   "blkdebug:%s:%s", s->config_file ?: "",
> >                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >                   bs->file->bs->exact_filename);
> >                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > cc1: all warnings being treated as errors
> > make: *** [/home/dummy/qemu/rules.mak:69: block/blkdebug.o] Error 1
> >   CC      block/blkverify.o
> > block/blkverify.c: In function =E2=80=98blkverify_refresh_filename=E2=
=80=99:
> > block/blkverify.c:309:29: error: =E2=80=98%s=E2=80=99 directive outpu=
t may be truncated
> > writing up to 4095 bytes into a region of size 4086
> > [-Werror=3Dformat-truncation=3D]
> >                   "blkverify:%s:%s",
> >                              ^~
> > block/blkverify.c:308:9: note: =E2=80=98snprintf=E2=80=99 output betw=
een 12 and 8202
> > bytes into a destination of size 4096
> >          snprintf(bs->exact_filename, sizeof(bs->exact_filename),
> >          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >                   "blkverify:%s:%s",
> >                   ~~~~~~~~~~~~~~~~~~
> >                   bs->file->bs->exact_filename,
> >                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >                   s->test_file->bs->exact_filename);
> >                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > cc1: all warnings being treated as errors
> > make: *** [/home/dummy/qemu/rules.mak:69: block/blkverify.o] Error 1
> >   CC      hw/usb/bus.o
> > hw/usb/bus.c: In function =E2=80=98usb_port_location=E2=80=99:
> > hw/usb/bus.c:410:66: error: =E2=80=98%d=E2=80=99 directive output may=
 be truncated
> > writing between 1 and 11 bytes into a region of size between 0 and 15
> > [-Werror=3Dformat-truncation=3D]
> >          snprintf(downstream->path, sizeof(downstream->path), "%s.%d"=
,
> >                                                                   ^~
> > hw/usb/bus.c:410:9: note: =E2=80=98snprintf=E2=80=99 output between 3=
 and 28 bytes into
> > a destination of size 16
> >          snprintf(downstream->path, sizeof(downstream->path), "%s.%d"=
,
> >          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~
> >                   upstream->path, portnr);
> >                   ~~~~~~~~~~~~~~~~~~~~~~~
> > cc1: all warnings being treated as errors
> > make: *** [/home/dummy/qemu/rules.mak:69: hw/usb/bus.o] Error 1
> >   CC      net/slirp.o
> > net/slirp.c: In function =E2=80=98slirp_smb_cleanup=E2=80=99:
> > net/slirp.c:565:44: error: =E2=80=98%s=E2=80=99 directive output may =
be truncated
> > writing up to 127 bytes into a region of size 121
> > [-Werror=3Dformat-truncation=3D]
> >          snprintf(cmd, sizeof(cmd), "rm -rf %s", s->smb_dir);
> >                                             ^~
> > net/slirp.c:565:9: note: =E2=80=98snprintf=E2=80=99 output between 8 =
and 135 bytes into
> > a destination of size 128
> >          snprintf(cmd, sizeof(cmd), "rm -rf %s", s->smb_dir);
> >          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > net/slirp.c: In function =E2=80=98slirp_smb=E2=80=99:
> > net/slirp.c:609:46: error: =E2=80=98%s=E2=80=99 directive output may =
be truncated
> > writing 8 bytes into a region of size between 0 and 127
> > [-Werror=3Dformat-truncation=3D]
> >      snprintf(smb_conf, sizeof(smb_conf), "%s/%s", s->smb_dir, "smb.c=
onf");
> >                                               ^~               ~~~~~~=
~~~~
> > net/slirp.c:609:5: note: =E2=80=98snprintf=E2=80=99 output between 10=
 and 137 bytes into
> > a destination of size 128
> >      snprintf(smb_conf, sizeof(smb_conf), "%s/%s", s->smb_dir, "smb.c=
onf");
> >      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~
> > net/slirp.c:654:55: error: =E2=80=98%s=E2=80=99 directive output may =
be truncated
> > writing up to 127 bytes into a region of size 110
> > [-Werror=3Dformat-truncation=3D]
> >      snprintf(smb_cmdline, sizeof(smb_cmdline), "%s -l %s -s %s",
> >                                                        ^~
> > net/slirp.c:654:5: note: =E2=80=98snprintf=E2=80=99 output 23 or more=
 bytes (assuming
> > 150) into a destination of size 128
> >      snprintf(smb_cmdline, sizeof(smb_cmdline), "%s -l %s -s %s",
> >      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >               CONFIG_SMBD_COMMAND, s->smb_dir, smb_conf);
> >               ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > cc1: all warnings being treated as errors
> > make: *** [/home/dummy/qemu/rules.mak:69: net/slirp.o] Error 1
> > make: Target 'all' not remade because of errors.
> >=20
> >=20
