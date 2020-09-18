Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27EBBC43465
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 20:56:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B89221741
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 20:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eC3fVDMI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B89221741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJNQp-0007MD-9C
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 16:56:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kJNI7-0002ck-Ny
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 16:47:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44020)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kJNHv-0006Fy-TJ
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 16:47:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600462043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dMkREXu3O51Oc94RWLTL6PmoyQuNR6EO5v7agZ1eleg=;
 b=eC3fVDMIpQF50YikuyKNFzj8h6iuDU7dkULtPtL/EHgAYqePjT3U+YxK3r3EWZHdeUWbkH
 5Z0us+wZZM8JgTk3PqrAJTnWP4FEiVayKDCdY1i7QNGNqP8ayVySGFXilSKg4cYlhVVjG3
 A2iW0KkPKCY7JnY8czrUoEgrw9uuuUI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-TWD-VXMUP5W33Ubsy2xSJA-1; Fri, 18 Sep 2020 16:47:20 -0400
X-MC-Unique: TWD-VXMUP5W33Ubsy2xSJA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DFE36800C78;
 Fri, 18 Sep 2020 20:47:19 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9FDAE7881F;
 Fri, 18 Sep 2020 20:47:19 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 04/17] sifive: Use DECLARE_*CHECKER* macros
Date: Fri, 18 Sep 2020 16:47:01 -0400
Message-Id: <20200918204714.27276-5-ehabkost@redhat.com>
In-Reply-To: <20200918204714.27276-1-ehabkost@redhat.com>
References: <20200918204714.27276-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 00:20:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

 $ ./scripts/codeconverter/converter.py -i \
   --pattern=TypeCheckMacro $(git grep -l '' -- '*.[ch]')

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20200831210740.126168-12-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/intc/sifive_plic.h           | 4 ++--
 include/hw/char/sifive_uart.h   | 4 ++--
 include/hw/gpio/sifive_gpio.h   | 3 ++-
 include/hw/misc/sifive_e_prci.h | 4 ++--
 include/hw/misc/sifive_test.h   | 4 ++--
 include/hw/misc/sifive_u_otp.h  | 4 ++--
 include/hw/misc/sifive_u_prci.h | 4 ++--
 7 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/hw/intc/sifive_plic.h b/hw/intc/sifive_plic.h
index aa6ae13c3a..b75b1f145d 100644
--- a/hw/intc/sifive_plic.h
+++ b/hw/intc/sifive_plic.h
@@ -27,8 +27,8 @@
 #define TYPE_SIFIVE_PLIC "riscv.sifive.plic"
 
 typedef struct SiFivePLICState SiFivePLICState;
-#define SIFIVE_PLIC(obj) \
-    OBJECT_CHECK(SiFivePLICState, (obj), TYPE_SIFIVE_PLIC)
+DECLARE_INSTANCE_CHECKER(SiFivePLICState, SIFIVE_PLIC,
+                         TYPE_SIFIVE_PLIC)
 
 typedef enum PLICMode {
     PLICMode_U,
diff --git a/include/hw/char/sifive_uart.h b/include/hw/char/sifive_uart.h
index 2bb72ac80b..3e962be659 100644
--- a/include/hw/char/sifive_uart.h
+++ b/include/hw/char/sifive_uart.h
@@ -53,8 +53,8 @@ enum {
 #define TYPE_SIFIVE_UART "riscv.sifive.uart"
 
 typedef struct SiFiveUARTState SiFiveUARTState;
-#define SIFIVE_UART(obj) \
-    OBJECT_CHECK(SiFiveUARTState, (obj), TYPE_SIFIVE_UART)
+DECLARE_INSTANCE_CHECKER(SiFiveUARTState, SIFIVE_UART,
+                         TYPE_SIFIVE_UART)
 
 struct SiFiveUARTState {
     /*< private >*/
diff --git a/include/hw/gpio/sifive_gpio.h b/include/hw/gpio/sifive_gpio.h
index af991fa44e..fc53785c9d 100644
--- a/include/hw/gpio/sifive_gpio.h
+++ b/include/hw/gpio/sifive_gpio.h
@@ -19,7 +19,8 @@
 
 #define TYPE_SIFIVE_GPIO "sifive_soc.gpio"
 typedef struct SIFIVEGPIOState SIFIVEGPIOState;
-#define SIFIVE_GPIO(obj) OBJECT_CHECK(SIFIVEGPIOState, (obj), TYPE_SIFIVE_GPIO)
+DECLARE_INSTANCE_CHECKER(SIFIVEGPIOState, SIFIVE_GPIO,
+                         TYPE_SIFIVE_GPIO)
 
 #define SIFIVE_GPIO_PINS 32
 
diff --git a/include/hw/misc/sifive_e_prci.h b/include/hw/misc/sifive_e_prci.h
index de1e502eea..262ca16181 100644
--- a/include/hw/misc/sifive_e_prci.h
+++ b/include/hw/misc/sifive_e_prci.h
@@ -53,8 +53,8 @@ enum {
 #define TYPE_SIFIVE_E_PRCI      "riscv.sifive.e.prci"
 
 typedef struct SiFiveEPRCIState SiFiveEPRCIState;
-#define SIFIVE_E_PRCI(obj) \
-    OBJECT_CHECK(SiFiveEPRCIState, (obj), TYPE_SIFIVE_E_PRCI)
+DECLARE_INSTANCE_CHECKER(SiFiveEPRCIState, SIFIVE_E_PRCI,
+                         TYPE_SIFIVE_E_PRCI)
 
 struct SiFiveEPRCIState {
     /*< private >*/
diff --git a/include/hw/misc/sifive_test.h b/include/hw/misc/sifive_test.h
index dc54b7af0c..88a38d00c5 100644
--- a/include/hw/misc/sifive_test.h
+++ b/include/hw/misc/sifive_test.h
@@ -25,8 +25,8 @@
 #define TYPE_SIFIVE_TEST "riscv.sifive.test"
 
 typedef struct SiFiveTestState SiFiveTestState;
-#define SIFIVE_TEST(obj) \
-    OBJECT_CHECK(SiFiveTestState, (obj), TYPE_SIFIVE_TEST)
+DECLARE_INSTANCE_CHECKER(SiFiveTestState, SIFIVE_TEST,
+                         TYPE_SIFIVE_TEST)
 
 struct SiFiveTestState {
     /*< private >*/
diff --git a/include/hw/misc/sifive_u_otp.h b/include/hw/misc/sifive_u_otp.h
index 4572534f50..82c9176c8f 100644
--- a/include/hw/misc/sifive_u_otp.h
+++ b/include/hw/misc/sifive_u_otp.h
@@ -51,8 +51,8 @@
 #define TYPE_SIFIVE_U_OTP           "riscv.sifive.u.otp"
 
 typedef struct SiFiveUOTPState SiFiveUOTPState;
-#define SIFIVE_U_OTP(obj) \
-    OBJECT_CHECK(SiFiveUOTPState, (obj), TYPE_SIFIVE_U_OTP)
+DECLARE_INSTANCE_CHECKER(SiFiveUOTPState, SIFIVE_U_OTP,
+                         TYPE_SIFIVE_U_OTP)
 
 struct SiFiveUOTPState {
     /*< private >*/
diff --git a/include/hw/misc/sifive_u_prci.h b/include/hw/misc/sifive_u_prci.h
index 83eab43686..d9ebf40b7f 100644
--- a/include/hw/misc/sifive_u_prci.h
+++ b/include/hw/misc/sifive_u_prci.h
@@ -60,8 +60,8 @@
 #define TYPE_SIFIVE_U_PRCI      "riscv.sifive.u.prci"
 
 typedef struct SiFiveUPRCIState SiFiveUPRCIState;
-#define SIFIVE_U_PRCI(obj) \
-    OBJECT_CHECK(SiFiveUPRCIState, (obj), TYPE_SIFIVE_U_PRCI)
+DECLARE_INSTANCE_CHECKER(SiFiveUPRCIState, SIFIVE_U_PRCI,
+                         TYPE_SIFIVE_U_PRCI)
 
 struct SiFiveUPRCIState {
     /*< private >*/
-- 
2.26.2


