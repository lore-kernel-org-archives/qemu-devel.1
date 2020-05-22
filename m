Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68DF8C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 12:26:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 330A4206B6
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 12:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aaoy0Y8F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 330A4206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jc6l6-0001Rr-22
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 08:26:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41588)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1jc6k2-0000n6-Kj
 for qemu-devel@nongnu.org; Fri, 22 May 2020 08:25:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27461
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1jc6k0-0002Wd-Vp
 for qemu-devel@nongnu.org; Fri, 22 May 2020 08:25:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590150331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9BwoBHWiUoM4kiqQxZOudwD0jN347XKEVkk4ss4l3e0=;
 b=Aaoy0Y8FlSzwiMiiP7+VqoDa8CnutEyIjXlUE5KBc0MUhzsjZ1U72o4BkTknfpQrQI5uPl
 pTFr2sjwGWbQJz7vUjrnZPP+L/JNFAvYrOkMFVcGG2kjxo9c3zOY0vZiej/fQgofCtzQ15
 XEywkFFvpkfM5N7D4KEMZ/0rvIgaGEA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-FUyx8pHqP4yyokMfj53rXQ-1; Fri, 22 May 2020 08:25:28 -0400
X-MC-Unique: FUyx8pHqP4yyokMfj53rXQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE8058014D7;
 Fri, 22 May 2020 12:25:26 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-114-19.ams2.redhat.com
 [10.36.114.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9F081619C0;
 Fri, 22 May 2020 12:25:13 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/3] virtio: add vhost-user-vsock device
Date: Fri, 22 May 2020 14:25:09 +0200
Message-Id: <20200522122512.87413-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 08:01:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Julio Montes <julio.montes@intel.com>,
 Sebastien Boeuf <sebastien.boeuf@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v2:
  - removed live migration code in the vhost-user-vsock base device since
    vhost-user-vsock application built with Cloud Hypervisor crates doesn't
    support VHOST_USER_PROTOCOL_F_LOG_SHMFD, so I'm not able to test this
    code [Stefan]

v1: https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg04365.html

This series add vhost-user-vsock base device and its PCI version
(vhost-user-vsock-pci).
The vhost-user-vsock device can be used to implement the virtio-vsock
device emulation in user-space.
An use case might be Kata, where they prefer to emulate devices
in user-space.

The first patch creates a new vhost-vsock-common parent class
with the common code usable for both vhost-vsock and vhost-user-vsock
devices.

The other patches add the vhost-user-vsock base device and its PCI
version.

I also implemented a vhost-user-vsock [1] (still WiP) application written in
Rust using crates from Cloud Hypervisor.
The application implements the Firecracker hybrid vsock (vsock over
unix domain socket) [2]

The vhost-user-vsock-pci device can be tested following these steps:

    # build vhost-user-vsock application
    git clone https://github.com/stefano-garzarella/cloud-hypervisor.git
    git checkout vhost-user-vsock
    cargo build

    # start vhost-user-vsock
    ./target/debug/vhost_user_vsock \
        --vsock-backend guest_cid=4,uds_path=/tmp/vm4.vsock,sock=/tmp/vhost4.socket

    # start QEMU
    qemu-system-x86_64 -m 1G -smp 2 -cpu host -M q35,accel=kvm \
        ... \
        -chardev socket,id=char0,reconnect=0,path=/tmp/vhost4.socket \
        -device vhost-user-vsock-pci,chardev=char0 -monitor stdio

    # Guest listening
    guest$ nc --vsock -l 1234

    host$ nc -U /tmp/vm4.vsock
    CONNECT 1234

    # Host listening
    host$ nc -l -U /tmp/vm4.vsock_1234

    guest$ nc --vsock 2 1234

[1] https://github.com/stefano-garzarella/cloud-hypervisor.git
    (vhost-user-vsock branch)
[2] https://github.com/firecracker-microvm/firecracker/blob/master/docs/vsock.md

Stefano Garzarella (3):
  vhost-vsock: add vhost-vsock-common abstraction
  virtio: add vhost-user-vsock base device
  virtio: add vhost-user-vsock-pci device

 configure                              |   3 +
 include/hw/virtio/vhost-user-vsock.h   |  36 ++++
 include/hw/virtio/vhost-vsock-common.h |  47 ++++
 include/hw/virtio/vhost-vsock.h        |  11 +-
 hw/virtio/vhost-user-vsock-pci.c       |  84 ++++++++
 hw/virtio/vhost-user-vsock.c           | 181 ++++++++++++++++
 hw/virtio/vhost-vsock-common.c         | 258 ++++++++++++++++++++++
 hw/virtio/vhost-vsock.c                | 283 ++++---------------------
 hw/virtio/Makefile.objs                |   4 +-
 9 files changed, 656 insertions(+), 251 deletions(-)
 create mode 100644 include/hw/virtio/vhost-user-vsock.h
 create mode 100644 include/hw/virtio/vhost-vsock-common.h
 create mode 100644 hw/virtio/vhost-user-vsock-pci.c
 create mode 100644 hw/virtio/vhost-user-vsock.c
 create mode 100644 hw/virtio/vhost-vsock-common.c

-- 
2.25.4


