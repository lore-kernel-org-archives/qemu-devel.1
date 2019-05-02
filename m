Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59806C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 15:56:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CA342075E
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 15:56:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CA342075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53548 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hME47-0003we-Fq
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 11:56:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hME3N-00038S-Qa
	for qemu-devel@nongnu.org; Thu, 02 May 2019 11:55:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hME3M-0006BL-V6
	for qemu-devel@nongnu.org; Thu, 02 May 2019 11:55:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37462)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>)
	id 1hME3M-0006Aj-PK; Thu, 02 May 2019 11:55:20 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C5956CAA67;
	Thu,  2 May 2019 15:55:19 +0000 (UTC)
Received: from localhost (dhcp-192-222.str.redhat.com [10.33.192.222])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 723A41001E6F;
	Thu,  2 May 2019 15:55:19 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Thomas Huth <thuth@redhat.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu,  2 May 2019 17:55:16 +0200
Message-Id: <20190502155516.12415-1-cohuck@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Thu, 02 May 2019 15:55:19 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] s390/ipl: cast to SCSIDevice directly
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "Jason J . Herne" <jjherne@linux.ibm.com>, qemu-s390x@nongnu.org,
	Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190502155516.t5x_m4cng6KwCV9u66QXDdGYgOI3wU4bUAaxHhqrtvo@z>

Coverity notes that the result of object_dynamic_cast() to
SCSIDevice is not checked in s390_gen_initial_iplp(); as
we know that we always have a SCSIDevice in that branch,
we can instead cast via SCSI_DEVICE directly.

Coverity: CID 1401098
Fixes: 44445d8668f4 ("s390 vfio-ccw: Add bootindex property and IPLB data")
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/ipl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index d0cc06a05fd0..b93750c14eac 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -374,8 +374,7 @@ static bool s390_gen_initial_iplb(S390IPLState *ipl)
     if (ccw_dev) {
         switch (devtype) {
         case CCW_DEVTYPE_SCSI:
-            sd = (SCSIDevice *) object_dynamic_cast(OBJECT(dev_st),
-                                                           TYPE_SCSI_DEVICE);
+            sd = SCSI_DEVICE(dev_st);
             ipl->iplb.len = cpu_to_be32(S390_IPLB_MIN_QEMU_SCSI_LEN);
             ipl->iplb.blk0_len =
                 cpu_to_be32(S390_IPLB_MIN_QEMU_SCSI_LEN - S390_IPLB_HEADER_LEN);
-- 
2.17.2


