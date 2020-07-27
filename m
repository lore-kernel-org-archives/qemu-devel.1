Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CD5C43446
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 14:33:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C50A2083B
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 14:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P/k3XT7P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C50A2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k04CG-0005AS-OT
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 10:33:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k04Ap-0003Ce-UC
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 10:32:15 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44789
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k04Ao-0001F0-4c
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 10:32:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595860333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AHMvwCpHzHvg1F3ImQSbDTzqzrVUtZ/6UHRF8xJVQi0=;
 b=P/k3XT7PSnXa66U0QyYp5pUBsO32HjZKCF0RVGBGlsgYDB0q6admkLEP8ag6Y+VEcN5ynT
 Ns5T0zaS6Ott8u+8U03FRaH9lY8H7LvhvQsO/dmJUy4waBw/RhselKmDL85T+sxGv4+c0k
 5+78M3AbzGPtJnaUCc3DJw8raQ4UlWE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-bw0cq6NbPHSUmg2a-ted6Q-1; Mon, 27 Jul 2020 10:32:08 -0400
X-MC-Unique: bw0cq6NbPHSUmg2a-ted6Q-1
Received: by mail-wr1-f71.google.com with SMTP id 5so3982333wrc.17
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 07:32:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=AHMvwCpHzHvg1F3ImQSbDTzqzrVUtZ/6UHRF8xJVQi0=;
 b=KKq2En3OPT9NL7EDWWjwR41b1RK4mvW4zXR5TgSDGg+Nu7JtjSXF7T390J7Tz0DrnX
 0MHdtBB1TgsaUsx2fV1vrg7et9B5+al/UGAsLpChVTeLq0MaapuYj50UIHWKbx+5AWX1
 MSp0nsQBy6PLQUkepk14K3oJpkl3bSHfLtSd7qxwb8HsIXeb6cATa33WiWLHrRN2b3yH
 cHUkeAw0Q4Rr75N3u+ILmvt45aI6M2sTyviVIqD8rx3DmsUdxtEbvB3Kdfe/rZehTlBy
 zuNXb95YXBFYQoKOPyWHrlH7eYCQlXCn+KyW9Zi0lTpLceDTomaA2pKrRCHdtE4QrUqE
 t4bg==
X-Gm-Message-State: AOAM531CMgJr1/ApOVlsWT+1IsVP/6+6ki1S19AahTyj3Gglyt3V1O1N
 s6/vJD/D69yAmr/dOr+265E7tZ63zRh2cZh+x7CcKomkpeoiBilg7vTWKX8JUgxxkpYjU3AfhEz
 H6RGmnYwVLmUimkw=
X-Received: by 2002:adf:fd04:: with SMTP id e4mr20145533wrr.353.1595860326180; 
 Mon, 27 Jul 2020 07:32:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzGL1kZ8Xr3yooFaJo/c/8dUrhe/9dCiJHmEOulv57q5J35ewQXvwhLqOaSea2BVAWT0x7b9Q==
X-Received: by 2002:adf:fd04:: with SMTP id e4mr20145516wrr.353.1595860325947; 
 Mon, 27 Jul 2020 07:32:05 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
 by smtp.gmail.com with ESMTPSA id t189sm16519960wmf.47.2020.07.27.07.32.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 07:32:05 -0700 (PDT)
Date: Mon, 27 Jul 2020 10:32:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 1/6] virtio-mem-pci: force virtio version 1
Message-ID: <20200727143104.97776-2-mst@redhat.com>
References: <20200727143104.97776-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200727143104.97776-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 01:46:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


