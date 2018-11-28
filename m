Received: from eggs.gnu.org ([2001:4830:134:3::10]:38926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gS7U9-0000ZC-MO
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 16:35:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gS7U6-0005nE-CL
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 16:35:05 -0500
Received: from indium.canonical.com ([91.189.90.7]:45230)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gS7U6-0005ek-6H
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 16:35:02 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gS7U4-0002uv-Hb
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 21:35:00 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 792832E80DB
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 21:35:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Nov 2018 21:20:59 -0000
From: Alexander Gretha <1336794@bugs.launchpad.net>
Reply-To: Bug 1336794 <1336794@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140702135258.23882.15100.malonedeb@soybean.canonical.com>
Message-Id: <154344005923.16019.572305508941077507.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1336794] Re: 9pfs does not honor open file
 handles on unlinked files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

hi greg,

thanks very much for you answer. i saw the proposed kernel patch from eric =
van hensbergen - even tried to build my own kernel with the patch applied, =
i was ready to run this on a custom kernel with a custom built qemu, but al=
though the patch can be applied, there have been too many changes in the su=
rrounding code for it to be able to work.
the idea of the 9p file sharing in qemu is really nice (and fast). i am (wa=
s) trying to use it as a persistent storage on a kubernetes cluster and it =
is much better than nfs (performance wise) locking works just dandy.
with 9p i thought i was golden, unfortunately no cigar.
since there are different parties involved (and to get something into the l=
inux kernel requires - from what i have read - the patience of a buddhist m=
onk) i think it will be very hard to get this picked up.
because of the time frame this will probably not be a solution for me, but =
i am nonetheless willing to invest some time to bringing this forward.
how is a good way to proceed? (sorry, this question might sound dumb, but d=
espite being a software developer for most of my working life the ways of t=
he open source community have never revealed themselves to me).

-alex

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1336794

Title:
  9pfs does not honor open file handles on unlinked files

Status in QEMU:
  In Progress
Status in Ubuntu:
  Confirmed

Bug description:
  This was originally filed over here:
  https://bugzilla.redhat.com/show_bug.cgi?id=3D1114221

  The open-unlink-fstat idiom used in some places to create an anonymous
  private temporary file does not work in a QEMU guest over a virtio-9p
  filesystem.

  Version-Release number of selected component (if applicable):

  qemu-kvm-1.6.2-6.fc20.x86_64
  qemu-system-x86-1.6.2-6.fc20.x86_64
  (those are fedora RPMs)

  How reproducible:

  Always. See this example C program:

  https://bugzilla.redhat.com/attachment.cgi?id=3D913069

  Steps to Reproduce:
  1. Export a filesystem with virt-manager for the guest.
        (type: mount, driver: default, mode: passthrough)
  2. Start guest and mount that filesystem
        (mount -t 9p -o trans=3Dvirtio,version=3D9p2000.L  ...)
  3. Run a program that uses open-unlink-fstat
        (in my case it was trying to compile Perl 5.20)

  Actual results:

  fstat fails:

  open("/home/tst/filename", O_RDWR|O_CREAT|O_EXCL, 0600) =3D 3
  unlink("/home/tst/filename")            =3D 0
  fstat(3, 0x23aa1a8)                     =3D -1 ENOENT (No such file or di=
rectory)
  close(3)

  Expected results:

  open("/home/tst/filename", O_RDWR|O_CREAT|O_EXCL, 0600) =3D 3
  unlink("/home/tst/filename")            =3D 0
  fstat(3, {st_mode=3DS_IFREG|0600, st_size=3D0, ...}) =3D 0
  fcntl(3, F_SETFD, FD_CLOEXEC)           =3D 0
  close(3) =


  Additional info:

  There was a patch put into the kernel back in '07 to handle this very
  problem for other filesystems; maybe its helpful:

        http://lwn.net/Articles/251228/

  There is also a thread on LKML from last December specifically about
  this very problem:

        https://lkml.org/lkml/2013/12/31/163

  There was a discussion on the QEMU list back in '11 that doesn't seem
  to have come to a conclusion, but did provide the test program that
  i've attached to this report:

        http://marc.info/?l=3Dqemu-devel&m=3D130443605720648&w=3D2

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1336794/+subscriptions
