Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9700FC43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:30:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B9FF206D3
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E3fAQ5rM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B9FF206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igoZg-00012x-VO
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 06:30:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51257)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1igoG0-00088k-9k
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1igoFz-0000FD-1s
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:44 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:52505)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1igoFy-0000Ea-P0
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:42 -0500
Received: by mail-wm1-x334.google.com with SMTP id p9so6267511wmc.2
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 03:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=wi/6WNBxanhHv1N5BExE4AXQCOcHHg7jTThmTTrFuxQ=;
 b=E3fAQ5rMQqlRQ9i4FQQsIxXvkz4kn9TgzZejAjUVtx/8JRNY4xZc73bvqFyxzLhhbP
 1R7DbAXzszwvGyxy+ZPeaeYcUfuxu7LH8aPzSRlGM+SjyHmlNJjxL+JdJv3cDX03Zh/o
 FgZz7NwfOKOmAamu1cmElumik801kRe242CDCD52vPhTzUb1ynG/IFNrL91XZZiMLIWO
 pYSyEqh64aJpbuUjctJUVGJzT/4NndXOziAMWRECebvcA0/k1iAQTspkmql2gpM8dotE
 ay0ozQRYMSXAglHy9Ugp+1n1GnPRvs5jufVfy7CEoV6JBPItTygNimGsog8QeI9NFhgp
 0Pgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wi/6WNBxanhHv1N5BExE4AXQCOcHHg7jTThmTTrFuxQ=;
 b=XhKNSRONBqf8fesvrwvD6kdrxW7KxHQvH1vBuJdJE8HGZRBYbWvIOoagadznWcDgKm
 BRayoOQSrlaPoko7ReU0Uzkze4m3HRhjZNqe47UwZ1ue4UDcv+spAQalEiBKQzU6z7Qk
 5QnWbnFKnpByMFY+EBqoE4p5jhoCILf3Pnjvv18KIVvafr9YzuWhryrc1SnBI60kVMja
 9DqzZ4mHLMvm8y560xL1C+q7TPbf59r+zK9XAqLMuTpv+rUEdHc53RQUhq3FQnZ0WHlA
 wsMYp9tX4nD0lh0LzNkvXqQNNKCyelfFnXujl/3hhllSMAttnOX3EF7O0u6SDg1jJIHp
 H01w==
X-Gm-Message-State: APjAAAUwCUqQ3ScObwyclDA7q6/W6LujOQ4VEoBdJcV/rdHYt0P+S23q
 ZBVdkdwl1jrXFt//WSi1JZfU+NhE2i4Ptw==
X-Google-Smtp-Source: APXvYqyMEhI4I0MSbdf73r/sJFavTnfTTnDA9U6WkPPYsNAB8U2P5pi8tX0JKo5lQIIDCqWBeghOqw==
X-Received: by 2002:a05:600c:2509:: with SMTP id
 d9mr30448057wma.148.1576494581374; 
 Mon, 16 Dec 2019 03:09:41 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id x10sm20976131wrp.58.2019.12.16.03.09.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 03:09:40 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/34] hw/arm/acpi: enable SHPC native hot plug
Date: Mon, 16 Dec 2019 11:09:02 +0000
Message-Id: <20191216110904.30815-33-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216110904.30815-1-peter.maydell@linaro.org>
References: <20191216110904.30815-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::334
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Heyi Guo <guoheyi@huawei.com>

After the introduction of generic PCIe root port and PCIe-PCI bridge,
we will also have SHPC controller on ARM, so just enable SHPC native
hot plug.

Also update tests/data/acpi/virt/DSDT* to pass "make check".

Cc: Shannon Zhao <shannon.zhaosl@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Heyi Guo <guoheyi@huawei.com>
Message-id: 20191209063719.23086-3-guoheyi@huawei.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt-acpi-build.c          |   7 ++++++-
 tests/data/acpi/virt/DSDT         | Bin 18462 -> 18462 bytes
 tests/data/acpi/virt/DSDT.memhp   | Bin 19799 -> 19799 bytes
 tests/data/acpi/virt/DSDT.numamem | Bin 18462 -> 18462 bytes
 4 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 51b293e0a1e..bd5f771e9be 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -267,7 +267,12 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
         aml_create_dword_field(aml_arg(3), aml_int(8), "CDW3"));
     aml_append(ifctx, aml_store(aml_name("CDW2"), aml_name("SUPP")));
     aml_append(ifctx, aml_store(aml_name("CDW3"), aml_name("CTRL")));
-    aml_append(ifctx, aml_and(aml_name("CTRL"), aml_int(0x1D),
+
+    /*
+     * Allow OS control for all 5 features:
+     * PCIeHotplug SHPCHotplug PME AER PCIeCapability.
+     */
+    aml_append(ifctx, aml_and(aml_name("CTRL"), aml_int(0x1F),
                               aml_name("CTRL")));
 
     ifctx1 = aml_if(aml_lnot(aml_equal(aml_arg(1), aml_int(0x1))));
diff --git a/tests/data/acpi/virt/DSDT b/tests/data/acpi/virt/DSDT
index 05bcfc8a912f58f266aa906563ea01c24906717e..d0f3afeb134fdf1c11f64cd06dbcdd30be603b80 100644
GIT binary patch
delta 28
kcmbO?fpOjhMlP3Nmk>D*1_q{tja=*8809zbbW3Ff0C~9xM*si-

delta 28
kcmbO?fpOjhMlP3Nmk>D*1_q|2ja=*87-cu_bW3Ff0C~j-M*si-

diff --git a/tests/data/acpi/virt/DSDT.memhp b/tests/data/acpi/virt/DSDT.memhp
index c041a910fdf272cb89263bb636239ae3a5e1708d..41ccc6431b917252bcbaac86c33b340c796be5ce 100644
GIT binary patch
delta 28
kcmcaUi}Cs_MlP3NmymE@1_mbija=*8809zbbeqQp0Eq|*2mk;8

delta 28
kcmcaUi}Cs_MlP3NmymE@1_ma@ja=*87-cu_beqQp0ErX{2mk;8

diff --git a/tests/data/acpi/virt/DSDT.numamem b/tests/data/acpi/virt/DSDT.numamem
index 05bcfc8a912f58f266aa906563ea01c24906717e..d0f3afeb134fdf1c11f64cd06dbcdd30be603b80 100644
GIT binary patch
delta 28
kcmbO?fpOjhMlP3Nmk>D*1_q{tja=*8809zbbW3Ff0C~9xM*si-

delta 28
kcmbO?fpOjhMlP3Nmk>D*1_q|2ja=*87-cu_bW3Ff0C~j-M*si-

-- 
2.20.1


