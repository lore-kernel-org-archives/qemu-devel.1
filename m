Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3CBC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 11:56:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 983B22177B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 11:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CqqzLn1t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 983B22177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBGWB-0007Xy-Pa
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 07:56:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46846)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kBGVS-00070X-UR
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 07:55:50 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51854
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kBGVQ-0008JP-N9
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 07:55:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598529347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=J6X82Iz+q40HK149GWOTkkeq809o+moGTCmrT+d0gr0=;
 b=CqqzLn1t6lKtEg5eGbfrcRhY+0TcCFq8FaugcaoXTdjZjU8JMj3EnScCdU6Kn/UVpzszqN
 oUHCsS/zlPqGgr2BHpMCxG3fIFhqjwWRoQqXuAHEddN7/5W9rhTxBkGig4KvrDnE0rff6I
 S1qbvuNtIXAwOXTVjv5LT+ljMcmSE+Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-aF_Iw6-NPzyLAjBdzzaEbw-1; Thu, 27 Aug 2020 07:55:42 -0400
X-MC-Unique: aF_Iw6-NPzyLAjBdzzaEbw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BFC541015EC4;
 Thu, 27 Aug 2020 11:55:41 +0000 (UTC)
Received: from localhost.localdomain (ovpn-112-91.phx2.redhat.com
 [10.3.112.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8C6091002D48;
 Thu, 27 Aug 2020 11:55:39 +0000 (UTC)
From: P J P <ppandit@redhat.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: [PATCH] sd: sdhci: check data_count is within fifo_buffer
Date: Thu, 27 Aug 2020 17:23:36 +0530
Message-Id: <20200827115336.1851276-1-ppandit@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ppandit@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 07:16:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Ruhr-University <bugs-syssec@rub.de>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-block@nongnu.org,
 Prasad J Pandit <pjp@fedoraproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

While doing multi block SDMA, transfer block size may exceed
the 's->fifo_buffer[s->buf_maxsz]' size. It may leave the
current element pointer 's->data_count' pointing out of bounds.
Leading the subsequent DMA r/w operation to OOB access issue.
Add check to avoid it.

 -> https://ruhr-uni-bochum.sciebo.de/s/NNWP2GfwzYKeKwE?path=%2Fsdhci_oob_write1
 ==1459837==ERROR: AddressSanitizer: heap-buffer-overflow
 WRITE of size 54722048 at 0x61500001e280 thread T3
    #0  __interceptor_memcpy (/lib64/libasan.so.6+0x3a71d)
    #1  flatview_read_continue ../exec.c:3245
    #2  flatview_read ../exec.c:3278
    #3  address_space_read_full ../exec.c:3291
    #4  address_space_rw ../exec.c:3319
    #5  dma_memory_rw_relaxed ../include/sysemu/dma.h:87
    #6  dma_memory_rw ../include/sysemu/dma.h:110
    #7  dma_memory_read ../include/sysemu/dma.h:116
    #8  sdhci_sdma_transfer_multi_blocks ../hw/sd/sdhci.c:629
    #9  sdhci_write ../hw/sd/sdhci.c:1097
    #10 memory_region_write_accessor ../softmmu/memory.c:483
    ...

Reported-by: Ruhr-University <bugs-syssec@rub.de>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/sd/sdhci.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 1785d7e1f7..155e25ceee 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -604,6 +604,9 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
                     s->blkcnt--;
                 }
             }
+            if (s->data_count <= begin || s->data_count > s->buf_maxsz) {
+                break;
+            }
             dma_memory_write(s->dma_as, s->sdmasysad,
                              &s->fifo_buffer[begin], s->data_count - begin);
             s->sdmasysad += s->data_count - begin;
@@ -626,6 +629,9 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
                 s->data_count = block_size;
                 boundary_count -= block_size - begin;
             }
+            if (s->data_count <= begin || s->data_count > s->buf_maxsz) {
+                break;
+            }
             dma_memory_read(s->dma_as, s->sdmasysad,
                             &s->fifo_buffer[begin], s->data_count - begin);
             s->sdmasysad += s->data_count - begin;
-- 
2.26.2


