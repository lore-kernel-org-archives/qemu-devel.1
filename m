Received: from eggs.gnu.org ([2001:4830:134:3::10]:40378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1gHb4y-0005h6-Ta
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 16:57:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1gHb4e-0004ub-Rt
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 16:57:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46450
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1gHb4e-0004tl-LJ
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 16:57:16 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w9UKs2hk136235
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 16:57:14 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2nevw7cg9w-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 16:57:14 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 30 Oct 2018 20:57:14 -0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <CAFEAcA9czM5qCtj3F_QAhS8dP7yQog-9eD8dGP0qaSeOZ_hang@mail.gmail.com>
References: <20181030144358.23144-1-mdroth@linux.vnet.ibm.com>
	<CAFEAcA9czM5qCtj3F_QAhS8dP7yQog-9eD8dGP0qaSeOZ_hang@mail.gmail.com>
Date: Tue, 30 Oct 2018 15:57:03 -0500
Message-Id: <154093302393.20054.12233984835977061096@sif>
Subject: Re: [Qemu-devel] [PULL 00/24] qemu-ga patch queue for soft-freeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

Quoting Peter Maydell (2018-10-30 13:49:18)
> On 30 October 2018 at 14:43, Michael Roth <mdroth@linux.vnet.ibm.com> wro=
te:
> > The following changes since commit 62b658db1df7c6fa574caae038144f24bf6c=
a495:
> >
> >   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-reques=
t' into staging (2018-10-29 17:03:27 +0000)
> >
> > are available in the Git repository at:
> >
> >   git://github.com/mdroth/qemu.git tags/qga-pull-2018-10-30-tag
> >
> > for you to fetch changes up to 86f167a2326cebec947da6526dae0a356148bd8a:
> >
> >   qga-win: changing --retry-path option behavior (2018-10-30 09:06:28 -=
0500)
> >
> > ----------------------------------------------------------------
> > qemu-ga patch queue for soft-freeze
> >
> > * support for --retry-path option for recovering from communication
> >   path failures
> > * support for serial/device name in guest-get-fsinfo for linux/w32
> > * support for freezing individual mount points in guest-fsfreeze-*
> > * fixes for unicode paths on w32, not-present vcpus in guest-get-vcpus,
> >   buffer overflow in guest-get-fsinfo for w32, and other minor fixes
> >
> > ----------------------------------------------------------------
> =

> I get a compile failure here for my Ubuntu x86-64 host
> static build:
> =

>   LINK    qemu-ga
> /usr/bin/ld: cannot find -ludev
> =

> This is probably because my system has libudev as a dynamic
> library but not a static one. Googling suggests that libudev
> upstream don't support providing a static library, so we
> need to either make configure handle this case or declare
> (and enforce?) that --static requires --disable-tools.
> =

> It seems to me that a statically linked guest agent might
> be useful for some use cases? It would mean you didn't have
> to depend on the exact libraries the guest had installed.

Hi Peter,

Sorry for the breakage. Static is indeed useful for qemu-ga, but libudev
isn't a hard dependency for qemu-ga so we can get away with simply
disabling libudev for static builds. Would the following (squashed into
patch 04/24) be acceptable? This fixes static qemu-ga builds for me for
both Ubuntu 18.04 and FC27. I'll go ahead submit a v2 shortly since it
may be late for you:

--- a/configure
+++ b/configure
@@ -5608,7 +5608,7 @@ fi
 ##########################################
 # Do we have libudev
 if test "$libudev" !=3D "no" ; then
-  if $pkg_config libudev; then
+  if $pkg_config libudev && test "$static" !=3D "yes"; then
     if test "$static" !=3D "yes"; then
       libudev=3D"yes"
       libudev_libs=3D$($pkg_config --libs libudev)

> =

> (As an aside, it's an ubuntu bug that
> "pkg-config --static --libs libudev" doesn't correctly report
> that it can't do static linking of this library, but this
> is an extremely common bug in library pkg-config files.)
> =

> thanks
> -- PMM
>=20
