Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F87C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 15:40:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 516A22071A
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 15:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hutqCqLg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 516A22071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnOYC-0006TS-JL
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 11:40:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58640)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jnOWo-0004X5-Fg
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 11:38:34 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36338
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jnOWm-0003I4-Rh
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 11:38:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592840311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hBq+Z6OPkLv/ZB3fwxJKju8zMgluDlDcd2q8/YLF+1g=;
 b=hutqCqLg5gnrJzQNUdZqYspp7EHjSXMgI2n02NSXR0Wd00Nj8fH2UtKhmPE0VpfhkbjIvb
 bpj/nxZK9qgKIjuK9Hxrs4HHMPRNhDBqER00+zeuQr9VRGtTmy2AvpwRjWF7PKALRXSMW/
 WZObkeo+ansWWrs5bByb9+6ksSGA2pc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-nkov9MQtO3-9Tfb5bqGS1A-1; Mon, 22 Jun 2020 11:38:24 -0400
X-MC-Unique: nkov9MQtO3-9Tfb5bqGS1A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E0AFA1883604;
 Mon, 22 Jun 2020 15:38:21 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-13-110.pek2.redhat.com [10.72.13.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6FE5C1DC;
 Mon, 22 Jun 2020 15:38:04 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: mst@redhat.com, armbru@redhat.com, eblake@redhat.com, cohuck@redhat.com,
 jasowang@redhat.com
Subject: [PATCH v1 00/10] vDPA support in qemu
Date: Mon, 22 Jun 2020 23:37:46 +0800
Message-Id: <20200622153756.19189-1-lulu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 02:57:26
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
This RFC introduce the vDPA support in qemu
TODO 
1) vIOMMU support
2) live migration support

Cindy Lu (8):
  net: introduce qemu_get_peer
  vhost_net: use the function qemu_get_peer
  vhost-backend: export the vhost backend helper
  vhsot_net: introduce set_config & get_config function
  vhost: introduce new VhostOps vhost_dev_start
  vhost: implement vhost_dev_start method
  vhost-vdpa: introduce vhost-vdpa backend
  vhost-vdpa: introduce vhost-vdpa net client

Jason Wang (2):
  virtio-bus: introduce queue_enabled method
  virtio-pci: implement queue_enabled method

 configure                         |  21 ++
 hw/net/vhost_net.c                |  46 +++-
 hw/net/virtio-net.c               |  19 +-
 hw/virtio/Makefile.objs           |   1 +
 hw/virtio/vhost-backend.c         |  40 ++-
 hw/virtio/vhost-vdpa.c            | 406 ++++++++++++++++++++++++++++++
 hw/virtio/vhost.c                 |  59 ++++-
 hw/virtio/virtio-pci.c            |  18 ++
 hw/virtio/virtio.c                |   6 +
 include/hw/virtio/vhost-backend.h |  36 ++-
 include/hw/virtio/vhost-vdpa.h    |  26 ++
 include/hw/virtio/vhost.h         |   8 +
 include/hw/virtio/virtio-bus.h    |   4 +
 include/net/net.h                 |   1 +
 include/net/vhost-vdpa.h          |  21 ++
 include/net/vhost_net.h           |   6 +-
 net/Makefile.objs                 |   2 +-
 net/clients.h                     |   2 +
 net/net.c                         |   9 +
 net/vhost-vdpa.c                  | 230 +++++++++++++++++
 qapi/net.json                     |  23 +-
 qemu-options.hx                   |  12 +
 22 files changed, 952 insertions(+), 44 deletions(-)
 create mode 100644 hw/virtio/vhost-vdpa.c
 create mode 100644 include/hw/virtio/vhost-vdpa.h
 create mode 100644 include/net/vhost-vdpa.h
 create mode 100644 net/vhost-vdpa.c

-- 
2.21.1


