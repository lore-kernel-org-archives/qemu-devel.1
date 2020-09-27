Return-Path: <SRS0=PST1=DE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12D0C4346E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 14:59:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4087523899
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 14:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UEIb/IgD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4087523899
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMY8q-0005uK-3i
	for qemu-devel@archiver.kernel.org; Sun, 27 Sep 2020 10:59:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kMY7v-0005Fo-M5
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 10:58:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53750)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kMY7t-0006Ry-Fr
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 10:58:10 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601218687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=emFydObY5sOmzVU7aR2Oxn+24L3b3rXtNM8x9eSycYY=;
 b=UEIb/IgDc+wZxixa0WD1Y40ww1my6xYW88SeIhWdCHcmePYn0b9doG9AYNPVliFAQlmrFY
 ktIkWaxAP5Klvg7IXFb+udZFr5y0gu5oV3HpM9HIhZKFjwRQ7o7IPVFEH1tomQVlKNDzgM
 1Yy405ZiJw6NVRclz1hgUY44zkPHJLk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-NwAf63WvN329U0R4_XFiRA-1; Sun, 27 Sep 2020 10:58:05 -0400
X-MC-Unique: NwAf63WvN329U0R4_XFiRA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0215C1DDE2;
 Sun, 27 Sep 2020 14:58:04 +0000 (UTC)
Received: from localhost (unknown [10.36.110.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8CD1C55777;
 Sun, 27 Sep 2020 14:57:54 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/6] Add physical display dimensions to spice/virtio-gpu
Date: Sun, 27 Sep 2020 18:57:45 +0400
Message-Id: <20200927145751.365446-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=marcandre.lureau@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/27 10:58:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.576,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: spice-devel@lists.freedesktop.org, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>=0D

Hi,=0D
=0D
This series improves the support for HiDPI displays with Spice.=0D
The related spice series have already been merged.=0D
=0D
v3:=0D
 - simplify the handling of Spice monitor configuration (Frediano)=0D
v2:=0D
 - add a patch to "spice: remove the single monitor config logic" (Gerd)=0D
=0D
Marc-Andr=C3=A9 Lureau (6):=0D
  edid: fix physical display size computation=0D
  edid: use physical dimensions if available=0D
  ui: add getter for UIInfo=0D
  spice: remove the single monitor config logic=0D
  spice: get monitors physical dimension=0D
  virtio-gpu: set physical dimensions for EDID=0D
=0D
 hw/display/edid-generate.c     | 36 +++++++++++++++++++++++-----------=0D
 hw/display/virtio-gpu-base.c   |  2 ++=0D
 hw/display/virtio-gpu.c        |  2 ++=0D
 include/hw/display/edid.h      |  5 ++++-=0D
 include/hw/virtio/virtio-gpu.h |  1 +=0D
 include/ui/console.h           |  4 ++++=0D
 qemu-edid.c                    | 11 +++++++++--=0D
 ui/console.c                   |  7 +++++++=0D
 ui/spice-display.c             | 35 ++++++++++++---------------------=0D
 9 files changed, 66 insertions(+), 37 deletions(-)=0D
=0D
--=20=0D
2.26.2=0D
=0D


