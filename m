Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDEAFC4363D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 13:50:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1953F206F0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 13:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="QlxceLhd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1953F206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ9pe-0000F2-Pl
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 09:50:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60766)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1kQ9nx-0007S2-9X
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 09:48:29 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:48458)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1kQ9nq-0007HY-Sw
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 09:48:26 -0400
Received: from myt5-23f0be3aa648.qloud-c.yandex.net
 (myt5-23f0be3aa648.qloud-c.yandex.net
 [IPv6:2a02:6b8:c12:3e29:0:640:23f0:be3a])
 by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id E7E1F2E0A2D;
 Wed,  7 Oct 2020 16:48:16 +0300 (MSK)
Received: from myt4-18a966dbd9be.qloud-c.yandex.net
 (myt4-18a966dbd9be.qloud-c.yandex.net [2a02:6b8:c00:12ad:0:640:18a9:66db])
 by myt5-23f0be3aa648.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id
 0OzbthAlMi-mGuuYmQq; Wed, 07 Oct 2020 16:48:16 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1602078496; bh=DpsmNAP+OKORs4kA2QUdqK3bC5XLdsYMLzn211UthOA=;
 h=Message-Id:Date:Subject:To:From:Cc;
 b=QlxceLhdU7tc72gvcQBYTyCLj9TeIBo+tadg+/FlUADZax9zIRoA5rSHhl45I/2Rn
 bRIJyCoHESCAl1v2Gmnc2IzCeS1Bon1PDeNdykEoQB22QP4vk3FVv/YgtQ5B63YT+A
 ZDbLcMDcJ4ykF26Ye6fdnfyCHBoMKxAIiOT2ulIw=
Authentication-Results: myt5-23f0be3aa648.qloud-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b081:413::1:13])
 by myt4-18a966dbd9be.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 OPBmtt5AQX-mGoeSQfS; Wed, 07 Oct 2020 16:48:16 +0300
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (Client certificate not present)
From: Dima Stepanov <dimastep@yandex-team.ru>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 0/2] fuzz: add virtio-blk fuzz target
Date: Wed,  7 Oct 2020 16:47:57 +0300
Message-Id: <cover.1602078083.git.dimastep@yandex-team.ru>
X-Mailer: git-send-email 2.7.4
Received-SPF: pass client-ip=77.88.29.217;
 envelope-from=dimastep@yandex-team.ru; helo=forwardcorp1p.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 09:48:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: alxndr@bu.edu, yc-core@yandex-team.ru, stefanha@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Based on the current virtio-scsi-fuzz target implement new virtio-blk
fuzz target. Use a virtio_blk_test.c file as a reference for the block
device initialization.

Also make a small update to the documentation to fix build/run command
lines after meson and build changes in QEMU.

Dima Stepanov (2):
  fuzz: add virtio-blk fuzz target
  docs/fuzz: update make and run command lines

 docs/devel/fuzzing.txt             |   6 +-
 tests/qtest/fuzz/meson.build       |   1 +
 tests/qtest/fuzz/virtio_blk_fuzz.c | 234 +++++++++++++++++++++++++++++++++++++
 3 files changed, 238 insertions(+), 3 deletions(-)
 create mode 100644 tests/qtest/fuzz/virtio_blk_fuzz.c

-- 
2.7.4


