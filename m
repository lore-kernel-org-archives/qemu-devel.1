Received: from eggs.gnu.org ([2001:4830:134:3::10]:37006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dT7Pz-0004Yd-Qm
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 10:06:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dT7Pu-0001Bw-1U
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 10:06:07 -0400
Received: from indium.canonical.com ([91.189.90.7]:55046)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dT7Pt-0001B1-RC
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 10:06:01 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dT7Ps-000553-Ls
	for <qemu-devel@nongnu.org>; Thu, 06 Jul 2017 14:06:00 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 7CFE62E819D
	for <qemu-devel@nongnu.org>; Thu,  6 Jul 2017 14:06:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Jul 2017 13:54:13 -0000
From: Thomas Huth <1326533@bugs.launchpad.net>
Reply-To: Bug 1326533 <1326533@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140604210316.4341.83973.malonedeb@soybean.canonical.com>
Message-Id: <149934925331.6509.1188129536620376736.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1326533] Re: SDL2 UI sends a NULL to
 sdl_grab_start if fullscreen, which crashes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The NULL pointer check has been added here:
http://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3Df2335791fd0ceb2f9e3

** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1326533

Title:
  SDL2 UI sends a NULL to sdl_grab_start if fullscreen, which crashes

Status in QEMU:
  Fix Released

Bug description:
  in ui/sdl2.c:

  =C2=A0=C2=A0=C2=A0=C2=A0if (full_screen) {
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0gui_fullscreen =3D 1;
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sdl_grab_start(0);
  =C2=A0=C2=A0=C2=A0=C2=A0}

  Is sent, but no null checks are made in sdl_grab_start (its assumed to
  be an allocated pointer). So a crash happens if you start qemu -full-
  screen.

  It should at lease send the first [0] of the newly allocated
  sdl2_console through.

  Quickly looking around should look something like:

  =C2=A0=C2=A0=C2=A0=C2=A0if (full_screen) {
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0gui_fullscreen =3D 1;
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sdl_grab_start(&sdl2_cons=
ole[0]);
  =C2=A0=C2=A0=C2=A0=C2=A0}

  Or possibly put into the loop where the sdl2_console is created

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1326533/+subscriptions
