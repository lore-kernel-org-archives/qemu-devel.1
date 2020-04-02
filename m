Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6600EC2BA12
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 19:08:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3253620737
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 19:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AArqcsal"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3253620737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK5C9-0004C4-5R
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 15:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33775)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jK5At-0002OV-LF
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 15:06:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jK5As-0000Aj-JX
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 15:06:47 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23245
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jK5As-00009B-Fd
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 15:06:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585854405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sewDymgizkxqPJPRT3hku2hWbDlQTKfdk8fI/f5dunM=;
 b=AArqcsaltbFxIohBCirFam3Ic5sTtkxceDpDK0wyQOlE9ckQ294NY+/qWE9/CP2xf5OkEe
 XfN1Lz/ZYCSyvIW5WW+WyHhLUEyvG5I8ZLBCuJQ9Cri61qg++LC+jg8LjEm2oXjkX9AiDV
 wAj40nk45X86TE8VIeoVUudQEa39PXY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-AXgxyE0QNEOmQC29Dw-v8g-1; Thu, 02 Apr 2020 15:06:43 -0400
X-MC-Unique: AXgxyE0QNEOmQC29Dw-v8g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 58EC88018A7;
 Thu,  2 Apr 2020 19:06:42 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D746650BEE;
 Thu,  2 Apr 2020 19:06:41 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/15] hw/scsi/vmw_pvscsi: Remove assertion for kick after reset
Date: Thu,  2 Apr 2020 15:06:26 -0400
Message-Id: <20200402190640.1693-2-pbonzini@redhat.com>
In-Reply-To: <20200402190640.1693-1-pbonzini@redhat.com>
References: <20200402190640.1693-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Elazar Leibovich <elazar.leibovich@oracle.com>,
 Liran Alon <liran.alon@oracle.com>
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
Message-Id: <20200315132634.113632-1-liran.alon@oracle.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/vmw_pvscsi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
index c91352cf46..ec5bf9ea34 100644
--- a/hw/scsi/vmw_pvscsi.c
+++ b/hw/scsi/vmw_pvscsi.c
@@ -719,7 +719,10 @@ pvscsi_process_io(PVSCSIState *s)
     PVSCSIRingReqDesc descr;
     hwaddr next_descr_pa;
=20
-    assert(s->rings_info_valid);
+    if (!s->rings_info_valid) {
+        return;
+    }
+
     while ((next_descr_pa =3D pvscsi_ring_pop_req_descr(&s->rings)) !=3D 0=
) {
=20
         /* Only read after production index verification */
--=20
2.18.2



