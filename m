Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C935C47423
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:38:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E948420936
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XCcUx1y0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E948420936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNADq-0001bV-2O
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 03:38:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57590)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9xh-0003iF-8z
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:22:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40954)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9xe-0001h5-9v
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:22:08 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601364125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K2sWzSHYFBhWaJIWswBrHcBoYnbw0ENAiy7UBKlgPck=;
 b=XCcUx1y0pUUNptmG3PrGLdHj/mw/ZN0diyJqsUA3plT6kKAQgdx7ZHeNKW0eNUJf9t2wOP
 yDYV55D/Q3BTK98Pua/selkLauJfoSihm9oGonxgHHL2sqwR4YHeqQqxHst2i2JRUxCRCp
 tgxAA7X5q4ybBJHTJ87ooOotDRGGhnY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-547-qJvo2m7UNPi9DufKStQlGA-1; Tue, 29 Sep 2020 03:22:01 -0400
X-MC-Unique: qJvo2m7UNPi9DufKStQlGA-1
Received: by mail-wr1-f70.google.com with SMTP id l17so1348162wrw.11
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 00:22:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=K2sWzSHYFBhWaJIWswBrHcBoYnbw0ENAiy7UBKlgPck=;
 b=TZJhtOXl7Ezuc1kbuIX5dCQ05IYdB7HKBdKI32/aVJ07kABCthB4W2nsP9YKa/tI6g
 KwMX8lN0kEhQfnGmTMBE7PC5I6E480XX1ptR1QETpUFObivDQD/dUo8TaggDFvnrDTII
 LkZC4QptDTnL/NgCLTy/yUzFmqXcojdvhDhss/09/WMKb6LQAQaWYKbqKx9mxCA54TEB
 t1I7CI4vrbhV0VyAG3bHCnNmOjIz9LuHEYZRglikiZ0b1VRnn9KxXbbmCJIHUNw0qwS/
 xvOxEMAgQ1xp4gD2j3LTz/AOMPBCKkMrVPp272DjBp8TAwV/Skxmw0JMjkWh3a7G9o3Y
 147A==
X-Gm-Message-State: AOAM531nDPtW5idpdcp0u67bPNzZ6LwAUVUueNXEYO7dPVgj65U2Smup
 2WikDGHzFwMXWKVUg+tL7KouvhmPVuCT4TAZzHSqvHdwCvZ2Qbzqg/5hSMl4eTiQg2h7NMKdxbw
 0DUeXhBgKX1XhsDo=
X-Received: by 2002:adf:e9c3:: with SMTP id l3mr2485766wrn.63.1601364119528;
 Tue, 29 Sep 2020 00:21:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJywpyL3jXSndifgJ/2y722aDku1tstFmHwXmmlwH2yBBcf+5wLsMDRFHIkhtb7X6kjutcPYrw==
X-Received: by 2002:adf:e9c3:: with SMTP id l3mr2485750wrn.63.1601364119384;
 Tue, 29 Sep 2020 00:21:59 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id q15sm4538505wrr.8.2020.09.29.00.21.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 00:21:58 -0700 (PDT)
Date: Tue, 29 Sep 2020 03:21:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v4 24/48] acpi: add aml_land() and aml_break() primitives
Message-ID: <20200929071948.281157-25-mst@redhat.com>
References: <20200929071948.281157-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200929071948.281157-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 02:22:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Mammedov <imammedo@redhat.com>

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Tested-by: Laszlo Ersek <lersek@redhat.com>
Message-Id: <20200923094650.1301166-5-imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/acpi/aml-build.h |  2 ++
 hw/acpi/aml-build.c         | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index d27da03d64..fe0055fffb 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -290,6 +290,7 @@ Aml *aml_to_buffer(Aml *src, Aml *dst);
 Aml *aml_store(Aml *val, Aml *target);
 Aml *aml_and(Aml *arg1, Aml *arg2, Aml *dst);
 Aml *aml_or(Aml *arg1, Aml *arg2, Aml *dst);
+Aml *aml_land(Aml *arg1, Aml *arg2);
 Aml *aml_lor(Aml *arg1, Aml *arg2);
 Aml *aml_shiftleft(Aml *arg1, Aml *count);
 Aml *aml_shiftright(Aml *arg1, Aml *count, Aml *dst);
@@ -300,6 +301,7 @@ Aml *aml_increment(Aml *arg);
 Aml *aml_decrement(Aml *arg);
 Aml *aml_index(Aml *arg1, Aml *idx);
 Aml *aml_notify(Aml *arg1, Aml *arg2);
+Aml *aml_break(void);
 Aml *aml_call0(const char *method);
 Aml *aml_call1(const char *method, Aml *arg1);
 Aml *aml_call2(const char *method, Aml *arg1, Aml *arg2);
diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index f6fbc9b95d..3792ba96ce 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -556,6 +556,15 @@ Aml *aml_or(Aml *arg1, Aml *arg2, Aml *dst)
     return build_opcode_2arg_dst(0x7D /* OrOp */, arg1, arg2, dst);
 }
 
+/* ACPI 1.0b: 16.2.5.4 Type 2 Opcodes Encoding: DefLAnd */
+Aml *aml_land(Aml *arg1, Aml *arg2)
+{
+    Aml *var = aml_opcode(0x90 /* LAndOp */);
+    aml_append(var, arg1);
+    aml_append(var, arg2);
+    return var;
+}
+
 /* ACPI 1.0b: 16.2.5.4 Type 2 Opcodes Encoding: DefLOr */
 Aml *aml_lor(Aml *arg1, Aml *arg2)
 {
@@ -629,6 +638,13 @@ Aml *aml_notify(Aml *arg1, Aml *arg2)
     return var;
 }
 
+/* ACPI 1.0b: 16.2.5.3 Type 1 Opcodes Encoding: DefBreak */
+Aml *aml_break(void)
+{
+    Aml *var = aml_opcode(0xa5 /* BreakOp */);
+    return var;
+}
+
 /* helper to call method without argument */
 Aml *aml_call0(const char *method)
 {
-- 
MST


