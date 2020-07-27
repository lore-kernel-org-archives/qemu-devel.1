Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722C5C433E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 13:50:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40EF0206E7
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 13:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CXR9dZvv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40EF0206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k03Wo-0006s7-Au
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 09:50:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k03Vb-00055y-Vs
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 09:49:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24392
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k03VZ-0001r4-8g
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 09:49:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595857776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AHMvwCpHzHvg1F3ImQSbDTzqzrVUtZ/6UHRF8xJVQi0=;
 b=CXR9dZvvJh9rHBdgzzzOiL/aCEhzhCidiwVRlKoHT9RwvyTZMWCbAFv6vjEZsc8YZ10HgE
 /iPR98kK1cH2qSgevO2br/VNDyBqfNm4mx7xQTqKgRQ442hbChfEp1Wl+pbSgfbM6jmFR8
 msV8GBujgepjQNb+dVZu/nCRg16gf10=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-vAS3g852PNSyXkNeCbsmag-1; Mon, 27 Jul 2020 09:49:34 -0400
X-MC-Unique: vAS3g852PNSyXkNeCbsmag-1
Received: by mail-wr1-f70.google.com with SMTP id z1so3958288wrn.18
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 06:49:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=AHMvwCpHzHvg1F3ImQSbDTzqzrVUtZ/6UHRF8xJVQi0=;
 b=CVUiRcLf7dshG08UT8SxNjsbGSTuakhpd/mCo+q9gFCVCmuAwz41WuZHrGqLcSxEbu
 BAhy/mG9GgIZGpOxOYH9YVP7SyGZDpNbo6F1uytsWSX0UhL52wXT4Is91g+kuuT86PKd
 Wj8rft//rRTH3LopQHBR8Juklt62Tixvzmsxr9FPQF21qw1JYRohEIZtHC4PPHVmU+9+
 q6kXFJiFGFcKOrYfei0dyhzEejk8U4hvCkg4JbLTLewRQLSm1h4ya2GaKzhDER7jJWMk
 FcMT7u+Qy5xt6qGkCaUhVIcQeP0OWbWlCWtERywlSqt2dM7Ex9bSTI5FVh1KkK5ggVyM
 wATQ==
X-Gm-Message-State: AOAM532qzj1sLjfzAL79BofWuRZBOEY75wDklm3F1uO523XrG0wHhgMJ
 V9TjTzuNJVVsEgn2wu+Vpe+P/tC2YH3s0ZKucsTfxRETnXOrVr1JcgC+ao8/BqRdP485oK9wWGV
 GzMl28Fd4cHjrNPQ=
X-Received: by 2002:adf:e94a:: with SMTP id m10mr8069260wrn.249.1595857772844; 
 Mon, 27 Jul 2020 06:49:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyS7895x4hajfh+pBoM36f+0F94u3SBOH21OiopxXQCuKgddXx8EDy1TgZNblfui/NJEE9s5w==
X-Received: by 2002:adf:e94a:: with SMTP id m10mr8069244wrn.249.1595857772636; 
 Mon, 27 Jul 2020 06:49:32 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
 by smtp.gmail.com with ESMTPSA id 88sm13343163wrk.43.2020.07.27.06.49.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 06:49:32 -0700 (PDT)
Date: Mon, 27 Jul 2020 09:49:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/7] virtio-mem-pci: force virtio version 1
Message-ID: <20200727134614.96376-2-mst@redhat.com>
References: <20200727134614.96376-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200727134614.96376-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 00:16:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 qemu-stable@nongnu.org, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

Trying to run simple virtio-mem-pci examples currently fails with
    qemu-system-x86_64: -device virtio-mem-pci,id=vm0,memdev=mem0,node=0,
    requested-size=300M: device is modern-only, use disable-legacy=on
due to the added safety checks in 9b3a35ec8236 ("virtio: verify that legacy
support is not accidentally on").

As noted by Conny, we have to force virtio version 1. While at it, use
qdev_realize() to set the parent bus and realize - like most other
virtio-*-pci implementations.

Fixes: 0b9a2443a48b ("virtio-pci: Proxy for virtio-mem")
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20200727115905.129397-1-david@redhat.com>
Cc: qemu-stable@nongnu.org
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-mem-pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio-mem-pci.c b/hw/virtio/virtio-mem-pci.c
index d375280ee1..590cec041b 100644
--- a/hw/virtio/virtio-mem-pci.c
+++ b/hw/virtio/virtio-mem-pci.c
@@ -21,8 +21,8 @@ static void virtio_mem_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     VirtIOMEMPCI *mem_pci = VIRTIO_MEM_PCI(vpci_dev);
     DeviceState *vdev = DEVICE(&mem_pci->vdev);
 
-    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
-    object_property_set_bool(OBJECT(vdev), "realized", true, errp);
+    virtio_pci_force_virtio_1(vpci_dev);
+    qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
 }
 
 static void virtio_mem_pci_set_addr(MemoryDeviceState *md, uint64_t addr,
-- 
MST


