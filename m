Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C702C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 11:40:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1424214D8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 11:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a2fFzyZi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1424214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL38o-00019A-08
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 07:40:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35030)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kL37F-0008LO-9u
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 07:39:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48777)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kL37C-0006tc-Fp
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 07:39:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600861148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4yfe0X9HVd0pUFQ/9IUloC9Tl/QG80Uh0KlTiLsNF3s=;
 b=a2fFzyZi05ZwIEmZN+iSwHjcA4qzRlkYbHuiCEGNLB4SORllFXS/p6Ezk1JEU4hen1I1XD
 CUqAlkeqQrXsMWXWWa05y4YctXb4FKJdJ6FX/KunxSbidL6kBfbRCFiH4w0t2NrWN5Rpvg
 hc0KfNU7fOVoEkr/n0Y+7d8B6GZ/31Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-541-TII_JGuLM3u--SyLYg10QQ-1; Wed, 23 Sep 2020 07:39:06 -0400
X-MC-Unique: TII_JGuLM3u--SyLYg10QQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F411100746D
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2020 11:39:05 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-112-54.ams2.redhat.com [10.36.112.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BBFFD78805;
 Wed, 23 Sep 2020 11:39:01 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 0/5] virtio-mem: block size and address-assignment
 optimizations
Date: Wed, 23 Sep 2020 13:38:55 +0200
Message-Id: <20200923113900.72718-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
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
Cc: David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let's try to detect the actual THP size and use it as default block size
(unless the page size of the backend is bigger). Handle large block sizes
better, avoiding a virtio-spec violation and optimizing address
auto-detection.

David Hildenbrand (5):
  virtio-mem: Probe THP size to determine default block size
  virtio-mem: Check that "memaddr" is multiples of the block size
  memory-device: Support big alignment requirements
  memory-device: Add get_min_alignment() callback
  virito-mem: Implement get_min_alignment()

 hw/mem/memory-device.c         | 20 ++++---
 hw/virtio/virtio-mem-pci.c     | 14 +++++
 hw/virtio/virtio-mem.c         | 95 ++++++++++++++++++++++++++++++++--
 include/hw/mem/memory-device.h | 11 ++++
 4 files changed, 130 insertions(+), 10 deletions(-)

-- 
2.26.2


