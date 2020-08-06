Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB11C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:04:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C3B822D05
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A3ACcp5y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C3B822D05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3e84-0004iQ-4V
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 07:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42904)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k3dXA-0004JT-T2
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:54:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58675
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k3dX9-0000If-6m
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:54:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596711242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=SOC3LaHVlJs/MBm7cGCcBs630KBGQSWI7UqcuLQ0ZGs=;
 b=A3ACcp5y5zShgIN5Vt6lHtnvTP1+3DEomKjrWa6ezFHCWKYBI++2BfFpO0dF9tr8/RD9Mw
 MUP7GmMF4Wvbe3skCwwDw+bXE/a8+S7aEPm/aEyCDvbDNWvnImujv1cF0TZYPONym8Zqe0
 uAOrTzOvrb9rwnEIRPO0jtAiwLefKgY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-8Xcvs8PDOka5UpM0HUvRyw-1; Thu, 06 Aug 2020 06:53:58 -0400
X-MC-Unique: 8Xcvs8PDOka5UpM0HUvRyw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71E308017FB;
 Thu,  6 Aug 2020 10:53:57 +0000 (UTC)
Received: from thuth.com (ovpn-112-229.ams2.redhat.com [10.36.112.229])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C229565C68;
 Thu,  6 Aug 2020 10:53:51 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-s390x@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-5.2 v2 0/9] Continue booting in case the first device is
 not bootable
Date: Thu,  6 Aug 2020 12:53:40 +0200
Message-Id: <20200806105349.632-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 00:24:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: "Jason J . Herne" <jjherne@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Janosch Frank <frankja@linux.ibm.com>, qemu-block@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, Collin Walling <walling@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The traditional / architected way of booting on s390x is to always
specify the device where the guest should be booted from - that means
s390x guests should be always started with a device that has the
"bootindex" property set.

For the users that are used to a firmware from a different CPU archi-
tecture (or the lazy s390x folks like myself), the s390-ccw bios also
tries to find a bootable device on its own in case the user did not
specify a "bootindex" property. Unfortunately, it always stops at the
very first device that it can find, no matter whether it's bootable or
not. That causes some weird behavior, for example while

 qemu-system-s390x -hda bootable.qcow2

boots perfectly fine, the bios refuses to work if you just specify
a virtio-scsi controller in front of it:

 qemu-system-s390x -device virtio-scsi -hda bootable.qcow2

While this is perfectly fine from the Z architecture point of view, it
still could be a little bit uncomfortable and confusing for the lazy
or ignorant users who did not specify a "bootindex". And since all major
firmwares on other architectures correctly boot in such cases, too,
let's also try to teach the s390-ccw bios how to boot in such cases.

For this, we have to get rid of the various panic()s and IPL_assert()
statements at the "low-level" function and let the main code handle
the decision instead whether a boot from a device should fail or not,
so that the main code can continue searching in case it wants to.

 Thomas

v2:
 - Add patch to remove superfluous call to enable_subchannel()
 - Add patch to test the new behavior in the tests/qtest/cdrom-test
 - Added Reviewed-bys from v1
 - Renamed check_sch_no() to is_dev_possibly_bootable()
 - Reworked the return codes to use 0/-ENODEV instead of true/false

Thomas Huth (9):
  pc-bios/s390-ccw/Makefile: Compile with -std=gnu99, -fwrapv and
    -fno-common
  pc-bios/s390-ccw: Move ipl-related code from main() into a separate
    function
  pc-bios/s390-ccw: Introduce ENODEV define and remove guards of others
  pc-bios/s390-ccw: Move the inner logic of find_subch() to a separate
    function
  pc-bios/s390-ccw: Do not bail out early if not finding a SCSI disk
  pc-bios/s390-ccw: Scan through all devices if no boot device specified
  pc-bios/s390-ccw: Allow booting in case the first virtio-blk disk is
    bad
  pc-bios/s390-ccw/main: Remove superfluous call to enable_subchannel()
  tests/qtest/cdrom: Add more s390x-related boot tests

 pc-bios/s390-ccw/Makefile        |   7 +-
 pc-bios/s390-ccw/bootmap.c       |  34 ++++--
 pc-bios/s390-ccw/main.c          | 172 +++++++++++++++++++------------
 pc-bios/s390-ccw/s390-ccw.h      |   8 +-
 pc-bios/s390-ccw/virtio-blkdev.c |   7 +-
 pc-bios/s390-ccw/virtio-scsi.c   |  28 +++--
 pc-bios/s390-ccw/virtio-scsi.h   |   2 +-
 tests/qtest/cdrom-test.c         |  12 +++
 8 files changed, 174 insertions(+), 96 deletions(-)

-- 
2.18.1


