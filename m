Received: from eggs.gnu.org ([2001:4830:134:3::10]:33218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dOAEI-0005TH-G4
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 18:05:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dOAED-0002d5-CL
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 18:05:34 -0400
Received: from indium.canonical.com ([91.189.90.7]:49023)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dOAED-0002cr-6I
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 18:05:29 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dOAEC-0005qR-4m
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 22:05:28 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 1DFF32E8190
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 22:05:28 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Jun 2017 21:48:35 -0000
From: Buck <1047470@bugs.launchpad.net>
Reply-To: Bug 1047470 <1047470@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120907154742.10241.91584.malonedeb@gac.canonical.com>
Message-Id: <149816811527.3849.13920382017387313225.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1047470] Re: qemu/kvm hangs reading from serial
 console
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

i don't use kvm/qemu any more and so don't have a means
to determine if this is still an issue or not so please
presume fixed, i guess

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1047470

Title:
  qemu/kvm hangs reading from serial console

Status in QEMU:
  Incomplete

Bug description:
  This is for a qemu-kvm running on RHEL 5, so it's pretty old,
  but i think the problem still exists in 1.2

  We have conman running on our hosts, connecting to the
  kvm/qemu's using
  =C2=A0=C2=A0=C2=A0=C2=A0virsh console
  which just opens up the console /dev/pts/slave that qemu
  opens up when run with options
  =C2=A0=C2=A0=C2=A0=C2=A0-nographic
  =C2=A0=C2=A0=C2=A0=C2=A0-serial mon:pty

  Sometimes virsh console exits and then qemu locks up[*].
  My guess is that something like this happens:

  virsh console exits
  qemu does a select() on /dev/ptmx (and other FDs)
  select() returns the FD of /dev/ptmx in the read-fdset
  qemu does a read()
  read() returns -1 (EIO)
  qemu does other stuff for a while
  select() ... /dev/ptmx
  read() .. EIO
  other stuff
  select() ... read() ... select() ... read() ... select()
  conman starts a new virsh console that connects
  qemu does a read()
  read() blocks b/c there is now a writer on the tty slave

  So i don't see any way around this, given the sorta rudi-
  mentary semantics of TTY IO on Linux (not that i know of
  any platform that does it better ... ?), except ...

  maybe qemu should
  =C2=A0=C2=A0=C2=A0=C2=A0fcntl(master_fd, F_SETFL, flags | O_NONBLOCK)
  in qemu-char.c:qemu_char_open_pty()
  and be prepared to handle E_WOULDBLOCK|E_AGAIN in
  qemu-char.c:fd_chr_read() ... ?

  --buck

  [*] i think, b/c in the old version we are running, sometimes
  =C2=A0=C2=A0=C2=A0=C2=A0the guest spits out the
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^]
  =C2=A0=C2=A0=C2=A0=C2=A0character to its console, and virsh console reads=
 it and
  =C2=A0=C2=A0=C2=A0=C2=A0doesn't check to see if its from stdin or the pty=
 and exits,
  =C2=A0=C2=A0=C2=A0=C2=A0which, i think, can be fixed like this:

  --- libvirt-0.8.2/tools/console.c.ctrl_close_bracket_handling_fix       2=
012-09-06 10:30:43.606997191 -0400
  +++ libvirt-0.8.2/tools/console.c       2012-09-06 10:34:52.154000464 -04=
00
  @@ -155,6 +155,7 @@ int vshRunConsole(const char *tty) {

  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Quit if end of file, or we got the Ctrl-] =
key */
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!got ||
  +                    fds[i].fd =3D=3D STDIN_FILENO &&
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(got =3D=3D 1 &&
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0buf[0] =3D=3D C=
TRL_CLOSE_BRACKET))
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0goto done;

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1047470/+subscriptions
