Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA46C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 10:53:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC2D1206B5
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 10:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EDemFVjP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC2D1206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8Lin-0003J8-Q7
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 06:53:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41030)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k8Lhd-00018L-UJ
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 06:52:21 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22575
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k8Lha-0004Ss-NE
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 06:52:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597834337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZqvNa3Td+YZ1Je/SNIqwATQPd5SBzVw1+A57zfnDS2M=;
 b=EDemFVjPqZ/k36C/dXm6pUnF1rr1qlBmulDbrGOC1mOh9oNYO/6RJO13GekOdSFT9yhPPJ
 yw53y97qVMjRRHYU3Dz2CocZa6WnsRLWCVc4jv8bcVaXpPudEZT4psVkmSS9oh9qFaSDte
 laKGcUCn+0B15u6waQm70eY0oPldtss=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-DYcubxlPONKqlGPMYLsPkQ-1; Wed, 19 Aug 2020 06:52:14 -0400
X-MC-Unique: DYcubxlPONKqlGPMYLsPkQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C64F10066FB;
 Wed, 19 Aug 2020 10:52:12 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-114-132.ams2.redhat.com
 [10.36.114.132])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 85B615C1A3;
 Wed, 19 Aug 2020 10:51:57 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] vhost-vsock: force virtio version 1
Date: Wed, 19 Aug 2020 12:51:53 +0200
Message-Id: <20200819105156.54163-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 01:46:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 Cornelia Huck <cohuck@redhat.com>, qemu-stable@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Recenlty changes in QEMU 5.1 requires to set 'disable-legacy=3Don'
on vhost-vsock-pci and vhost-user-vsock-pci devices:

    $ ./qemu-system-x86_64 ... -device vhost-vsock-pci,guest-cid=3D5
        qemu-system-x86_64: -device vhost-vsock-pci,guest-cid=3D5:
        device is modern-only, use disable-legacy=3Don

As discussed with Cornelia [1], this series force virtio version 1
to vhost-vsock-pci, vhost-user-vsock-pci, and vhost-vsock-ccw devices.

virtio-vsock was introduced after the release of VIRTIO 1.0 specifications,
so it should be 'modern-only'.
In addition Cornelia verified that forcing a legacy mode on vhost-vsock-pci
device using x86-64 host and s390x guest, so with different endianness,
produces strange behaviours.

About migration, QEMU 5.1 already requires that the source and destination
specify 'disable-legacy=3Don', otherwise the migration fails in this way:
    qemu-system-x86_64: get_pci_config_device: Bad config data: i=3D0x2 read:=
 12 device: 53 cmask: ff wmask: 0 w1cmask:0
    qemu-system-x86_64: Failed to load PCIDevice:config
    qemu-system-x86_64: Failed to load virtio-vhost_vsock:virtio
    qemu-system-x86_64: error while loading state for instance 0x0 of device =
'0000:00:03.0/virtio-vhost_vsock'
    qemu-system-x86_64: load of migration failed: Invalid argument

With this series applied there is the same requirements. Alternatively
we have to detach and re-attach the device manually.

Thanks,
Stefano

[1] https://lists.nongnu.org/archive/html/qemu-devel/2020-08/msg02515.html

Stefano Garzarella (3):
  vhost-vsock-pci: force virtio version 1
  vhost-user-vsock-pci: force virtio version 1
  vhost-vsock-ccw: force virtio version 1

 hw/s390x/vhost-vsock-ccw.c       | 2 ++
 hw/virtio/vhost-user-vsock-pci.c | 2 +-
 hw/virtio/vhost-vsock-pci.c      | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

--=20
2.26.2


