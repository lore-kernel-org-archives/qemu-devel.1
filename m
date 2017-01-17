Received: from eggs.gnu.org ([2001:4830:134:3::10]:53682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cTS2E-0004JC-Eh
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 06:34:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cTS2A-0007ot-HC
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 06:34:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36444)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cTS2A-0007oJ-CD
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 06:34:38 -0500
Date: Tue, 17 Jan 2017 19:34:34 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170117113434.GC6199@lemon>
References: <20161213132205.9114-1-alex.bennee@linaro.org>
	<20170117094953.GA6199@lemon> <87ziiqszlt.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87ziiqszlt.fsf@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] tests/docker: add basic user mapping
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: bobby.prani@gmail.com, qemu-devel@nongnu.org

On Tue, 01/17 11:19, Alex Benn=E9e wrote:
> >> +            if args.user:
> >> +                uid =3D os.getuid()
> >> +                uname =3D getpwuid(uid).pw_name
> >> +                scriptlet =3D docker_dir+"/setup_user.sh"
> >> +
> >> +                # write scriptlet
> >> +                setup =3D open(scriptlet, "w")
> >> +                setup.write("#!/bin/sh\n")
> >> +                setup.write("useradd -u %d -U %s" % (uid, uname))
> >> +                setup.close()
> >> +
> >> +                st =3D os.stat(scriptlet)
> >> +                os.chmod(scriptlet,
> >> +                         st.st_mode | stat.S_IXUSR | stat.S_IXGRP |=
 stat.S_IXOTH)
> >
> > Is it cleaner we inject commands into the docker file directly?
>=20
> How do you mean? Running a second docker run command after we have buil=
t
> the image?
>=20
> IIRC I'd previously tried having a template approach where we took a
> docker.in and generated a final template for the build but we abandoned
> that approach.

build_image() generates a tmp_df, for "LABEL com.qemu..." (I should have =
named
it org.qemu.., really, it was a silly mistake). We can add an additional =
"RUN
useradd -u ..." line there just as well.

Fam

>=20
> >
> >> +
> >>              dkr.build_image(tag, docker_dir, dockerfile,
> >>                              quiet=3Dargs.quiet, argv=3Dargv)
> >>
