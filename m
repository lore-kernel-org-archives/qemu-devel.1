Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C7CC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 23:13:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0679206F7
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 23:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gN7aLmEr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0679206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joEZx-0003Cx-4R
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 19:13:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1joETy-0000N6-BV
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 19:07:06 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26865
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1joETw-0001Vk-Go
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 19:07:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593040023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XlFSgiVnedcPbHMPcza92pu5ADeDm2yfx70RS10qWhY=;
 b=gN7aLmEre2CHmt2pxcmHmMc/YoE2pYMOYmlye6z1rGHmfmw6cupXyImuFEV6kS4pYo+IJ3
 o6PTHgW4zE2oCwWiwlky4kELbpVheDJ0tIEymGocYTRR81+S5uljtV9NhbaGzIc3utqo9k
 8/UUIrs1oIFj0huX7wdKqSA175hswVk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-aLzSSXkwMSWJuh8zl_AE0w-1; Wed, 24 Jun 2020 19:07:01 -0400
X-MC-Unique: aLzSSXkwMSWJuh8zl_AE0w-1
Received: by mail-wr1-f69.google.com with SMTP id g14so4715533wrp.8
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 16:07:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=XlFSgiVnedcPbHMPcza92pu5ADeDm2yfx70RS10qWhY=;
 b=ENp9Z/L7unfLYCqx+nNTWo0sbqDw9IvSfYu4aZsE3iJnNS34WkYEW2VIRDzpSdPC7M
 kxeZf1xrTDrHzX5CWjapYehEyM4nlpO5Ic4fLbBqFifqOeyboyhsREFHjZ7hxYd8EvDw
 hhPmlzytCQIfEEFdD+71OP5UDempjzmDAsOiHAZBSGcdc3grrMyvO06SHy1ALaCUNLyu
 Oo184i8V8K+omiAzGynOdbpmcH1gvL2uRxEwrpQ8lsJzlM/6XxNIwQxDhHRieozlU09+
 0ezbMN4P1J4Ch4uQVq4i8pyAgaUvxPg/Mq68u3Wh5RG3Jb23n6XQozE1aicgeVwynHly
 ItiQ==
X-Gm-Message-State: AOAM532fo3/EhUJI5xCbY5U4IleWBs+HQfZ5qN8hET0J3vIx86keyQoy
 CaVpLc5UAa3ZOwJT6OXNGXFVC8xBK4d9LOUVAiKfMQncxODUoptxPyAATxutobs959iCqbrewTe
 F9cs6CP2vuVVq7dM=
X-Received: by 2002:a1c:7e52:: with SMTP id z79mr133112wmc.104.1593040020375; 
 Wed, 24 Jun 2020 16:07:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy/+ly/FKD5+cQ9M7V0rzjx9wLH+MmfnUk2RtTQjBDo/b4nnBiXpwDJKCGheg8UipldjpnlAg==
X-Received: by 2002:a1c:7e52:: with SMTP id z79mr133087wmc.104.1593040020149; 
 Wed, 24 Jun 2020 16:07:00 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 q1sm14484983wro.82.2020.06.24.16.06.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2020 16:06:59 -0700 (PDT)
Date: Wed, 24 Jun 2020 19:06:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 11/19] acpi: q35: drop _SB.PCI0.ISA.LPCD opregion.
Message-ID: <20200624230609.703104-12-mst@redhat.com>
References: <20200624230609.703104-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200624230609.703104-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 00:34:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

Seems to be unused.

ich9 DSDT changes:

     Scope (_SB.PCI0)
     {
         Device (ISA)
         {
             Name (_ADR, 0x001F0000)  // _ADR: Address
             OperationRegion (PIRQ, PCI_Config, 0x60, 0x0C)
-            OperationRegion (LPCD, PCI_Config, 0x80, 0x02)
-            Field (LPCD, AnyAcc, NoLock, Preserve)
-            {
-                COMA,   3,
-                    ,   1,
-                COMB,   3,
-                Offset (0x01),
-                LPTD,   2
-            }
         }
     }

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20200619091905.21676-12-kraxel@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/acpi-build.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 59f1b4d890..378515df66 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1340,7 +1340,6 @@ static void build_q35_isa_bridge(Aml *table)
 {
     Aml *dev;
     Aml *scope;
-    Aml *field;
 
     scope =  aml_scope("_SB.PCI0");
     dev = aml_device("ISA");
@@ -1350,16 +1349,6 @@ static void build_q35_isa_bridge(Aml *table)
     aml_append(dev, aml_operation_region("PIRQ", AML_PCI_CONFIG,
                                          aml_int(0x60), 0x0C));
 
-    aml_append(dev, aml_operation_region("LPCD", AML_PCI_CONFIG,
-                                         aml_int(0x80), 0x02));
-    field = aml_field("LPCD", AML_ANY_ACC, AML_NOLOCK, AML_PRESERVE);
-    aml_append(field, aml_named_field("COMA", 3));
-    aml_append(field, aml_reserved_field(1));
-    aml_append(field, aml_named_field("COMB", 3));
-    aml_append(field, aml_reserved_field(1));
-    aml_append(field, aml_named_field("LPTD", 2));
-    aml_append(dev, field);
-
     aml_append(scope, dev);
     aml_append(table, scope);
 }
-- 
MST


