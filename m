Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B5CC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:40:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E5742075B
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UN8T5TB7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E5742075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVcGv-0008FR-By
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 10:40:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVc6i-0006Mm-Co
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:30:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24436
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVc6h-0006Ws-5M
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:30:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588602606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bo79CUgFM2z6ABK0rxVoGCIfB5lUV00d4CJDYbtIRA8=;
 b=UN8T5TB74ZENRqE4sCO3dl37OPXi6A/pEsfImV6nfN9vn00v/CDvbczMbDhTFAFgyhOXte
 ycbj/ZAmtBzKIkdREVNeyRt9VYhjLf4liP8sHg8qGJlCZZbWHGkqrA1bi6ZzbKB46WAKDW
 wr2R5SgfcfkLTDQDyCYtM1PxoehGXGE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273--G4p8jyWPRqaM4Kw39wxog-1; Mon, 04 May 2020 10:30:04 -0400
X-MC-Unique: -G4p8jyWPRqaM4Kw39wxog-1
Received: by mail-wr1-f72.google.com with SMTP id s11so10856757wru.6
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 07:30:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=HiyhWJdustdM3N2mnLTkt5fy7WWcO4+CQ1UxAjOBv98=;
 b=Pg9iOuwVrYT51VKVZK7zoSAjtKNeNK6p0dIGYg93gZdsBE9ZtJ0hr90bN7zceztvyg
 2Gy/cCxfSMd56tYweFFD4t+Jih3lfBI9KeBZX7clNDwBUk/wz1elyuFBWaMvvGpomU6w
 1nS6ALa0RNr1qY6nGIqm08U0wRnSnwXPY7HVtDcYN0RkqTMEON4Yqw44Bq42R9x/lqYj
 l4lMEFoME5q3RvfMAc7kCCANHDFumfco1iogOkRz/35RE3mKCI2Ee3yNyTmdKm0sc1YL
 5Utit3O9K3PPqrLJsecosLBww5FUt/j5kPy4u+28DWpe5uMA59BLxwQh+dLulJJaKUhO
 CrBA==
X-Gm-Message-State: AGi0Pubji8Y3HyO9qjBvs0fCaqrqheNjdIaNG1IQSE/+flmnPom+pjuX
 jOIX1cAZfsOsCu3Lsg4+/9kW9qECHm1bcaYvL39l+MA5TNoOcjeB8NjQ1VM4z9HDA++9fMxq3DS
 t2Z/mEWOqh3HvGVE=
X-Received: by 2002:a1c:4144:: with SMTP id o65mr15910856wma.78.1588602603432; 
 Mon, 04 May 2020 07:30:03 -0700 (PDT)
X-Google-Smtp-Source: APiQypLim1edNF80L0cZwXOI7K/OFPfqaN9QEVcjl1bYJN0DUOPfu02dwcmY59NoQ14JKrR1XqF0Gg==
X-Received: by 2002:a1c:4144:: with SMTP id o65mr15910834wma.78.1588602603265; 
 Mon, 04 May 2020 07:30:03 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
 by smtp.gmail.com with ESMTPSA id
 138sm14799517wmb.14.2020.05.04.07.30.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 07:30:02 -0700 (PDT)
Date: Mon, 4 May 2020 10:30:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 20/29] bios-tables-test: test pc-dimm and nvdimm coldplug for
 arm/virt
Message-ID: <20200504142814.157589-21-mst@redhat.com>
References: <20200504142814.157589-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200504142814.157589-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 05:09:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

Since we now have both pc-dimm and nvdimm support, update
test_acpi_virt_tcg_memhp() to include those.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Message-Id: <20200421125934.14952-7-shameerali.kolothum.thodi@huawei.com>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.=
c
index 0a597bbacf..c9843829b3 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -927,12 +927,17 @@ static void test_acpi_virt_tcg_memhp(void)
     };
=20
     data.variant =3D ".memhp";
-    test_acpi_one(" -cpu cortex-a57"
+    test_acpi_one(" -machine nvdimm=3Don"
+                  " -cpu cortex-a57"
                   " -m 256M,slots=3D3,maxmem=3D1G"
                   " -object memory-backend-ram,id=3Dram0,size=3D128M"
                   " -object memory-backend-ram,id=3Dram1,size=3D128M"
                   " -numa node,memdev=3Dram0 -numa node,memdev=3Dram1"
-                  " -numa dist,src=3D0,dst=3D1,val=3D21",
+                  " -numa dist,src=3D0,dst=3D1,val=3D21"
+                  " -object memory-backend-ram,id=3Dram2,size=3D128M"
+                  " -object memory-backend-ram,id=3Dnvm0,size=3D128M"
+                  " -device pc-dimm,id=3Ddimm0,memdev=3Dram2,node=3D0"
+                  " -device nvdimm,id=3Ddimm1,memdev=3Dnvm0,node=3D1",
                   &data);
=20
     free_test_data(&data);
--=20
MST


