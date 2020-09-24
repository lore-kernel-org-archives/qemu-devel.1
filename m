Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C459C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 09:48:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 021242396E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 09:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eqGU+nS6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 021242396E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLNrY-0001Y3-VD
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 05:48:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38896)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNTk-0000vb-KV
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:23:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54690)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNTb-00061u-3M
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:23:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600939422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SMbLWkx++SRjJTxVHc7OGdAT7b6LdYR09l6M084Hgjs=;
 b=eqGU+nS6buxnKbT7RXMLE1jlSa1ds2C6w/tB8mmFbmHHp2kYKPwouk4a/f1/ngUOYg3Ggh
 jGvxHZwxK9hsxJuVUC3fajKtBuXq/QbciEXrHeunhoQqrkRuFFeJHWuu4UPB9ZtsXGfHA5
 hTtgwkfyPVMNelNiWqIUwgkxcstTtFw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-rX2aqHD_OfSYtTrq8hsZhA-1; Thu, 24 Sep 2020 05:23:38 -0400
X-MC-Unique: rX2aqHD_OfSYtTrq8hsZhA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10645104D3E3;
 Thu, 24 Sep 2020 09:23:37 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C0B1473662;
 Thu, 24 Sep 2020 09:23:36 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 26/92] hw: megasas: return -1 when 'megasas_map_sgl' fails
Date: Thu, 24 Sep 2020 05:22:08 -0400
Message-Id: <20200924092314.1722645-27-pbonzini@redhat.com>
In-Reply-To: <20200924092314.1722645-1-pbonzini@redhat.com>
References: <20200924092314.1722645-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Li Qiang <liq3ea@163.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Li Qiang <liq3ea@163.com>

The caller of 'megasas_map_sgl' will only check if the return
is zero or not. If it return 0 it means success, as in the next
patch we will consider 'iov_count=0' is an error, so let's
return -1 to indicate a failure.

Signed-off-by: Li Qiang <liq3ea@163.com>
Message-Id: <20200815141940.44025-2-liq3ea@163.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/megasas.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index e90c00823a..4cc709d2c6 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -280,7 +280,7 @@ static int megasas_map_sgl(MegasasState *s, MegasasCmd *cmd, union mfi_sgl *sgl)
     if (iov_count > MEGASAS_MAX_SGE) {
         trace_megasas_iovec_sgl_overflow(cmd->index, iov_count,
                                          MEGASAS_MAX_SGE);
-        return iov_count;
+        return -1;
     }
     pci_dma_sglist_init(&cmd->qsg, PCI_DEVICE(s), iov_count);
     for (i = 0; i < iov_count; i++) {
@@ -310,7 +310,7 @@ static int megasas_map_sgl(MegasasState *s, MegasasCmd *cmd, union mfi_sgl *sgl)
     return 0;
 unmap:
     qemu_sglist_destroy(&cmd->qsg);
-    return iov_count - i;
+    return -1;
 }
 
 /*
-- 
2.26.2



