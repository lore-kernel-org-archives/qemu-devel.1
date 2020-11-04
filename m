Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B3B6C388F7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 08:44:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0151C21556
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 08:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BqqsdnRD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0151C21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaEPU-0008Jj-Sc
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 03:44:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46512)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kaEOO-0006ev-Kr
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 03:43:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40079)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kaEOL-0005ta-5u
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 03:43:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604479419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tGrjmCEXBoBaCsyPVGeYrGNhz2JCmoDnznUDdTUcGTA=;
 b=BqqsdnRDPElx6Jf2T3KPAoen7j/3Jd6w7vPlnIGWGXjiYdoXEAwQpMqWO5vlpRpdkPYfSz
 4u6+BwDTAD1B84YSFz1x/CXszOZE/jGiY3y2Jq2d1liZgBL9X9E/FSdkuh5HVxo7W8CfO1
 /4k9UuMYcu8rMwwkOUqQdtyqiRRXh08=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-_N_3a-8oPTCIBrGPFs-AUA-1; Wed, 04 Nov 2020 03:43:37 -0500
X-MC-Unique: _N_3a-8oPTCIBrGPFs-AUA-1
Received: by mail-wr1-f70.google.com with SMTP id 31so8941277wrg.12
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 00:43:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tGrjmCEXBoBaCsyPVGeYrGNhz2JCmoDnznUDdTUcGTA=;
 b=TgRjXw9QTuJI+uUv/4LOsWA04eu+SEJiVof630xEAMCBc3wWpU50pMv6inKgp75Lyh
 stX+M99iRrd6z7bSCx41kQv4BSL58EpiaxxrRGnGNSwrMt5Cfc30VdjwtTk0KZBQH34s
 9xL3vxHKbpLQwXIam25sN8zjCeXRVHu0sVCguE/HKAZAHou9cd/sPsbVo0BIxZSZ1wVd
 AMLXxn+jmmiTrEMbLaVbAMtuxcbJnaOO2fYZWLignnR/QDxRUwDGK/CyMoyVcl4CjlE/
 KBJXJf8APU62azxNO/bkLgfHpF0JUZAGmg2u12WK/v1rcExdUa+KkEvF6XCYZbmR4NAD
 6ssw==
X-Gm-Message-State: AOAM533GzIds8vViaYYqrnB6bfhOYQF9hgVLFL31p25LAE3RUwKWON36
 /lPWHGo/fDiO9/vUEpFjwThxbvR4SkllM0n92dHNhoHX9TrGXWTadBIfyq5Q5HNotBZQSxYRNXl
 9k5QrW6eIPZgcAnI=
X-Received: by 2002:a1c:328a:: with SMTP id y132mr3270205wmy.134.1604479416178; 
 Wed, 04 Nov 2020 00:43:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzAKBMbrYMVmfktTukMP82vBC6mMWUm7JJP3Ip5nEjHwOa1kocaNQENSOogMMSxmOQs/LYjew==
X-Received: by 2002:a1c:328a:: with SMTP id y132mr3270172wmy.134.1604479415976; 
 Wed, 04 Nov 2020 00:43:35 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id m4sm1513423wrr.47.2020.11.04.00.43.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2020 00:43:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 v2 1/4] s390x: fix build for --without-default-devices
Date: Wed,  4 Nov 2020 09:43:24 +0100
Message-Id: <20201104084327.3010593-2-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201104084327.3010593-1-philmd@redhat.com>
References: <20201104084327.3010593-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Cornelia Huck <cohuck@redhat.com>

s390-pci-vfio.c calls into the vfio code, so we need it to be
built conditionally on vfio (which implies CONFIG_LINUX).

Reported-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Fixes: cd7498d07fbb ("s390x/pci: Add routine to get the vfio dma available count")
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20201103123237.718242-1-cohuck@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/hw/s390x/s390-pci-vfio.h | 3 ++-
 hw/s390x/meson.build             | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/hw/s390x/s390-pci-vfio.h b/include/hw/s390x/s390-pci-vfio.h
index c7984905b3b..ff708aef500 100644
--- a/include/hw/s390x/s390-pci-vfio.h
+++ b/include/hw/s390x/s390-pci-vfio.h
@@ -13,8 +13,9 @@
 #define HW_S390_PCI_VFIO_H
 
 #include "hw/s390x/s390-pci-bus.h"
+#include CONFIG_DEVICES
 
-#ifdef CONFIG_LINUX
+#ifdef CONFIG_VFIO
 bool s390_pci_update_dma_avail(int fd, unsigned int *avail);
 S390PCIDMACount *s390_pci_start_dma_count(S390pciState *s,
                                           S390PCIBusDevice *pbdev);
diff --git a/hw/s390x/meson.build b/hw/s390x/meson.build
index f4663a83551..2a7818d94b9 100644
--- a/hw/s390x/meson.build
+++ b/hw/s390x/meson.build
@@ -27,7 +27,7 @@
 ))
 s390x_ss.add(when: 'CONFIG_S390_CCW_VIRTIO', if_true: files('s390-virtio-ccw.c'))
 s390x_ss.add(when: 'CONFIG_TERMINAL3270', if_true: files('3270-ccw.c'))
-s390x_ss.add(when: 'CONFIG_LINUX', if_true: files('s390-pci-vfio.c'))
+s390x_ss.add(when: 'CONFIG_VFIO', if_true: files('s390-pci-vfio.c'))
 
 virtio_ss = ss.source_set()
 virtio_ss.add(files('virtio-ccw.c'))
-- 
2.26.2


