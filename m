Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBCEAC433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 22:02:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB57720706
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 22:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fNsqUzkz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB57720706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAKY3-0008M0-UZ
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 18:02:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48566)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kAKVO-0006DM-Rm
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 17:59:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42818
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kAKVL-0008FF-AD
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 17:59:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598306389;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XsuS4RWhkmHJmOqgg1gzMNuS2tjgVfSq3SfuWytoBDM=;
 b=fNsqUzkzDEwejVRDI7SJ7nSjeXNFDt72q5YMoUQzZDK5qq0+JMn5VfgVtJuGdrf/KBjbBY
 FAM7bkGNDrPvB8M6cJoy/BTJcjEcYzdy2zvpiQ6vlFL8SK2GIf0bsQRfS8ba8hGP91D90a
 4DEL0cNaBY/IVNN9vnWVSYCFbAAAWFs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-0UPd6I7dN-ShNPbKJVmCQQ-1; Mon, 24 Aug 2020 17:59:48 -0400
X-MC-Unique: 0UPd6I7dN-ShNPbKJVmCQQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2382918A224F;
 Mon, 24 Aug 2020 21:59:47 +0000 (UTC)
Received: from localhost (unknown [10.10.67.254])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F36785B680;
 Mon, 24 Aug 2020 21:59:36 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/6] qom: Use typedefs instead of struct names on
 instance_size/class_size
Date: Mon, 24 Aug 2020 17:59:30 -0400
Message-Id: <20200824215936.2961951-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 16:48:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This changes existing QOM boilerplate to use existing typedef=0D
names when setting instance_size and class_size on TypeInfo=0D
variables.  This makes the code more consistent and will make=0D
future conversion to QOM type declaration macros easier.=0D
=0D
Cc: "Michael S. Tsirkin" <mst@redhat.com>=0D
Cc: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>=0D
Cc: Gerd Hoffmann <kraxel@redhat.com>=0D
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>=0D
Cc: Alistair Francis <alistair@alistair23.me>=0D
Cc: Peter Maydell <peter.maydell@linaro.org>=0D
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>=0D
Cc: Jason Wang <jasowang@redhat.com>=0D
Cc: qemu-devel@nongnu.org=0D
Cc: qemu-arm@nongnu.org=0D
=0D
Eduardo Habkost (6):=0D
  xilinx_axidma: Use typedef name for instance_size=0D
  omap_intc: Use typedef name for instance_size=0D
  lpc_ich9: Use typedef name for instance_size=0D
  xilinx_axienet: Use typedef name for instance_size=0D
  vhost-user-vga: Use typedef name for instance_size=0D
  virtio-vga: Use typedef name for instance_size=0D
=0D
 hw/display/vhost-user-vga.c | 2 +-=0D
 hw/display/virtio-vga.c     | 6 +++---=0D
 hw/dma/xilinx_axidma.c      | 4 ++--=0D
 hw/intc/omap_intc.c         | 2 +-=0D
 hw/isa/lpc_ich9.c           | 2 +-=0D
 hw/net/xilinx_axienet.c     | 4 ++--=0D
 6 files changed, 10 insertions(+), 10 deletions(-)=0D
=0D
--=20=0D
2.26.2=0D
=0D


