Return-Path: <SRS0=9ZvH=C5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA0E0C43463
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 11:47:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63A0420EDD
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 11:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7bIt4F4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63A0420EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJxoF-0002f5-2d
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 07:47:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46100)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kJxlX-0001ML-5X
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 07:44:23 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51271)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kJxlV-0000Ac-Fa
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 07:44:22 -0400
Received: by mail-wm1-x343.google.com with SMTP id w2so9446529wmi.1
 for <qemu-devel@nongnu.org>; Sun, 20 Sep 2020 04:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vFhP//g2kZUXZ+MAEt2Ablmdm9itVCJ1RZ3mPAAaqKM=;
 b=W7bIt4F4z6IiBy9m/LcKPgpOqz7FrN9GBpJuve00BFY9kXUb/mLfbBgoPvG81e+e1I
 PnmN8xdfVYhfolnL/Au7or3VYohzuyU+qgU61oKMiOuiLvML1lLLR1YrG8RyVOxhKkUD
 At2U1VxKyw0DDkZ3K8+6cgJOlgUg4G4X4ttSbnF28kWiWKEx5DCrAF0R6pwz7R/ksdxO
 R49LnJb7/kTrQSjtAggbyHcuKbCIapvd4GrEf6Jg/ZC7K9SP2Q6n0s35YN62z1rYuoYc
 YS7B1susGSIfY5Cjvl4LUE8YHWRaLM1Az0/VQh5o+hB66bh9DtXZa5BUW2dgmMDXj/bb
 3X+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=vFhP//g2kZUXZ+MAEt2Ablmdm9itVCJ1RZ3mPAAaqKM=;
 b=kxeMhHn9afFWJIddjNIXD52VNXTi1ikTPtRyBk9j+n4W4Jyp2k1M2Inhm2Eyk55D1p
 s/Q91YB+ct0XOu8MFUA7JgIIrp2TBj3VdTU1lMiIPd8IjKQzqo64LsxHZyaOCCSGCd6l
 YrKha1bgcB35tXzOkvE4ZuKXJ6L2ofZNAwM2UF/OWXsgnNgH7sTDHjuumkSte4XZ+1qO
 YSSihPAPDHjWcAAIg7FBJSp03SLerbbI3Z7akl37/6W1jRDEStWlA0Sgd0aZhWVrv/gR
 S7ZVMkR8hojffZ8R2/kQAo/PKrSohCMvef897dStFO7WUeLwjkkGiv5cD1ELTuXw4jqJ
 plCQ==
X-Gm-Message-State: AOAM530SZaXAErOje1ChhSPSU5H0cJyZyNs6CMqKkPmfxn24PuMunOmT
 k/P9uybyCYU3kv8ZtSyGBn8=
X-Google-Smtp-Source: ABdhPJyz0j5G6/Jn6raiSm4b4XBR2XD5rdMCO5YiUU0gweX8qLMIBsSFUJ0cLbs1Gh97QejA8lUIOw==
X-Received: by 2002:a1c:9c4b:: with SMTP id f72mr24727724wme.188.1600602260050; 
 Sun, 20 Sep 2020 04:44:20 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id e18sm16415708wra.36.2020.09.20.04.44.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2020 04:44:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 1/2] qdev: Document qbus_realize() and qbus_unrealize()
Date: Sun, 20 Sep 2020 13:44:15 +0200
Message-Id: <20200920114416.353277-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200920114416.353277-1-f4bug@amsat.org>
References: <20200920114416.353277-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Durrant <paul@xen.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 xen-devel@lists.xenproject.org, Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add some documentation for the qbus_realize() and qbus_unrealize()
functions introduced in commit 9940b2cfbc0.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/qdev-core.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index e025ba9653f..02ac1c50b7f 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -675,7 +675,19 @@ typedef int (qdev_walkerfn)(DeviceState *dev, void *opaque);
 void qbus_create_inplace(void *bus, size_t size, const char *typename,
                          DeviceState *parent, const char *name);
 BusState *qbus_create(const char *typename, DeviceState *parent, const char *name);
+/**
+ * qbus_realize: Realize a bus
+ * @bus: bus to realize
+ * @errp: pointer to error object
+ *
+ * On success, return true.
+ * On failure, store an error through @errp and return false.
+ */
 bool qbus_realize(BusState *bus, Error **errp);
+/**
+ * qbus_realize: Unrealize a bus
+ * @bus: bus to unrealize
+ */
 void qbus_unrealize(BusState *bus);
 
 /* Returns > 0 if either devfn or busfn skip walk somewhere in cursion,
-- 
2.26.2


