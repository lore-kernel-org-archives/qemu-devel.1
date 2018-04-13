Received: from eggs.gnu.org ([2001:4830:134:3::10]:32792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f76kf-0001Hk-5R
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 18:01:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f76kc-0002XD-3W
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 18:01:01 -0400
Received: from indium.canonical.com ([91.189.90.7]:38100)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1f76kb-0002Wh-U0
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 18:00:58 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1f76kZ-0003om-W3
	for <qemu-devel@nongnu.org>; Fri, 13 Apr 2018 22:00:56 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id E5C6E2E80D2
	for <qemu-devel@nongnu.org>; Fri, 13 Apr 2018 22:00:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Apr 2018 21:49:51 -0000
From: Thomas Huth <1435973@bugs.launchpad.net>
Reply-To: Bug 1435973 <1435973@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150324165921.23494.55963.malonedeb@wampee.canonical.com>
Message-Id: <152365619166.13989.4164892744437666034.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1435973] Re: Qemu crash when a guest linux issues
 specific scsi command via ioctl(SG_IO) with SCSI disk emulation.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Looks like this has been fixed here:
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3Dc170aad8b057223b1139d7

** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1435973

Title:
  Qemu crash when a guest linux issues specific scsi command via
  ioctl(SG_IO) with SCSI disk emulation.

Status in QEMU:
  Fix Released

Bug description:
  As of git revision 362ca922eea03240916287a8a6267801ab095d12, when
  guest linux issues specifit scsi command, qemu crashes.

  To reproduce.

  1. launch qemu with scsi emulatoin
  qemu-sysytem-i386.exe -kernel bzImage -drive file=3Drootfs.ext2,index=3D0=
,if=3Dscsi -append root=3D/dev/sda -drive file=3D\\.\PhysicalDrive1,index=
=3D1,if=3Dscsi
  2. issues scsi command via ioctl(SG_IO) on guest linux. like below.

  -------------------------
  struct request_sense sens;
  struct sg_io_hdr sg;
  unsigned char cdb[6];
  unsigned char buf[127];

  memset( &sens, 0, sizeof(sens) );
  memset(&sg, 0, sizeof(sg));
  memset(cdb, 0, sizeof(cdb));
  memset(buf, 0, sizeof(buf));

  // qemu crash!!!
  cdb[0] =3D 0xff;

  sg.dxferp =3D buf;
  sg.dxfer_len =3D sizeof(buf);
  sg.dxfer_direction =3D SG_DXFER_FROM_DEV;
  sg.flags =3D 0;
  sg.interface_id =3D 'S';
  sg.cmdp =3D cdb;
  sg.cmd_len =3D sizeof( cdb );
  sg.sbp =3D (unsigned char*)&sens;
  sg.mx_sb_len =3D sizeof( sens );

  ioctl( fd, SG_IO, &sg );
  -------------------------

  I think cause is below code.

  scsi-bus.c L1239
  int scsi_req_parse_cdb(SCSIDevice *dev, SCSICommand *cmd, uint8_t *buf)
  {
      int rc;

      cmd->lba =3D -1;
      cmd->len =3D scsi_cdb_length(buf);
      ...
      memcpy(cmd->buf, buf, cmd->len);
  }

  scsi_cdb_length(buf) returns -1 when buf[0] is unexpected value.
  Then memcpy(cmd->buf, buf, 4294967295); is executed and crash.

  Environment
  Qemu: git revision 362ca922eea03240916287a8a6267801ab095d12
  Guest: linux kernel 3.18.4 + buildroot
  Host: Windows 7 64bit

  Thanks,
  hiroaki

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1435973/+subscriptions
