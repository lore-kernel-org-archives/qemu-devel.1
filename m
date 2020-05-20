Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EACC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 08:09:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C26F2065F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 08:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="YzFBCQet"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C26F2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbJmi-0007Tf-HS
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 04:09:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rvkagan@yandex-team.ru>)
 id 1jbJkt-0004P2-1R; Wed, 20 May 2020 04:07:11 -0400
Received: from forwardcorp1j.mail.yandex.net ([2a02:6b8:0:1619::183]:34328)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rvkagan@yandex-team.ru>)
 id 1jbJkp-0008Pp-Dz; Wed, 20 May 2020 04:07:09 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net
 [IPv6:2a02:6b8:0:1619::162])
 by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 0667B2E1521;
 Wed, 20 May 2020 11:07:00 +0300 (MSK)
Received: from vla5-58875c36c028.qloud-c.yandex.net
 (vla5-58875c36c028.qloud-c.yandex.net [2a02:6b8:c18:340b:0:640:5887:5c36])
 by mxbackcorp1j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 bcsor4v0rj-6vTS8sZb; Wed, 20 May 2020 11:06:59 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1589962019; bh=EjkfETItd56nU4EAo+AAosAF/iNz9qJsYjkDq713yZY=;
 h=Message-Id:Date:Subject:To:From:Cc;
 b=YzFBCQetTXcFsa27/ANaYOuMldTEtRTKzYZmCQdT+tYGTKD5WZn2gH/3bYqWD8Frl
 4XFwVcTdjMQTTlPRxXWm+Jt2OB0LyNh1QkDIXhR3hoYwbxnnIjIlEHwwoSJt6ulFqr
 mXnGfwkCLfmykRGQTSKOVVXF9JUO8mPWI9OXO/VI=
Authentication-Results: mxbackcorp1j.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b081:1519::1:a])
 by vla5-58875c36c028.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 HRdUjo6D3m-6vXmwmik; Wed, 20 May 2020 11:06:57 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
From: Roman Kagan <rvkagan@yandex-team.ru>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 0/3] block: make BlockConf.*_size properties 32-bit
Date: Wed, 20 May 2020 11:06:54 +0300
Message-Id: <20200520080657.29080-1-rvkagan@yandex-team.ru>
X-Mailer: git-send-email 2.26.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a02:6b8:0:1619::183;
 envelope-from=rvkagan@yandex-team.ru; helo=forwardcorp1j.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, John Snow <jsnow@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Devices (virtio-blk, scsi, etc.) and the block layer are happy to use=0D
32-bit for logical_block_size, physical_block_size, and min_io_size.=0D
However, the properties in BlockConf are defined as uint16_t limiting=0D
the values to 32768.=0D
=0D
This appears unnecessary tight, and we've seen bigger block sizes handy=0D
at times.=0D
=0D
Make them 32 bit instead and lift the limitation up to 2 MiB which=0D
appears to be good enough for everybody, and matches the qcow2 cluster=0D
size limit.=0D
=0D
As the values can now be fairly big and awkward to type, make the=0D
property setter accept common size suffixes (k, m).=0D
=0D
While at this, introduce a few consistency checks on the blocksize-related=
=0D
values in BlockConf, to prevent their silent truncation or rounding.=0D
=0D
Also fix the accessor for opt_io_size in virtio-blk to make it consistent w=
ith=0D
the size of the field, and thus synchronize virtio-blk and scsi in the way=
=0D
opt_io_size is used.=0D
=0D
History:=0D
v3 -> v4:=0D
- add patch to opt_io_size width=0D
- add patch to perform consistency checks [Kevin]=0D
- check min_io_size against truncation [Kevin]=0D
=0D
v2 -> v3:=0D
- mention qcow2 cluster size limit in the log and comment [Eric]=0D
=0D
v1 -> v2:=0D
- cap the property at 2 MiB [Eric]=0D
- accept size suffixes=0D
=0D
Roman Kagan (3):=0D
  virtio-blk: store opt_io_size with correct size=0D
  block: consolidate blocksize properties consistency checks=0D
  block: make BlockConf.*_size properties 32-bit=0D
=0D
 include/hw/block/block.h     | 10 ++++-----=0D
 include/hw/qdev-properties.h |  2 +-=0D
 hw/block/block.c             | 40 +++++++++++++++++++++++++++++++++++-=0D
 hw/block/fdc.c               |  5 ++++-=0D
 hw/block/nvme.c              |  5 ++++-=0D
 hw/block/virtio-blk.c        |  9 ++------=0D
 hw/core/qdev-properties.c    | 34 +++++++++++++++++++++---------=0D
 hw/ide/qdev.c                |  5 ++++-=0D
 hw/scsi/scsi-disk.c          | 10 +++------=0D
 hw/usb/dev-storage.c         |  5 ++++-=0D
 tests/qemu-iotests/172.out   |  2 +-=0D
 11 files changed, 91 insertions(+), 36 deletions(-)=0D
=0D
-- =0D
2.26.2=0D
=0D

