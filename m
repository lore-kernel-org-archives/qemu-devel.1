Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2DC3C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 12:47:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3939D20725
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 12:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JOfrw4Yt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3939D20725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYTom-0002ZK-2e
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 08:47:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kYTmi-0000kr-OB
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 08:45:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26020)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kYTmg-0000iE-OX
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 08:45:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604061933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2qvybBCIE1Zjv+mt4qBhgbngIyzXePj4i5BwfD1rO8Y=;
 b=JOfrw4Ytd2ULEsuRP+uu0DhK6veIvmbOl8P2wQ8W7adOX0B/QBc8VKYoclgU/bDCQloDjf
 WOITWGkDNyc64l2FewgZmFNQgwkU3wv0KQttUSZiloKzN8afvlW7j2lO375ztXQl8V1whq
 vTll8yUJjAfjqhRNP1ZSHlz+o95OXXs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-88jYwgSCPxWsuyK3OEp0Kw-1; Fri, 30 Oct 2020 08:45:30 -0400
X-MC-Unique: 88jYwgSCPxWsuyK3OEp0Kw-1
Received: by mail-wm1-f69.google.com with SMTP id y21so316163wmi.7
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 05:45:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=2qvybBCIE1Zjv+mt4qBhgbngIyzXePj4i5BwfD1rO8Y=;
 b=Bj64RkgZN7Cd3oFm3WBmtWaTHkvWpyjnLiDE+5Nm3SYvKcsk5tK3whHqwoPQlVGqDs
 EpOOgME8pwjUr0VXjvvcDmShIeeKG0kyOBEks2KnVwKuOFiG5Zog9VAf98mwSOwLuS/O
 jGVBzReNV/zuFj5EZhwBEopoDDYp8Qv5SEdGyCIvUwV2w0HUnDBrMNkkmwJchZBNNaEh
 u4w9p6IZgdUDVDbrPkbQu3b9245h70TOy1mc/GdrmC9fkWV0eNLLXb2j5XNu3a51FJwj
 1JQ951ugS0/SJV18/eBIZ9MdK0YnUQ0LCItTP1ea8OJCi3jPRNNBQIJAUyop5TiG/D5l
 nOoQ==
X-Gm-Message-State: AOAM533SAFn7VDTDXJh3qbyp+HII7CxNRzSTBu1mHTyJzdSM8XbtOFgG
 xn6ENcYFVJJYagoXxLy8huQtzBCydi35ZqiyvFyoe610JxyQCgNwWIUaWJYrIEopN3nntTW+NMu
 I79l8ZbAA3EJcCDQ=
X-Received: by 2002:a1c:4d14:: with SMTP id o20mr2441791wmh.72.1604061929450; 
 Fri, 30 Oct 2020 05:45:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyocOfMUmDYW7MlCrgP8+STQiAso4Njm5zwNXPERdlLOAvy7spFLjdptL6oXGytgo3z8GZM4g==
X-Received: by 2002:a1c:4d14:: with SMTP id o20mr2441779wmh.72.1604061929287; 
 Fri, 30 Oct 2020 05:45:29 -0700 (PDT)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id r18sm11477001wrj.50.2020.10.30.05.45.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 05:45:28 -0700 (PDT)
Date: Fri, 30 Oct 2020 08:45:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/15] pci: advertise a page aligned ATS
Message-ID: <20201030124454.854286-11-mst@redhat.com>
References: <20201030124454.854286-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201030124454.854286-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 02:24:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 qemu-stable@nongnu.org, Peter Xu <peterx@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jason Wang <jasowang@redhat.com>

After Linux kernel commit 61363c1474b1 ("iommu/vt-d: Enable ATS only
if the device uses page aligned address."), ATS will be only enabled
if device advertises a page aligned request.

Unfortunately, vhost-net is the only user and we don't advertise the
aligned request capability in the past since both vhost IOTLB and
address_space_get_iotlb_entry() can support non page aligned request.

Though it's not clear that if the above kernel commit makes
sense. Let's advertise a page aligned ATS here to make vhost device
IOTLB work with Intel IOMMU again.

Note that in the future we may extend pcie_ats_init() to accept
parameters like queue depth and page alignment.

Cc: qemu-stable@nongnu.org
Signed-off-by: Jason Wang <jasowang@redhat.com>
Message-Id: <20200909081731.24688-1-jasowang@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci/pcie.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 5b48bae0f6..d4010cf8f3 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -971,8 +971,9 @@ void pcie_ats_init(PCIDevice *dev, uint16_t offset)
 
     dev->exp.ats_cap = offset;
 
-    /* Invalidate Queue Depth 0, Page Aligned Request 0 */
-    pci_set_word(dev->config + offset + PCI_ATS_CAP, 0);
+    /* Invalidate Queue Depth 0, Page Aligned Request 1 */
+    pci_set_word(dev->config + offset + PCI_ATS_CAP,
+                 PCI_ATS_CAP_PAGE_ALIGNED);
     /* STU 0, Disabled by default */
     pci_set_word(dev->config + offset + PCI_ATS_CTRL, 0);
 
-- 
MST


