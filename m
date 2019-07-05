Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16AEFC46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 14:14:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF8EE20828
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 14:14:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF8EE20828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjOyS-0006OH-6j
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 10:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46522)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pagupta@redhat.com>) id 1hjOuE-0002ZM-Fy
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 10:09:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pagupta@redhat.com>) id 1hjOuB-00042R-Fu
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 10:09:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45960)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1hjOuB-0003s8-AE
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 10:09:39 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 61E4A30C5859;
 Fri,  5 Jul 2019 14:09:21 +0000 (UTC)
Received: from dhcp201-121.englab.pnq.redhat.com (ovpn-116-58.sin2.redhat.com
 [10.67.116.58])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5D98318657;
 Fri,  5 Jul 2019 14:08:42 +0000 (UTC)
From: Pankaj Gupta <pagupta@redhat.com>
To: dm-devel@redhat.com, linux-nvdimm@lists.01.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-acpi@vger.kernel.org, qemu-devel@nongnu.org,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Date: Fri,  5 Jul 2019 19:33:26 +0530
Message-Id: <20190705140328.20190-6-pagupta@redhat.com>
In-Reply-To: <20190705140328.20190-1-pagupta@redhat.com>
References: <20190705140328.20190-1-pagupta@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Fri, 05 Jul 2019 14:09:36 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v15 5/7] dax: check synchronous mapping is
 supported
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

This patch introduces 'daxdev_mapping_supported' helper
which checks if 'MAP_SYNC' is supported with filesystem
mapping. It also checks if corresponding dax_device is
synchronous. Virtio pmem device is asynchronous and
does not not support VM_SYNC.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 include/linux/dax.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/dax.h b/include/linux/dax.h
index 86fc55c99b58..d1bea3979b5a 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -53,6 +53,18 @@ static inline void set_dax_synchronous(struct dax_device *dax_dev)
 {
 	__set_dax_synchronous(dax_dev);
 }
+/*
+ * Check if given mapping is supported by the file / underlying device.
+ */
+static inline bool daxdev_mapping_supported(struct vm_area_struct *vma,
+					     struct dax_device *dax_dev)
+{
+	if (!(vma->vm_flags & VM_SYNC))
+		return true;
+	if (!IS_DAX(file_inode(vma->vm_file)))
+		return false;
+	return dax_synchronous(dax_dev);
+}
 #else
 static inline struct dax_device *dax_get_by_host(const char *host)
 {
@@ -87,6 +99,11 @@ static inline bool dax_synchronous(struct dax_device *dax_dev)
 static inline void set_dax_synchronous(struct dax_device *dax_dev)
 {
 }
+static inline bool daxdev_mapping_supported(struct vm_area_struct *vma,
+				struct dax_device *dax_dev)
+{
+	return !(vma->vm_flags & VM_SYNC);
+}
 #endif
 
 struct writeback_control;
-- 
2.20.1


