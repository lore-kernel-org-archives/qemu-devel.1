Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4465AC43464
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 11:55:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0A2820773
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 11:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="efTkzcAf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0A2820773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKKPi-00062X-Vx
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 07:55:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45980)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kKKG7-0002vu-3C
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 07:45:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43229
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kKKG4-0002a1-Ld
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 07:45:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600688723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c6pD2+Pc8POfcBxmxk90BGRRuH6Y8wbJMwjn9MiDPb8=;
 b=efTkzcAfX9+KFF6T+6AfTMhG9bdqlqEe2txs/eZGmccP7Zvr/iXfN9gjLzdNmimFILu0dH
 a1wXDgThYI9s9cEOdTYBpAAKS1VVhizDfVEgla0xqLH95wmLkhYeat/g2gcO4Slp/SH1Wf
 14lhzaLIDC/tMBApEiLMLTMuUpXfZnY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-lI26gkozP261_3IDl0ZEPQ-1; Mon, 21 Sep 2020 07:45:21 -0400
X-MC-Unique: lI26gkozP261_3IDl0ZEPQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 18BE09CC0C;
 Mon, 21 Sep 2020 11:45:20 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-85.ams2.redhat.com
 [10.36.112.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 153FE7366A;
 Mon, 21 Sep 2020 11:45:11 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id CF49B16E16; Mon, 21 Sep 2020 13:45:09 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] microvm: add irq table
Date: Mon, 21 Sep 2020 13:45:08 +0200
Message-Id: <20200921114509.14511-2-kraxel@redhat.com>
In-Reply-To: <20200921114509.14511-1-kraxel@redhat.com>
References: <20200921114509.14511-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 07:01:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a comment with a table listing the IRQs,
both legacy pc and microvm side-by-side.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/hw/i386/microvm.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/hw/i386/microvm.h b/include/hw/i386/microvm.h
index be2d95af4d74..27eadd6c535c 100644
--- a/include/hw/i386/microvm.h
+++ b/include/hw/i386/microvm.h
@@ -27,6 +27,28 @@
 #include "hw/acpi/acpi_dev_interface.h"
 #include "qom/object.h"
 
+/*
+ *  IRQ    |  pc        | microvm (acpi=on)
+ * --------+------------+------------------
+ *   0     |  pit       |
+ *   1     |  kbd       |
+ *   2     |  cascade   |
+ *   3     |  serial 1  |
+ *   4     |  serial 0  | serial
+ *   5     |  -         |
+ *   6     |  floppy    |
+ *   7     |  parallel  |
+ *   8     |  rtc       | rtc (rtc=on)
+ *   9     |  acpi      | acpi (ged)
+ *  10     |  pci lnk   |
+ *  11     |  pci lnk   |
+ *  12     |  ps2       |
+ *  13     |  fpu       |
+ *  14     |  ide 0     |
+ *  15     |  ide 1     |
+ *  16-23  |  pci gsi   | virtio
+ */
+
 /* Platform virtio definitions */
 #define VIRTIO_MMIO_BASE      0xfeb00000
 #define VIRTIO_NUM_TRANSPORTS 8
-- 
2.27.0


