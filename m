Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647C6C2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 22:24:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEBF920782
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 22:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yz3uYooX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEBF920782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYGLD-0006fe-Ml
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 18:24:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42916)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kYG1g-0003vu-Kq
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 18:04:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50446)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kYG1Z-0006ez-0P
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 18:04:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604009036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Obm/UiHjwrOZvMKR1ByzYIEDJy3ZZONdnzSp2EMhhU8=;
 b=Yz3uYooXwSBW69vnQzFXe+EoIGMKljIS/b8+F08yICFPMXEeygOSC41bfvbD2tne6gAYWh
 btgPcQDhmsTqlMJDF/mV+1Eoyk6mWDRGA95FAbr5Qc+eh266xxLlOdMtq0916zC8SsKDO4
 ZBkbnKunyxXiNtxgGKVZS77gw7QP/X8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-9yYUPXveN8OwXdy0UFyMSQ-1; Thu, 29 Oct 2020 18:03:54 -0400
X-MC-Unique: 9yYUPXveN8OwXdy0UFyMSQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7EDEA84BA67;
 Thu, 29 Oct 2020 22:03:53 +0000 (UTC)
Received: from localhost (ovpn-114-68.rdu2.redhat.com [10.10.114.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3F0041002C01;
 Thu, 29 Oct 2020 22:03:53 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 29/36] qdev: Move qdev_prop_tpm declaration to tpm_prop.h
Date: Thu, 29 Oct 2020 18:02:39 -0400
Message-Id: <20201029220246.472693-30-ehabkost@redhat.com>
In-Reply-To: <20201029220246.472693-1-ehabkost@redhat.com>
References: <20201029220246.472693-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 00:47:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move the variable declaration close to the macro that uses it.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Daniel P. Berrangé" <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org
---
 hw/tpm/tpm_prop.h            | 2 ++
 include/hw/qdev-properties.h | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/tpm/tpm_prop.h b/hw/tpm/tpm_prop.h
index 85e1ae5718..871af584b7 100644
--- a/hw/tpm/tpm_prop.h
+++ b/hw/tpm/tpm_prop.h
@@ -25,6 +25,8 @@
 #include "sysemu/tpm_backend.h"
 #include "hw/qdev-properties.h"
 
+extern const PropertyInfo qdev_prop_tpm;
+
 #define DEFINE_PROP_TPMBE(_n, _s, _f)                     \
     DEFINE_PROP(_n, _s, _f, qdev_prop_tpm, TPMBackend *)
 
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index e1ef466790..2b00a1bcf6 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -18,7 +18,6 @@ extern const PropertyInfo qdev_prop_uint64;
 extern const PropertyInfo qdev_prop_int64;
 extern const PropertyInfo qdev_prop_size;
 extern const PropertyInfo qdev_prop_string;
-extern const PropertyInfo qdev_prop_tpm;
 extern const PropertyInfo qdev_prop_on_off_auto;
 extern const PropertyInfo qdev_prop_size32;
 extern const PropertyInfo qdev_prop_uuid;
-- 
2.28.0


