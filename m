Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5EE0C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 11:40:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 163AF22261
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 11:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QuxRN1Vo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 163AF22261
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQqlD-00085d-Mq
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 07:40:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58752)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1kQqjf-0006tH-48
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 07:38:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22626)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1kQqjc-0002uQ-EH
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 07:38:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602243530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=X4T+XUE+9fRRwHkmRqYdpenn9rrKvTmF6DF8BxeGGnY=;
 b=QuxRN1VoMr2mV4qOnojjrvgiM3KXxxTpBidy/wbQqskjgA9zkiOUcLWK5pC1FiXw9x6EWQ
 uaVi83AV7AyVLSc6RyGzGGYN7AWGQFqKFOD7wCK7cEivuSgagOcCJN/ZxsrUxoCvZY3K19
 3TU9YyOlPIuEa1WCPLGy60iAPJKkgEg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-L67iVjnhOQaFe7nofx5CUw-1; Fri, 09 Oct 2020 07:38:48 -0400
X-MC-Unique: L67iVjnhOQaFe7nofx5CUw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D88FA8DA194;
 Fri,  9 Oct 2020 11:38:46 +0000 (UTC)
Received: from thinkpad.redhat.com (ovpn-115-120.ams2.redhat.com
 [10.36.115.120])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 820B76266E;
 Fri,  9 Oct 2020 11:38:44 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] hw/char/serial: remove duplicate .class_init in
 serial_mm_info
Date: Fri,  9 Oct 2020 13:38:42 +0200
Message-Id: <20201009113843.60995-1-lvivier@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lvivier@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-riscv@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org,
 Anup Patel <anup.patel@wdc.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

.class_init is already set to serial_mm_class_init.

Remove the duplicate entry.

Fixes: 17fd1a6490b1 ("serial-mm: add "regshift" property")
Cc: marcandre.lureau@redhat.com
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/char/serial.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index 4386adabd466..97f71879ff2a 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -1120,7 +1120,6 @@ static const TypeInfo serial_mm_info = {
     .class_init = serial_mm_class_init,
     .instance_init = serial_mm_instance_init,
     .instance_size = sizeof(SerialMM),
-    .class_init = serial_mm_class_init,
 };
 
 static void serial_register_types(void)
-- 
2.26.2


