Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175D8C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 08:35:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6B43206F6
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 08:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DIVoqG0j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6B43206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQRu3-0008Ch-1I
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 04:35:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56438 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jQRrA-0002sq-Hm
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 04:32:45 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jQRr9-0006tn-Dr
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 04:32:43 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33952
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jQRr8-0006rh-Ux
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 04:32:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587371561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=xS3vlB7KqlCLTE+lOSq/HmUkat1SPEowKIyCt6Zygn4=;
 b=DIVoqG0jNr7sPrxFm4XIXfw99XBIoEONdJVEJoYE/X8Zcd4KMTqqkPwPZGeClX4UBKYoq8
 tArHUEvOj6pp8dBSGcZk4zHVkUEpELlgN+eblbGkipb3CiW1Nhwu5gUKZNQMRwSvsauaep
 5J3g2BmQo5G8ZKGTgsIRp+rqOmUJgRg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-yvzSMJakOpaqMpvfV3AwoQ-1; Mon, 20 Apr 2020 04:32:39 -0400
X-MC-Unique: yvzSMJakOpaqMpvfV3AwoQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72E2A1005509
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 08:32:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 426FB27BDC
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 08:32:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9CC6B11358BC; Mon, 20 Apr 2020 10:32:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/11] Miscellaneous error handling fixes
Date: Mon, 20 Apr 2020 10:32:25 +0200
Message-Id: <20200420083236.19309-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 01:47:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Maintainers decide whether any of these are serious enough to still go
into 5.0.  I doubt it.

Markus Armbruster (11):
  cryptodev: Fix cryptodev_builtin_cleanup() error API violation
  block/file-posix: Fix check_cache_dropped() error handling
  cpus: Fix configure_icount() error API violation
  cpus: Proper range-checking for -icount shift=3DN
  arm/virt: Fix virt_machine_device_plug_cb() error API violation
  fdc: Fix fallback=3Dauto error handling
  bochs-display: Fix vgamem=3DSIZE error handling
  virtio-net: Fix duplex=3D... and speed=3D... error handling
  xen/pt: Fix flawed conversion to realize()
  io: Fix qio_channel_socket_close() error handling
  migration/colo: Fix qmp_xen_colo_do_checkpoint() error handling

 backends/cryptodev-builtin.c | 10 ++-----
 block/file-posix.c           |  5 +++-
 cpus.c                       | 52 +++++++++++++++++++++---------------
 hw/arm/virt.c                |  4 +--
 hw/block/fdc.c               |  1 +
 hw/display/bochs-display.c   |  6 +++--
 hw/net/virtio-net.c          |  5 +++-
 hw/xen/xen_pt.c              | 12 ++++-----
 io/channel-socket.c          |  5 ++--
 migration/colo.c             |  8 +++++-
 10 files changed, 63 insertions(+), 45 deletions(-)

--=20
2.21.1


