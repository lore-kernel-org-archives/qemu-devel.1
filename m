Received: from eggs.gnu.org ([209.51.188.92]:54056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gstib-0001oe-Ri
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 13:20:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gstiZ-0004Kn-UF
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 13:20:41 -0500
Received: from indium.canonical.com ([91.189.90.7]:56186)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gstiW-0004Fc-EP
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 13:20:38 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gstiU-0002XF-Ms
	for <qemu-devel@nongnu.org>; Sun, 10 Feb 2019 18:20:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id AA39E2E8037
	for <qemu-devel@nongnu.org>; Sun, 10 Feb 2019 18:20:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 10 Feb 2019 18:12:43 -0000
From: Laurent Bigonville <bigon@bigon.be>
Reply-To: Bug 1815371 <1815371@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <154982236357.21816.7244935149831813819.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1815371] [NEW] SPICE session's connection_id's
 are not unique
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

From: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D920897

=3D=3D=3D=3D=3D

When creating a virtual machine with qemu (e.g. via libvirt) including a
SPICE server, the client_id of the SPICE session is not unique. For
example, starting multiple virtual machines on the same libvirtd, the
client_id is the same for all virtual machine's SPICE sessions.


A description of the client_id can be found in

https://www.spice-space.org/static/docs/spice_protocol.pdf under section
2.11. c) :


"UINT32 connection_id - In case of a new session (i.e., channel type is RED=
_CHANNEL_MAIN) this field is set to zero, and in response the server will a=
llocate session id and will send it via the RedLinkReply message. In case o=
f all other channel types, this field will be equal to the allocated sessio=
n id"


The relevant code for generating client ids in libspice-server1 can be foun=
d here: https://gitlab.freedesktop.org/spice/spice/blob/v0.12.8/server/reds=
.c#L1614

This uses rand() to generate the random id, but qemu (at least in the
case of qemu-system-x86) fails to initialize the RNG seed (with e.g.
srand()).


The result is, that every SPICE session started (by e.g. libvirtd) has the =
same client_id. Usually, this is not a problem, but running something like =
a SPICE proxy, relying on the client_id to correctly route connections, thi=
s creates problems.


Adding something like 'srand(time(NULL));' to qemu (in vl.c) solves this is=
sue. Related (as seen in some VNC patches, e.g. 'CVE-2017-15124/04-ui-avoid=
-pointless-VNC-updates-if-framebuffer-isn-t-.patch/ui/vnc.c' ):  srand(time=
(NULL)+getpid()+getpid()*987654+rand());


Tested on Debian 9.7 with kernel  4.9.0-6-amd64 #1 SMP Debian 4.9.88-1+deb9=
u1 (2018-05-07) x86_64 GNU/Linux.


=3D=3D=3D=3D=3D

** Affects: qemu
     Importance: Undecided
         Status: New

** Affects: qemu (Debian)
     Importance: Unknown
         Status: Unknown

** Bug watch added: Debian Bug tracker #920897
   https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D920897

** Also affects: qemu (Debian) via
   https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D920897
   Importance: Unknown
       Status: Unknown

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1815371

Title:
   SPICE session's connection_id's are not unique

Status in QEMU:
  New
Status in qemu package in Debian:
  Unknown

Bug description:
  From: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D920897

  =3D=3D=3D=3D=3D

  When creating a virtual machine with qemu (e.g. via libvirt) including
  a SPICE server, the client_id of the SPICE session is not unique. For
  example, starting multiple virtual machines on the same libvirtd, the
  client_id is the same for all virtual machine's SPICE sessions.

  =

  A description of the client_id can be found in

  https://www.spice-space.org/static/docs/spice_protocol.pdf under
  section 2.11. c) :

  =

  "UINT32 connection_id - In case of a new session (i.e., channel type is R=
ED_CHANNEL_MAIN) this field is set to zero, and in response the server will=
 allocate session id and will send it via the RedLinkReply message. In case=
 of all other channel types, this field will be equal to the allocated sess=
ion id"

  =

  The relevant code for generating client ids in libspice-server1 can be fo=
und here: https://gitlab.freedesktop.org/spice/spice/blob/v0.12.8/server/re=
ds.c#L1614

  This uses rand() to generate the random id, but qemu (at least in the
  case of qemu-system-x86) fails to initialize the RNG seed (with e.g.
  srand()).

  =

  The result is, that every SPICE session started (by e.g. libvirtd) has th=
e same client_id. Usually, this is not a problem, but running something lik=
e a SPICE proxy, relying on the client_id to correctly route connections, t=
his creates problems.

  =

  Adding something like 'srand(time(NULL));' to qemu (in vl.c) solves this =
issue. Related (as seen in some VNC patches, e.g. 'CVE-2017-15124/04-ui-avo=
id-pointless-VNC-updates-if-framebuffer-isn-t-.patch/ui/vnc.c' ):  srand(ti=
me(NULL)+getpid()+getpid()*987654+rand());

  =

  Tested on Debian 9.7 with kernel  4.9.0-6-amd64 #1 SMP Debian 4.9.88-1+de=
b9u1 (2018-05-07) x86_64 GNU/Linux.


  =3D=3D=3D=3D=3D

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1815371/+subscriptions
