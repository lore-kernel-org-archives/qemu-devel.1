Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4AABC433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:18:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64B202071B
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UKpe9sK8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64B202071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDnFt-0006z2-8E
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 07:18:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDn7p-0001Mp-Ha
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 07:09:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60664)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDn7n-0005z8-AF
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 07:09:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599131388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gfc0vh/hSxUgj/nHXInlGH3QJr0Hadg3+ww1zXZjK0w=;
 b=UKpe9sK8U3RUHZqdpXNqXB4rCXrncs31Su5LskFZuaklFP58EOqfSz06TUsDj8vnGis3Xt
 nPvrJ/0V39wrd8LVFi5JFeo09w8z+whs1G3s02p2cAfUH6SltRPjMGwSZr26xdSnJB10aN
 oqYebD4A7XYgdV5WS4hH/8uRf8fupHQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-DxewNy5VNjG5XU65okIWkQ-1; Thu, 03 Sep 2020 07:09:44 -0400
X-MC-Unique: DxewNy5VNjG5XU65okIWkQ-1
Received: by mail-wr1-f70.google.com with SMTP id b7so954401wrn.6
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 04:09:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Gfc0vh/hSxUgj/nHXInlGH3QJr0Hadg3+ww1zXZjK0w=;
 b=Lvn940b+l7fxOyNS/zecAdn3X0DSm32QaH+yKa/A+eLRCPm8ij8VBlfPVKSD+LHDfP
 KNzx/0ncJEAl/ZJZgs1INYAm3ZnQd/dj9JhwTuvNVst4FXcjJmhP0d+fG+yx0rrIbsca
 nv89+chHEYbxGu0klGPn2DgeLT+GdDmn+BAPrlORrue/0u/cybsmBR1/mTsx8YjPAj6q
 0oBEpBOgWmsyCPBNMJUX8ivqcJWydKFM68EME+WHA5qM7j6q/TdDjKknazhvP1yKIcZ/
 w8GY+Hc2iOpkGBh3dCU2mG1ML1DzLCAgcvxxv1oGJTPD0R6M5zudmbdObvTS7KAztvGe
 Rgog==
X-Gm-Message-State: AOAM533c0tWn8AK26+MzFO6xdQM3O74hEq0B2PlH43M6wPSP/SL15mX0
 lmxhLb64jPgNuQtYQENuPfbejmIGvtQY+hHY5Fxni0OgxRCjjCC0XH6A/nPkhwrGsydHD85ZgO1
 Ce3WYX92j1XMvStw=
X-Received: by 2002:a1c:4c06:: with SMTP id z6mr1916156wmf.40.1599131383034;
 Thu, 03 Sep 2020 04:09:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxa1QNXafg0ye14T7uTUb9HQ/dvqWbALHxQzlyRjgumJlibWVrf8ZVOSq1l2j24wGvld+nBug==
X-Received: by 2002:a1c:4c06:: with SMTP id z6mr1916113wmf.40.1599131382849;
 Thu, 03 Sep 2020 04:09:42 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id z13sm3820908wro.97.2020.09.03.04.09.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 04:09:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 11/12] hw/pci: Only allow PCI slave devices to write to
 direct memory
Date: Thu,  3 Sep 2020 13:08:30 +0200
Message-Id: <20200903110831.353476-12-philmd@redhat.com>
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
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 04:23:54
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

Do not allow PCI slaves to write to indirect memory
regions such MMIO.

This fixes LP#1886362 and LP#1888606.

Example with the former reproducer:

  $ cat << EOF | \
    qemu-system-i386 -M q35,accel=qtest \
                     -qtest stdio \
                     -trace memory_access\* \
  outl 0xcf8 0x80001010
  outl 0xcfc 0xe1020000
  outl 0xcf8 0x80001014
  outl 0xcf8 0x80001004
  outw 0xcfc 0x7
  outl 0xcf8 0x800010a2
  write 0xe102003b 0x1 0xff
  write 0xe1020103 0x1e 0xffffff055c5e5c30be4511d084ffffffffffffffffffffffffffffffffff
  write 0xe1020420 0x4 0xffffffff
  write 0xe1020424 0x4 0xffffffff
  write 0xe102042b 0x1 0xff
  write 0xe1020430 0x4 0x055c5e5c
  write 0x5c041 0x1 0x04
  write 0x5c042 0x1 0x02
  write 0x5c043 0x1 0xe1
  write 0x5c048 0x1 0x8a
  write 0x5c04a 0x1 0x31
  write 0x5c04b 0x1 0xff
  write 0xe1020403 0x1 0xff
  EOF
  562564:memory_access_illegal is_write:1 addr:0xe1020400 size:0x000e region:'e1000e-mmio'
  562592:memory_access_illegal is_write:1 addr:0xe102040e size:0x007c region:'e1000e-mmio'
  562601:memory_access_illegal is_write:1 addr:0xe102048a size:0x0004 region:'e1000e-mmio'

Reported-by: Alexander Bulekov <alxndr@bu.edu>
Buglink: https://bugs.launchpad.net/qemu/+bug/1886362
Buglink: https://bugs.launchpad.net/qemu/+bug/1888606
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/hw/pci/pci.h | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 8f901e6c289..cd97268b3a8 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -788,8 +788,12 @@ static inline AddressSpace *pci_get_address_space(PCIDevice *dev)
 static inline int pci_dma_rw(PCIDevice *dev, dma_addr_t addr,
                              void *buf, dma_addr_t len, DMADirection dir)
 {
+    MemTxAttrs attrs = {
+        .direct_access = (dir == DMA_DIRECTION_FROM_DEVICE),
+        .requester_id = pci_requester_id(dev),
+    };
     return dma_memory_rw(pci_get_address_space(dev), addr, buf, len,
-                         dir, MEMTXATTRS_UNSPECIFIED);
+                         dir, attrs);
 }
 
 static inline int pci_dma_read(PCIDevice *dev, dma_addr_t addr,
@@ -808,14 +812,18 @@ static inline int pci_dma_write(PCIDevice *dev, dma_addr_t addr,
     static inline uint##_bits##_t ld##_l##_pci_dma(PCIDevice *dev,      \
                                                    dma_addr_t addr)     \
     {                                                                   \
-        return ld##_l##_dma(pci_get_address_space(dev), addr,           \
-                            MEMTXATTRS_UNSPECIFIED);                    \
+        MemTxAttrs attrs = {                                            \
+            .requester_id = pci_requester_id(dev),                      \
+        };                                                              \
+        return ld##_l##_dma(pci_get_address_space(dev), addr, attrs);   \
     }                                                                   \
     static inline void st##_s##_pci_dma(PCIDevice *dev,                 \
                                         dma_addr_t addr, uint##_bits##_t val) \
     {                                                                   \
-        st##_s##_dma(pci_get_address_space(dev), addr, val,             \
-                     MEMTXATTRS_UNSPECIFIED);                           \
+        MemTxAttrs attrs = {                                            \
+            .requester_id = pci_requester_id(dev),                      \
+        };                                                              \
+        st##_s##_dma(pci_get_address_space(dev), addr, val, attrs);     \
     }
 
 PCI_DMA_DEFINE_LDST(ub, b, 8);
-- 
2.26.2


