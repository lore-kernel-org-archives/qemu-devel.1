Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBF0C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 19:34:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E9D52145D
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 19:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UtuA/nPd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E9D52145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFjNh-0005uB-D3
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 15:34:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37050)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kFjMu-0004vn-7g
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 15:33:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58312)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kFjMs-0000Rv-2k
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 15:33:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599593605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SevsorCaiQJWbJ6v1VbNoXvVm0i5mkWmenFSl8fSt5Y=;
 b=UtuA/nPdOuEwOj2qZh20k7rJgWBzVQ1SmuKprVmIwaQVVTryIVRe6Vud2q3a7Wo39x0fMo
 /jSCF7crH8BPLwL+ijtFWbB4Bf8O3G+arOMxazQ9ep0idtamWsD65fVSNCZdERhCaJQITR
 S5jh6xLf8qNZA1ATsynO/GmRCXRHBKg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-aavLtR5CM7yPrSVbY7n_Ag-1; Tue, 08 Sep 2020 15:33:21 -0400
X-MC-Unique: aavLtR5CM7yPrSVbY7n_Ag-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 917B71DDFA;
 Tue,  8 Sep 2020 19:33:20 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-115-123.ams2.redhat.com [10.36.115.123])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2F7939CBA;
 Tue,  8 Sep 2020 19:33:11 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 cohuck@redhat.com, mst@redhat.com, qemu-stable@nongnu.org
Subject: [PATCH v2 0/2] virtio-iommu-pci: Advertise the device as modern-only
Date: Tue,  8 Sep 2020 21:33:07 +0200
Message-Id: <20200908193309.20569-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eric.auger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 12:54:58
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
Cc: jean-philippe@linaro.org, thuth@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since commit 9b3a35ec82 ("virtio: verify that legacy support is not
accidentally on"), we are forced to use disable-legacy=on when
instantiating the virtio-iommu-pci device. This also revealed that
the unrealize() function is likely to call g_tree_destroy() on
NULL gtrees, which triggers assertions.

Best Regards

Eric

History:
v1 -> v2:
- Fix patch #1 commit message typos
- Add Connie's R-b on both patches

Eric Auger (2):
  virtio-iommu: Check gtrees are non null before destroying them
  virtio-iommu-pci: force virtio version 1

 hw/virtio/virtio-iommu-pci.c | 2 +-
 hw/virtio/virtio-iommu.c     | 8 ++++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

-- 
2.21.3


