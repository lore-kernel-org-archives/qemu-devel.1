Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23390C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:32:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E425420691
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K9Dg+Hxd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E425420691
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jii6e-0004PW-3P
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 13:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52342)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jihjc-0004Wc-Nj
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 13:08:24 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27494
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jihjb-0008V2-Br
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 13:08:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591722502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l1FNMSzdxkTmtGs96MOlFxksQhCZtICy60TUvMz4Bw8=;
 b=K9Dg+HxdMBkceNzqJJ+capetzES/cOmKOog3CrTGa1uwrp5RZniL/07fsVI+Qrb41EG+Ky
 0s7/8hKcbQfxPuG171fQx0D+XqeVMX8GaMJP70P4LBnKPWqDrAX2/qGGYe7TR52tZ3onyw
 sbdpLJLvpil92ZyWg3BBykm6aaTExKI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-DqKAUvpfOXSjYy3o5_FPmg-1; Tue, 09 Jun 2020 13:07:58 -0400
X-MC-Unique: DqKAUvpfOXSjYy3o5_FPmg-1
Received: by mail-wr1-f70.google.com with SMTP id h6so8913847wrx.4
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 10:07:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=l1FNMSzdxkTmtGs96MOlFxksQhCZtICy60TUvMz4Bw8=;
 b=UgwH3ZOFinzsmZlFCzFa0iKMY5pIPL42ZUmokhGmIyvUE7EXqcCpoIaZrKTwTpnX0A
 zeHwwjqfFJZvazLkfdnxDubaSPzH1nf/WKu9A1MsD7GfSXzFFQWJryn96ruXXx0tjPft
 v3UXQG7dChijIKC09vbFq1pqopsNh5TwkJ3+9tdzhconrdLoHzkZL00sSN9DFZUMdtB+
 d16RM0A3iBxhIIULgF3cuptvMhlynkLB2zjt+Uy08/076HKsGlZfGr3O4jUntNWBMZ2r
 stlubbGDakSCBGMI4/WfQSeJVQ2+OuVZuqjoZxlrUoJHza+41B1e/oFp9PXLijyDgkDL
 8mEw==
X-Gm-Message-State: AOAM532GrpxjFmrHKSwvP0tNY2k31rgwo7X+9PelQfRMsMRrC245XVZt
 srpShjVQ5LSirNQx8FTYZswdFTYXU/vCn1CladNp7xS3pXTDE2Wrwjfu0gyCKElIri/ZNSa1F4O
 dx/bfDWj2hHSbD84=
X-Received: by 2002:a05:6000:10d2:: with SMTP id
 b18mr5488103wrx.366.1591722473635; 
 Tue, 09 Jun 2020 10:07:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyx+or+ybnKrmibafZ+Zx5rFyOofLgppbqZQhSlVO4Q548GL5ihPzz6IEjcwQSbBYgFW9U+Mw==
X-Received: by 2002:a05:6000:10d2:: with SMTP id
 b18mr5488088wrx.366.1591722473413; 
 Tue, 09 Jun 2020 10:07:53 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id t129sm3907474wmf.41.2020.06.09.10.07.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 10:07:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v8 5/5] crypto/tls-cipher-suites: Produce fw_cfg consumable
 blob
Date: Tue,  9 Jun 2020 19:07:27 +0200
Message-Id: <20200609170727.9977-6-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200609170727.9977-1-philmd@redhat.com>
References: <20200609170727.9977-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 02:41:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since our format is consumable by the fw_cfg device,
we can implement the FW_CFG_DATA_GENERATOR interface.

Acked-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
v8: Add example in qemu-options.hx
---
 crypto/tls-cipher-suites.c | 19 +++++++++++++++++++
 qemu-options.hx            | 19 +++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/crypto/tls-cipher-suites.c b/crypto/tls-cipher-suites.c
index f02a041f9a..d6ea0ed190 100644
--- a/crypto/tls-cipher-suites.c
+++ b/crypto/tls-cipher-suites.c
@@ -14,6 +14,7 @@
 #include "qemu/error-report.h"
 #include "crypto/tlscreds.h"
 #include "crypto/tls-cipher-suites.h"
+#include "hw/nvram/fw_cfg.h"
 #include "trace.h"
 
 static void parse_cipher_suites(QCryptoTLSCipherSuites *s,
@@ -99,11 +100,28 @@ static void qcrypto_tls_cipher_suites_finalize(Object *obj)
     g_free(s->cipher_list);
 }
 
+static const void *qcrypto_tls_cipher_suites_get_data(Object *obj)
+{
+    QCryptoTLSCipherSuites *s = QCRYPTO_TLS_CIPHER_SUITES(obj);
+
+    return s->cipher_list;
+}
+
+static size_t qcrypto_tls_cipher_suites_get_length(Object *obj)
+{
+    QCryptoTLSCipherSuites *s = QCRYPTO_TLS_CIPHER_SUITES(obj);
+
+    return s->cipher_count * sizeof(IANA_TLS_CIPHER);
+}
+
 static void qcrypto_tls_cipher_suites_class_init(ObjectClass *oc, void *data)
 {
     UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
+    FWCfgDataGeneratorClass *fwgc = FW_CFG_DATA_GENERATOR_CLASS(oc);
 
     ucc->complete = qcrypto_tls_cipher_suites_complete;
+    fwgc->get_data = qcrypto_tls_cipher_suites_get_data;
+    fwgc->get_length = qcrypto_tls_cipher_suites_get_length;
 }
 
 static const TypeInfo qcrypto_tls_cipher_suites_info = {
@@ -115,6 +133,7 @@ static const TypeInfo qcrypto_tls_cipher_suites_info = {
     .class_init = qcrypto_tls_cipher_suites_class_init,
     .interfaces = (InterfaceInfo[]) {
         { TYPE_USER_CREATABLE },
+        { TYPE_FW_CFG_DATA_GENERATOR_INTERFACE },
         { }
     }
 };
diff --git a/qemu-options.hx b/qemu-options.hx
index c74366d7cc..b12cc910e3 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4585,6 +4585,25 @@ SRST
         string as described at
         https://gnutls.org/manual/html_node/Priority-Strings.html.
 
+        An example of use of this object is to enable the UEFI HTTPS Boot.
+        The tls-cipher-suites object exposes the ordered list of permitted
+        TLS cipher suites from the host side to the firmware, via
+        fw_cfg. The list is represented as an array of IANA_TLS_CIPHER
+        objects. The firmware uses the IANA_TLS_CIPHER array for configuring
+        guest-side TLS.
+
+        In the following example, the priority at which the host-side policy
+        is retrieved is given by the ``priority`` property of the new object
+        type. ``priority=@SYSTEM`` may be used to refer to
+        /etc/crypto-policies/back-ends/gnutls.config (given that QEMU uses
+        GNUTLS).
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


