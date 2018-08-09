Received: from eggs.gnu.org ([2001:4830:134:3::10]:37515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fns7s-0000ld-Sh
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 17:05:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fns7o-0005pI-RE
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 17:05:44 -0400
Received: from indium.canonical.com ([91.189.90.7]:51876)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fns7o-0005oo-A7
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 17:05:40 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fns7n-0000OQ-12
	for <qemu-devel@nongnu.org>; Thu, 09 Aug 2018 21:05:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 059A92E8076
	for <qemu-devel@nongnu.org>; Thu,  9 Aug 2018 21:05:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Aug 2018 20:53:48 -0000
From: =?utf-8?q?Murilo_Opsfelder_Ara=C3=BAjo?= <1786343@bugs.launchpad.net>
Reply-To: Bug 1786343 <1786343@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153384533733.1481.3173989120968287826.malonedeb@gac.canonical.com>
Message-Id: <153384802866.10156.13845057705219287463.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1786343] Re: QEMU v3.0.0-rc4 configure fails with
 --enable-mpath on CentOS 7.5
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I'll work on a fix for configure.

** Changed in: qemu
       Status: New =3D> Confirmed

** Changed in: qemu
     Assignee: (unassigned) =3D> Murilo Opsfelder Ara=C3=BAjo (mopsfelder)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1786343

Title:
  QEMU v3.0.0-rc4 configure fails with --enable-mpath on CentOS 7.5

Status in QEMU:
  Confirmed

Bug description:
  QEMU v3.0.0-rc4 configure fails with --enable-mpath on CentOS 7.5.

  After commit b3f1c8c413bc83e4a2cc7a63e4eddf9fe6449052 "qemu-pr-helper: us=
e new
  libmultipath API", QEMU started using new libmultipath API, which is not
  available on CentOS 7.5.  Reverting this commit, configure passes.

  Steps to reproduce (fails on x86_64 and ppc64le architectures):

    $ git clone git://git.qemu.org/qemu.git
    $ mkdir -p qemu/build && cd qemu/build
    $ ../configure --enable-mpath
    ERROR: Multipath requires libmpathpersist devel

    $ rpm -qa | grep device-mapper | sort
    device-mapper-1.02.146-4.el7.ppc64le
    device-mapper-devel-1.02.146-4.el7.ppc64le
    device-mapper-libs-1.02.146-4.el7.ppc64le
    device-mapper-multipath-0.4.9-119.el7.ppc64le
    device-mapper-multipath-devel-0.4.9-119.el7.ppc64le
    device-mapper-multipath-libs-0.4.9-119.el7.ppc64le

  Snippet from config.log:

    funcs: do_compiler do_cc compile_prog main
    lines: 92 125 3580 0
    cc -pthread -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include -m64 =
-D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototy=
pes -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes -f=
no-strict-aliasing -fno-common -fwrapv -Wendif-labels -Wno-missing-include-=
dirs -Wempty-body -Wnested-externs -Wformat-security -Wformat-y2k -Winit-se=
lf -Wignored-qualifiers -Wold-style-declaration -Wold-style-definition -Wty=
pe-limits -fstack-protector-strong -Wno-missing-braces -I/usr/include/p11-k=
it-1 -I/usr/include/libpng15 -o config-temp/qemu-conf.exe config-temp/qemu-=
conf.c -m64 -g -ludev -lmultipath -lmpathpersist
    config-temp/qemu-conf.c: In function =E2=80=98main=E2=80=99:
    config-temp/qemu-conf.c:15:5: error: too few arguments to function =E2=
=80=98mpath_lib_init=E2=80=99
         multipath_conf =3D mpath_lib_init();
         ^
    In file included from config-temp/qemu-conf.c:2:0:
    /usr/include/mpath_persist.h:179:12: note: declared here
     extern int mpath_lib_init (struct udev *udev);
                ^

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1786343/+subscriptions
