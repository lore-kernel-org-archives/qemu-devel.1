Received: from eggs.gnu.org ([2001:4830:134:3::10]:43657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gCMEj-0001M9-GC
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 06:06:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gCMEa-00061s-Ah
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 06:05:58 -0400
Received: from indium.canonical.com ([91.189.90.7]:51968)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gCMEV-0005fD-SV
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 06:05:48 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gCMEP-000326-N5
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 10:05:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 92B962E80D7
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 10:05:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Oct 2018 09:55:50 -0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Reply-To: Bug 1798057 <1798057@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153968292598.9512.8127269016874180318.malonedeb@chaenomeles.canonical.com>
Message-Id: <153968375162.9421.2598722097561234261.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1798057] Re: Not able to start instances larger
 than 1 TB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi Alex,
  You should be able to fix this by passing the right cpu flags, e.g.:

-cpu IvyBridge,host-phys-bits=3Dyes

or

-cpu IvyBridge,physbits=3D46

Dave

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1798057

Title:
  Not able to start instances larger than 1 TB

Status in QEMU:
  New

Bug description:
  Specs:

  CPU: Intel(R) Xeon(R) Gold 6132 CPU @ 2.60GHz
  OS: Ubuntu 18.04 AMD64
  QEMU: 1:2.11+dfsg-1ubuntu7.6 (Ubuntu Bionic Package)
  Openstack: Openstack Queens (Ubuntu Bionic Package)
  Libvirt-daemon: 4.0.0-1ubuntu8.5
  Seabios: 1.10.2-1ubuntu1

  =

  The Problem:
  We are not able to start instances, which have a memory size over 1 TB.
  After starting the instance, they shortly lock up. Starting guests with a=
 lower amount of RAM works
  perfectly. We dealt with the same problem in the past with an older Qemu =
Version (2.5) by patching some source files according to this patch:

  https://git.centos.org/blob/rpms!!qemu-
  kvm.git/34b32196890e2c41b0aee042e600ba422f29db17/SOURCES!kvm-fix-
  guest-physical-bits-to-match-host-to-go-beyond-1.patch

  =

  I think we now have somewhat the same problem here, however the source ba=
se changed and I'am not able to find the corresponding snippet to patch thi=
s.

  Also, guests show a wrong physical address size which is probably the cau=
se of the lock ups on high memory guests:
  root@debug:~# grep physical /proc/cpuinfo =

  physical id	: 0
  address sizes	: 40 bits physical, 48 bits virtual =


  Any way to fix this?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1798057/+subscriptions
