Received: from eggs.gnu.org ([2001:4830:134:3::10]:56875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1em0Lt-0006gW-9z
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 11:56:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1em0Lq-0006vz-IW
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 11:56:13 -0500
Received: from indium.canonical.com ([91.189.90.7]:59434)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1em0Lq-0006vh-Bd
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 11:56:10 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1em0Lp-0006NF-F8
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 16:56:09 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 716192E8071
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 16:56:09 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Feb 2018 16:39:19 -0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Reply-To: Bug 589315 <589315@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20100603181944.2106.17684.malonedeb@soybean.canonical.com>
Message-Id: <151862635907.9308.2339015783347033214.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 589315] Re: qemu: Improve error reporting when
 migration can't connect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

yep, it's been giving errors now for a while (and not hanging) and also
recently gained the error text in 'info migrate':

[dgilbert@dgilbert-t530 ~]$ /usr/bin/qemu-system-x86_64 -nographic
QEMU 2.10.1 monitor - type 'help' for more information
(qemu) migrate tcp:0:12345
qemu-system-x86_64: Failed to connect socket: Connection refused
(qemu) info migrate
globals: store-global-state=3D1, only_migratable=3D0, send-configuration=3D=
1, send-section-footer=3D1
capabilities: xbzrle: off rdma-pin-all: off auto-converge: off zero-blocks:=
 off compress: off events: off postcopy-ram: off x-colo: off release-ram: o=
ff block: off return-path: off =

Migration status: failed (Failed to connect socket: Connection refused)
total time: 0 milliseconds
(qemu) =


So marking as fix-release

(Note that there's a bug that causes a crash in the disconnect case on
current head, but that's only been in for a week or so and I've just
sent a fix for it).

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/589315

Title:
  qemu: Improve error reporting when migration can't connect

Status in QEMU:
  In Progress

Bug description:
  Tested with upstream qemu as of Jun 3 2010

  If the source qemu instance can't connect to the migration destination (s=
ay
  there is no listening QEMU instance, or port is blocked by a firewall), a=
ll we
  get is info migrate -> Migration status: failed. This is all we have to r=
eport
  back to libvirt users if their firewall is misconfigured, which is crappy.

  Ideally, if we can't connect, migration would fail immediately with a rel=
evant
  message and strerror(). More info from 'info migrate' would be nice too, =
no
  idea how this will play with QMP though.

  As a slightly related issue, try entering

  migrate tcp:127.0.0.0:6000

  We get a 'migration failed' error, and then the monitor hangs!

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/589315/+subscriptions
