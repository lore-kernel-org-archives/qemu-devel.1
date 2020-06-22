Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5110AC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 13:57:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D96520732
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 13:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hK3xV5iK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D96520732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnMww-0006kk-Cl
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 09:57:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57202)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jnMvp-0005PE-A9
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 09:56:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53395
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jnMvn-0007iu-BE
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 09:56:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592834174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=koPta83YrvYTu3iosfVuLysO1zTX+p+Br2Szbh760II=;
 b=hK3xV5iKqnkZDSdzLfWl5R06mkXGB/yDooAN45B+Jbze6COoc1F+blWja6rtdXX/nKNlR3
 ClHRlMCFZRNbgjSLrwDYDv+G4DvRdYEFFgqdcv4bZv4FsuJS5KjxFJ1pjDCpvCh71hgUzm
 m42MPDhRpXaVYIVbgyS2xJtnvNtTvcs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-hGMWWiCnN-SY3IZcr19uBw-1; Mon, 22 Jun 2020 09:56:08 -0400
X-MC-Unique: hGMWWiCnN-SY3IZcr19uBw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D32A18005AD
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 13:56:07 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-67.ams2.redhat.com
 [10.36.112.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4EB9B5D9E2;
 Mon, 22 Jun 2020 13:56:02 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 1DED117477; Mon, 22 Jun 2020 15:56:01 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 0/7] build some devices as modules.
Date: Mon, 22 Jun 2020 15:55:54 +0200
Message-Id: <20200622135601.12433-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 01:27:42
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
Cc: dinechin@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
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

Gerd Hoffmann (7):
  qdev: add support for device module loading
  build: fix device module builds
  ccid: build smartcard as module
  usb: build usb-redir as module
  vga: build qxl as module
  vga: build virtio-gpu only once
  vga: build virtio-gpu as module

 Makefile.objs            |  1 +
 Makefile.target          |  7 +++++
 include/hw/qdev-core.h   |  3 ++
 include/qemu/module.h    |  1 +
 hw/core/qdev.c           | 66 ++++++++++++++++++++++++++++++++++++++++
 qdev-monitor.c           |  5 +++
 qom/qom-qmp-cmds.c       |  5 +++
 softmmu/vl.c             |  4 +++
 stubs/hw-module.c        | 10 ++++++
 hw/Makefile.objs         |  2 ++
 hw/display/Makefile.objs | 28 ++++++++++-------
 hw/usb/Makefile.objs     | 13 +++++---
 stubs/Makefile.objs      |  1 +
 13 files changed, 131 insertions(+), 15 deletions(-)
 create mode 100644 stubs/hw-module.c

-- 
2.18.4


