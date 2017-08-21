Received: from eggs.gnu.org ([2001:4830:134:3::10]:49998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1djhdU-0001xB-Ev
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 04:00:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1djhdQ-00045T-81
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 04:00:36 -0400
Received: from indium.canonical.com ([91.189.90.7]:52275)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1djhdQ-00045H-2H
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 04:00:32 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1djhdP-0000vm-3w
	for <qemu-devel@nongnu.org>; Mon, 21 Aug 2017 08:00:31 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 18B7E2E80C7
	for <qemu-devel@nongnu.org>; Mon, 21 Aug 2017 08:00:31 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Aug 2017 07:47:51 -0000
From: Thomas Huth <1054180@bugs.launchpad.net>
Reply-To: Bug 1054180 <1054180@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120921161324.22633.34633.malonedeb@chaenomeles.canonical.com>
Message-Id: <150330167165.17444.7297182278064985891.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1054180] Re: DNS activity in slirp (user
 networking) mode quickly depletes file descriptors and crashes qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets ... can you still reproduce this problem with
the latest version of QEMU (currently v2.9 or a release candidate of
2.10)?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1054180

Title:
  DNS activity in slirp (user networking) mode quickly depletes file
  descriptors and crashes qemu

Status in QEMU:
  Incomplete

Bug description:
  Hi, we have encountered quite some trouble with filedescriptor
  depletion of the qemu process. We have figured out that it can be
  demonstrated easily by doing a lot of DNS queries inside the VM -- in
  our real world scenario this is caused by running centos network
  install with a fast mirror.

  This situation is further problematic because qemu can't handle fd deplet=
ion very well:
  1) if ulimit is 1024 then qemu hangs in infinite loop whenever it tries t=
o open the 1025th fd
  2) setting ulimit >1024 does not help that much because qemu uses select =
and max. fd set size is 1024 per default =3D> qemu crashes because of buffe=
r overflow in select()
  3) setting ulimit > 1024 AND recompiling with large enough fd set size AN=
D disabling gcc's fortify source seems to work, but that's really just a ho=
t-fix

  The problem can be replicated quite easily by running something like

  while :; do echo >/dev/udp/10.0.2.3/53; done

  inside a Linux VM -- crash comes very soon.

  This problem is present in current qemu (1.2.0) and in earlier as
  well.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1054180/+subscriptions
