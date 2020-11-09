Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705F7C56201
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 11:28:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3ADF2084C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 11:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="IzCpJk3R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3ADF2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc5LL-00037K-LC
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 06:28:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1kc5JR-0001is-Su
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 06:26:17 -0500
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:54200)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1kc5JO-0004xP-B9
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 06:26:16 -0500
Received: from vla1-fdfb804fb3f3.qloud-c.yandex.net
 (vla1-fdfb804fb3f3.qloud-c.yandex.net
 [IPv6:2a02:6b8:c0d:3199:0:640:fdfb:804f])
 by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 7AA0C2E14C2;
 Mon,  9 Nov 2020 14:26:08 +0300 (MSK)
Received: from vla5-58875c36c028.qloud-c.yandex.net
 (vla5-58875c36c028.qloud-c.yandex.net [2a02:6b8:c18:340b:0:640:5887:5c36])
 by vla1-fdfb804fb3f3.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id
 BTX9MESI24-Q8w8D5RQ; Mon, 09 Nov 2020 14:26:08 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1604921168; bh=NB4zUzyl27YzrQuTdtDDvGl0I2qD2FxtKiNboQo3pFY=;
 h=Message-Id:Date:Subject:To:From:Cc;
 b=IzCpJk3RIxQupmfz1U4JoY4YE3xVLPAfVwdwnRjy3fQQa4AGqEReEzxOthNj1I+Gr
 5Q7/ievJIgcQoq3zBb8UPRxOD15c4CtMZyiwRnNXkRgSFTKF6t1YW97PjN1e2PVR+l
 2m754yxgoEwqJO9ug7WmGy673a0Ms5NCRuqc2JZ4=
Authentication-Results: vla1-fdfb804fb3f3.qloud-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b081:605::1:0])
 by vla5-58875c36c028.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 dhixZmtAax-PrnSumc4; Mon, 09 Nov 2020 14:26:08 +0300
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (Client certificate not present)
From: Dima Stepanov <dimastep@yandex-team.ru>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/2] fuzz: add virtio-blk fuzz target
Date: Mon,  9 Nov 2020 14:25:49 +0300
Message-Id: <cover.1604920905.git.dimastep@yandex-team.ru>
X-Mailer: git-send-email 2.7.4
Received-SPF: pass client-ip=77.88.29.217;
 envelope-from=dimastep@yandex-team.ru; helo=forwardcorp1p.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 06:26:09
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
Cc: alxndr@bu.edu, darren.kenny@oracle.com, yc-core@yandex-team.ru,
 stefanha@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v1 -> v2:
  - Update meson build with the CONFIG_VIRTIO_BLK case
  - Add "Reviewed-by: Alexander Bulekov" for both patches

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


