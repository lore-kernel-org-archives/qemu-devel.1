Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6711C32753
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 20:24:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A9802133F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 20:24:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A9802133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxzpC-0005nR-78
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 16:24:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33067)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1hxzn2-0003vd-72
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 16:22:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1hxzn0-0003om-5K
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 16:22:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60704)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1hxzmw-0003kN-FU; Wed, 14 Aug 2019 16:22:30 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0EBF63067294;
 Wed, 14 Aug 2019 20:22:28 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.39])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9750E10016EB;
 Wed, 14 Aug 2019 20:22:22 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 14 Aug 2019 23:22:06 +0300
Message-Id: <20190814202219.1870-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Wed, 14 Aug 2019 20:22:28 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 00/13] RFC: luks/encrypted qcow2 key management
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
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi!

This patch series implements key management for luks based encryption
It supports both raw luks images and qcow2 encrypted images.

Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1731898

There are still several issues that need to be figured out,
on which the feedback is very welcome, but other than that the code mostly works.

The main issues are:

1. Instead of the proposed blockdev-update-encryption/blockdev-erase-encryption
interface, it is probably better to implement 'blockdev-amend-options' in qmp,
and use this both for offline and online key update (with some translation
layer to convert the qemu-img 'options' to qmp structures)

This interface already exists for offline qcow2 format options update/

This is an issue that was raised today on IRC with Kevin Wolf. Really thanks
for the idea!

We agreed that this new qmp interface should take the same options as
blockdev-create does, however since we want to be able to edit the encryption
slots separately, this implies that we sort of need to allow this on creation
time as well.

Also the BlockdevCreateOptions is a union, which is specialized by the driver name
which is great for creation, but for update, the driver name is already known,
and thus the user should not be forced to pass it again.
However qmp doesn't seem to support union type guessing based on actual fields
given (this might not be desired either), which complicates this somewhat.

2. 'crypto' driver (the raw luks block device/file) has special behavior for

share-rw=on. write sharing usually is only allowed for raw files, files that
qemu doesn't itself touch, but only guest does. For such files a well behaved guests can
share the storage.

On the other hand most of the format drivers need to store the metadata, and we don't
have any format driver which implements some kind of sync vs other users of the same
file, thus this is not allowed.

However since for luks which is technically a format driver, the metadata is readonly,
such write sharing was allowed till now, and due to backward compatibility should
still be allowed in the future.

This causes an issue with online updating of the keys, and the solution that was suggested
by Keven that I implemented was to request the exclusive write access only during the key
update.

Testing. This was lightly tested with manual testing and with few iotests that I prepared.
I haven't yet tested fully the write sharing behavior, nor did I run the whole iotests
suite to see if this code causes some regressions. Since I will need probably
to rewrite some chunks of it to change to 'amend' interface, I decided to post it now,
to see if you have other ideas/comments to add.

Best regards,
	Maxim Levitsky

Maxim Levitsky (13):
  block-crypto: misc refactoring
  qcrypto-luks: misc refactoring
  qcrypto-luks: refactoring: extract load/store/check/parse header
    functions
  qcrypto-luks: refactoring: simplify the math used for keyslot
    locations
  qcrypto-luks: clear the masterkey and password before freeing them
    always
  qcrypto-luks: implement more rigorous header checking
  block: add manage-encryption command (qmp and blockdev)
  qcrypto: add the plumbing for encryption management
  qcrypto-luks: implement the encryption key management
  block/crypto: implement the encryption key management
  block/qcow2: implement the encryption key managment
  qemu-img: implement key management
  iotests : add tests for encryption key management

 block/block-backend.c            |    9 +
 block/crypto.c                   |  127 ++-
 block/crypto.h                   |    3 +
 block/io.c                       |   24 +
 block/qcow2.c                    |   27 +
 blockdev.c                       |   40 +
 crypto/block-luks.c              | 1673 ++++++++++++++++++++----------
 crypto/block.c                   |   29 +
 crypto/blockpriv.h               |    9 +
 include/block/block.h            |   12 +
 include/block/block_int.h        |   11 +
 include/crypto/block.h           |   27 +
 include/sysemu/block-backend.h   |    7 +
 qapi/block-core.json             |   36 +
 qapi/crypto.json                 |   26 +
 qemu-img-cmds.hx                 |   13 +
 qemu-img.c                       |  140 +++
 tests/qemu-iotests/257           |  197 ++++
 tests/qemu-iotests/257.out       |   96 ++
 tests/qemu-iotests/258           |   95 ++
 tests/qemu-iotests/258.out       |   30 +
 tests/qemu-iotests/259           |  199 ++++
 tests/qemu-iotests/259.out       |    5 +
 tests/qemu-iotests/common.filter |    5 +-
 tests/qemu-iotests/group         |    3 +
 25 files changed, 2286 insertions(+), 557 deletions(-)
 create mode 100755 tests/qemu-iotests/257
 create mode 100644 tests/qemu-iotests/257.out
 create mode 100755 tests/qemu-iotests/258
 create mode 100644 tests/qemu-iotests/258.out
 create mode 100644 tests/qemu-iotests/259
 create mode 100644 tests/qemu-iotests/259.out

-- 
2.17.2


