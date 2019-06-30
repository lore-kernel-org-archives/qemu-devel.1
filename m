Return-Path: <SRS0=1g4J=U5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3357DC5B57E
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2019 15:12:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0E8F20665
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2019 15:12:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0E8F20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhbV8-0006rs-Et
	for qemu-devel@archiver.kernel.org; Sun, 30 Jun 2019 11:12:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32960)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mlevitsk@redhat.com>) id 1hhbSt-0005OF-Jg
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 11:10:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1hhbSl-00016G-WC
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 11:09:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39846)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1hhbSS-0000Se-DF; Sun, 30 Jun 2019 11:09:41 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6BB04356EA;
 Sun, 30 Jun 2019 15:09:00 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.39])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 465051001B02;
 Sun, 30 Jun 2019 15:08:57 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Date: Sun, 30 Jun 2019 18:08:54 +0300
Message-Id: <20190630150855.1016-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Sun, 30 Jun 2019 15:09:00 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 0/1] RFC: don't obey the block device max
 transfer len / max segments for block devices
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Maxim Levitsky <mlevitsk@redhat.com>,
 John Ferlan <jferlan@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It looks like Linux block devices, even in O_DIRECT mode don't have any user visible
limit on transfer size / number of segments, which underlying block device can have.
The block layer takes care of enforcing these limits by splitting the bios.

By limiting the transfer sizes, we  force qemu to do the splitting itself which
introduces various overheads.
It is especially visible in nbd server, where the low max transfer size of the
underlying device forces us to advertise this over NBD, thus increasing the traffic overhead in case of
image conversion which benefits from large blocks.

More information can be found here:
https://bugzilla.redhat.com/show_bug.cgi?id=1647104

Tested this with qemu-img convert over nbd and natively and to my surprise, even native IO performance improved a bit.
(The device on which it was tested is Intel Optane DC P4800X, which has 128k max transfer size)

The benchmark:

Images were created using:

Sparse image:  qemu-img create -f qcow2 /dev/nvme0n1p3 1G / 10G / 100G
Allocated image: qemu-img create -f qcow2 /dev/nvme0n1p3 -o preallocation=metadata  1G / 10G / 100G

The test was:

 echo "convert native:"
 rm -rf /dev/shm/disk.img
 time qemu-img convert -p -f qcow2 -O raw -T none $FILE /dev/shm/disk.img > /dev/zero

 echo "convert via nbd:"
 qemu-nbd -k /tmp/nbd.sock -v  -f qcow2 $FILE -x export --cache=none --aio=native --fork
 rm -rf /dev/shm/disk.img
 time qemu-img convert -p -f raw -O raw nbd:unix:/tmp/nbd.sock:exportname=export /dev/shm/disk.img > /dev/zero

The results:

=========================================
1G sparse image:
 native:
	before: 0.027s
	after: 0.027s
 nbd:
	before: 0.287s
	after: 0.035s

=========================================
100G sparse image:
 native:
	before: 0.028s
	after: 0.028s
 nbd:
	before: 23.796s
	after: 0.109s

=========================================
1G preallocated image:
 native:
       before: 0.454s
       after: 0.427s
 nbd:
       before: 0.649s
       after: 0.546s

The block limits of max transfer size/max segment size are retained
for the SCSI passthrough because in this case the kernel passes the userspace request
directly to the kernel scsi driver, bypassing the block layer, and thus there is no code to split
such requests.

What do you think?

Fam, since you was the original author of the code that added
these limits, could you share your opinion on that?
What was the reason besides SCSI passthrough?

Best regards,
	Maxim Levitsky

Maxim Levitsky (1):
  raw-posix.c - use max transfer length / max segemnt count only for
    SCSI passthrough

 block/file-posix.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

-- 
2.17.2


