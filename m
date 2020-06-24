Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E30DC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 13:12:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EE9D20786
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 13:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dNdrogpk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EE9D20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo5CW-00041t-BU
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 09:12:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40980)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jo5B8-0002Du-Au
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 09:11:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35702
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jo5B6-0001TA-Lc
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 09:11:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593004259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=sr0lGjX37bfFElAIYeIf6/YwbJzx83Nd0T8AXvQ6TXY=;
 b=dNdrogpkbI0wLB/JOnE5OHxSFOJeB9at/Vi2QiYai220Vtq6mUer25mdvO4nwYj3sJtD2O
 YksJ2kMtr8IFUJlo8oMxOLgnD+0ZX20C4kmFNczq7tLye7I2qoZ9XR3pjM/ue21SogXyLp
 JRDsHFXs6Z0nwWMnytepuWP6KS9xe6Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-Pkvy_bPWO2e8KovSLCiX6Q-1; Wed, 24 Jun 2020 09:10:56 -0400
X-MC-Unique: Pkvy_bPWO2e8KovSLCiX6Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7DE0618A8223
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 13:10:55 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-67.ams2.redhat.com
 [10.36.112.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 816755DAA0;
 Wed, 24 Jun 2020 13:10:46 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 93B8C16E18; Wed, 24 Jun 2020 15:10:45 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 00/10] build some devices as modules.
Date: Wed, 24 Jun 2020 15:10:35 +0200
Message-Id: <20200624131045.14512-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 02:33:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 dinechin@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Specifically devices which depend on shared libraries,
to reduce the runtime dependencies of core qemu.

v2:
 - better commit messages.
 - add some more devices.
 - general tidy up.

v3:
 - rebase, solve stubs conflict.
 - fix -vga $name
 - fix -device $name,help

v4:
 - rebase to latest master
 - adapt to armbru's device init changes

v5:
 - move from qdev (aka device) to qom (aka object) level.
 - add braille chardev.

Gerd Hoffmann (10):
  module: qom module support
  object: qom module support
  qdev: device module support
  build: fix device module builds
  ccid: build smartcard as module
  usb: build usb-redir as module
  vga: build qxl as module
  vga: build virtio-gpu only once
  vga: build virtio-gpu as module
  chardev: enable modules, use for braille

 Makefile.objs            |  2 ++
 Makefile.target          |  7 +++++
 include/qemu/module.h    |  2 ++
 include/qom/object.h     | 12 +++++++
 chardev/char.c           |  2 +-
 hw/core/qdev.c           |  6 ++--
 qdev-monitor.c           |  5 +--
 qom/object.c             | 14 +++++++++
 qom/qom-qmp-cmds.c       |  3 +-
 softmmu/vl.c             |  4 +--
 util/module.c            | 67 ++++++++++++++++++++++++++++++++++++++++
 chardev/Makefile.objs    |  5 ++-
 hw/Makefile.objs         |  2 ++
 hw/display/Makefile.objs | 28 ++++++++++-------
 hw/usb/Makefile.objs     | 13 +++++---
 15 files changed, 148 insertions(+), 24 deletions(-)

-- 
2.18.4


