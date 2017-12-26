Received: from eggs.gnu.org ([2001:4830:134:3::10]:45235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eTgsF-0004q5-3W
	for qemu-devel@nongnu.org; Mon, 25 Dec 2017 23:29:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eTgsA-0000Fn-8g
	for qemu-devel@nongnu.org; Mon, 25 Dec 2017 23:29:55 -0500
Received: from indium.canonical.com ([91.189.90.7]:38426)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eTgsA-0000Ep-2G
	for qemu-devel@nongnu.org; Mon, 25 Dec 2017 23:29:50 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eTgs7-0001Ed-Dl
	for <qemu-devel@nongnu.org>; Tue, 26 Dec 2017 04:29:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 673F92E80D0
	for <qemu-devel@nongnu.org>; Tue, 26 Dec 2017 04:29:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 Dec 2017 04:17:26 -0000
From: Launchpad Bug Tracker <1119281@bugs.launchpad.net>
Reply-To: Bug 1119281 <1119281@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130208104503.10940.77009.malonedeb@chaenomeles.canonical.com>
Message-Id: <151426184707.1219.9281189639283944724.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1119281] Re: The virtio network device breaks
 UuidCreateSequential()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1119281

Title:
  The virtio network device breaks UuidCreateSequential()

Status in QEMU:
  Expired

Bug description:
  UuidCreateSequential() usually creates version 1 UUIDs (1) which means
  they contain the main network card's MAC address. However when using a
  virtio network card and driver the UUIDs contain random data instead
  of the guest's MAC address. Changing the network card to either the
  default rtl8139 one or the e1000 one fixes the issue.

  Here is the software I have tested this with:
   * qemu 1.1.2+dfsg-5 and 1.4.0~rc0+dfsg-1exp (from Debian Testing and Exp=
erimental respectively)
   * The 0.1-49 and 0.1-52 Windows virtio drivers from https://alt.fedorapr=
oject.org/pub/alt/virtio-win/latest/images/bin/
   * Both a 32-bit Windows XP guest and a 64-bit Windows 7 one.

  =

  Here is how to test for this issue:
  * Set up a Windows guest with a single network card(2), a virtio one and =
install the corresponding driver.

  * Boot the guest and copy the uuidtest.exe file (see attachement) to
  it

  * On the command line, type 'ipconfig /all'. Give you the correct
  network card's MAC address on a line like the one below:

          Physical Address. . . . . . . . . : 52-54-00-C7-0E-97

  * Run uuidtest.exe. It will show the VM returning a UUID with the
  wrong MAC address, and quite possibly even a multicast MAC address!
  (3). In the example below 'f75292c62787' should have been the MAC
  address. Note that on Windows XP UuidCreateSequential() returns
  RPC_S_UUID_LOCAL_ONLY for virtio cards but that on Windows 7 it
  returns 0.

          UuidCreateSequential() returned 0
          uuid=3D{56e1ffe4-71d8-11e2-b1cc-f75292c62787}
          Got a version 1 UUID
          The UUID does not contain a non-multicast MAC address

  * Reboot and notice uuidtest.exe now reports a different value where
  the MAC address should be.

  * Shut down the VM and switch the network card to rtl8139, install the
  drivers, run uuidtest.exe and notice that the last group of digits
  finally contains the correct MAC address.

  =

  (1) https://en.wikipedia.org/wiki/Globally_unique_identifier#Algorithm
  (2) Best do it with a single card to avoid confusion over which is the pr=
imary one.
  (3) If the first byte of the address is odd then this is a multicast addr=
ess.
      https://en.wikipedia.org/wiki/MAC_address#Address_details

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1119281/+subscriptions
