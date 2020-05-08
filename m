Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BB0C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 16:34:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98F7520CC7
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 16:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Myp8GrvR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98F7520CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX5x8-0007Ze-LP
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 12:34:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60592)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jX5w4-0005wg-Cm
 for qemu-devel@nongnu.org; Fri, 08 May 2020 12:33:16 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57030
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jX5w2-0005A1-R3
 for qemu-devel@nongnu.org; Fri, 08 May 2020 12:33:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588955592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pNOPBaptLtkgLmyWaGY4d608APV0MPx1WGQ/pUAZTpE=;
 b=Myp8GrvRPSTAsE8z1dxKgAJ5xhJkGVKjOMWeuEXHsXDePuXcvSsfMFLCTOyvks9cv5cTh2
 0IcZTi8MhO6zPrzm8d4wWcp8tS1Lcv+mxRrMcfZZndVyUVf8fzW64F5cEwUxeyagEulV/4
 N9pRCVycn+EGwR7OXH90Z1M/elBjwnU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-178-8vGW5FV2P5CP-P00v267vA-1; Fri, 08 May 2020 12:33:08 -0400
X-MC-Unique: 8vGW5FV2P5CP-P00v267vA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4B81800688;
 Fri,  8 May 2020 16:33:05 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-12-75.pek2.redhat.com [10.72.12.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F20346ACF5;
 Fri,  8 May 2020 16:32:45 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: mst@redhat.com, armbru@redhat.com, eblake@redhat.com, cohuck@redhat.com,
 jasowang@redhat.com
Subject: [RFC v2 0/9] vDPA support in qemu
Date: Sat,  9 May 2020 00:32:09 +0800
Message-Id: <20200508163218.22592-1-lulu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 08:00:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

change from v1
separe the patch of introduce vhost_set_vring_ready method
separe the patch of qemu_get_peer
separe the patch  of vhost_set_state
intorduce the new macro specific for vDPA in configure
intorduce the fuction to pass the fd from cmdline 
introduce the docmation in qemu-options.hx
the other comments form last version  


Cindy Lu (3):
  net: introduce qemu_get_peer
  net: use the function qemu_get_peer
  virtio_net: introduce vhost_set_state

Jason Wang (4):
  virtio-bus: introduce queue_enabled method
  virito-pci: implement queue_enabled method
  vhost_net: set vq ready during start if necessary
  vhost: introduce vhost_set_vring_ready method

Tiwei Bie (2):
  vhost-vdpa: introduce vhost-vdpa net client
  vhost-vdpa: implement vhost-vdpa backend

 configure                         |  21 ++
 hw/net/vhost_net-stub.c           |   4 +
 hw/net/vhost_net.c                |  77 ++++-
 hw/net/virtio-net.c               |   9 +
 hw/virtio/Makefile.objs           |   1 +
 hw/virtio/vhost-backend.c         |   5 +
 hw/virtio/vhost-vdpa.c            | 447 ++++++++++++++++++++++++++++++
 hw/virtio/vhost.c                 |  14 +
 hw/virtio/virtio-pci.c            |  13 +
 hw/virtio/virtio.c                |   6 +
 include/hw/virtio/vhost-backend.h |  10 +-
 include/hw/virtio/vhost-vdpa.h    |  25 ++
 include/hw/virtio/vhost.h         |   1 +
 include/hw/virtio/virtio-bus.h    |   4 +
 include/net/net.h                 |   1 +
 include/net/vhost-vdpa.h          |  19 ++
 include/net/vhost_net.h           |   4 +-
 net/Makefile.objs                 |   2 +-
 net/clients.h                     |   2 +
 net/net.c                         |   9 +
 net/vhost-vdpa.c                  | 227 +++++++++++++++
 qapi/net.json                     |  22 +-
 qemu-options.hx                   |  19 ++
 23 files changed, 930 insertions(+), 12 deletions(-)
 create mode 100644 hw/virtio/vhost-vdpa.c
 create mode 100644 include/hw/virtio/vhost-vdpa.h
 create mode 100644 include/net/vhost-vdpa.h
 create mode 100644 net/vhost-vdpa.c

-- 
2.21.1


