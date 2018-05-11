Received: from eggs.gnu.org ([2001:4830:134:3::10]:48526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fH3vK-00054Y-Fh
	for qemu-devel@nongnu.org; Fri, 11 May 2018 05:01:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fH3vG-0006wz-Fb
	for qemu-devel@nongnu.org; Fri, 11 May 2018 05:01:10 -0400
Received: from indium.canonical.com ([91.189.90.7]:38798)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fH3vG-0006vz-9Y
	for qemu-devel@nongnu.org; Fri, 11 May 2018 05:01:06 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fH3vC-0004kl-W7
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 09:01:03 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id A9F9B2E8F59
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 09:01:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 May 2018 08:49:58 -0000
From: ChristianEhrhardt <1770417@bugs.launchpad.net>
Reply-To: Bug 1770417 <1770417@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152596210054.26788.14569755785770428905.malonedeb@chaenomeles.canonical.com>
Message-Id: <152602859816.25295.271319984138177684.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1770417] Re: Qemu can not parse long fqdns during
 drive-mirror
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Ubuntu task is not actionable until we settled on how to change the
parsing code for long strings upstream, so I set it to confirmed but
wishlist (until we know what size a patch - or actions a recommendation
on handling differently has).

** Changed in: qemu (Ubuntu)
       Status: New =3D> Confirmed

** Changed in: qemu (Ubuntu)
   Importance: Undecided =3D> Wishlist

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1770417

Title:
  Qemu can not parse long fqdns during drive-mirror

Status in QEMU:
  New
Status in qemu package in Ubuntu:
  Confirmed

Bug description:
  During migration of an openstack booted instance, I got the following
  error:

  Apr 12 10:55:22 cmp1 libvirtd[4133]: 2018-04-12 10:55:22.133+0000:
  4139: error : qemuMonitorJSONCheckError:392 : internal error: unable
  to execute QEMU command 'drive-mirror': error parsing address 'cmp0
  .sandriichenko-deploy-heat-virtual-mcp-pike-ovs-76.bud-mk.local:49153'

  A bit more info in libvirt bug
  https://bugzilla.redhat.com/show_bug.cgi?id=3D1568939

  To reproduce it with qemu only, I followed the guide at
  https://github.com/qemu/qemu/blob/master/docs/interop/live-block-
  operations.rst#id21. On dest and source compute nodes, I launched an
  instance:

  qemu-system-x86_64 -display none -nodefconfig -M q35 -nodefaults -m
  512 -blockdev node-name=3Dnode-
  TargetDisk,driver=3Dqcow2,file.driver=3Dfile,file.node-
  name=3Dfile,file.filename=3D./test-instance-mirror.qcow2 -device virtio-
  blk,drive=3Dnode-TargetDisk,id=3Dvirtio0 -S -monitor stdio -qmp unix
  :./qmp-sock,server,nowait -incoming tcp:localhost:6666

  Then on dest node I launched nbd server:

  (qemu) nbd_server_start cmp0:49153
  (qemu) nbd_server_add -w node-TargetDisk

  On the source node:

  (qemu) drive_mirror -n  node-TargetDisk nbd:cmp0.vdrok-deploy-heat-virtua=
l-mcp-pike-ovs-foobarbuzz.bud-mk.local:49153:exportname=3Dnode-TargetDisk
  error parsing address 'cmp0.vdrok-deploy-heat-virtual-mcp-pike-ovs-foobar=
buzz.bud-mk.local:49153'

  When using short host name instead of FQDN address seems to be parsed
  fine:

  (qemu) drive_mirror -n  node-TargetDisk nbd:cmp0:49153:exportname=3Dnode-=
TargetDisk qcow2
  Image is not in qcow2 format

  (not sure why it is not a qcow2 format, as I have qcow2 image with raw
  backing file, but this is unrelated)

  QEMU version is 2.11.1 from bionic

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1770417/+subscriptions
