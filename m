Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52823C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 16:47:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A883720735
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 16:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SdovtGMT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A883720735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZzT0-000368-NU
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 11:47:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46592)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZzRr-0001Sv-AG
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 11:46:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38613)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZzRp-0002hm-Hn
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 11:46:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604421976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tGrjmCEXBoBaCsyPVGeYrGNhz2JCmoDnznUDdTUcGTA=;
 b=SdovtGMTKkReaK70TJiW2ZjSvZYFibpDBT3/vLn5Azo1rKMaQV0yPnVerMji+4OoyD1fle
 JHfjhlMf6h0/42Qpk6EAmdTqGAtkVjOuTm2XtoGO+fPKdU9lC8AV0OePgTITDn4ML+0zBb
 3Sq98Km3R86M4P7SQ1456bhCZurMchM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-9ETvbJudOO-4CcuPlphPMA-1; Tue, 03 Nov 2020 11:46:14 -0500
X-MC-Unique: 9ETvbJudOO-4CcuPlphPMA-1
Received: by mail-wm1-f69.google.com with SMTP id u9so1726181wmb.2
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 08:46:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tGrjmCEXBoBaCsyPVGeYrGNhz2JCmoDnznUDdTUcGTA=;
 b=mU3x6X+Mdteblr67nJybJRAMxRXnz4UHJ4XagQqRE+3aTagNkk0yfEVbfgT3ieg7wB
 MUEm8hqVBWSbepqQxUUZjxhjT8QC3HbSwSqINhJ/d0u7BvWEwh/4hoxljVQlnR6SmRtO
 eizu4488mLhS6ja9jGgrpH17Us3CuQlQlgTGJUaJpd6lc2rNCw+oSBX+QeCuMS5sviBU
 n2q3j+eLlJ4iFt+Gbqx1E/EkIJpKJZgYmZMQ19w3gsPBmDfkW0FfXTwQgGsKULKlyAs9
 eWYAovLuEWo+KfnZ2+inM3wYVpYTAi2mGaaVPNdB6vnKm9DVGjkIVoDeA1N5JtK2Gb3q
 0vZg==
X-Gm-Message-State: AOAM532R+gbhQNbDoaOL87AfyogHbupthKV5xTgOmOzYjW7TFZMgJG/G
 lKJYNMktnD8kx4KnSZevrL7ZvBCLycgwG0dom9LdX5lzdBJyoWqxhFlIlV+6IafeolAlpms7e5v
 rC2IQj2ubvWSr7yo=
X-Received: by 2002:a5d:4409:: with SMTP id z9mr26696707wrq.236.1604421972523; 
 Tue, 03 Nov 2020 08:46:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy9SqEZwZWVAv10V/Wn9pzZ/ZitkoGweCYKSNvD+o3e85DqIUax7Pi6bIG7DsrF8ojWBKzjyQ==
X-Received: by 2002:a5d:4409:: with SMTP id z9mr26696685wrq.236.1604421972384; 
 Tue, 03 Nov 2020 08:46:12 -0800 (PST)
Received: from x1w.redhat.com (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id q12sm187104wrp.80.2020.11.03.08.46.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 08:46:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 1/3] s390x: fix build for --without-default-devices
Date: Tue,  3 Nov 2020 17:46:02 +0100
Message-Id: <20201103164604.2692357-2-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201103164604.2692357-1-philmd@redhat.com>
References: <20201103164604.2692357-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


