Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DBDFC433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:11:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E386206EB
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c7CutQ7a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E386206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDn9O-0004ud-4A
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 07:11:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34372)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDn7f-0001BD-J7
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 07:09:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22503)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDn7c-0005yI-Tu
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 07:09:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599131379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6vKwxcBB1Jm47jSnzS0OZNKGx56lCbflcLgkBcmGpYU=;
 b=c7CutQ7aLjyLcx3mrx4DS914Wtbj5iihfz3Gj1bBraM2YQPEVjxo7sTICrxCKLv5C1A21u
 gM4SJLpnkJ2WpyfBuX0eLojWX/hHv3MFRAk//mMV23h6dgUFMZKkflie8VUCdE0jFF0dW2
 CWTok/+kdQQ8b+3cEOT12nrKn9lnY4Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-QeZ5Dz04MTWAAWsqxhSaFQ-1; Thu, 03 Sep 2020 07:09:38 -0400
X-MC-Unique: QeZ5Dz04MTWAAWsqxhSaFQ-1
Received: by mail-wm1-f70.google.com with SMTP id z1so856948wmk.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 04:09:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6vKwxcBB1Jm47jSnzS0OZNKGx56lCbflcLgkBcmGpYU=;
 b=nGpIhgm6/fJ9UUSMWCq8yppCpKbXSPn/7yNk3NhOYJ9Tnf8q5nZ9OdTmkaoe9mO4mW
 Xhf2CBm/CrQCS6+8H3aQBrx10DtrMMbYNFUryLRfs2+R34KnqFa8MymbllhewqJ+yuh8
 tmlAb5A4k//zdzT64DcVoFEE3Na5fNVxrMdu+kfQjapMMHzkw7N8ncsrr/tKD7HVEeVq
 K53atsPC0kw6Ob6PesGE744gX0XeGvnbvcMqviDvxX3RFmZmA3f2GGYQQ7snPZVbTjxR
 EAVy3oGATn6MlUOteLoHXE8Qxzoh7n16iGIYkUpsX+qER6P5Xy+Wlb7L175wIAuHxAAX
 fgNA==
X-Gm-Message-State: AOAM532R2qM3IiD41/3gQHcBLRp7RZ4shpZEoifcR9aQsRXfI30mvhRN
 af1fekSau/Lhdm/JEvvUAA3vgkIVzyASLbdXee64oWosAvqOVLjuzNY6OTl19G98t4sRTTQaViP
 /pkUjoOfBxe9a8sM=
X-Received: by 2002:adf:f7d0:: with SMTP id a16mr1759235wrq.381.1599131377060; 
 Thu, 03 Sep 2020 04:09:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx9ZzABMZHs/OnZtQQCj7u3oB9peViXkexZzHsdyPbqqnttBSyzIq0Xp6JVHBCMLGPo6NUwEw==
X-Received: by 2002:adf:f7d0:: with SMTP id a16mr1759190wrq.381.1599131376857; 
 Thu, 03 Sep 2020 04:09:36 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id h6sm3675958wmb.22.2020.09.03.04.09.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 04:09:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 10/12] exec/memattrs: Introduce MemTxAttrs::direct_access
 field
Date: Thu,  3 Sep 2020 13:08:29 +0200
Message-Id: <20200903110831.353476-11-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200903110831.353476-1-philmd@redhat.com>
References: <20200903110831.353476-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:47:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Peter Xu <peterx@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, qemu-block@nongnu.org,
 Li Qiang <liq3ea@163.com>, "Emilio G . Cota" <cota@braap.org>,
 Peter Chubb <peter.chubb@nicta.com.au>, Joel Stanley <joel@jms.id.au>,
 Richard Henderson <rth@twiddle.net>, Laszlo Ersek <lersek@redhat.com>,
 Robert Foley <robert.foley@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beniamino Galvani <b.galvani@gmail.com>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm@nongnu.org, Jan Kiszka <jan.kiszka@web.de>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Tony Nguyen <tony.nguyen@bt.com>,
 Prasad J Pandit <pjp@fedoraproject.org>, Alexander Bulekov <alxndr@bu.edu>,
 Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-ppc@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add the 'direct_access' bit to the memory attributes to restrict
bus master access to ROM/RAM.
Have read/write accessors return MEMTX_BUS_ERROR if an access is
restricted and the region is not ROM/RAM ('direct').
Add corresponding trace events.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/exec/memattrs.h | 3 +++
 exec.c                  | 8 ++++++++
 trace-events            | 1 +
 3 files changed, 12 insertions(+)

diff --git a/include/exec/memattrs.h b/include/exec/memattrs.h
index 95f2d20d55b..c27cf639a96 100644
--- a/include/exec/memattrs.h
+++ b/include/exec/memattrs.h
@@ -35,6 +35,8 @@ typedef struct MemTxAttrs {
     unsigned int secure:1;
     /* Memory access is usermode (unprivileged) */
     unsigned int user:1;
+    /* Bus master restricted to ROM/RAM slaves */
+    unsigned int direct_access:1;
     /* Requester ID (for MSI for example) */
     unsigned int requester_id:16;
     /* Invert endianness for this page */
@@ -66,6 +68,7 @@ typedef struct MemTxAttrs {
 #define MEMTX_OK 0
 #define MEMTX_ERROR             (1U << 0) /* device returned an error */
 #define MEMTX_DECODE_ERROR      (1U << 1) /* nothing at that address */
+#define MEMTX_BUS_ERROR         (1U << 2) /* bus returned an error */
 typedef uint32_t MemTxResult;
 
 #endif
diff --git a/exec.c b/exec.c
index 7683afb6a8e..e6185eb04de 100644
--- a/exec.c
+++ b/exec.c
@@ -3213,6 +3213,10 @@ static MemTxResult flatview_write(FlatView *fv, hwaddr addr, MemTxAttrs attrs,
 
     l = len;
     mr = flatview_translate(fv, addr, &addr1, &l, true, attrs);
+    if (attrs.direct_access && !memory_access_is_direct(mr, true)) {
+        trace_memory_access_illegal(true, addr, len, mr->name);
+        return MEMTX_BUS_ERROR;
+    }
     result = flatview_write_continue(fv, addr, attrs, buf, len,
                                      addr1, l, mr);
 
@@ -3275,6 +3279,10 @@ static MemTxResult flatview_read(FlatView *fv, hwaddr addr,
 
     l = len;
     mr = flatview_translate(fv, addr, &addr1, &l, false, attrs);
+    if (attrs.direct_access && !memory_access_is_direct(mr, false)) {
+        trace_memory_access_illegal(false, addr, len, mr->name);
+        return MEMTX_BUS_ERROR;
+    }
     return flatview_read_continue(fv, addr, attrs, buf, len,
                                   addr1, l, mr);
 }
diff --git a/trace-events b/trace-events
index 42107ebc697..931896735b1 100644
--- a/trace-events
+++ b/trace-events
@@ -54,6 +54,7 @@ find_ram_offset_loop(uint64_t size, uint64_t candidate, uint64_t offset, uint64_
 ram_block_discard_range(const char *rbname, void *hva, size_t length, bool need_madvise, bool need_fallocate, int ret) "%s@%p + 0x%zx: madvise: %d fallocate: %d ret: %d"
 memory_notdirty_write_access(uint64_t vaddr, uint64_t ram_addr, unsigned size) "0x%" PRIx64 " ram_addr 0x%" PRIx64 " size %u"
 memory_notdirty_set_dirty(uint64_t vaddr) "0x%" PRIx64
+memory_access_illegal(bool is_write, uint64_t addr, uint64_t len, const char *mr_name) "is_write:%u addr:0x%08" PRIx64 " size:0x%04" PRIx64 " region:'%s'"
 
 # memory.c
 memory_region_ops_read(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
-- 
2.26.2


