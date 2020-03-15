Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF880C2BB1D
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 13:27:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A95B205ED
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 13:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Hgk9nf6X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A95B205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDTIK-0007CK-Lp
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 09:27:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44775)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jDTFs-0006Lm-3r
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 09:24:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jDTFq-0001nu-Tn
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 09:24:36 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:51520)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jDTFq-0001ek-Kk
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 09:24:34 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02FDN3mE185377;
 Sun, 15 Mar 2020 13:24:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=J6ZiGQ4x1tHeR62jp28UqNAh6TGJQMKqqCyEp5Ljjbk=;
 b=Hgk9nf6XuuvalRPjHosUzg+s3JBwSs0T66NGFKN04wNDchen4JL3kkI3y2eMq4c/Qt/P
 ZMK+7SO8wORj67LuPT2fwT3PPUHQTxZDKGr7KjSypZF5x6fq/TPBrHWrvfgpRhFZz3ql
 vwunMeNNOZbW/NIybgWfCx8nccEWR7wMOeiVQIOP/y5w+Rmyg2fDrKE5dFNkknYVVC3f
 rXYXl1fgpA/iISVWjCbpeyV/xoCr25LvqTr5Jlso+XQMe1tWr0Wmigu3CyFK6Zxsdfnn
 EHRrwa6r9DuvbSQDXrtspeMIlQOW/YxuErG7sa4FSsnqx7UTb23HppFB85vZzmZIn3Tb Ww== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 2yrq7kk97h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 15 Mar 2020 13:24:23 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02FDNYU7013733;
 Sun, 15 Mar 2020 13:24:23 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3020.oracle.com with ESMTP id 2ys926ew48-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 15 Mar 2020 13:24:23 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02FDOLWt013734;
 Sun, 15 Mar 2020 13:24:21 GMT
Received: from spark.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Sun, 15 Mar 2020 06:24:21 -0700
From: Liran Alon <liran.alon@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/scsi/vmw_pvscsi: Remove assertion for kick after reset
Date: Sun, 15 Mar 2020 15:26:34 +0200
Message-Id: <20200315132634.113632-1-liran.alon@oracle.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9560
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=999
 mlxscore=0 spamscore=0 bulkscore=0 adultscore=0 suspectscore=1
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003150074
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9560
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 suspectscore=1
 adultscore=0 bulkscore=0 mlxlogscore=999 priorityscore=1501 clxscore=1011
 malwarescore=0 mlxscore=0 phishscore=0 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003150074
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 141.146.126.78
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
Cc: fam@euphon.net, pbonzini@redhat.com, dmitry.fleytman@gmail.com,
 liran.alon@oracle.com, elazar@vastdata.com
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


