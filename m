Received: from eggs.gnu.org ([2001:4830:134:3::10]:50014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1djhdX-0001zS-9L
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 04:00:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1djhdR-00045x-92
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 04:00:39 -0400
Received: from indium.canonical.com ([91.189.90.7]:52289)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1djhdR-00045l-3E
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 04:00:33 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1djhdQ-0000w8-4q
	for <qemu-devel@nongnu.org>; Mon, 21 Aug 2017 08:00:32 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 20E202E80C9
	for <qemu-devel@nongnu.org>; Mon, 21 Aug 2017 08:00:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Aug 2017 07:48:39 -0000
From: Thomas Huth <1054180@bugs.launchpad.net>
Reply-To: Bug 1054180 <1054180@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120921161324.22633.34633.malonedeb@chaenomeles.canonical.com>
Message-Id: <150330171918.11273.2779287120959028186.malone@wampee.canonical.com>
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

Also could you please provide the exact command line that you use to
start QEMU?

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
