Received: from eggs.gnu.org ([2001:4830:134:3::10]:57337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cRPXb-0000cp-DB
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 15:30:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cRPXY-0004kS-7z
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 15:30:39 -0500
Received: from indium.canonical.com ([91.189.90.7]:59942)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cRPXY-0004kI-0l
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 15:30:36 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cRPXW-0003mF-Ty
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 20:30:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id DA36F2E80C1
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 20:30:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Jan 2017 20:13:00 -0000
From: Thomas Huth <1268671@bugs.launchpad.net>
Reply-To: Bug 1268671 <1268671@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140113174654.7725.99941.malonedeb@soybean.canonical.com>
Message-Id: <20170111201300.20524.57338.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1268671] Re: CentOS guest crashing due to
 assertion failure in qemu-char.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

QEMU 0.12 is completely outdated nowadays ... can you still reproduce
this problem with the latest version of QEMU?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1268671

Title:
  CentOS guest crashing due to assertion failure in qemu-char.c

Status in QEMU:
  Incomplete

Bug description:
  Here is the log in /var/log/libvirt/qemu/centos_heavy.log

  qemu-kvm: /builddir/build/BUILD/qemu-kvm-0.12.1.2/qemu-char.c:630: io_wat=
ch_poll_finalize: Assertion `iwp->src =3D=3D ((void *)0)' failed.
  2014-01-13 16:50:31.576+0000: shutting down

  The code it's failing the assertion on has an interesting comment:

  =C2=A0=C2=A0=C2=A0=C2=A0static void io_watch_poll_finalize(GSource *sourc=
e)
  =C2=A0=C2=A0=C2=A0=C2=A0{
  =C2=A0=C2=A0=C2=A0=C2=A0/* Due to a glib bug, removing the last reference=
 to a source
  =C2=A0=C2=A0=C2=A0=C2=A0* inside a finalize callback causes recursive loc=
king (and a
  =C2=A0=C2=A0=C2=A0=C2=A0* deadlock). This is not a problem inside other c=
allbacks,
  =C2=A0=C2=A0=C2=A0=C2=A0* including dispatch callbacks, so we call io_rem=
ove_watch_poll
  =C2=A0=C2=A0=C2=A0=C2=A0* to remove this source. A t this point, iwp->src=
 must
  =C2=A0=C2=A0=C2=A0=C2=A0* be NULL, or we would leak it.
  =C2=A0=C2=A0=C2=A0=C2=A0*
  =C2=A0=C2=A0=C2=A0=C2=A0* This would be solved much more elegantly by chi=
ld sources,
  =C2=A0=C2=A0=C2=A0=C2=A0* but we support older glib versions that do not =
have them.
  =C2=A0=C2=A0=C2=A0=C2=A0*/
  =C2=A0=C2=A0=C2=A0=C2=A0IOWatchPoll *iwp =3D io_watch_poll_from_source(so=
urce);
  =C2=A0=C2=A0=C2=A0=C2=A0assert(iwp->src =3D=3D NULL);
  =C2=A0=C2=A0=C2=A0=C2=A0}

  ------
  CPU Info:

  http://pastebin.com/U7MrzFxK

  --------

  Relevant RPM versions:

  qemu-kvm-0.12.1.2-2.415.el6_5.3.x86_64
  libvirt-0.10.2-29.el6_5.2.x86_64

  --------

  Domain config:

  http://pastebin.com/Nf2VsER8

  (Note the use of the vmchannels; I believe this is playing a part in
  this crash)

  ---------

  uname -a:

  Linux blizzard 2.6.32-431.3.1.el6.x86_64 #1 SMP Fri Jan 3 21:39:27 UTC
  2014 x86_64 x86_64 x86_64 GNU/Linux

  ---------

  CLI to start guest (included in attached dump):

  http://pastebin.com/W01Xzyb0

  ---------

  thread apply all bt:

  http://pastebin.com/FTpUDU7A

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1268671/+subscriptions
