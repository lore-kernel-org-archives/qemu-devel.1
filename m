Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA778C43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:17:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81E052071B
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RsySzsPs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81E052071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDnFQ-0005wN-Kg
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 07:17:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDn7q-0001R0-Uj
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 07:09:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51387
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDn7o-00060V-D9
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 07:09:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599131391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9GnpNx8hKziNiqdzN01AImO2FtSdDZqIBcQzFpkVYA0=;
 b=RsySzsPsh2kvq7nkD+jX+Er/fgawngwtQlGJTComtHoWAKMxZbTtVoCI+AyPk7sfjn7lk3
 TiN5KktQpjL5fo7KUxP+aAUaVkInUFKmrC3hmaH8gmmmqUtByrrVZqnvFOD5+5pugiKfgm
 lE43lwsbzfSuJDCyOfvytjejGSWUQhQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-528-PePNy95GPcqEXhlxmqkwoQ-1; Thu, 03 Sep 2020 07:09:50 -0400
X-MC-Unique: PePNy95GPcqEXhlxmqkwoQ-1
Received: by mail-wm1-f71.google.com with SMTP id c186so836259wmd.9
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 04:09:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9GnpNx8hKziNiqdzN01AImO2FtSdDZqIBcQzFpkVYA0=;
 b=nkPwc6Dsf5DSeM3y6HU/5NtswfGCZ4SIEc4XqWuWeNfQEbT1fFQ7D0k5RlwKRBmxuU
 ueUXpJ2qEetWNULvvatsQhkwfA4sS+HQQd9y4k69kC3Vj6ja8Xf74DNoeDsa/asVHMD7
 V9QUva2tZRMBPwaEPT5vBFXhA8R36lcv+JZr3iuJsdNu1kSniagzL4YuSjS6j8KfdYzc
 OOPm9KlkdXKH/aq52CIs8FOsXlR2Y/3JRXhygnyBsSseuaWoiSDD1JcShTfXywALPwvI
 qEfwFmkYfa1ufuoGHjmUkTPBq1//aGalBnAsF0BZqV+Asx5ppSPT9rPkDNXzQJ25vvO+
 JRBw==
X-Gm-Message-State: AOAM530Ut2N9V6Ms780kFOrTJyVqArUWvrR9brGfdBdYNdjEL9mqX6Hp
 H8r/1fVfBEOx7wj/okRMoCPUh8S70mw2SVUI+jpF48xBWsbW0DoAdqTjaxnuXkXNZlw8EX0A3uP
 TyDSWqCVh8hVNVaM=
X-Received: by 2002:a1c:f003:: with SMTP id a3mr1951210wmb.170.1599131388986; 
 Thu, 03 Sep 2020 04:09:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxMrJssg5m9tGdHjZnb9WOYc9LGcKTl/RYUTl+cJMTDL99r9rkDu5mWJzLx75Laz0g6Ll7jVQ==
X-Received: by 2002:a1c:f003:: with SMTP id a3mr1951153wmb.170.1599131388703; 
 Thu, 03 Sep 2020 04:09:48 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id q3sm3709070wmq.12.2020.09.03.04.09.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 04:09:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 12/12] dma: Assert when device writes to indirect memory
 (such MMIO regions)
Date: Thu,  3 Sep 2020 13:08:31 +0200
Message-Id: <20200903110831.353476-13-philmd@redhat.com>
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
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:58:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Assert DMA accesses are done on direct memory (in particular
to catch invalid accesses to MMIO regions).

Example with the reproducer from LP#1886362 (see previous commit):

  qemu-system-i386: include/sysemu/dma.h:111: int dma_memory_rw(AddressSpace *, dma_addr_t, void *, dma_addr_t, DMADirection, MemTxAttrs): Assertion `dir == DMA_DIRECTION_TO_DEVICE || attrs.direct_access' failed.
  (gdb) bt
  #0  0x00007ffff51d69e5 in raise () at /lib64/libc.so.6
  #1  0x00007ffff51bf895 in abort () at /lib64/libc.so.6
  #2  0x00007ffff51bf769 in _nl_load_domain.cold () at /lib64/libc.so.6
  #3  0x00007ffff51cee76 in annobin_assert.c_end () at /lib64/libc.so.6
  #4  0x0000555557b48a94 in dma_memory_rw (as=0x7fffddd3ca28, addr=4064, buf=0x7fffffff7780, len=16, dir=DMA_DIRECTION_FROM_DEVICE, attrs=...) at /home/phil/source/qemu/include/sysemu/dma.h:111
  #5  0x0000555557b487e0 in pci_dma_rw (dev=0x7fffddd3c800, addr=4064, buf=0x7fffffff7780, len=16, dir=DMA_DIRECTION_FROM_DEVICE) at /home/phil/source/qemu/include/hw/pci/pci.h:791
  #6  0x0000555557b47373 in pci_dma_write (dev=0x7fffddd3c800, addr=4064, buf=0x7fffffff7780, len=16) at /home/phil/source/qemu/include/hw/pci/pci.h:804
  #7  0x0000555557b340b4 in e1000e_write_packet_to_guest (core=0x7fffddd3f4e0, pkt=0x61100006c740, rxr=0x7fffffff7cf0, rss_info=0x7fffffff7d10) at hw/net/e1000e_core.c:1609
  #8  0x0000555557b30739 in e1000e_receive_iov (core=0x7fffddd3f4e0, iov=0x619000060e80, iovcnt=4) at hw/net/e1000e_core.c:1709
  #9  0x00005555576e2069 in e1000e_nc_receive_iov (nc=0x61400000a060, iov=0x619000060e80, iovcnt=4) at hw/net/e1000e.c:213
  #10 0x00005555572a3c34 in net_tx_pkt_sendv (pkt=0x631000028800, nc=0x61400000a060, iov=0x619000060e80, iov_cnt=4) at hw/net/net_tx_pkt.c:556
  #11 0x00005555572a23e2 in net_tx_pkt_send (pkt=0x631000028800, nc=0x61400000a060) at hw/net/net_tx_pkt.c:633
  #12 0x00005555572a4c67 in net_tx_pkt_send_loopback (pkt=0x631000028800, nc=0x61400000a060) at hw/net/net_tx_pkt.c:646
  #13 0x0000555557b70b05 in e1000e_tx_pkt_send (core=0x7fffddd3f4e0, tx=0x7fffddd5f748, queue_index=0) at hw/net/e1000e_core.c:664
  #14 0x0000555557b6eab8 in e1000e_process_tx_desc (core=0x7fffddd3f4e0, tx=0x7fffddd5f748, dp=0x7fffffff8680, queue_index=0) at hw/net/e1000e_core.c:743
  #15 0x0000555557b6d65d in e1000e_start_xmit (core=0x7fffddd3f4e0, txr=0x7fffffff88a0) at hw/net/e1000e_core.c:934
  #16 0x0000555557b5ea38 in e1000e_set_tctl (core=0x7fffddd3f4e0, index=256, val=255) at hw/net/e1000e_core.c:2431
  #17 0x0000555557b369ef in e1000e_core_write (core=0x7fffddd3f4e0, addr=1027, val=255, size=4) at hw/net/e1000e_core.c:3265
  #18 0x00005555576de3be in e1000e_mmio_write (opaque=0x7fffddd3c800, addr=1027, val=255, size=4) at hw/net/e1000e.c:109
  #19 0x0000555558e6b789 in memory_region_write_accessor (mr=0x7fffddd3f110, addr=1027, value=0x7fffffff8eb0, size=4, shift=0, mask=4294967295, attrs=...) at softmmu/memory.c:483
  #20 0x0000555558e6b05b in access_with_adjusted_size (addr=1027, value=0x7fffffff8eb0, size=1, access_size_min=4, access_size_max=4, access_fn= 0x555558e6b120 <memory_region_write_accessor>, mr=0x7fffddd3f110, attrs=...) at softmmu/memory.c:544
  #21 0x0000555558e69776 in memory_region_dispatch_write (mr=0x7fffddd3f110, addr=1027, data=255, op=MO_8, attrs=...) at softmmu/memory.c:1465
  #22 0x0000555558f60462 in flatview_write_continue (fv=0x60600003f9e0, addr=3775005699, attrs=..., ptr=0x6020000e3710, len=1, addr1=1027, l=1, mr=0x7fffddd3f110) at exec.c:3176
  #23 0x0000555558f4e38b in flatview_write (fv=0x60600003f9e0, addr=3775005699, attrs=..., buf=0x6020000e3710, len=1) at exec.c:3220
  #24 0x0000555558f4dd4f in address_space_write (as=0x60800000baa0, addr=3775005699, attrs=..., buf=0x6020000e3710, len=1) at exec.c:3315
  #25 0x000055555916b3e0 in qtest_process_command (chr=0x55555c03f300 <qtest_chr>, words=0x604000058150) at softmmu/qtest.c:567
  #26 0x000055555915f7f2 in qtest_process_inbuf (chr=0x55555c03f300 <qtest_chr>, inbuf=0x6190000200e0) at softmmu/qtest.c:710

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/sysemu/dma.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/sysemu/dma.h b/include/sysemu/dma.h
index 8a7dbf0b0f3..a4ba9438a56 100644
--- a/include/sysemu/dma.h
+++ b/include/sysemu/dma.h
@@ -108,6 +108,8 @@ static inline int dma_memory_rw(AddressSpace *as, dma_addr_t addr,
                                 void *buf, dma_addr_t len,
                                 DMADirection dir, MemTxAttrs attrs)
 {
+    assert(dir == DMA_DIRECTION_TO_DEVICE || attrs.direct_access);
+
     dma_barrier(as, dir);
 
     return dma_memory_rw_relaxed(as, addr, buf, len, dir, attrs);
-- 
2.26.2


