Received: from eggs.gnu.org ([2001:4830:134:3::10]:59128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ff5Xa-0005D6-4P
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 11:35:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ff5XW-0001lp-VR
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 11:35:58 -0400
Received: from indium.canonical.com ([91.189.90.7]:49002)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ff5XW-0001lH-Kz
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 11:35:54 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ff5XV-0000ij-4q
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 15:35:53 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 233A52E8079
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 15:35:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Jul 2018 15:16:25 -0000
From: =?utf-8?b?7oO/IENocmlzdGlhbiBFaHJoYXJkdCDug78=?=
	<1587065@bugs.launchpad.net>
Reply-To: Bug 1587065 <1587065@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160530134240.21929.85128.malonedeb@wampee.canonical.com>
Message-Id: <153175418683.23644.13331000379185368944.launchpad@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1587065] Re: btrfs qemu-ga - multiple mounts
 block fsfreeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Description changed:

  [Impact]
  =

- =C2=A0* An explanation of the effects of the bug on users and
- =

- =C2=A0* justification for backporting the fix to the stable release.
- =

- =C2=A0* In addition, it is helpful, but not required, to include an
- =C2=A0=C2=A0=C2=A0explanation of how the upload fixes this bug.
+ =C2=A0* backport upstream fix to avoid double unmounts (e.g. bind mounts) =

+    hanging the freeze action.
  =

  [Test Case]
  =

  =C2=A0* Prepare a guest
  =C2=A0=C2=A0=C2=A0$ uvt-simplestreams-libvirt --verbose sync --source htt=
p://cloud-images.ubuntu.com/daily arch=3Damd64 release=3Dxenial label=3Ddai=
ly
  uvt-kvm create --password ubuntu x-freeze arch=3Damd64 release=3Dxenial l=
abel=3Ddaily
  =

  =C2=A0* Shut it down and use virsh edit to add a channel for the agent. A=
dd this somewhere under <devices>:
  <channel type=3D'unix'>
  =C2=A0=C2=A0=C2=A0<source mode=3D'bind'/>
  =C2=A0=C2=A0=C2=A0<target type=3D'virtio' name=3D'org.qemu.guest_agent.0'=
/>
  </channel>
  =

  =C2=A0=C2=A0* Start the guest again, in it install qemu-guest-agent
  =

  =C2=A0=C2=A0*
  =

  =C2=A0=C2=A0* On the Host then freeze and thaw the guest
  =C2=A0=C2=A0=C2=A0=C2=A0$ virsh domfsfreeze x-freeze
  =C2=A0=C2=A0=C2=A0=C2=A0$ virsh domfsthaw x-freeze
  =

  =C2=A0=C2=A0# The above works, then trigger the issue, in the guest do
  =C2=A0=C2=A0=C2=A0=C2=A0$ sudo mkdir /mnt/test
  =C2=A0=C2=A0=C2=A0=C2=A0$ sudo mount -o bind / /mnt/test/
  =

  =C2=A0=C2=A0* Now the freeze/thaw will fail unless the fix is applied.
  =

  [Regression Potential]
  =

  =C2=A0* From looking at the code alone I could think of a different cause=
 that
  =C2=A0=C2=A0=C2=A0makes it return EBUSY.
  =C2=A0=C2=A0=C2=A0The biggest risk I could see due to that is the agent r=
eporting a
  =C2=A0=C2=A0=C2=A0successful freeze due to accepting EBUSY which is not a=
ctually true.
  =C2=A0=C2=A0=C2=A0But we have that in Ubuntu since Artful and
  =C2=A0=C2=A0=C2=A0upstream since January 2017 and there are no such repor=
ts.
  =

  [Other Info]
  =

  =C2=A0* n/a
  =

  ---
  =

  Having two mounts of the same device makes fsfreeze through qemu-ga impos=
sible.
  root@CmsrvMTA:/# mount -l | grep /dev/vda2
  /dev/vda2 on / type btrfs (rw,relatime,space_cache,subvolid=3D257,subvol=
=3D/@)
  /dev/vda2 on /home type btrfs (rw,relatime,space_cache,subvolid=3D258,sub=
vol=3D/@home)
  =

  Having two mounts is rather common with btrfs, so the feature fsfreeze
  is unusable on these systems.
  =

  Below more information about how we encountered this issue...
  =

  Message send to qemu-discuss@nongnu.org:
  =

  Message 1:
  ----------
  I use external snapshots to backup my guests. I use the 'quiesce' option =
to flush and frees the guest file system with the qemu guest agent.
  =

  With the exeption of one guest, this procedure works fine. On the 'unwill=
ing' guest, I get this error message:
  "ERROR 2016-05-25 00:51:19 | T25-bakVMSCmsrvVH2 | fout: internal error: u=
nable to execute QEMU agent command 'guest-fsfreeze-freeze': failed to free=
ze /: Device or resource busy"
  =

  I don't think this is not some sort of time-out error, because
  activation of the fsfreeze and the error message happen immediately
  after each other:
  =

  $ grep qemu-ga syslog.1
  May 25 00:51:19 CmsrvMTA qemu-ga: info: guest-fsfreeze called
  =

  This is the only entry of the qemu guest agent in syslog.
  =

  $ sudo virsh version
  Compiled against library: libvirt 1.3.1
  Using library: libvirt 1.3.1
  Gebruikte API: QEMU 1.3.1
  Draaiende hypervisor: QEMU 2.5.0
  =

  $ virsh qemu-agent-command CmsrvMTA '{"execute": "guest-info"}'
  {"return":{"version":"2.5.0", ... ,{"enabled":true,"name":"guest-fstrim",=
"success-response":true},{"enabled":true,"name":"guest-fsfreeze-thaw","succ=
ess-response":true},{"enabled":true,"name":"guest-fsfreeze-status","success=
-response":true},{"enabled":true,"name":"guest-fsfreeze-freeze-list","succe=
ss-response":true},{"enabled":true,"name":"guest-fsfreeze-freeze","success-=
response":true}, ... }
  =

  For making an external snapshot, I use this command:
  $ virsh snapshot-create-as --domain CmsrvMTA sn1 --disk-only --atomic --q=
uiesce --no-metadata --diskspec vda,file=3D/srv/poolVMS/CmsrvMTA.sn1
  =

  Piece of reply 1:
  -----------------
  I have encountered this before. Some operating systems
  =C2=A0may have bind-mounts that let a device appear multiple times in the=
 mount list. Unfortunately the guest agent is not smart enough to consider =
a device that has been frozen as succesfull and keep going. This causes thi=
s specific error.
  =

  Piece of reply 2:
  -----------------
  Ok, that seems to be it.
  =

  I=E2=80=99ve got the =E2=80=98/=E2=80=99 and =E2=80=98/home=E2=80=99 on t=
he same device formatted as btrfs on
  two separate sub volumes.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1587065

Title:
  btrfs qemu-ga - multiple mounts block fsfreeze

Status in QEMU:
  Fix Released
Status in qemu package in Ubuntu:
  Fix Released
Status in qemu source package in Xenial:
  In Progress

Bug description:
  [Impact]

  =C2=A0* backport upstream fix to avoid double unmounts (e.g. bind mounts) =

     hanging the freeze action.

  [Test Case]

  =C2=A0* Prepare a guest
  =C2=A0=C2=A0=C2=A0$ uvt-simplestreams-libvirt --verbose sync --source htt=
p://cloud-images.ubuntu.com/daily arch=3Damd64 release=3Dxenial label=3Ddai=
ly
  uvt-kvm create --password ubuntu x-freeze arch=3Damd64 release=3Dxenial l=
abel=3Ddaily

  =C2=A0* Shut it down and use virsh edit to add a channel for the agent. A=
dd this somewhere under <devices>:
  <channel type=3D'unix'>
  =C2=A0=C2=A0=C2=A0<source mode=3D'bind'/>
  =C2=A0=C2=A0=C2=A0<target type=3D'virtio' name=3D'org.qemu.guest_agent.0'=
/>
  </channel>

  =C2=A0=C2=A0* Start the guest again, in it install qemu-guest-agent

  =C2=A0=C2=A0*

  =C2=A0=C2=A0* On the Host then freeze and thaw the guest
  =C2=A0=C2=A0=C2=A0=C2=A0$ virsh domfsfreeze x-freeze
  =C2=A0=C2=A0=C2=A0=C2=A0$ virsh domfsthaw x-freeze

  =C2=A0=C2=A0# The above works, then trigger the issue, in the guest do
  =C2=A0=C2=A0=C2=A0=C2=A0$ sudo mkdir /mnt/test
  =C2=A0=C2=A0=C2=A0=C2=A0$ sudo mount -o bind / /mnt/test/

  =C2=A0=C2=A0* Now the freeze/thaw will fail unless the fix is applied.

  [Regression Potential]

  =C2=A0* From looking at the code alone I could think of a different cause=
 that
  =C2=A0=C2=A0=C2=A0makes it return EBUSY.
  =C2=A0=C2=A0=C2=A0The biggest risk I could see due to that is the agent r=
eporting a
  =C2=A0=C2=A0=C2=A0successful freeze due to accepting EBUSY which is not a=
ctually true.
  =C2=A0=C2=A0=C2=A0But we have that in Ubuntu since Artful and
  =C2=A0=C2=A0=C2=A0upstream since January 2017 and there are no such repor=
ts.

  [Other Info]

  =C2=A0* n/a

  ---

  Having two mounts of the same device makes fsfreeze through qemu-ga impos=
sible.
  root@CmsrvMTA:/# mount -l | grep /dev/vda2
  /dev/vda2 on / type btrfs (rw,relatime,space_cache,subvolid=3D257,subvol=
=3D/@)
  /dev/vda2 on /home type btrfs (rw,relatime,space_cache,subvolid=3D258,sub=
vol=3D/@home)

  Having two mounts is rather common with btrfs, so the feature fsfreeze
  is unusable on these systems.

  Below more information about how we encountered this issue...

  Message send to qemu-discuss@nongnu.org:

  Message 1:
  ----------
  I use external snapshots to backup my guests. I use the 'quiesce' option =
to flush and frees the guest file system with the qemu guest agent.

  With the exeption of one guest, this procedure works fine. On the 'unwill=
ing' guest, I get this error message:
  "ERROR 2016-05-25 00:51:19 | T25-bakVMSCmsrvVH2 | fout: internal error: u=
nable to execute QEMU agent command 'guest-fsfreeze-freeze': failed to free=
ze /: Device or resource busy"

  I don't think this is not some sort of time-out error, because
  activation of the fsfreeze and the error message happen immediately
  after each other:

  $ grep qemu-ga syslog.1
  May 25 00:51:19 CmsrvMTA qemu-ga: info: guest-fsfreeze called

  This is the only entry of the qemu guest agent in syslog.

  $ sudo virsh version
  Compiled against library: libvirt 1.3.1
  Using library: libvirt 1.3.1
  Gebruikte API: QEMU 1.3.1
  Draaiende hypervisor: QEMU 2.5.0

  $ virsh qemu-agent-command CmsrvMTA '{"execute": "guest-info"}'
  {"return":{"version":"2.5.0", ... ,{"enabled":true,"name":"guest-fstrim",=
"success-response":true},{"enabled":true,"name":"guest-fsfreeze-thaw","succ=
ess-response":true},{"enabled":true,"name":"guest-fsfreeze-status","success=
-response":true},{"enabled":true,"name":"guest-fsfreeze-freeze-list","succe=
ss-response":true},{"enabled":true,"name":"guest-fsfreeze-freeze","success-=
response":true}, ... }

  For making an external snapshot, I use this command:
  $ virsh snapshot-create-as --domain CmsrvMTA sn1 --disk-only --atomic --q=
uiesce --no-metadata --diskspec vda,file=3D/srv/poolVMS/CmsrvMTA.sn1

  Piece of reply 1:
  -----------------
  I have encountered this before. Some operating systems
  =C2=A0may have bind-mounts that let a device appear multiple times in the=
 mount list. Unfortunately the guest agent is not smart enough to consider =
a device that has been frozen as succesfull and keep going. This causes thi=
s specific error.

  Piece of reply 2:
  -----------------
  Ok, that seems to be it.

  I=E2=80=99ve got the =E2=80=98/=E2=80=99 and =E2=80=98/home=E2=80=99 on t=
he same device formatted as btrfs on
  two separate sub volumes.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1587065/+subscriptions
