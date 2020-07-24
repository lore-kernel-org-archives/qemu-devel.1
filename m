Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F57C433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 05:24:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0C42206E3
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 05:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WUCpTzKp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0C42206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyqCC-0003Ed-Vn
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 01:24:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51754)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jyqAs-00013Y-LD
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 01:23:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24378
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jyqAp-0007S6-6g
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 01:23:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595568190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/s3X8YqjASZjM7L/p0xkJEgVoB+Q5trhJzSdGsKpBWg=;
 b=WUCpTzKpFBtPr6jSQ+6kfBt7p7+ISPTlUbEVOv6A2Bdlp9I/EDmIbXW73nhT2KVWgcsGjz
 3czlMcuf/q+j5nuG6u5Iy0Wzc0Z8RFl7OpHHRCZCxY8UsajDNKY2uytM3KOqrJRmtCkByH
 FoNX9VtyocYlf+NcUPqUgqXXXSsy7p8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-WFvfen2UO2iiIJx-wqp7rQ-1; Fri, 24 Jul 2020 01:23:08 -0400
X-MC-Unique: WFvfen2UO2iiIJx-wqp7rQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9CC4458;
 Fri, 24 Jul 2020 05:23:07 +0000 (UTC)
Received: from ibm-p8-OVS-01-fsp.mgmt.pnr.lab.eng.rdu2.redhat.com
 (ovpn-120-206.rdu2.redhat.com [10.10.120.206])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DE7B27AC80;
 Fri, 24 Jul 2020 05:23:06 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 6/7] ide: clear interrupt on command write
Date: Fri, 24 Jul 2020 01:22:59 -0400
Message-Id: <20200724052300.1163728-7-jsnow@redhat.com>
In-Reply-To: <20200724052300.1163728-1-jsnow@redhat.com>
References: <20200724052300.1163728-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jsnow@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 01:23:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: kwolf@redhat.com, Alexander Bulekov <alxndr@bu.edu>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Not known to fix any bug, but I couldn't help but notice that ATA
specifies that writing to this register should clear an interrupt.

ATA7: Section 5.3.3 (Command register - Effect)
ATA6: Section 7.4.4 (Command register - Effect)
ATA5: Section 7.4.4 (Command register - Effect)
ATA4: Section 7.4.4 (Command register - Effect)
ATA3: Section 5.2.2 (Command register)

Other editions: try searching for the phrase "Writing this register".

Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index 5f4f004312..e4c69a7fde 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -1312,6 +1312,7 @@ void ide_ioport_write(void *opaque, uint32_t addr, uint32_t val)
     default:
     case ATA_IOPORT_WR_COMMAND:
         ide_clear_hob(bus);
+        qemu_irq_lower(bus->irq);
         ide_exec_cmd(bus, val);
         break;
     }
-- 
2.26.2


