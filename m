Received: from eggs.gnu.org ([2001:4830:134:3::10]:43023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eAfsv-0002W9-AF
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 13:36:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eAfss-00087j-5k
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 13:36:01 -0400
Received: from indium.canonical.com ([91.189.90.7]:44308)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eAfsr-00085y-Vi
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 13:35:58 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eAfsp-0000eV-KW
	for <qemu-devel@nongnu.org>; Fri, 03 Nov 2017 17:35:55 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 3F9092E8010
	for <qemu-devel@nongnu.org>; Fri,  3 Nov 2017 17:35:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Nov 2017 17:23:44 -0000
From: pgnet <1689367@bugs.launchpad.net>
Reply-To: Bug 1689367 <1689367@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170508175438.13498.58008.malonedeb@chaenomeles.canonical.com>
Message-Id: <150972982420.4698.1257479636533498259.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1689367] Re: In qemu chroot,
 repeating "qemu: Unsupported syscall: 384" messages. sys_getrandom ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The statically linked qemu files in chroot are cp'd from the host env

	file $(which qemu-arm) $(which qemu-arm-binfmt)
		/usr/bin/qemu-arm:        ELF 64-bit LSB executable, x86-64, version 1 (G=
NU/Linux), statically linked, for GNU/Linux 3.0.0, BuildID[sha1]=3Da6c50ab9=
b8f1845daab2f41d85936712aabafd89, not stripped
		/usr/bin/qemu-arm-binfmt: ELF 64-bit LSB executable, x86-64, version 1 (G=
NU/Linux), statically linked, for GNU/Linux 3.0.0, BuildID[sha1]=3Dff78e29b=
45699433557fab5396b79f07211fd3d5, not stripped

where

	rpm -q --whatprovides $(which qemu-arm) $(which qemu-arm-binfmt)
		qemu-linux-user-2.10.1-412.1.x86_64
		qemu-linux-user-2.10.1-412.1.x86_64

pkg

        qemu-linux-user-2.10.1-412.1.x86_64

is sourced/installed from the openSUSE 'Virtualization' repo,

        https://build.opensuse.org/package/show/Virtualization/qemu-
linux-user

and,

	rpm -q --changelog qemu-linux-user-2.10.1-412.1.x86_64 | head -n 20
		* Thu Oct 19 2017 brogers@suse.com
		- Patch queue updated from git://github.com/openSUSE/qemu.git opensuse-2.=
10
		  * Patches added:
		  0040-io-monitor-encoutput-buffer-size-fr.patch
		  0041-cirrus-fix-oob-access-in-mode4and5-.patch
		  0042-9pfs-use-g_malloc0-to-allocate-spac.patch

		* Tue Oct 03 2017 brogers@suse.com
		- Update to v2.10.1 a stable, bug-fix-only release
		  * Patches dropped (upstream):
		  0034-slirp-fix-clearing-ifq_so-from-pend.patch
		  0035-s390-ccw-Fix-alignment-for-CCW1.patch
		  0038-s390x-ais-for-2.10-stable-disable-a.patch
		  0039-s390x-cpumodel-remove-ais-from-z14-.patch
		  * Patches renamed:
		  0036-target-i386-cpu-Add-new-EPYC-CPU-mo.patch
		  - > 0034-target-i386-cpu-Add-new-EPYC-CPU-mo.patch
		  0037-chardev-baum-fix-baum-that-releases.patch
		  - > 0035-chardev-baum-fix-baum-that-releases.patch
		  0040-io-fix-temp-directory-used-by-test-.patch

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1689367

Title:
  In qemu chroot, repeating "qemu: Unsupported syscall: 384" messages.
  sys_getrandom ?

Status in QEMU:
  Incomplete

Bug description:
  On exec of an armv7 qemu chroot on my local x86_64 desktop, launched
  via

          /usr/sbin/qemu-binfmt-conf.sh

  from

          qemu-linux-user-2.9.0-374.1.x86_64

  on the host, inside the chroot any compile activity is laced with
  repetitions of

          qemu: Unsupported syscall: 384

  messages.

  This wasn't always the case -- but, TBH, it's been ~ 6 months since I
  used this env, and there have been scads of usual pkg updates in the
  interim.  These messages appear to be non-fatal, with no particular
  effect at all; at least not so far ...

  From a chat in #IRC,

  	[10:05] davidgiluk clever/pgnd: I see it as getrandom
  	[10:05] davidgiluk pgnd: https://fedora.juszkiewicz.com.pl/syscalls.html=
   sort it on the ARM table and you can easily see it
  	[10:05] clever arch/arm/tools/syscall.tbl:384  common  getrandom        =
       sys_getrandom
  	[10:06] davidgiluk pgnd: my *guess* is that something is calling getrand=
om, getting told it's not implemented and then falling back to using /dev/u=
random
  	[10:10] pgnd davidgiluk: If that *is* the case, is it to be considered a=
 problem, or just informational?
  	[10:12] davidgiluk pgnd: As long as it's falling back probably informati=
onal; but someone should probably go and wire up sys_getrandom at some point

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1689367/+subscriptions
