Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BBFCC10DCE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 13:24:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7916205ED
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 13:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G8/Gw86y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7916205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDTFp-0006CO-UV
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 09:24:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42002)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jDTEF-0005mN-Gn
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 09:22:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jDTEE-0008Ne-6l
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 09:22:55 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60478)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jDTED-0008Dg-TJ
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 09:22:54 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02FDMfcx039179;
 Sun, 15 Mar 2020 13:22:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=J6ZiGQ4x1tHeR62jp28UqNAh6TGJQMKqqCyEp5Ljjbk=;
 b=G8/Gw86yNA/M4mCbuhuFa7F0NDORdgnuLjkm2y7uxdPzSN/d1STqRy+thCV4qq2ZdJ2B
 l8hqeUls8+nLbqK3TN0V3pR/pk5gSkK4AXQ626L0tyRcdMv6c04iPv9VBij/Y2M+uSEs
 LHycgxOhqvWc+t/e4z5awvq+inTSKhfwSSoLaq90XTPshGWWHkD4eRsRqS2nfyQgehMy
 uVzzxzU+EKP2mA1+E8KhggYdvKNh34rh/7LrWFNea+thXQdd4hvsD4mo3ukvplSkKD35
 n1sEr3dGn4vm2YgdTNqmfHCfX5xu85Fy8qLV5ktboZ5n2TEChebCDfsHBDKTzxXzgxsU nQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 2yrppqub28-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 15 Mar 2020 13:22:41 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02FDMcgJ190368;
 Sun, 15 Mar 2020 13:22:38 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 2ys8tn3pd8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 15 Mar 2020 13:22:38 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02FDMbev011865;
 Sun, 15 Mar 2020 13:22:37 GMT
Received: from spark.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Sun, 15 Mar 2020 06:22:37 -0700
From: Liran Alon <liran.alon@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/scsi/vmw_pvscsi: Remove assertion for kick after reset
Date: Sun, 15 Mar 2020 15:24:47 +0200
Message-Id: <20200315132447.113131-1-liran.alon@oracle.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9560
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 mlxscore=0
 malwarescore=0 suspectscore=1 mlxlogscore=999 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003150074
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9560
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0
 suspectscore=1 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1011
 impostorscore=0 priorityscore=1501 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003150074
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.86
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
Cc: fam@euphon.net, pbonzini@redhat.com, dmitry.fleytman@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Elazar Leibovich <elazar.leibovich@oracle.com>

When running Ubuntu 3.13.0-65-generic guest, QEMU sometimes crashes
during guest ACPI reset. It crashes on assert(s->rings_info_valid)
in pvscsi_process_io().

Analyzing the crash revealed that it happens when userspace issues
a sync during a reboot syscall.

Below are backtraces we gathered from the guests.

Guest backtrace when issuing PVSCSI_CMD_ADAPTER_RESET:
    pci_device_shutdown
    device_shutdown
    init_pid_ns
    init_pid_ns
    kernel_power_off
    SYSC_reboot

Guest backtrace when issuing PVSCSI_REG_OFFSET_KICK_RW_IO:
    scsi_done
    scsi_dispatch_cmd
    blk_add_timer
    scsi_request_fn
    elv_rb_add
    __blk_run_queue
    queue_unplugged
    blk_flush_plug_list
    blk_finish_plug
    ext4_writepages
    set_next_entity
    do_writepages
    __filemap_fdatawrite_range
    filemap_write_and_wait_range
    ext4_sync_file
    ext4_sync_file
    do_fsync
    sys_fsync

Since QEMU pvscsi should imitate VMware pvscsi device emulation,
we decided to imitate VMware's behavior in this case.

To check VMware behavior, we wrote a kernel module that issues
a reset to the pvscsi device and then issues a kick. We ran it on
VMware ESXi 6.5 and it seems that it simply ignores the kick.
Hence, we decided to ignore the kick as well.

Signed-off-by: Elazar Leibovich <elazar.leibovich@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 hw/scsi/vmw_pvscsi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
index c91352cf46de..b2bb80449bba 100644
--- a/hw/scsi/vmw_pvscsi.c
+++ b/hw/scsi/vmw_pvscsi.c
@@ -719,7 +719,12 @@ pvscsi_process_io(PVSCSIState *s)
     PVSCSIRingReqDesc descr;
     hwaddr next_descr_pa;
 
-    assert(s->rings_info_valid);
+    if (!s->rings_info_valid) {
+        qemu_log("WARNING: PVSCSI: Cannot process I/O when "
+                 "rings are not valid.\n");
+        return;
+    }
+
     while ((next_descr_pa = pvscsi_ring_pop_req_descr(&s->rings)) != 0) {
 
         /* Only read after production index verification */
-- 
2.20.1


