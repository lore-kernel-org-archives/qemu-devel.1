Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E516C49ED7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 20:05:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23C6D2053B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 20:05:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23C6D2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB2g0-0000SH-FV
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 16:05:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45488)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tasleson@redhat.com>) id 1iB2dB-0006FQ-KB
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 16:02:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tasleson@redhat.com>) id 1iB2Q8-00026J-FP
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 15:48:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50302)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tasleson@redhat.com>) id 1iB2Q7-00025E-IR
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 15:48:52 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 373CC10C030B
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 19:48:49 +0000 (UTC)
Received: from sulaco.redhat.com (ovpn-112-12.phx2.redhat.com [10.3.112.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 745C35D6D0;
 Thu, 19 Sep 2019 19:48:48 +0000 (UTC)
From: Tony Asleson <tasleson@redhat.com>
To: qemu-devel@nongnu.org,
	kwolf@redhat.com
Subject: [RFC 0/4] POC: Generating realistic block errors
Date: Thu, 19 Sep 2019 14:48:43 -0500
Message-Id: <20190919194847.18518-1-tasleson@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Thu, 19 Sep 2019 19:48:49 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For a long time I thought that VMs could be a great way to improve OS
code quality by modifying the simulated hardware to return errors to
exercise error paths in the OSs, specifically in block devices for right =
now.
A number of different approaches are available within the Linux kernel, e=
g.
scsi-debug, dm-flakey, and others.  However, I always though it would be =
best to
simulate it from the hardware.  To fully exercise the entire stack.  As a
bonus it's OS agnostic for those projects that cross OSs and it's availab=
le
before the OS even boots.

This POC needs a lot more work, but it's what I have so far.  Learning QE=
MU
internals, plus some of the different bus types has been interesting to s=
ay
the least.  I'm most familiar with SCSI, but the others are foreign to me=
.
AHCI/SATA/ATA is very interesting with it's history and the associated co=
de to
handle it's evolution.

Eventually I think it would be useful to add functionality for errors on
write paths, timeouts, and different error behaviors.  Like media error(s=
) that
are corrected by a re-write (simulate failed write on power loss), bit ro=
t
injection etc.  I know a number of these can be solved different ways,
but embracing them from the VM environment seems ideal to me.  Expanding
to gather statistics on IO patterns, histograms etc. could be very
useful too.  Having the ability to start/stop information collection and
then have access to what happened and in what order could allow for
better error injection of key FS structures and software RAID solutions t=
oo.

I've recently been informed that blkdebug exists.  From a cursory investi=
gation
it does appear have overlap, but I haven't given it a try yet.  From look=
ing
at the code to insert my changes it appears that some of the errors I'm
generating are different than what for example an EIO on a read_aio does,=
 but
I'm not sure.  Perhaps some of the other features that I've outlined abov=
e
already exist too in some other capacity of QEMU?

Instead of working on this more in a vacuum I'm presenting what I have.  =
To
gauge interest, to see if others think it's as interesting as I do.  Or p=
erhaps,
to find out that I've been re-inventing the wheel.

I'm interested in learning what thoughts people have on this.

Thanks,
Tony

Tony Asleson (4):
  Add qapi for block error injection
  SCSI media error reporting
  NVMe media error reporting
  ahci media error reporting

 block/Makefile.objs  |   2 +-
 block/error_inject.c | 179 +++++++++++++++++++++++++++++++++++++++++++
 block/error_inject.h |  43 +++++++++++
 block/qapi.c         |  18 +++++
 hw/block/nvme.c      |   8 ++
 hw/ide/ahci.c        |  27 +++++++
 hw/scsi/scsi-disk.c  |  33 ++++++++
 include/scsi/utils.h |   4 +
 qapi/block.json      |  36 +++++++++
 scsi/utils.c         |  31 ++++++++
 10 files changed, 380 insertions(+), 1 deletion(-)
 create mode 100644 block/error_inject.c
 create mode 100644 block/error_inject.h

--=20
2.21.0


