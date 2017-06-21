Received: from eggs.gnu.org ([2001:4830:134:3::10]:42815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dNbue-0001p1-DX
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 05:27:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dNbub-00059w-7D
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 05:27:00 -0400
Received: from indium.canonical.com ([91.189.90.7]:40753)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dNbua-00059c-W9
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 05:26:57 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dNbuY-0001wg-Sz
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 09:26:54 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D9F152E80E3
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 09:26:54 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Jun 2017 09:10:38 -0000
From: Christian Theune <christian@theune.cc>
Reply-To: Bug 1587065 <1587065@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160530134240.21929.85128.malonedeb@wampee.canonical.com>
Message-Id: <149803623845.2749.15410151113778582849.malone@chaenomeles.canonical.com>
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

This has been merged in upstream Qemu a while ago.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1587065

Title:
  btrfs qemu-ga - multiple mounts block fsfreeze

Status in QEMU:
  New

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
