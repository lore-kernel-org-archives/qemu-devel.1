Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED32EC432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 21:51:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B03912073B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 21:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iisi29LY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B03912073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icG4i-0006Wh-Pu
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 16:51:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33096)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1icFJP-0002vF-89
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 16:02:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1icFIH-0007fz-6V
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 16:01:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27634
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1icFIF-0007Rc-Kj
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 16:01:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575406867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=it8GuBWnM9fQOjZwRTeEzTGSPewpYgeD/zGxn3XUFRw=;
 b=iisi29LYZBdF07ALOnPQG19BPrVvN/8qTx0Ua6c+8rC0xDi6cZH8W4skhEOppmskjj5QZl
 ymIQCbwLh8Mfw21/y1p6Ov5JGkLg8+N6viz8J3MBk/AxuM3Qhv+lnNiesOpRm25/7YJboE
 2QRW1KN8pEogQtN7IKdhfxB6u4H2HvU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-6cejwbo6Nf-eC7glTVhCLw-1; Tue, 03 Dec 2019 16:01:04 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6CA958017CC;
 Tue,  3 Dec 2019 21:01:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1113669196;
 Tue,  3 Dec 2019 21:01:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8A9561138606; Tue,  3 Dec 2019 22:01:01 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: Review of onboard block device configuration with -drive
Date: Tue, 03 Dec 2019 22:01:01 +0100
Message-ID: <87fti1i0oi.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 6cejwbo6Nf-eC7glTVhCLw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To the best of my knowledge, -blockdev can fully replace -drive if=3Dnone.
Replacing other interface types takes more than just -blockdev, because
they additionally instruct the board code to create a block frontend.
-blockdev is *only* about backends, so something else needs to replace
the frontend part.

The common tool to create frontends is -device.  To replace -drive, we
use -blockdev with -device.  For instance, -drive if=3Dscsi,media=3Ddisk ca=
n
be replaced by -blockdev with -device scsi-hd.  In general, the
replacement depends on the machine type.

In some cases, board code can create multiple devices.  For instance,
some board code can create SCSI HBAs in addition to SCSI devices.  We
need multiple -device then.

This method is workable as long as all of the devices are available with
-device ("pluggable").  For the cases that create "non-pluggable"
devices, we need another replacement.

Example: pflash devices are not pluggable.  To replace -drive
if=3Dplflash, We chose to add machine properties that forward to the
onboard pflash devices' "drive" properties.  Done for i386 machines
i440fx*, q35*, isapc, arm machines virt, sbsa-ref, riscv machine virt,
in these commits:

    ebc29e1bea pc: Support firmware configuration with -blockdev
    e0561e60f1 hw/arm/virt: Support firmware configuration with -blockdev
    e9fdf45324 hw/arm: Add arm SBSA reference machine, devices part
    71eb522c40 riscv/virt: Add the PFlash CFI01 device

For all the other machines sporting pflash devices, -drive if=3Dpflash
remains the only way to configure them.  As long as that's the case, we
can't deprecate -drive entirely.

Let's review where exactly we stand on replacing -drive in the frontend
configuration role.  Problematic cases are marked with "-drive is the
only way to ...".  Beware, I might misread the code, especially for the
more exotic machines.

The interface types are:

* if=3Dnone

  There is nothing to replace.

* if=3Dide

  ARM machines spitz, borzoi, terrier, and tosa recognize bus=3D0,unit=3D0.
  If present, they create a dscm1xxxx device with the appropriate IDE
  device (ide-hd or ide-cd) plugged in.  dscm1xxxx is not pluggable, and
  -drive is the only way to create it.

  Several other machines have onboard IDE controllers.  Board code
  recognizes their bus numbers, and creates the appropriate IDE devices
  for all the unit numbers.  You can create them with -device instead.

* if=3Dscsi

  ARM machines realview-eb*, versatile* create as many lsi53c895a SCSI
  HBAs as needed to provide all the bus numbers used with -drive
  if=3Dscsi.  PPC machines pseries* similarly create spapr-vscsi SCSI
  HBAs.

  Each SCSI HBA so created then recognizes its own bus number, and
  creates the appropriate SCSI devices (scsi-hd, scsi-cd or
  scsi-generic) for all the unit numbers.

  Dirt effect: lsi53c895a and spapr-vscsi do that even when added with
  -device.  No other SCSI HBA does.  This usage is deprecated.

  All these devices can be created with -device instead.

  HPPA machine hppa, M68k machine q800, Mips machines magnum, pica61,
  PPC machine 40p, and the sun4m SPARC machines have an onboard SCSI
  HBA.  Board code recognizes bus number 0, and creates the appropriate
  SCSI devices for the unit numbers.

* if=3Dfloppy

  i386 machines pc*, isapc and xenfv recognize bus=3D0,unit=3D[01].  Unless
  both are absent, they create an isa-fdc controller with the approriate
  floppy devices.

  All these devices can be created with -device instead.

  Mips machines magnum, pica61, SPARC machines sun4u, sun4v have an
  onboard floppy controller.  They recognize bus=3D0,unit=3D[01], and creat=
e
  the appropriate floppy devices.

  SPARC sun4m machines other than SS-600MP do the same, except they
  recognize only unit=3D0.

  Devices fdc37m81x-superio, pc87312, smc37c669-superio,
  vt82c686b-superio (all children of isa-superio) recognize
  bus=3D0,unit=3D[01], and create the appropriate floppy devices.  This is
  inappropriate for device code, and marked FIXME.  -drive is the only
  way to connect backends to these devices.

* if=3Dpflash

  Many machines have onboard pflash devices.  They recognize
  bus=3D0,unit=3DU where 0 <=3D U < number of such onboard devices.  ARM
  machine sbsa-ref, virt, i386 machines pc*, isapc, xenfv, Risc-V
  machine virt provide machine properties for connecting backends to
  their onboard pflash devices.  For the other machines, -drive is still
  the only way to connect backends.

  PPC machines pseries* create spapr-nvram devices instead.  It can be
  created with -device instead.

  SPARC machine niagara creates a memory region instead *boggle*.
  -drive is the only way to configure that.

  Other machines create the onboard pflash device only when the
  corresponing drive is present.  Since pflash devices are not
  pluggable, -drive is the only way to create them.

* if=3Dmtd

  Many machines have onboard flash devices other than pflash.  They
  recognize bus=3D0,unit=3DU where 0 <=3D U < number of such onboard device=
s.
  -drive is the only way to connect backends.

  ARM machines ast*-evb, *-bmc additionally create a memory region for
  bus=3D0,unit=3D0.  -drive is the only way to configure that.

* if=3Dsd

  Many machines have onboard sd-card devices.  They recognize
  bus=3D0,unit=3DU where 0 <=3D U < number of such onboard devices.  -drive=
 is
  the only way to connect backends.

* if=3Dvirtio

  This is effectively sugar for -drive with -device virtio-blk-pci,
  except for qemu-system-s390x, where it's virtio-blk-ccw instead.

* if=3Dxen

  i386 machine xenpv puts the configuration into xenstore, which makes
  stuff happen.  In other words: I have no clue.  I figure -drive is the
  only way to make this stuff happen.

How did I find this information?  The result of -drive is encapsulated,
and board code has to use drive_get(), drive_get_by_index(), or
drive_get_next() to access it.  I reviewed their callers.

Summary

* if=3Dnone, if=3Dscsi, if=3Dvirtio could be deprecated now, because they h=
ave
  replacements.

* if=3Dide is blocked by the dscm1xxxx issue.  I suspect making it
  conditional on -drive is a mistake.  If we make it unconditional, we
  should be able to deprecate if=3Dide.

* if=3Dfloppy is blocked by the isa-superio issue.  Fixing that FIXME
  should let us deprecate if=3Dfloppy.

* if=3Dpflash, if=3Dmtd and if=3Dsd are blocked by the "no way to connect
  backends to onboard devices" issue, and the "no way to create the
  device" issue.  We solved them for if=3Dpflash with some boards.  Many
  more remain.

* if=3Dxen: no clue.


