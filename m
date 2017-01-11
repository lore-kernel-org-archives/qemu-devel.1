Received: from eggs.gnu.org ([2001:4830:134:3::10]:36592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cR9ct-0008Q4-DO
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 22:31:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cR9cq-0002v4-4B
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 22:31:03 -0500
Received: from indium.canonical.com ([91.189.90.7]:42540)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cR9cp-0002um-Re
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 22:31:00 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cR9cn-0003Z5-Qh
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 03:30:57 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 3C6C42E80E7
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 03:30:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Jan 2017 03:24:38 -0000
From: Rafael David Tinoco <rafael.tinoco@canonical.com>
Reply-To: Bug 1626972 <1626972@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160923110300.23502.55001.malonedeb@soybean.canonical.com>
Message-Id: <20170111032438.27129.64464.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1626972] Re: QEMU memfd_create fallback mechanism
 change for security drivers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Xenial Verification (with 3.13 kernel from Trusty since a <=3D 3.17 kernel
is needed). This verifies that Ubuntu Cloud Archive repositories will be
alright with this new packages (from Xenial / Yakkety).

## CURRENT

inaddy@(xkvm01):~$ apt-cache policy qemu-kvm
qemu-kvm:
  Installed: 1:2.5+dfsg-5ubuntu10.6
  Candidate: 1:2.5+dfsg-5ubuntu10.6

xkvm01 (sender):

Jan 11 01:07:54 xkvm01 kernel: type=3D1400 audit(1484104074.014:13):
apparmor=3D"DENIED" operation=3D"mknod" profile=3D"libvirt-7cdcb6c0-f85e-46=
39
-912b-c785bd5992d9" name=3D"/tmp/memfd-Jh5UhR" pid=3D2535 comm=3D"qemu-
system-x86" requested_mask=3D"c" denied_mask=3D"c" fsuid=3D112 ouid=3D112

$ sudo virsh migrate --live guest qemu+ssh://xkvm02/system
error: internal error: unable to execute QEMU command 'migrate': Migration =
disabled: failed to allocate shared memory

xkvm02 (receiver):

Jan 11 01:08:23 xkvm02 kernel: type=3D1400 audit(1484104103.888:53):
apparmor=3D"DENIED" operation=3D"mknod" profile=3D"libvirt-7cdcb6c0-f85e-46=
39
-912b-c785bd5992d9" name=3D"/tmp/memfd-fc9rij" pid=3D2000 comm=3D"qemu-
system-x86" requested_mask=3D"c" denied_mask=3D"c" fsuid=3D112 ouid=3D112

OBS: The check was being done in the wrong place AND situation, like I
showed in this bug.

## PROPOSED


inaddy@(xkvm01):~$ apt-cache policy qemu-kvm
qemu-kvm:
  Installed: 1:2.5+dfsg-5ubuntu10.7
  Candidate: 1:2.5+dfsg-5ubuntu10.7

xkvm01 (sender):

<nothing related to /tmp/memfd>

xkvm02 (receiver):

inaddy@(xkvm02):~$ virsh list
 Id    Name                           State
----------------------------------------------------
 1     guest                          running

<nothing related to /tmp/memfd>

Its all good.

verification-xenial-done

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1626972

Title:
  QEMU memfd_create fallback mechanism change for security drivers

Status in Ubuntu Cloud Archive:
  Invalid
Status in Ubuntu Cloud Archive mitaka series:
  Fix Committed
Status in QEMU:
  Fix Committed
Status in qemu package in Ubuntu:
  Fix Released
Status in qemu source package in Xenial:
  Fix Committed
Status in qemu source package in Yakkety:
  Fix Committed
Status in qemu source package in Zesty:
  Fix Released

Bug description:
  [Impact]

   * Updated QEMU (from UCA) live migration doesn't work with 3.13 kernels.
   * QEMU code checks if it can create /tmp/memfd-XXX files wrongly.
   * Apparmor will block access to /tmp/ and QEMU will fail migrating.

  [Test Case]

   * Install 2 Ubuntu Trusty (3.13) + UCA Mitaka + apparmor rules.
   * Try to live-migration from one to another. =

   * Apparmor will block creation of /tmp/memfd-XXX files.

  [Regression Potential]

   Pros:
   * Exhaustively tested this.
   * Worked with upstream on this fix. =

   * I'm implementing new vhost log mechanism for upstream.
   * One line change to a blocker that is already broken.

   Cons:
   * To break live migration in other circumstances. =


  [Other Info]

   * Christian Ehrhardt has been following this.

  ORIGINAL DESCRIPTION:

  When libvirt starts using apparmor, and creating apparmor profiles for
  every virtual machine created in the compute nodes, mitaka qemu (2.5 -
  and upstream also) uses a fallback mechanism for creating shared
  memory for live-migrations. This fall back mechanism, on kernels 3.13
  - that don't have memfd_create() system-call, try to create files on
  /tmp/ directory and fails.. causing live-migration not to work.

  Trusty with kernel 3.13 + Mitaka with qemu 2.5 + apparmor capability =3D
  can't live migrate.

  From qemu 2.5, logic is on :

  void *qemu_memfd_alloc(const char *name, size_t size, unsigned int seals,=
 int *fd)
  {
  =C2=A0=C2=A0=C2=A0=C2=A0if (memfd_create)... ### only works with HWE kern=
els

  =C2=A0=C2=A0=C2=A0=C2=A0else ### 3.13 kernels, gets blocked by apparmor
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tmpdir =3D g_get_tmp_dir
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0...
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mfd =3D mkstemp(fname)
  }

  And you can see the errors:

  From the host trying to send the virtual machine:

  2016-08-15 16:36:26.160 1974 ERROR nova.virt.libvirt.driver [req-0cac612b=
-8d53-4610-b773-d07ad6bacb91 691a581cfa7046278380ce82b1c38ddd 133ebc3585c04=
1aebaead8c062cd6511 - - -] [instance: 2afa1131-bc8c-43d2-9c4a-962c1bf7723e]=
 Migration operation has aborted
  2016-08-15 16:36:26.248 1974 ERROR nova.virt.libvirt.driver [req-0cac612b=
-8d53-4610-b773-d07ad6bacb91 691a581cfa7046278380ce82b1c38ddd 133ebc3585c04=
1aebaead8c062cd6511 - - -] [instance: 2afa1131-bc8c-43d2-9c4a-962c1bf7723e]=
 Live Migration failure: internal error: unable to execute QEMU command 'mi=
grate': Migration disabled: failed to allocate shared memory

  From the host trying to receive the virtual machine:

  Aug 15 16:36:19 tkcompute01 kernel: [ 1194.356794] type=3D1400 audit(1471=
289779.791:72): apparmor=3D"STATUS" operation=3D"profile_load" profile=3D"u=
nconfined" name=3D"libvirt-2afa1131-bc8c-43d2-9c4a-962c1bf7723e" pid=3D1256=
5 comm=3D"apparmor_parser"
  Aug 15 16:36:19 tkcompute01 kernel: [ 1194.357048] type=3D1400 audit(1471=
289779.791:73): apparmor=3D"STATUS" operation=3D"profile_load" profile=3D"u=
nconfined" name=3D"qemu_bridge_helper" pid=3D12565 comm=3D"apparmor_parser"
  Aug 15 16:36:20 tkcompute01 kernel: [ 1194.877027] type=3D1400 audit(1471=
289780.311:74): apparmor=3D"STATUS" operation=3D"profile_replace" profile=
=3D"unconfined" name=3D"libvirt-2afa1131-bc8c-43d2-9c4a-962c1bf7723e" pid=
=3D12613 comm=3D"apparmor_parser"
  Aug 15 16:36:20 tkcompute01 kernel: [ 1194.904407] type=3D1400 audit(1471=
289780.343:75): apparmor=3D"STATUS" operation=3D"profile_replace" profile=
=3D"unconfined" name=3D"qemu_bridge_helper" pid=3D12613 comm=3D"apparmor_pa=
rser"
  Aug 15 16:36:20 tkcompute01 kernel: [ 1194.973064] type=3D1400 audit(1471=
289780.407:76): apparmor=3D"DENIED" operation=3D"mknod" profile=3D"libvirt-=
2afa1131-bc8c-43d2-9c4a-962c1bf7723e" name=3D"/tmp/memfd-tNpKSj" pid=3D1262=
5 comm=3D"qemu-system-x86" requested_mask=3D"c" denied_mask=3D"c" fsuid=3D1=
07 ouid=3D107
  Aug 15 16:36:20 tkcompute01 kernel: [ 1194.979871] type=3D1400 audit(1471=
289780.411:77): apparmor=3D"DENIED" operation=3D"open" profile=3D"libvirt-2=
afa1131-bc8c-43d2-9c4a-962c1bf7723e" name=3D"/tmp/" pid=3D12625 comm=3D"qem=
u-system-x86" requested_mask=3D"r" denied_mask=3D"r" fsuid=3D107 ouid=3D0
  Aug 15 16:36:20 tkcompute01 kernel: [ 1194.979881] type=3D1400 audit(1471=
289780.411:78): apparmor=3D"DENIED" operation=3D"open" profile=3D"libvirt-2=
afa1131-bc8c-43d2-9c4a-962c1bf7723e" name=3D"/var/tmp/" pid=3D12625 comm=3D=
"qemu-system-x86" requested_mask=3D"r" denied_mask=3D"r" fsuid=3D107 ouid=
=3D0

  When leaving libvirt without apparmor capabilities (thus not confining
  virtual machines on compute nodes, the live migration works as
  expected, so, clearly, apparmor is stepping into the live migration).
  I'm sure that virtual machines have to be confined and that this isn't
  the desired behaviour...

To manage notifications about this bug go to:
https://bugs.launchpad.net/cloud-archive/+bug/1626972/+subscriptions
