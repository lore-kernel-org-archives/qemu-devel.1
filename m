Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F84C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 20:41:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BCD120663
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 20:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OwZs0Sma"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BCD120663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsXvW-0004jE-7A
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 16:41:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52510)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jsXuN-0002zj-IU
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 16:40:11 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20687
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jsXuK-0002T8-J9
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 16:40:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594068007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=b1TX1DgeBrDNcQ8i7BNWXPZR6629OOyXYFtQ/bDhXMk=;
 b=OwZs0SmakUa91lrWtV1sazD0+l+DRW4Zpr88rpV7G+XhRWkezAQoCVo+2aMCTiG4ZUB1N+
 5J198ZKXsfAeDAws5M5ggPKoasG92p1fb2LOWDOXg5wtfgEY7MlLi6JQU3fYR9k9n6AtZc
 nS3xcHW90AgHJGxniDKU5GMbbSUah/k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-HS9ozvHAO3aRd7TyQGHBrg-1; Mon, 06 Jul 2020 16:39:58 -0400
X-MC-Unique: HS9ozvHAO3aRd7TyQGHBrg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E469580B70A;
 Mon,  6 Jul 2020 20:39:57 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-97.phx2.redhat.com [10.3.113.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 93ED81C4;
 Mon,  6 Jul 2020 20:39:54 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 00/10] Tighten qemu-img rules on missing backing format
Date: Mon,  6 Jul 2020 15:39:44 -0500
Message-Id: <20200706203954.341758-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 15:29:35
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org,
 kchamart@redhat.com, libvir-list@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v5 was here:
https://lists.gnu.org/archive/html/qemu-devel/2020-04/msg00679.html
In v6:
- add a few more patches
- change qcow semantics based on several iterations of mailing list
debates on what behavior is easiest to support
- add iotesting that a probed raw file cannot be committed into
- instead of recording an implicit probed raw file, instead we record
only a non-raw file
- rebase to a few more affected iotests, plus s/5.0/5.1/

Yes, I know this is really short notice to make it in before feature
freeze for 5.1 (removal in 6.0), so it may end up slipping into 5.2
(removal in 6.1); but we'll see how things go.

Also available at
https://repo.or.cz/qemu/ericb.git/shortlog/refs/tags/qemu-img-create-backing-v6

001/10:[down] 'qemu-img: Flush stdout before before potential stderr messages'
002/10:[down] 'block: Finish deprecation of 'qemu-img convert -n -o''
003/10:[----] [--] 'sheepdog: Add trivial backing_fmt support'
004/10:[----] [--] 'vmdk: Add trivial backing_fmt support'
005/10:[0088] [FC] 'qcow: Tolerate backing_fmt='
006/10:[down] 'block: Error if backing file fails during creation without -u'
007/10:[0004] [FC] 'qcow2: Deprecate use of qemu-img amend to change backing file'
008/10:[0059] [FC] 'iotests: Specify explicit backing format where sensible'
009/10:[----] [-C] 'block: Add support to warn on backing file change without format'
010/10:[0027] [FC] 'qemu-img: Deprecate use of -b without -F'

Eric Blake (10):
  qemu-img: Flush stdout before before potential stderr messages
  block: Finish deprecation of 'qemu-img convert -n -o'
  sheepdog: Add trivial backing_fmt support
  vmdk: Add trivial backing_fmt support
  qcow: Tolerate backing_fmt=
  block: Error if backing file fails during creation without -u
  qcow2: Deprecate use of qemu-img amend to change backing file
  iotests: Specify explicit backing format where sensible
  block: Add support to warn on backing file change without format
  qemu-img: Deprecate use of -b without -F

 docs/system/deprecated.rst    | 58 +++++++++++++++++++----
 docs/tools/qemu-img.rst       |  4 ++
 include/block/block.h         |  4 +-
 block.c                       | 53 +++++++++++++++------
 block/qcow.c                  | 20 +++++++-
 block/qcow2.c                 |  7 ++-
 block/sheepdog.c              | 18 ++++++-
 block/stream.c                |  2 +-
 block/vmdk.c                  | 14 ++++++
 blockdev.c                    |  3 +-
 qemu-img.c                    | 15 ++++--
 tests/qemu-iotests/017        |  2 +-
 tests/qemu-iotests/017.out    |  2 +-
 tests/qemu-iotests/018        |  2 +-
 tests/qemu-iotests/018.out    |  2 +-
 tests/qemu-iotests/019        |  5 +-
 tests/qemu-iotests/019.out    |  2 +-
 tests/qemu-iotests/020        |  4 +-
 tests/qemu-iotests/020.out    |  4 +-
 tests/qemu-iotests/024        |  8 ++--
 tests/qemu-iotests/024.out    |  5 +-
 tests/qemu-iotests/028        |  4 +-
 tests/qemu-iotests/028.out    |  2 +-
 tests/qemu-iotests/030        | 26 ++++++++---
 tests/qemu-iotests/034        |  2 +-
 tests/qemu-iotests/034.out    |  2 +-
 tests/qemu-iotests/037        |  2 +-
 tests/qemu-iotests/037.out    |  2 +-
 tests/qemu-iotests/038        |  2 +-
 tests/qemu-iotests/038.out    |  2 +-
 tests/qemu-iotests/039        |  3 +-
 tests/qemu-iotests/039.out    |  2 +-
 tests/qemu-iotests/040        | 47 +++++++++++++------
 tests/qemu-iotests/041        | 37 ++++++++++-----
 tests/qemu-iotests/042        |  4 +-
 tests/qemu-iotests/043        | 18 +++----
 tests/qemu-iotests/043.out    | 16 ++++---
 tests/qemu-iotests/046        |  2 +-
 tests/qemu-iotests/046.out    |  2 +-
 tests/qemu-iotests/049.out    |  8 ++--
 tests/qemu-iotests/050        |  4 +-
 tests/qemu-iotests/050.out    |  2 +-
 tests/qemu-iotests/051        |  2 +-
 tests/qemu-iotests/051.out    |  2 +-
 tests/qemu-iotests/051.pc.out |  2 +-
 tests/qemu-iotests/054.out    |  2 +-
 tests/qemu-iotests/056        |  3 +-
 tests/qemu-iotests/060        |  2 +-
 tests/qemu-iotests/060.out    |  2 +-
 tests/qemu-iotests/061        | 10 ++--
 tests/qemu-iotests/061.out    | 11 +++--
 tests/qemu-iotests/069        |  2 +-
 tests/qemu-iotests/069.out    |  2 +-
 tests/qemu-iotests/073        |  2 +-
 tests/qemu-iotests/073.out    |  2 +-
 tests/qemu-iotests/079.out    |  2 +-
 tests/qemu-iotests/082        | 10 ++--
 tests/qemu-iotests/082.out    | 14 +++---
 tests/qemu-iotests/085        |  4 +-
 tests/qemu-iotests/085.out    |  6 +--
 tests/qemu-iotests/089        |  2 +-
 tests/qemu-iotests/089.out    |  2 +-
 tests/qemu-iotests/095        |  4 +-
 tests/qemu-iotests/095.out    |  4 +-
 tests/qemu-iotests/097        |  4 +-
 tests/qemu-iotests/097.out    | 16 +++----
 tests/qemu-iotests/098        |  2 +-
 tests/qemu-iotests/098.out    |  8 ++--
 tests/qemu-iotests/110        |  4 +-
 tests/qemu-iotests/110.out    |  4 +-
 tests/qemu-iotests/111.out    |  2 +-
 tests/qemu-iotests/112.out    |  4 +-
 tests/qemu-iotests/114        | 12 +++++
 tests/qemu-iotests/114.out    |  9 ++++
 tests/qemu-iotests/122        | 34 +++++++++-----
 tests/qemu-iotests/122.out    | 12 +++--
 tests/qemu-iotests/126        |  4 +-
 tests/qemu-iotests/126.out    |  4 +-
 tests/qemu-iotests/127        |  4 +-
 tests/qemu-iotests/127.out    |  4 +-
 tests/qemu-iotests/129        |  3 +-
 tests/qemu-iotests/133        |  2 +-
 tests/qemu-iotests/133.out    |  2 +-
 tests/qemu-iotests/139        |  2 +-
 tests/qemu-iotests/141        |  4 +-
 tests/qemu-iotests/141.out    |  4 +-
 tests/qemu-iotests/142        |  2 +-
 tests/qemu-iotests/142.out    |  2 +-
 tests/qemu-iotests/153        | 14 +++---
 tests/qemu-iotests/153.out    | 35 +++++++-------
 tests/qemu-iotests/154        | 42 ++++++++---------
 tests/qemu-iotests/154.out    | 42 ++++++++---------
 tests/qemu-iotests/155        | 12 +++--
 tests/qemu-iotests/156        |  9 ++--
 tests/qemu-iotests/156.out    |  6 +--
 tests/qemu-iotests/158        |  2 +-
 tests/qemu-iotests/158.out    |  2 +-
 tests/qemu-iotests/161        |  8 ++--
 tests/qemu-iotests/161.out    |  8 ++--
 tests/qemu-iotests/176        |  4 +-
 tests/qemu-iotests/176.out    | 32 ++++++-------
 tests/qemu-iotests/177        |  2 +-
 tests/qemu-iotests/177.out    |  2 +-
 tests/qemu-iotests/179        |  2 +-
 tests/qemu-iotests/179.out    |  2 +-
 tests/qemu-iotests/189        |  2 +-
 tests/qemu-iotests/189.out    |  2 +-
 tests/qemu-iotests/191        | 12 ++---
 tests/qemu-iotests/191.out    | 12 ++---
 tests/qemu-iotests/195        |  6 +--
 tests/qemu-iotests/195.out    |  6 +--
 tests/qemu-iotests/198        |  2 +-
 tests/qemu-iotests/198.out    |  3 +-
 tests/qemu-iotests/204        |  2 +-
 tests/qemu-iotests/204.out    |  2 +-
 tests/qemu-iotests/216        |  2 +-
 tests/qemu-iotests/224        |  4 +-
 tests/qemu-iotests/225        |  2 +-
 tests/qemu-iotests/225.out    |  2 +-
 tests/qemu-iotests/228        |  5 +-
 tests/qemu-iotests/245        |  3 +-
 tests/qemu-iotests/249        |  4 +-
 tests/qemu-iotests/249.out    |  4 +-
 tests/qemu-iotests/252        |  2 +-
 tests/qemu-iotests/257        |  3 +-
 tests/qemu-iotests/259.out    |  2 +-
 tests/qemu-iotests/267        |  4 +-
 tests/qemu-iotests/267.out    |  6 +--
 tests/qemu-iotests/270        |  2 +-
 tests/qemu-iotests/270.out    |  2 +-
 tests/qemu-iotests/273        |  4 +-
 tests/qemu-iotests/273.out    |  4 +-
 tests/qemu-iotests/274        | 12 ++---
 tests/qemu-iotests/274.out    | 29 ++++++------
 tests/qemu-iotests/279        |  4 +-
 tests/qemu-iotests/279.out    |  4 +-
 tests/qemu-iotests/290        |  2 +-
 tests/qemu-iotests/290.out    |  4 +-
 tests/qemu-iotests/293        | 88 +++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/293.out    | 59 +++++++++++++++++++++++
 tests/qemu-iotests/group      |  1 +
 141 files changed, 792 insertions(+), 402 deletions(-)
 create mode 100755 tests/qemu-iotests/293
 create mode 100644 tests/qemu-iotests/293.out

-- 
2.27.0


