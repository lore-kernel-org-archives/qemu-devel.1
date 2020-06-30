Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79317C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 17:51:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C3C920768
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 17:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kj5dUwmi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C3C920768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqKPa-0005oi-JL
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 13:51:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50128)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jqKOx-0005FR-HP
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 13:50:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24991
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jqKOv-0000wX-Q5
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 13:50:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593539432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/kkWGHDKKaX5S9E8oE78VoWf9TsTkY3V5XT0iS5NrDY=;
 b=Kj5dUwmiHCJVOtwTBhUkQkYnmbU+0prxvmE4WkMowd9ISWjj8ZoNlccvBRaqx725l8qBxW
 82rcWnNl8vV7Tep8iuOTzzwL5X+VD4Svpx8r2hWsY2Pou9z8PU87FzRbwKrRhpXyGObFwR
 kRHjtjKa7I29nGsNtfEijwx+BbvMbjU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-L70fhi1eOk291TF1QezAOQ-1; Tue, 30 Jun 2020 13:50:25 -0400
X-MC-Unique: L70fhi1eOk291TF1QezAOQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0FD3DA0BDB;
 Tue, 30 Jun 2020 17:50:23 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-12-19.pek2.redhat.com [10.72.12.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 73526619B7;
 Tue, 30 Jun 2020 17:50:04 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: mst@redhat.com, armbru@redhat.com, eblake@redhat.com, cohuck@redhat.com,
 jasowang@redhat.com
Subject: [PATCH v2 00/12] vDPA support in qemu
Date: Wed,  1 Jul 2020 01:49:24 +0800
Message-Id: <20200630174937.25560-1-lulu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lulu@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=lulu@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 03:55:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: mhabets@solarflare.com, qemu-devel@nongnu.org, rob.miller@broadcom.com,
 saugatm@xilinx.com, lulu@redhat.com, hanand@xilinx.com, hch@infradead.org,
 eperezma@redhat.com, jgg@mellanox.com, shahafs@mellanox.com,
 kevin.tian@intel.com, parav@mellanox.com, vmireyno@marvell.com,
 cunming.liang@intel.com, gdawar@xilinx.com, jiri@mellanox.com,
 xiao.w.wang@intel.com, stefanha@redhat.com, zhihong.wang@intel.com,
 aadam@redhat.com, rdunlap@infradead.org, maxime.coquelin@redhat.com,
 lingshan.zhu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

vDPA device is a device that uses a datapath which complies with the
virtio specifications with vendor specific control path. vDPA devices
can be both physically located on the hardware or emulated by software.
This PATCH introduce the vDPA support in qemu
TODO 
1) vIOMMU support
2) live migration support
3) docs for vhost-vdpa
4) config interrupt support 

change from v1
separate the patch of vhost_vq_get_addr
separate the patch of vhost_dev_start
introduce the docmation for vhost-vdpa.rst 
other comments form last version 

github address
https://github.com/lulu-github-name/qemutmp.git PATCHV2

Cindy Lu (9):
  net: introduce qemu_get_peer
  vhost_net: use the function qemu_get_peer
  vhost: introduce new VhostOps vhost_dev_start
  vhost: implement vhost_dev_start method
  vhost: introduce new VhostOps vhost_vq_get_addr
  vhost: implement vhost_vq_get_addr method
  vhost: introduce new VhostOps vhost_get_device_id
  vhost-vdpa: introduce vhost-vdpa backend
  vhost-vdpa: introduce vhost-vdpa net client

Jason Wang (3):
  virtio-bus: introduce queue_enabled method
  virtio-pci: implement queue_enabled method
  vhost: check the existence of vhost_set_iotlb_callback

 configure                         |  21 ++
 docs/interop/index.rst            |   1 +
 docs/interop/vhost-vdpa.rst       |  17 ++
 hw/net/vhost_net.c                |  35 ++-
 hw/net/virtio-net.c               |  22 +-
 hw/virtio/Makefile.objs           |   1 +
 hw/virtio/vhost-backend.c         |   7 +-
 hw/virtio/vhost-vdpa.c            | 469 ++++++++++++++++++++++++++++++
 hw/virtio/vhost.c                 |  48 ++-
 hw/virtio/virtio-pci.c            |  13 +
 hw/virtio/virtio.c                |   6 +
 include/hw/virtio/vhost-backend.h |  16 +-
 include/hw/virtio/vhost-vdpa.h    |  26 ++
 include/hw/virtio/vhost.h         |   7 +
 include/hw/virtio/virtio-bus.h    |   4 +
 include/net/net.h                 |   1 +
 include/net/vhost-vdpa.h          |  22 ++
 net/Makefile.objs                 |   2 +-
 net/clients.h                     |   2 +
 net/net.c                         |  10 +
 net/vhost-vdpa.c                  | 228 +++++++++++++++
 qapi/net.json                     |  28 +-
 qemu-options.hx                   |  12 +
 23 files changed, 966 insertions(+), 32 deletions(-)
 create mode 100644 docs/interop/vhost-vdpa.rst
 create mode 100644 hw/virtio/vhost-vdpa.c
 create mode 100644 include/hw/virtio/vhost-vdpa.h
 create mode 100644 include/net/vhost-vdpa.h
 create mode 100644 net/vhost-vdpa.c

-- 
2.21.1


