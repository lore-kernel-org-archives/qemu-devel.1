Received: from eggs.gnu.org ([2001:4830:134:3::10]:34794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cUES0-0007Ak-Td
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 10:16:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cUERx-0006oI-O0
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 10:16:32 -0500
Received: from indium.canonical.com ([91.189.90.7]:55674)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cUERx-0006nt-I3
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 10:16:29 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cUERw-0002mQ-Cj
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 15:16:28 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 5E9732E80C1
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 15:16:28 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Jan 2017 15:04:51 -0000
From: Elaye Karstadt <elayeek@gmail.com>
Reply-To: Bug 1524546 <1524546@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20151209233416.12733.38134.malonedeb@chaenomeles.canonical.com>
Message-Id: <20170119150451.27052.20965.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1524546] Re: qemu-img rebase error message
 mentions wrong file name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I'm pretty sure this is working as intended.
If you observe the code, qemu-img first opens filename. When qemu opens a f=
ile, it needs full access to it's chain of backing files - Hence, if the ol=
d backing file does not exist, opening filename fails.

(Not an active qemu dev, just passing through)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1524546

Title:
  qemu-img rebase error message mentions wrong file name

Status in QEMU:
  New

Bug description:
  While doing 'qemu-img rebase' for linking to a different backing file, if=
 the old backing file does not exist, the command fails. During this failur=
e, the error message shown is misleading.
  e.g. qemu-img rebase -b <backing_file> <filename> throws error saying "Co=
uld not open <filename>"
  Ideally it should "Could not open <old_backing_file>"

  snippet -
  [root@oxy-dev ~]# qemu-img info /opt/stack/data/nova/instances/94864a64-e=
bf8-45e6-a777-615921216a0a/disk
  image: /opt/stack/data/nova/instances/94864a64-ebf8-45e6-a777-615921216a0=
a/disk
  file format: qcow2
  virtual size: 20G (21474836480 bytes)
  disk size: 174M
  cluster_size: 65536
  backing file: /tmp/3559241a79b79ae663ec6e3d9b75d469967b383b
  Format specific information:
      compat: 1.1
      lazy refcounts: false
  [root@oxy-dev ~]# mv /tmp/3559241a79b79ae663ec6e3d9b75d469967b383b /tmp/3=
559241a79b79ae663ec6e3d9b75d469967b383a
  [root@oxy-dev ~]# file !$
  file /tmp/3559241a79b79ae663ec6e3d9b75d469967b383a
  /tmp/3559241a79b79ae663ec6e3d9b75d469967b383a: x86 boot sector; partition=
 1: ID=3D0x83, active, starthead 32, startsector 2048, 409600 sectors; part=
ition 2: ID=3D0x8e, starthead 159, startsector 411648, 16365568 sectors, co=
de offset 0xc0
  [root@oxy-dev ~]# file /tmp/3559241a79b79ae663ec6e3d9b75d469967b383b
  /tmp/3559241a79b79ae663ec6e3d9b75d469967b383b: cannot open (No such file =
or directory)
  [root@oxy-dev ~]# qemu-img rebase -b /tmp/3559241a79b79ae663ec6e3d9b75d46=
9967b383a /opt/stack/data/nova/instances/94864a64-ebf8-45e6-a777-615921216a=
0a/disk
  qemu-img: Could not open '/opt/stack/data/nova/instances/94864a64-ebf8-45=
e6-a777-615921216a0a/disk': Could not open file: No such file or directory
  [root@oxy-dev ~]# =

  qemu-img version 1.5.3
  OS: RHEL7 - 3.10.0-229
  libvirtd (libvirt) 1.2.8

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1524546/+subscriptions
