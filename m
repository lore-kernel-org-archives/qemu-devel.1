Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65740C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 15:24:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F46020709
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 15:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JfG3mhTm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F46020709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZcCm-0001qZ-Aq
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 11:24:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1jZc9Q-0005UE-7D
 for qemu-devel@nongnu.org; Fri, 15 May 2020 11:21:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51344
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1jZc9H-0006sO-HO
 for qemu-devel@nongnu.org; Fri, 15 May 2020 11:21:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589556078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=FUn7N3ywoihaKKugb+UX15XmY5aTLcnwC/riuMNxzHY=;
 b=JfG3mhTmvmcKAq/zzb+admBW6RXA3zQr5p+053wjsn0L2kiLUK+SKrQ7XT9M570kNzAOkG
 0fCGscZ/5lN6m8oX5gkeCBWroLMXd868pTE7BH4djP+BvGARTR2JRYUVnS/8SuyBtkaiD1
 LzjYgUE3OwL3xrHS9CGmpmCfgwPXIKE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-GceYI0jqNhuLu8E9ne7AAw-1; Fri, 15 May 2020 11:21:14 -0400
X-MC-Unique: GceYI0jqNhuLu8E9ne7AAw-1
Received: by mail-wm1-f72.google.com with SMTP id t62so936470wmt.7
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 08:21:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=FUn7N3ywoihaKKugb+UX15XmY5aTLcnwC/riuMNxzHY=;
 b=ifg8QIIx+D0YgC/XKBobsBwQJBOK0s5EdJbPiOmFNhvizGJARynjb5EEQwNo0m/qqp
 CULkjaNEE6JQUyehV33rusIykk1xCTcRylaufcJem/48NIaXwpp3A5ebKUQGKHHsmijN
 3eHrFsDayDAkhQ+sFtN1Heu+g9SzZt7w56T8QVH8y1pEBHhODUFrq5cKR/EaoyqJn7Q1
 Bm6H7mfwmtHUfCAF/ipHfAtqD+MHJJ/r+zBYryuU5hw+89e0VXpYaimy1N55Ogau2XVS
 2AnupkMFWPvzTf0l9kO63em5GJuLm9v+wpHrI31ZVFABjyuqyXVzvHehmERDpsc4zx1K
 MknQ==
X-Gm-Message-State: AOAM5302pU/YMPvXKYZG1A1Alxsnwcx2x4FQLWgzcXGp4a3N/Lcc6hoF
 QRw+FnPLsj3KMoibjCb0kFLJIWiFbXfzkBcrOqq0t+YFFCgdic0LOY8c2UX8lcYz2di/NZKNSx8
 MlMbNcGpdP1m3CkY=
X-Received: by 2002:adf:f786:: with SMTP id q6mr4744068wrp.120.1589556072613; 
 Fri, 15 May 2020 08:21:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzPELqCVKMK9hECEQKDvH51TzvynxIWjkkPp4CpKZLDeuxg/pzsM09HF9TfUvRQIBKphVg2cw==
X-Received: by 2002:adf:f786:: with SMTP id q6mr4744034wrp.120.1589556072314; 
 Fri, 15 May 2020 08:21:12 -0700 (PDT)
Received: from steredhat.redhat.com ([79.49.207.108])
 by smtp.gmail.com with ESMTPSA id q9sm3913849wmb.34.2020.05.15.08.21.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2020 08:21:11 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] virtio: add vhost-user-vsock device
Date: Fri, 15 May 2020 17:21:07 +0200
Message-Id: <20200515152110.202917-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 22:56:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 hw/virtio/vhost-user-vsock.c           | 188 ++++++++++++++++
 hw/virtio/vhost-vsock-common.c         | 258 ++++++++++++++++++++++
 hw/virtio/vhost-vsock.c                | 283 ++++---------------------
 hw/virtio/Makefile.objs                |   4 +-
 9 files changed, 663 insertions(+), 251 deletions(-)
 create mode 100644 include/hw/virtio/vhost-user-vsock.h
 create mode 100644 include/hw/virtio/vhost-vsock-common.h
 create mode 100644 hw/virtio/vhost-user-vsock-pci.c
 create mode 100644 hw/virtio/vhost-user-vsock.c
 create mode 100644 hw/virtio/vhost-vsock-common.c

-- 
2.25.4


