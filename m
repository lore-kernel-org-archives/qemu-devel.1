Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E845CC433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 16:43:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B38A220723
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 16:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RREtsUMu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B38A220723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrlGE-0005Gw-07
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 12:43:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52608)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrlCp-0000Ay-Th
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 12:39:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44924
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrlCn-0005T5-MV
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 12:39:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593880797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SoMzx8A+FvWrYD3fCm48tVpQZqurazT9wEn66p/sv/E=;
 b=RREtsUMuf9xOfAwH5LcjUdLkFP0X6r6WhYZYPSaIfGzbrrQghdOqBZY4SqJP8maGjU70GH
 dB1ewDXE826XncH3DimPXlg2x233aT6oTBkURhT5ZhfvazUC7QXtRvIdD+nOAt7AqMrVv5
 W9+rrd7yIL6pwduIxURzChlpN34C160=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-y8YM_rxZMaK_3UbSTojltw-1; Sat, 04 Jul 2020 12:39:55 -0400
X-MC-Unique: y8YM_rxZMaK_3UbSTojltw-1
Received: by mail-wm1-f72.google.com with SMTP id t145so39976322wmt.2
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 09:39:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SoMzx8A+FvWrYD3fCm48tVpQZqurazT9wEn66p/sv/E=;
 b=tjcQXjXf4z3YFsZWKD7PBsXUefft3d8k1n4lpd2Wxldu2wYptqoPeCZUkgZSYspHzC
 j0PJULytq6bK15cr29etY4haWFvrRnhiFovI9hcXFGzIORwHnos3/nzNFII6tJ5dpEQA
 volzirLRHa8Tv0JT5tjHuZpCCSuhF8iFt5WRiHiSGAqhDkjO8cEwaNyMLPCd/CmIBkqX
 2WSnpBKHnHrpfNgN/1FvBh3yDfxr0ojI2zwsR409tAaFevG0LFz0QmhD0zbAGkmNDb4b
 zgEPpLVLHwtksH+YKfMJkHgCvRslAyd/U5bhKRObd7WRspKOmobXNa2Xm2QF0YxJHNUr
 Oidw==
X-Gm-Message-State: AOAM533ZYua75a+bOKEgi2TPmMMGJlkcJ3pesWImW6/rx5CU7Hau1ve1
 4lHvfbW/I5bwgznuD5rhZWAxaILZ7b8nnfH6v10xNJ0v1/k+0+YLwQY7SwEkTBBSMDGO0Ko/q00
 x/YpveO1qJThM6BI=
X-Received: by 2002:adf:e50a:: with SMTP id j10mr44217697wrm.71.1593880794065; 
 Sat, 04 Jul 2020 09:39:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVcBdbyx4Vu6pxwhm7S5WKVdlD8nuS4ufxBCdNKEKYMUmbFUM+owxKRd2/wi3OZdKggl32zw==
X-Received: by 2002:adf:e50a:: with SMTP id j10mr44217677wrm.71.1593880793778; 
 Sat, 04 Jul 2020 09:39:53 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id j4sm13006917wrp.51.2020.07.04.09.39.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 09:39:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 5/5] crypto/tls-cipher-suites: Produce fw_cfg consumable blob
Date: Sat,  4 Jul 2020 18:39:27 +0200
Message-Id: <20200704163927.28188-6-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200704163927.28188-1-philmd@redhat.com>
References: <20200704163927.28188-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 11:39:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since our format is consumable by the fw_cfg device,
we can implement the FW_CFG_DATA_GENERATOR interface.

Example of use to dump the cipher suites (if tracing enabled):

  $ qemu-system-x86_64 -S \
    -object tls-cipher-suites,id=mysuite1,priority=@SYSTEM \
    -fw_cfg name=etc/path/to/ciphers,gen_id=mysuite1 \
    -trace qcrypto\*
  1590664444.197123:qcrypto_tls_cipher_suite_priority priority: @SYSTEM
  1590664444.197219:qcrypto_tls_cipher_suite_info data=[0x13,0x02] version=TLS1.3 name=TLS_AES_256_GCM_SHA384
  1590664444.197228:qcrypto_tls_cipher_suite_info data=[0x13,0x03] version=TLS1.3 name=TLS_CHACHA20_POLY1305_SHA256
  1590664444.197233:qcrypto_tls_cipher_suite_info data=[0x13,0x01] version=TLS1.3 name=TLS_AES_128_GCM_SHA256
  1590664444.197236:qcrypto_tls_cipher_suite_info data=[0x13,0x04] version=TLS1.3 name=TLS_AES_128_CCM_SHA256
  1590664444.197240:qcrypto_tls_cipher_suite_info data=[0xc0,0x30] version=TLS1.2 name=TLS_ECDHE_RSA_AES_256_GCM_SHA384
  1590664444.197245:qcrypto_tls_cipher_suite_info data=[0xcc,0xa8] version=TLS1.2 name=TLS_ECDHE_RSA_CHACHA20_POLY1305
  1590664444.197250:qcrypto_tls_cipher_suite_info data=[0xc0,0x14] version=TLS1.0 name=TLS_ECDHE_RSA_AES_256_CBC_SHA1
  1590664444.197254:qcrypto_tls_cipher_suite_info data=[0xc0,0x2f] version=TLS1.2 name=TLS_ECDHE_RSA_AES_128_GCM_SHA256
  1590664444.197258:qcrypto_tls_cipher_suite_info data=[0xc0,0x13] version=TLS1.0 name=TLS_ECDHE_RSA_AES_128_CBC_SHA1
  1590664444.197261:qcrypto_tls_cipher_suite_info data=[0xc0,0x2c] version=TLS1.2 name=TLS_ECDHE_ECDSA_AES_256_GCM_SHA384
  1590664444.197266:qcrypto_tls_cipher_suite_info data=[0xcc,0xa9] version=TLS1.2 name=TLS_ECDHE_ECDSA_CHACHA20_POLY1305
  1590664444.197270:qcrypto_tls_cipher_suite_info data=[0xc0,0xad] version=TLS1.2 name=TLS_ECDHE_ECDSA_AES_256_CCM
  1590664444.197274:qcrypto_tls_cipher_suite_info data=[0xc0,0x0a] version=TLS1.0 name=TLS_ECDHE_ECDSA_AES_256_CBC_SHA1
  1590664444.197278:qcrypto_tls_cipher_suite_info data=[0xc0,0x2b] version=TLS1.2 name=TLS_ECDHE_ECDSA_AES_128_GCM_SHA256
  1590664444.197283:qcrypto_tls_cipher_suite_info data=[0xc0,0xac] version=TLS1.2 name=TLS_ECDHE_ECDSA_AES_128_CCM
  1590664444.197287:qcrypto_tls_cipher_suite_info data=[0xc0,0x09] version=TLS1.0 name=TLS_ECDHE_ECDSA_AES_128_CBC_SHA1
  1590664444.197291:qcrypto_tls_cipher_suite_info data=[0x00,0x9d] version=TLS1.2 name=TLS_RSA_AES_256_GCM_SHA384
  1590664444.197296:qcrypto_tls_cipher_suite_info data=[0xc0,0x9d] version=TLS1.2 name=TLS_RSA_AES_256_CCM
  1590664444.197300:qcrypto_tls_cipher_suite_info data=[0x00,0x35] version=TLS1.0 name=TLS_RSA_AES_256_CBC_SHA1
  1590664444.197304:qcrypto_tls_cipher_suite_info data=[0x00,0x9c] version=TLS1.2 name=TLS_RSA_AES_128_GCM_SHA256
  1590664444.197308:qcrypto_tls_cipher_suite_info data=[0xc0,0x9c] version=TLS1.2 name=TLS_RSA_AES_128_CCM
  1590664444.197312:qcrypto_tls_cipher_suite_info data=[0x00,0x2f] version=TLS1.0 name=TLS_RSA_AES_128_CBC_SHA1
  1590664444.197316:qcrypto_tls_cipher_suite_info data=[0x00,0x9f] version=TLS1.2 name=TLS_DHE_RSA_AES_256_GCM_SHA384
  1590664444.197320:qcrypto_tls_cipher_suite_info data=[0xcc,0xaa] version=TLS1.2 name=TLS_DHE_RSA_CHACHA20_POLY1305
  1590664444.197325:qcrypto_tls_cipher_suite_info data=[0xc0,0x9f] version=TLS1.2 name=TLS_DHE_RSA_AES_256_CCM
  1590664444.197329:qcrypto_tls_cipher_suite_info data=[0x00,0x39] version=TLS1.0 name=TLS_DHE_RSA_AES_256_CBC_SHA1
  1590664444.197333:qcrypto_tls_cipher_suite_info data=[0x00,0x9e] version=TLS1.2 name=TLS_DHE_RSA_AES_128_GCM_SHA256
  1590664444.197337:qcrypto_tls_cipher_suite_info data=[0xc0,0x9e] version=TLS1.2 name=TLS_DHE_RSA_AES_128_CCM
  1590664444.197341:qcrypto_tls_cipher_suite_info data=[0x00,0x33] version=TLS1.0 name=TLS_DHE_RSA_AES_128_CBC_SHA1
  1590664444.197345:qcrypto_tls_cipher_suite_count count: 29

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Acked-by: Laszlo Ersek <lersek@redhat.com>
Message-Id: <20200623172726.21040-6-philmd@redhat.com>
---
 crypto/tls-cipher-suites.c | 11 +++++++++++
 qemu-options.hx            | 18 ++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/crypto/tls-cipher-suites.c b/crypto/tls-cipher-suites.c
index a4e0f84307..0d305b684b 100644
--- a/crypto/tls-cipher-suites.c
+++ b/crypto/tls-cipher-suites.c
@@ -13,6 +13,7 @@
 #include "qom/object_interfaces.h"
 #include "crypto/tlscreds.h"
 #include "crypto/tls-cipher-suites.h"
+#include "hw/nvram/fw_cfg.h"
 #include "trace.h"
 
 /*
@@ -88,11 +89,20 @@ static void qcrypto_tls_cipher_suites_complete(UserCreatable *uc,
     }
 }
 
+static GByteArray *qcrypto_tls_cipher_suites_fw_cfg_gen_data(Object *obj,
+                                                             Error **errp)
+{
+    return qcrypto_tls_cipher_suites_get_data(QCRYPTO_TLS_CIPHER_SUITES(obj),
+                                              errp);
+}
+
 static void qcrypto_tls_cipher_suites_class_init(ObjectClass *oc, void *data)
 {
     UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
+    FWCfgDataGeneratorClass *fwgc = FW_CFG_DATA_GENERATOR_CLASS(oc);
 
     ucc->complete = qcrypto_tls_cipher_suites_complete;
+    fwgc->get_data = qcrypto_tls_cipher_suites_fw_cfg_gen_data;
 }
 
 static const TypeInfo qcrypto_tls_cipher_suites_info = {
@@ -103,6 +113,7 @@ static const TypeInfo qcrypto_tls_cipher_suites_info = {
     .class_init = qcrypto_tls_cipher_suites_class_init,
     .interfaces = (InterfaceInfo[]) {
         { TYPE_USER_CREATABLE },
+        { TYPE_FW_CFG_DATA_GENERATOR_INTERFACE },
         { }
     }
 };
diff --git a/qemu-options.hx b/qemu-options.hx
index ecc4658e1f..b2cbbbf281 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4586,6 +4586,24 @@ SRST
         string as described at
         https://gnutls.org/manual/html_node/Priority-Strings.html.
 
+        An example of use of this object is to control UEFI HTTPS Boot.
+        The tls-cipher-suites object exposes the ordered list of permitted
+        TLS cipher suites from the host side to the guest firmware, via
+        fw_cfg. The list is represented as an array of IANA_TLS_CIPHER
+        objects. The firmware uses the IANA_TLS_CIPHER array for configuring
+        guest-side TLS.
+
+        In the following example, the priority at which the host-side policy
+        is retrieved is given by the ``priority`` property.
+        Given that QEMU uses GNUTLS, ``priority=@SYSTEM`` may be used to
+        refer to /etc/crypto-policies/back-ends/gnutls.config.
+
+        .. parsed-literal::
+
+             # |qemu_system| \
+                 -object tls-cipher-suites,id=mysuite0,priority=@SYSTEM \
+                 -fw_cfg name=etc/edk2/https/ciphers,gen_id=mysuite0
+
     ``-object filter-buffer,id=id,netdev=netdevid,interval=t[,queue=all|rx|tx][,status=on|off][,position=head|tail|id=<id>][,insert=behind|before]``
         Interval t can't be 0, this filter batches the packet delivery:
         all packets arriving in a given interval on netdev netdevid are
-- 
2.21.3


