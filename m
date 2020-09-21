Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9981C43464
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 08:40:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3955A20773
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 08:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ESaCAiax"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3955A20773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKHMi-0001Zm-Bs
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 04:40:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1kKHLH-0000Yq-7p
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 04:38:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33266)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1kKHLD-0003Pl-Nl
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 04:38:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600677510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DfBED6v5ZK8fSJ+kNavxtgnaVPK9BejTjn4HYnaW7dI=;
 b=ESaCAiax9awYkVMVTDcHvUFB91bn3FXMaB5WBhASeQeZKttvw+vAZY4rXoNAJHTcGNdIZX
 XaDMxW4DwMew+I61GY/DjYCcQxm6tUrdZ3CgarEJ5Qly9THl4rg5W1cuiwe+GzskN6BzaK
 ++xnHnUsFGg44UkNad4LYtesaou01IE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-j_zloa75P0KQ5HSkCSMdmA-1; Mon, 21 Sep 2020 04:38:26 -0400
X-MC-Unique: j_zloa75P0KQ5HSkCSMdmA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C367B1891E9B;
 Mon, 21 Sep 2020 08:38:24 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-113-150.ams2.redhat.com
 [10.36.113.150])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B34406886A;
 Mon, 21 Sep 2020 08:38:08 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v4 0/4] vhost-vsock: force virtio version 1
Date: Mon, 21 Sep 2020 10:38:03 +0200
Message-Id: <20200921083807.48380-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:43:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.501,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Thomas Huth <thuth@redhat.com>, Qinghua Cheng <qcheng@redhat.com>,
 Qian Cai <caiqian@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-stable@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v4:
   - Patch 1: fixed commit message and warning message [Cornelia]
   - Patch 3: added comment in the code [Cornelia]
   - Added Cornelia's R-b tags

v3: https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg06549.html
v2: https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg04437.html
v1: https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg04373.html

Recently changes in QEMU 5.1 requires to set 'disable-legacy=on'
on vhost-vsock-pci and vhost-user-vsock-pci devices:

    $ ./qemu-system-x86_64 ... -device vhost-vsock-pci,guest-cid=5
        qemu-system-x86_64: -device vhost-vsock-pci,guest-cid=5:
        device is modern-only, use disable-legacy=on

As discussed with Cornelia [2], this series forces virtio version 1
to vhost-vsock-pci, vhost-user-vsock-pci, and vhost-vsock-ccw devices.

virtio-vsock was introduced after the release of VIRTIO 1.0 specifications,
so it should be 'modern-only'.
In addition Cornelia verified that forcing a legacy mode on vhost-vsock-pci
device using x86-64 host and s390x guest, so with different endianness,
produces strange behaviours.

This series should be merged in stable branch since it fixes migration issues
with QEMU 5.1:
- we skip legacy support check in the old machine types (< 5.1)
- we force virtio version 1 for vhost-vsock-pci and vhost-vsock-ccw devices
  only in the new machine types (>= 5.1). vhost-user-vsock-pci was introduced
  in 5.1 and doesn't support migration, so we forced virtio version 1 in any
  case,

Thanks,
Stefano

[1] https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg05312.html
[2] https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg02515.html

Stefano Garzarella (4):
  virtio: skip legacy support check on machine types less than 5.1
  vhost-vsock-pci: force virtio version 1
  vhost-user-vsock-pci: force virtio version 1
  vhost-vsock-ccw: force virtio version 1

 include/hw/virtio/virtio.h       |  2 ++
 hw/core/machine.c                |  1 +
 hw/s390x/vhost-vsock-ccw.c       | 12 ++++++++++++
 hw/s390x/virtio-ccw.c            | 15 ++++++++++++---
 hw/virtio/vhost-user-vsock-pci.c |  4 +++-
 hw/virtio/vhost-vsock-pci.c      | 10 +++++++++-
 hw/virtio/virtio-pci.c           | 14 ++++++++++++--
 hw/virtio/virtio.c               |  7 +++++++
 8 files changed, 58 insertions(+), 7 deletions(-)

-- 
2.26.2


