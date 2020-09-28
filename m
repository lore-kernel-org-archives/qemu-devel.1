Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E22C4727F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 11:51:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 487B62073A
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 11:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UJNGKvfh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 487B62073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMrgf-0005ro-9p
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 07:51:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kMreu-0004EU-EM
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 07:49:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30295)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kMrer-0007uk-AA
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 07:49:30 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601293768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GTGTPdbE73adVAy/3Xay5CjnCozVV2CicUh/zlZ/Gzs=;
 b=UJNGKvfhZl4Qs9Oh7x4HHku9wX7uFXYocgclQ4zI0lHj9YpTa6iSKvR9n6RZeubW2nRZYN
 Gssx2Bb6bSw+JIDTZ86we5FsNqHWSg2r0Os6t8R6LYeJa+44LUbC1t45mKuzXK+DH6er8K
 Stzpy0mdoekAml06oe+FuBm7esj55P8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-nVVUQnHbNU2UtY0qG1gw7g-1; Mon, 28 Sep 2020 07:49:24 -0400
X-MC-Unique: nVVUQnHbNU2UtY0qG1gw7g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 14B518018A9;
 Mon, 28 Sep 2020 11:49:23 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-115-97.ams2.redhat.com [10.36.115.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 604C72C31E;
 Mon, 28 Sep 2020 11:49:11 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/5] virtio-mem: block size and address-assignment
 optimizations
Date: Mon, 28 Sep 2020 13:49:04 +0200
Message-Id: <20200928114909.20791-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:47:08
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
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Wei Yang <richardw.yang@linux.intel.com>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let's try to detect the actual THP size and use it as default block size
(unless the page size of the backend indicates that THP don't apply).
Always allow to set a block size of 1 MiB, but warn if the configured block
size is smaller than the default. Handle large block sizes better, avoiding
a virtio-spec violation and optimizing address auto-detection.

For existing setups (x86-64), the default block size won't change (was, and
will be 2 MiB on anonymous memory). For existing x86-64 setups, the address
auto-detection won't change in relevant setups (esp., anonymous memory
and hugetlbfs with 2 MiB pages and no manual configuration of the block
size). I don't see the need for compatibility handling (especially, as
virtio-mem is still not considered production-ready).

Most of this is a preparation for future architectures, using hugetlbfs
to full extend, and using manually configured, larger block sizes
(relevant for vfio in the future).

v1 -> v2:
- Tweak some patch descriptions
- "virtio-mem: Probe THP size to determine default block size"
-- Beautify THP detection a bit.
-- Assume THP might only get used if the memory backend page size corresponds
   to the real hostpage size.
-- Use virtio_mem_default_block_size(RAMBlock *rb) to handle selection
   of the default block size for a RAMBlock.
-- Implement virtio_mem_get_block_size() as preparation for patch #5
- "memory-device: Add get_min_alignment() callback"
-- Simplify documentation.
- "virito-mem: Implement get_min_alignment()"
-- Simplify due to changes in patch #1.

David Hildenbrand (5):
  virtio-mem: Probe THP size to determine default block size
  virtio-mem: Check that "memaddr" is multiples of the block size
  memory-device: Support big alignment requirements
  memory-device: Add get_min_alignment() callback
  virito-mem: Implement get_min_alignment()

 hw/mem/memory-device.c         |  20 ++++--
 hw/virtio/virtio-mem-pci.c     |   7 +++
 hw/virtio/virtio-mem.c         | 110 +++++++++++++++++++++++++++++++--
 include/hw/mem/memory-device.h |  10 +++
 4 files changed, 137 insertions(+), 10 deletions(-)

-- 
2.26.2


