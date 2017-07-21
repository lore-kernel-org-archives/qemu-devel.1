Received: from eggs.gnu.org ([2001:4830:134:3::10]:39765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dYZAv-0004wE-Rt
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:45:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dYZAr-0001df-13
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:45:05 -0400
Received: from indium.canonical.com ([91.189.90.7]:52102)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dYZAq-0001cz-RA
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:45:00 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dYZAp-00042X-Df
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 14:44:59 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 6403B2E807E
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 14:44:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Jul 2017 14:33:16 -0000
From: Thomas Huth <992067@bugs.launchpad.net>
Reply-To: Bug 992067 <992067@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120430165246.29629.23281.malonedeb@soybean.canonical.com>
Message-Id: <150064759751.6577.18374850181855517512.launchpad@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 992067] Re: Windows 2008R2 very slow cold boot
 when >4GB memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/992067

Title:
  Windows 2008R2 very slow cold boot when >4GB memory

Status in QEMU:
  Fix Released

Bug description:
  I've been having a consistent problem booting 2008R2 guests with
  4096MB of RAM or greater. On the initial boot the KVM process starts
  out with a ~200MB memory allocation and will use 100% of all CPU
  allocated to it. The RES memory of the KVM process slowly rises by
  around 200mb every few minutes until it reaches it's memory allocation
  (several hours in some cases). Whilst this is happening the guest will
  usually blue screen with the message of -

  A clock interrupt was not received on a secondary processor within the
  allocated time interval

  If I let the KVM process continue to run it will eventually allocate
  the required memory the guest will run at full speed, usually
  restarting after the blue screen and booting into startup repair. From
  here you can restart it and it will boot perfectly. Once booted the
  guest has no performance issues at all.

  I've tried everything I could think of. Removing PAE, playing with
  huge pages, different kernels, different userspaces, different
  systems, different backing file systems, different processor feature
  set, with or without Virtio etc. My best theory is that the problem is
  caused by Windows 2008 zeroing out all the memory on boot and
  something is causing this to be held up or slowed to a crawl. The
  hosts always have memory free to boot the guest and are not using swap
  at all.

  Nothing so far has solved the issue. A few observations I've made about t=
he issue are - =

  Large memory 2008R2 guests seem to boot fine (or with a small delay) when=
 they are the first to boot on the host after a reboot
  Sometimes dropping the disk cache (echo 1 > /proc/sys/vm/drop_caches) wil=
l cause them to boot faster

  =

  The hosts I've tried are -
  All Nehalem based (5540, 5620 and 5660)
  Host ram of 48GB, 96GB and 192GB
  Storage on NFS, Gluster and local (ext4, xfs and zfs)
  QED, QCOW and RAW formats
  Scientific Linux 6.1 with the standard kernel 2.6.32, 2.6.38 and 3.3.1
  KVM userspaces 0.12, 0.14 and (currently) 0.15.1

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/992067/+subscriptions
