Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5540DC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 16:49:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C522B22208
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 16:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TrdPRKdV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C522B22208
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLUQf-0000Bz-Sx
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 12:49:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57724)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kLTlF-0003RJ-7Q
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 12:06:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28922)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kLTlA-00047c-TN
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 12:06:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600963570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mSCCpzPyhsMwYJKczrXwMJcdEyfh5JEBcvT1ucYDlOQ=;
 b=TrdPRKdVaoJ+IZRQZMn/o+RH6HznwWu3h7Ka9REF4IA47wlGOFFGt1F458ZcHpZ0QiDT3U
 FDLavBJTZEFTW/WvWqsGSnY0bjzQ3x2exDrMqu3ZukS3d6wTXgc7epFS0UEiIoTGyK0VXY
 EOwHJzuzyYSiveEKFSpISAqjaJoedes=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-gbfgZH2QNtmdSJnbvo3dSg-1; Thu, 24 Sep 2020 12:04:46 -0400
X-MC-Unique: gbfgZH2QNtmdSJnbvo3dSg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33515801FDC;
 Thu, 24 Sep 2020 16:04:45 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-4.ams2.redhat.com [10.36.114.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9065519C66;
 Thu, 24 Sep 2020 16:04:24 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH PROTOTYPE 0/6] virtio-mem: vfio support
Date: Thu, 24 Sep 2020 18:04:17 +0200
Message-Id: <20200924160423.106747-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
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
 David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>,
 Luiz Capitulino <lcapitulino@redhat.com>, Auger Eric <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Wei Yang <richardw.yang@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a quick and dirty (1.5 days of hacking) prototype to make
vfio and virtio-mem play together. The basic idea was the result of Alex
brainstorming with me on how to tackle this.

A virtio-mem device manages a memory region in guest physical address
space, represented as a single (currently large) memory region in QEMU.
Before the guest is allowed to use memory blocks, it must coordinate with
the hypervisor (plug blocks). After a reboot, all memory is usually
unplugged - when the guest comes up, it detects the virtio-mem device and
selects memory blocks to plug (based on requests from the hypervisor).

Memory hot(un)plug consists of (un)plugging memory blocks via a virtio-mem
device (triggered by the guest). When unplugging blocks, we discard the
memory. In contrast to memory ballooning, we always know which memory
blocks a guest may use - especially during a reboot, after a crash, or
after kexec.

The issue with vfio is, that it cannot deal with random discards - for this
reason, virtio-mem and vfio can currently only run mutually exclusive.
Especially, vfio would currently map the whole memory region (with possible
only little/no plugged blocks), resulting in all pages getting pinned and
therefore resulting in a higher memory consumption than expected (turning
virtio-mem basically useless in these environments).

To make vfio work nicely with virtio-mem, we have to map only the plugged
blocks, and map/unmap properly when plugging/unplugging blocks (including
discarding of RAM when unplugging). We achieve that by using a new notifier
mechanism that communicates changes.

It's important to map memory in the granularity in which we could see
unmaps again (-> virtio-mem block size) - so when e.g., plugging
consecutive 100 MB with a block size of 2MB, we need 50 mappings. When
unmapping, we can use a single vfio_unmap call for the applicable range.
We expect that the block size of virtio-mem devices will be fairly large
in the future (to not run out of mappings and to improve hot(un)plug
performance), configured by the user, when used with vfio (e.g., 128MB,
1G, ...) - Linux guests will still have to be optimized for that.

We try to handle errors when plugging memory (mapping in VFIO) gracefully
- especially to cope with too many mappings in VFIO.


As I basically have no experience with vfio, all I did for testing is
passthrough a secondary GPU (NVIDIA GK208B) via vfio-pci to my guest
and saw it pop up in dmesg. I did *not* actually try to use it (I know
...), so there might still be plenty of BUGs regarding the actual mappings
in the code. When I resize virtio-mem devices (resulting in
memory hot(un)plug), I can spot the memory consumption of my host adjusting
accordingly - in contrast to before, wehreby my machine would always
consume the maximum size of my VM, as if all memory provided by
virtio-mem devices were fully plugged.

I even tested it with 2MB huge pages (sadly for the first time with
virtio-mem ever) - and it worked like a charm on the hypervisor side as
well. The number of free hugepages adjusted accordingly. (again, did not
properly test the device in the guest ...).

If anybody wants to play with it and needs some guidance, please feel
free to ask. I might add some vfio-related documentation to
https://virtio-mem.gitlab.io/ (but it really isn't that special - only
the block size limitations have to be considered).

David Hildenbrand (6):
  memory: Introduce sparse RAM handler for memory regions
  virtio-mem: Impelement SparseRAMHandler interface
  vfio: Implement support for sparse RAM memory regions
  memory: Extend ram_block_discard_(require|disable) by two discard
    types
  virtio-mem: Require only RAM_BLOCK_DISCARD_T_COORDINATED discards
  vfio: Disable only RAM_BLOCK_DISCARD_T_UNCOORDINATED discards

 exec.c                         | 109 +++++++++++++++++----
 hw/vfio/common.c               | 169 ++++++++++++++++++++++++++++++++-
 hw/virtio/virtio-mem.c         | 164 +++++++++++++++++++++++++++++++-
 include/exec/memory.h          | 151 ++++++++++++++++++++++++++++-
 include/hw/vfio/vfio-common.h  |  12 +++
 include/hw/virtio/virtio-mem.h |   3 +
 softmmu/memory.c               |   7 ++
 7 files changed, 583 insertions(+), 32 deletions(-)

-- 
2.26.2


