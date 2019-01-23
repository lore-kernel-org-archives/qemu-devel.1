Received: from eggs.gnu.org ([209.51.188.92]:39394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gmMCl-0007H9-2L
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 12:20:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gmMCj-0006CS-OB
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 12:20:46 -0500
Received: from indium.canonical.com ([91.189.90.7]:51226)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gmMCh-00066w-SO
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 12:20:45 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gmMCa-0001Br-NS
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 17:20:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 9110C2E80D1
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 17:20:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Jan 2019 17:07:36 -0000
From: Michele Schillaci <1813045@bugs.launchpad.net>
Reply-To: Bug 1813045 <1813045@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <154826325670.29740.8985180444326228276.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1813045] [NEW] qemu-ga fsfreeze crashes the kernel
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

We use mainly Cloudlinux, Debian and Centos.
We experienced many crashes on our qemu instances based on Cloudlinux durin=
g a snapshot.
The issue is not related to CloudLinux directly, but to Qemu agent, which d=
oes not freeze the file system(s) correctly. What is actually happening:

When VM backup is invoked, Qemu agent freezes the file systems, so no singl=
e change will be made during the backup. But Qemu agent does not respect th=
e loop* devices in freezing order (we have checked its sources), which lead=
s to the next situation: =

1) freeze loopback fs
              ---> send async reqs to loopback thread
2) freeze main fs
3) loopback thread wakes up and trying to write data to the main fs, which =
is still frozen, and this finally leads to the hung task and kernel crash. =


I believe this is the culprit:

/dev/loop0 /tmp ext3 rw,nosuid,noexec,relatime,data=3Dordered 0 0
/dev/loop0 /var/tmp ext3 rw,nosuid,noexec,relatime,data=3Dordered 0 0

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1813045

Title:
  qemu-ga fsfreeze crashes the kernel

Status in QEMU:
  New

Bug description:
  We use mainly Cloudlinux, Debian and Centos.
  We experienced many crashes on our qemu instances based on Cloudlinux dur=
ing a snapshot.
  The issue is not related to CloudLinux directly, but to Qemu agent, which=
 does not freeze the file system(s) correctly. What is actually happening:

  When VM backup is invoked, Qemu agent freezes the file systems, so no sin=
gle change will be made during the backup. But Qemu agent does not respect =
the loop* devices in freezing order (we have checked its sources), which le=
ads to the next situation: =

  1) freeze loopback fs
                ---> send async reqs to loopback thread
  2) freeze main fs
  3) loopback thread wakes up and trying to write data to the main fs, whic=
h is still frozen, and this finally leads to the hung task and kernel crash=
. =


  I believe this is the culprit:

  /dev/loop0 /tmp ext3 rw,nosuid,noexec,relatime,data=3Dordered 0 0
  /dev/loop0 /var/tmp ext3 rw,nosuid,noexec,relatime,data=3Dordered 0 0

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1813045/+subscriptions
