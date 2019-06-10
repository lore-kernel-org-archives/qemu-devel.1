Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3715C468BC
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 09:17:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8027E206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 09:17:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8027E206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42662 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haGR2-0006yW-QN
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 05:17:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38736)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pagupta@redhat.com>) id 1haGKt-0001Mw-Qd
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 05:11:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pagupta@redhat.com>) id 1haGKj-0000fI-5p
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 05:11:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49988)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1haGKe-0000MG-9L
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 05:11:13 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4EC5B3084021;
 Mon, 10 Jun 2019 09:11:09 +0000 (UTC)
Received: from dhcp201-121.englab.pnq.redhat.com (ovpn-116-103.sin2.redhat.com
 [10.67.116.103])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C3D0160BF1;
 Mon, 10 Jun 2019 09:10:33 +0000 (UTC)
From: Pankaj Gupta <pagupta@redhat.com>
To: dm-devel@redhat.com, linux-nvdimm@lists.01.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-acpi@vger.kernel.org, qemu-devel@nongnu.org,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Date: Mon, 10 Jun 2019 14:37:27 +0530
Message-Id: <20190610090730.8589-5-pagupta@redhat.com>
In-Reply-To: <20190610090730.8589-1-pagupta@redhat.com>
References: <20190610090730.8589-1-pagupta@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Mon, 10 Jun 2019 09:11:09 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v11 4/7] dm: enable synchronous dax
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
Cc: pagupta@redhat.com, rdunlap@infradead.org, jack@suse.cz, snitzer@redhat.com,
 mst@redhat.com, jasowang@redhat.com, david@fromorbit.com,
 lcapitulino@redhat.com, adilger.kernel@dilger.ca, zwisler@kernel.org,
 aarcange@redhat.com, dave.jiang@intel.com, jstaron@google.com,
 darrick.wong@oracle.com, vishal.l.verma@intel.com, david@redhat.com,
 willy@infradead.org, hch@infradead.org, jmoyer@redhat.com, nilal@redhat.com,
 lenb@kernel.org, kilobyte@angband.pl, riel@surriel.com, yuval.shaia@oracle.com,
 stefanha@redhat.com, pbonzini@redhat.com, dan.j.williams@intel.com,
 kwolf@redhat.com, tytso@mit.edu, xiaoguangrong.eric@gmail.com,
 cohuck@redhat.com, rjw@rjwysocki.net, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

 This patch sets dax device 'DAXDEV_SYNC' flag if all the target
 devices of device mapper support synchrononous DAX. If device
 mapper consists of both synchronous and asynchronous dax devices,
 we don't set 'DAXDEV_SYNC' flag.

Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
---
 drivers/md/dm-table.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 350cf0451456..c5160d846fe6 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -890,10 +890,17 @@ static int device_supports_dax(struct dm_target *ti, struct dm_dev *dev,
 			start, len);
 }
 
+static int device_synchronous(struct dm_target *ti, struct dm_dev *dev,
+				       sector_t start, sector_t len, void *data)
+{
+	return dax_synchronous(dev->dax_dev);
+}
+
 bool dm_table_supports_dax(struct dm_table *t, int blocksize)
 {
 	struct dm_target *ti;
 	unsigned i;
+	bool dax_sync = true;
 
 	/* Ensure that all targets support DAX. */
 	for (i = 0; i < dm_table_get_num_targets(t); i++) {
@@ -906,7 +913,14 @@ bool dm_table_supports_dax(struct dm_table *t, int blocksize)
 		    !ti->type->iterate_devices(ti, device_supports_dax,
 			    &blocksize))
 			return false;
+
+		/* Check devices support synchronous DAX */
+		if (dax_sync &&
+		    !ti->type->iterate_devices(ti, device_synchronous, NULL))
+			dax_sync = false;
 	}
+	if (dax_sync)
+		set_dax_synchronous(t->md->dax_dev);
 
 	return true;
 }
-- 
2.20.1


