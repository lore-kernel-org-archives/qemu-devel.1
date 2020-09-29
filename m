Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F12C4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:47:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65C8E2075E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H0fViuk7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65C8E2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNAMN-0004CZ-Ef
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 03:47:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57988)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9yJ-0004Ri-Pk
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:22:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54031)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9yF-0001o9-SE
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:22:47 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601364162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zwBBSwvnp/uHMth/6XAMYE24Sth7d+Ub4ffHdjOzwKw=;
 b=H0fViuk7JWEV06AW2euPT0Ba5bggX72y4Z6C0QKroVzFEugOjSX4Uze9lws2jQwC8jrB2v
 +JlMsHbP3HDSMhbYoEhotgNJNqw7+mrLnKWIgs9vqrvS8YmQEDMPbVH/u6jMNctfsoAtmb
 twTGE2x1ISAT9jfq6yauTtJ+apo+7c0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-HK5n4LLgNqWqNXJfQ4Utmw-1; Tue, 29 Sep 2020 03:22:37 -0400
X-MC-Unique: HK5n4LLgNqWqNXJfQ4Utmw-1
Received: by mail-wm1-f71.google.com with SMTP id t8so1351471wmj.6
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 00:22:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=zwBBSwvnp/uHMth/6XAMYE24Sth7d+Ub4ffHdjOzwKw=;
 b=s8McNpB2kDkM7QadsMfYtNvWY2WNMDyurDauxgxR95SjDfXmQlqsIJhoxaLUgL5MDz
 7NGsoYGBd4XXT02tmmVprheny80X4SgWfHI1NCKKAKtuJpM3ZnplD0NQ++F++F8LT2Wm
 oHu0iY0a58c4nhFHB5YCjMnMxzY7X80PsdvQ1WaS64GtV2zQLDzkQYc2WziirWugNwpR
 lIx69/bQnUG5zgD+buMJkuXihiRXfI4Hk4fZ22Ptk81vilWO1jQ2fA3jW+qxxFTl7/my
 ymDUgrq5MbbjzD9j77s2aMyy6TfeoeNXq7IKU/7RjNJETK6Ol7QJquEbEmSwTSHrd+6Q
 2Zmw==
X-Gm-Message-State: AOAM5310s0RiQS7Vo9OyAqjwyPp4tYV9rG0GrJ2XFQpBZssPlSYUXg8v
 8GLFygKuACb7FoHvBJgX949xJZ6wiODSr1spmlc+c+BemqLIpr1qPP5p209T+Zl4FVnFfIcDQxZ
 Ck/5Ql2h7RgFA/do=
X-Received: by 2002:a05:600c:4108:: with SMTP id
 j8mr3036085wmi.116.1601364156181; 
 Tue, 29 Sep 2020 00:22:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxVkflQFkMI0T0v4DxN0pRvScYtGlaEmJAv6HVCBNMrDl40IMFgJWcmwQiCx9tYJH5Gqh6wgQ==
X-Received: by 2002:a05:600c:4108:: with SMTP id
 j8mr3036063wmi.116.1601364155983; 
 Tue, 29 Sep 2020 00:22:35 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id c25sm4172675wml.31.2020.09.29.00.22.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 00:22:35 -0700 (PDT)
Date: Tue, 29 Sep 2020 03:22:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v4 38/48] Fix a gap where acpi_pcihp_find_hotplug_bus()
 returns a non-hotpluggable bus
Message-ID: <20200929071948.281157-39-mst@redhat.com>
References: <20200929071948.281157-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200929071948.281157-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 22:47:55
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
Cc: Ani Sinha <ani@anisinha.ca>, Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Ani Sinha <ani@anisinha.ca>

When ACPI hotplug for the root bus is disabled, the bsel property for that
bus is not set. Please see the following commit:

3d7e78aa7777f ("Introduce a new flag for i440fx to disable PCI hotplug on the
root bus").

As a result, when acpi_pcihp_find_hotplug_bus() is called
with bsel set to 0, it may return the root bus. This can cause devices
attached to the root bus to get hot-unplugged if the user issues the following
set of commmands:

outl 0xae10 0
outl 0xae08 your_slot

Thanks to Julia for pointing this out here:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg734548.html

In this patch, we fix the issue in this function by checking if the bus which
is returned by the function is actually hotpluggable. If not, we simply return
NULL. This avoids the scenario where we were returning a non-hotpluggable bus.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20200918084111.15339-5-ani@anisinha.ca>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/acpi/pcihp.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index 39b1f74442..32ae8b2c0a 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -147,6 +147,21 @@ static PCIBus *acpi_pcihp_find_hotplug_bus(AcpiPciHpState *s, int bsel)
     if (!bsel && !find.bus) {
         find.bus = s->root;
     }
+
+    /*
+     * Check if find.bus is actually hotpluggable. If bsel is set to
+     * NULL for example on the root bus in order to make it
+     * non-hotpluggable, find.bus will match the root bus when bsel
+     * is 0. See acpi_pcihp_test_hotplug_bus() above. Since the
+     * bus is not hotpluggable however, we should not select the bus.
+     * Instead, we should set find.bus to NULL in that case. In the check
+     * below, we generalize this case for all buses, not just the root bus.
+     * The callers of this function check for a null return value and
+     * handle them appropriately.
+     */
+    if (find.bus && !qbus_is_hotpluggable(BUS(find.bus))) {
+        find.bus = NULL;
+    }
     return find.bus;
 }
 
-- 
MST


