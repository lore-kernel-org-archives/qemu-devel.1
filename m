Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 068B3C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:21:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5294121D47
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vnv1GYOJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5294121D47
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVysb-0002x9-Ax
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 11:21:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57356)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVyr5-0001Dv-N3
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:19:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52793)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVyr3-00009w-NZ
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:19:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603466383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ttvgS+r+18VpM2OBoh4lfYK/eRzxtUcQdupc1VVh/ow=;
 b=Vnv1GYOJnp7spJsw2DnCHnwzvKS2bxFY9l2Dy0g1QGjPYXUPgQ4nkqdADyu7lTkpl12Dwk
 rpLktafO7Fj5W7/V4VPNwBwFqTPGlVLbpAoHv8rU2Tv/N22Ovg9vESQeErazSwm4v3UALs
 LmQ41+E1NnI707TxtRCkmglw9YGM7nM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-I7UTSGHDPGaSJkuCsXCTwA-1; Fri, 23 Oct 2020 11:19:41 -0400
X-MC-Unique: I7UTSGHDPGaSJkuCsXCTwA-1
Received: by mail-wm1-f70.google.com with SMTP id v14so573611wmj.6
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 08:19:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ttvgS+r+18VpM2OBoh4lfYK/eRzxtUcQdupc1VVh/ow=;
 b=E9za6/hdr1vjPeHbaEUXvAXZXOFDNsQf+Au0KKvmY1MY6k428U9TP/Etw3OMiAKJLk
 tFByK2mO2t668rIqKuzdKti1dpYvDjzZSdROWNXikJgWZ2jSZUP6IbFTZA6+ZMp7RED7
 WpsePUvIis4U6yhzX5ghxUy6jbsZ3LPhk116ciMxVQPOXn3xmJdQ6cddc6b1/o6WDTas
 OAXR24YdD0Tm5/DXK6jrxNXKke9ytOFQPBBOU3EyReF2tX6Hfb7fhN7KrTJyCPWfcj1T
 0d/6SSlCfs/05hEXyd0zgyD61qwPGMgmLHeXSnoVXmuMgGY6j0GCClgtCsz2TYKhoTsO
 FK0A==
X-Gm-Message-State: AOAM530GF+ElQYRcSDXVSDPV/OhAxsb7wCmG7N/zwfoRYQ5mDmILIN4U
 c2Qc7BmUym1Hufjt8QrpnoEUumjLl8hGxpshFYaBTgF+lzNZXwJyW6g26IaHo4suCztfrOPogLa
 jzVIWODtowORvOMo=
X-Received: by 2002:a1c:49c2:: with SMTP id w185mr2821863wma.70.1603466379995; 
 Fri, 23 Oct 2020 08:19:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzmKJiCewP/Mt8BrNai0LshClxUJRKHhdZVFaM0xhEmiieM7Ky/xXkCrumd5nWJ/dEjxHNScA==
X-Received: by 2002:a1c:49c2:: with SMTP id w185mr2821852wma.70.1603466379767; 
 Fri, 23 Oct 2020 08:19:39 -0700 (PDT)
Received: from localhost.localdomain (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id n4sm3566236wrr.91.2020.10.23.08.19.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2020 08:19:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND v3 03/10] dma: Document
 address_space_map/address_space_unmap() prototypes
Date: Fri, 23 Oct 2020 17:19:16 +0200
Message-Id: <20201023151923.3243652-4-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201023151923.3243652-1-philmd@redhat.com>
References: <20201023151923.3243652-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 02:46:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add documentation based on address_space_map / address_space_unmap.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/sysemu/dma.h | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/include/sysemu/dma.h b/include/sysemu/dma.h
index 80c5bc3e02d..c6e12b4c243 100644
--- a/include/sysemu/dma.h
+++ b/include/sysemu/dma.h
@@ -1,7 +1,7 @@
 /*
  * DMA helper functions
  *
- * Copyright (c) 2009 Red Hat
+ * Copyright (c) 2009, 2020 Red Hat
  *
  * This work is licensed under the terms of the GNU General Public License
  * (GNU GPL), version 2 or later.
@@ -125,6 +125,19 @@ static inline int dma_memory_write(AddressSpace *as, dma_addr_t addr,
 
 int dma_memory_set(AddressSpace *as, dma_addr_t addr, uint8_t c, dma_addr_t len);
 
+/**
+ * address_space_map: Map a physical memory region into a host virtual address.
+ *
+ * May map a subset of the requested range, given by and returned in @plen.
+ * May return %NULL and set *@plen to zero(0), if resources needed to perform
+ * the mapping are exhausted.
+ * Use only for reads OR writes - not for read-modify-write operations.
+ *
+ * @as: #AddressSpace to be accessed
+ * @addr: address within that address space
+ * @len: pointer to length of buffer; updated on return
+ * @dir: indicates the transfer direction
+ */
 static inline void *dma_memory_map(AddressSpace *as,
                                    dma_addr_t addr, dma_addr_t *len,
                                    DMADirection dir)
@@ -138,6 +151,20 @@ static inline void *dma_memory_map(AddressSpace *as,
     return p;
 }
 
+/**
+ * address_space_unmap: Unmaps a memory region previously mapped
+ *                      by dma_memory_map()
+ *
+ * Will also mark the memory as dirty if @dir == %DMA_DIRECTION_FROM_DEVICE.
+ * @access_len gives the amount of memory that was actually read or written
+ * by the caller.
+ *
+ * @as: #AddressSpace used
+ * @buffer: host pointer as returned by address_space_map()
+ * @len: buffer length as returned by address_space_map()
+ * @dir: indicates the transfer direction
+ * @access_len: amount of data actually transferred
+ */
 static inline void dma_memory_unmap(AddressSpace *as,
                                     void *buffer, dma_addr_t len,
                                     DMADirection dir, dma_addr_t access_len)
-- 
2.26.2


