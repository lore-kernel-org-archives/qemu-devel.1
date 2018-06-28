Received: from eggs.gnu.org ([2001:4830:134:3::10]:52585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fYV3a-0006OG-AM
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 07:25:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fYV3W-0005Qx-7m
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 07:25:46 -0400
Received: from indium.canonical.com ([91.189.90.7]:60330)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fYV3W-0005QB-18
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 07:25:42 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fYV3U-0005k7-NQ
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 11:25:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id AF2BB2E8199
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 11:25:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 Jun 2018 11:13:42 -0000
From: =?utf-8?b?7oO/IENocmlzdGlhbiBFaHJoYXJkdCDug78=?=
	<1587065@bugs.launchpad.net>
Reply-To: Bug 1587065 <1587065@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160530134240.21929.85128.malonedeb@wampee.canonical.com>
Message-Id: <153018442295.12646.6028347888270232214.malone@gac.canonical.com>
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

Steps to reproduce

uvt-simplestreams-libvirt --verbose sync --source http://cloud-images.ubunt=
u.com/daily arch=3Damd64 release=3Dxenial label=3Ddaily
uvt-kvm create --password ubuntu x-freeze arch=3Damd64 release=3Dxenial lab=
el=3Ddaily

Add this to the guest definition and restart it
<channel type=3D'unix'>
   <source mode=3D'bind'/>
   <target type=3D'virtio' name=3D'org.qemu.guest_agent.0'/>
</channel>

>From the host freeze and thaw it:
$ virsh domfsfreeze x-freeze
$ virsh domfsthaw x-freeze

# The above works

In the Guest then add a bind mount to trigger the issue
$ sudo mkdir /mnt/test
$ sudo mount -o bind / /mnt/test/

Then again try to freeze/unfreeze
$ virsh domfsfreeze x-freeze
error: Unable to freeze filesystems
error: internal error: unable to execute QEMU agent command 'guest-fsfreeze=
-freeze': failed to freeze /: Device or resource busy


I installed a fix from my PPA [1] and with that it works just fine now.
Proposing an MP for review by the team, to afterwards move on into SRU proc=
essing.

[1]: https://launchpad.net/~ci-train-ppa-service/+archive/ubuntu/3310

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
  Confirmed

Bug description:
  Having two mounts of the same device makes fsfreeze through qemu-ga impos=
sible.
  root@CmsrvMTA:/# mount -l | grep /dev/vda2
  /dev/vda2 on / type btrfs (rw,relatime,space_cache,subvolid=3D257,subvol=
=3D/@)
  /dev/vda2 on /home type btrfs (rw,relatime,space_cache,subvolid=3D258,sub=
vol=3D/@home)

  Having two mounts is rather common with btrfs, so the feature fsfreeze
  is unusable on these systems.

  =

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
   may have bind-mounts that let a device appear multiple times in the moun=
t list. Unfortunately the guest agent is not smart enough to consider a dev=
ice that has been frozen as succesfull and keep going. This causes this spe=
cific error.

  Piece of reply 2:
  -----------------
  Ok, that seems to be it.

  I=E2=80=99ve got the =E2=80=98/=E2=80=99 and =E2=80=98/home=E2=80=99 on t=
he same device formatted as btrfs on
  two separate sub volumes.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1587065/+subscriptions
