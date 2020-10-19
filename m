Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21262C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 08:06:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 547C02224D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 08:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S8wvuAB9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 547C02224D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUQBe-0002h6-AU
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 04:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54468)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kUPye-0005eM-6J
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 03:53:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37526)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kUPyW-0008EG-C2
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 03:53:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603093979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=c4FOUYi9cXKiAWDYma5Y4/Q87X5rvRTOZxLMStEVqw4=;
 b=S8wvuAB9GUvAPZ3aquhXgMtJico3eu9Cyok/4/Ye13Gou6PhGPwd+VU/b+RGUV7iG0+Z6p
 yWaWVYE5BvzYsDb6LdCn9xXxkwOg8SwmD9ykYn41p5U7Pd7WCoQUq4DqhTwCTHBWlLOh7r
 pepAcf6FwAPZkk1KBnqUqlGf9SORIUs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-iU6lTWIUMe63aj_F3WgPvg-1; Mon, 19 Oct 2020 03:52:57 -0400
X-MC-Unique: iU6lTWIUMe63aj_F3WgPvg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B4F510A0B83
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 07:52:56 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-56.ams2.redhat.com
 [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 14E287838A;
 Mon, 19 Oct 2020 07:52:25 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 1508316E18; Mon, 19 Oct 2020 09:52:24 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/14] ui: build spice and opengl as module.
Date: Mon, 19 Oct 2020 09:52:10 +0200
Message-Id: <20201019075224.14803-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 01:44:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

- Add QemuSpiceOps, reorganize spice stubs.=0D
- Add support for module dependencies.=0D
- Build spice-core modular, and make the existing spice=0D
  modules (audio, chardev, qxl) depend on spice-core.=0D
- Build egl-headless display and opengl helpers modular=0D
  (pretty easy thanks to module dependencies).=0D
=0D
Gerd Hoffmann (14):=0D
  spice: add module helpers=0D
  spice: add QemuSpiceOps, move migrate_info=0D
  spice: move qemu_spice_init() to QemuSpiceOps.=0D
  spice: move display_init() to QemuSpiceOps.=0D
  spice: move add_interface() to QemuSpiceOps.=0D
  spice: move auth functions to QemuSpiceOps.=0D
  spice: move display_add_client() to QemuSpiceOps.=0D
  spice: wire up monitor in QemuSpiceOps.=0D
  spice: load module when enabled on the cmdline=0D
  modules: dependencies infrastructure=0D
  modules: add spice dependencies=0D
  spice: flip modules switch=0D
  opengl: build egl-headless display modular=0D
  opengl: build opengl helper code modular=0D
=0D
 include/ui/qemu-spice-module.h | 44 ++++++++++++++++++=0D
 include/ui/qemu-spice.h        | 42 +----------------=0D
 audio/spiceaudio.c             |  4 +-=0D
 chardev/spice.c                |  2 +-=0D
 monitor/misc.c                 |  2 +-=0D
 monitor/qmp-cmds.c             |  6 +--=0D
 softmmu/vl.c                   | 10 ++--=0D
 ui/spice-core.c                | 31 +++++++++----=0D
 ui/spice-input.c               |  6 +--=0D
 ui/spice-module.c              | 85 ++++++++++++++++++++++++++++++++++=0D
 util/module.c                  | 44 ++++++++++++++++--=0D
 ui/meson.build                 | 28 +++++++++--=0D
 12 files changed, 232 insertions(+), 72 deletions(-)=0D
 create mode 100644 include/ui/qemu-spice-module.h=0D
 create mode 100644 ui/spice-module.c=0D
=0D
--=20=0D
2.27.0=0D
=0D


