Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7ED0C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 12:46:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69512207CB
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 12:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="GT+rFY3/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69512207CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdvS8-0001H9-Hx
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 08:46:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rvkagan@yandex-team.ru>)
 id 1jdvR1-00080M-Rz; Wed, 27 May 2020 08:45:27 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:59790)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rvkagan@yandex-team.ru>)
 id 1jdvQy-0001Q8-HS; Wed, 27 May 2020 08:45:25 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net
 [IPv6:2a02:6b8:0:1a2d::301])
 by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 2C5E72E1581;
 Wed, 27 May 2020 15:45:18 +0300 (MSK)
Received: from iva4-7c3d9abce76c.qloud-c.yandex.net
 (iva4-7c3d9abce76c.qloud-c.yandex.net [2a02:6b8:c0c:4e8e:0:640:7c3d:9abc])
 by mxbackcorp1o.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 yGuxnAsuRm-jBxmk9RU; Wed, 27 May 2020 15:45:18 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1590583518; bh=42hnJ6RHsswvNBcGuhOx1Vid5BV/7/IOuRuXw9PtENo=;
 h=Message-Id:Date:Subject:To:From:Cc;
 b=GT+rFY3/A/0GhjPSqnGNvn8/0KVp00ezEslGbKJi1h1CVFHRFaME8nksjJwjD6zVw
 raZBgRPM5mlp8y4/rx6hWXKRnNlkNTSuGd95/scuF9tESi9pzKpbstRV6qtHXXiAtn
 i85pJ9QEsSf4mIai+JIHe8xloikKTWVzzaQUhOKI=
Authentication-Results: mxbackcorp1o.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b080:8308::1:12])
 by iva4-7c3d9abce76c.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 bzO5qPtczO-jBWOPpYZ; Wed, 27 May 2020 15:45:11 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
From: Roman Kagan <rvkagan@yandex-team.ru>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 0/5] block: enhance handling of size-related BlockConf
 properties
Date: Wed, 27 May 2020 15:45:06 +0300
Message-Id: <20200527124511.986099-1-rvkagan@yandex-team.ru>
X-Mailer: git-send-email 2.26.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=95.108.205.193;
 envelope-from=rvkagan@yandex-team.ru; helo=forwardcorp1o.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 08:45:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_PASS=-0.001,
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
 Stefano Stabellini <sstabellini@kernel.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Paul Durrant <paul@xen.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

BlockConf includes several properties counted in bytes.=0D
=0D
Enhance their handling in a some aspects, specifically=0D
=0D
- accept common size suffixes (k, m)=0D
- perform consistency checks on the values=0D
- lift the upper limit on physical_block_size and logical_block_size=0D
=0D
Also fix the accessor for opt_io_size in virtio-blk to make it consistent w=
ith=0D
the size of the field.=0D
=0D
History:=0D
v5 -> v6:=0D
- fix forgotten xen-block and swim=0D
- add prop_size32 instead of going with 64bit=0D
=0D
v4 -> v5:=0D
- re-split the patches [Philippe]=0D
- fix/reword error messages [Philippe, Kevin]=0D
- do early return on failed consistency check [Philippe]=0D
- use QEMU_IS_ALIGNED instead of open coding [Philippe]=0D
- make all BlockConf size props support suffixes=0D
- expand the log for virtio-blk opt_io_size [Michael]=0D
=0D
v3 -> v4:=0D
- add patch to fix opt_io_size width in virtio-blk=0D
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
Roman Kagan (5):=0D
  virtio-blk: store opt_io_size with correct size=0D
  block: consolidate blocksize properties consistency checks=0D
  qdev-properties: blocksize: use same limits in code and description=0D
  block: make size-related BlockConf properties accept size suffixes=0D
  block: lift blocksize property limit to 2 MiB=0D
=0D
 include/hw/block/block.h     |  14 +-=0D
 include/hw/qdev-properties.h |   5 +-=0D
 hw/block/block.c             |  41 ++-=0D
 hw/block/fdc.c               |   5 +-=0D
 hw/block/nvme.c              |   5 +-=0D
 hw/block/swim.c              |   5 +-=0D
 hw/block/virtio-blk.c        |   9 +-=0D
 hw/block/xen-block.c         |   6 +-=0D
 hw/core/qdev-properties.c    |  85 +++++-=0D
 hw/ide/qdev.c                |   5 +-=0D
 hw/scsi/scsi-disk.c          |  12 +-=0D
 hw/usb/dev-storage.c         |   5 +-=0D
 tests/qemu-iotests/172.out   | 532 +++++++++++++++++------------------=0D
 13 files changed, 420 insertions(+), 309 deletions(-)=0D
=0D
-- =0D
2.26.2=0D
=0D

