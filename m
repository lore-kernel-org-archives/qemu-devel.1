Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE61C2BB1D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:29:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42FFF206BE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eh3xG2TD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42FFF206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCTWU-0005bk-5L
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 15:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42144)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jCTVS-0004D8-Dt
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:28:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jCTVQ-0006hw-Fe
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:28:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60333
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jCTVQ-0006ew-5t
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:28:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584041311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=n8JMqNQOsyurPFl4DUBBfZRLqE6yhe53M5JEzz9sFM4=;
 b=Eh3xG2TDBVBil7/PQhpXaVgaW9+O4QHIAG0/CugHlsYowikJ13OWKhWy5FXoRgH7YF1piy
 TWizNxmmpnELQwQZbGBl3pFQkkgWQDGFRqQud2xEztdrccAgHec7QH8lDTqPBZ2oJqZsZ4
 GkrpFG3CnJVIAN6Mryn9l0RBsMs0PvQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-qQwBMbfuNdKKOO_sf5ue5g-1; Thu, 12 Mar 2020 15:28:27 -0400
X-MC-Unique: qQwBMbfuNdKKOO_sf5ue5g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62B6A1005513;
 Thu, 12 Mar 2020 19:28:26 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-177.phx2.redhat.com [10.3.116.177])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3B0585DA76;
 Thu, 12 Mar 2020 19:28:23 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 0/7] Tighten qemu-img rules on missing backing format
Date: Thu, 12 Mar 2020 14:28:15 -0500
Message-Id: <20200312192822.3739399-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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

v3 was here:
https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg01730.html
In v4:
- old patch 1 was reworked into new patch 1-3, with stricter rules
on which backing formats are accepted [Kevin]
- patch 4 is new: amend is handled differently from rebase [Kashyap]
- rebase to master

Eric Blake (7):
  sheepdog: Add trivial backing_fmt support
  vmdk: Add trivial backing_fmt support
  qcow: Tolerate backing_fmt=3D, but warn on backing_fmt=3Draw
  qcow2: Deprecate use of qemu-img amend to change backing file
  iotests: Specify explicit backing format where sensible
  block: Add support to warn on backing file change without format
  qemu-img: Deprecate use of -b without -F

 docs/system/deprecated.rst    | 31 +++++++++++++++
 docs/tools/qemu-img.rst       |  4 ++
 include/block/block.h         |  4 +-
 block.c                       | 34 +++++++++++++++--
 block/qcow.c                  | 16 +++++++-
 block/qcow2.c                 |  7 +++-
 block/sheepdog.c              | 14 +++++++
 block/stream.c                |  2 +-
 block/vmdk.c                  | 14 +++++++
 blockdev.c                    |  3 +-
 qemu-img.c                    |  4 +-
 tests/qemu-iotests/017        |  2 +-
 tests/qemu-iotests/017.out    |  2 +-
 tests/qemu-iotests/018        |  2 +-
 tests/qemu-iotests/018.out    |  2 +-
 tests/qemu-iotests/019        |  5 ++-
 tests/qemu-iotests/019.out    |  2 +-
 tests/qemu-iotests/020        |  4 +-
 tests/qemu-iotests/020.out    |  4 +-
 tests/qemu-iotests/024        |  8 ++--
 tests/qemu-iotests/024.out    |  5 ++-
 tests/qemu-iotests/028        |  4 +-
 tests/qemu-iotests/028.out    |  2 +-
 tests/qemu-iotests/030        | 26 +++++++++----
 tests/qemu-iotests/034        |  2 +-
 tests/qemu-iotests/034.out    |  2 +-
 tests/qemu-iotests/037        |  2 +-
 tests/qemu-iotests/037.out    |  2 +-
 tests/qemu-iotests/038        |  2 +-
 tests/qemu-iotests/038.out    |  2 +-
 tests/qemu-iotests/039        |  3 +-
 tests/qemu-iotests/039.out    |  2 +-
 tests/qemu-iotests/040        | 47 ++++++++++++++++-------
 tests/qemu-iotests/041        | 37 ++++++++++++------
 tests/qemu-iotests/042        |  4 +-
 tests/qemu-iotests/043        | 18 ++++-----
 tests/qemu-iotests/043.out    | 16 +++++---
 tests/qemu-iotests/046        |  2 +-
 tests/qemu-iotests/046.out    |  2 +-
 tests/qemu-iotests/050        |  4 +-
 tests/qemu-iotests/050.out    |  2 +-
 tests/qemu-iotests/051        |  2 +-
 tests/qemu-iotests/051.out    |  2 +-
 tests/qemu-iotests/051.pc.out |  2 +-
 tests/qemu-iotests/056        |  3 +-
 tests/qemu-iotests/060        |  2 +-
 tests/qemu-iotests/060.out    |  2 +-
 tests/qemu-iotests/061        | 10 ++---
 tests/qemu-iotests/061.out    | 11 +++---
 tests/qemu-iotests/069        |  2 +-
 tests/qemu-iotests/069.out    |  2 +-
 tests/qemu-iotests/073        |  2 +-
 tests/qemu-iotests/073.out    |  2 +-
 tests/qemu-iotests/082        | 10 +++--
 tests/qemu-iotests/082.out    | 14 ++++---
 tests/qemu-iotests/085        |  4 +-
 tests/qemu-iotests/085.out    |  6 +--
 tests/qemu-iotests/089        |  2 +-
 tests/qemu-iotests/089.out    |  2 +-
 tests/qemu-iotests/095        |  4 +-
 tests/qemu-iotests/095.out    |  4 +-
 tests/qemu-iotests/097        |  4 +-
 tests/qemu-iotests/097.out    | 16 ++++----
 tests/qemu-iotests/098        |  2 +-
 tests/qemu-iotests/098.out    |  8 ++--
 tests/qemu-iotests/110        |  4 +-
 tests/qemu-iotests/110.out    |  4 +-
 tests/qemu-iotests/114        | 11 ++++++
 tests/qemu-iotests/114.out    |  8 ++++
 tests/qemu-iotests/122        | 27 +++++++------
 tests/qemu-iotests/122.out    |  8 ++--
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
 tests/qemu-iotests/153        | 14 +++----
 tests/qemu-iotests/153.out    | 35 +++++++++--------
 tests/qemu-iotests/154        | 42 ++++++++++----------
 tests/qemu-iotests/154.out    | 42 ++++++++++----------
 tests/qemu-iotests/155        | 12 ++++--
 tests/qemu-iotests/156        |  9 +++--
 tests/qemu-iotests/156.out    |  6 +--
 tests/qemu-iotests/158        |  2 +-
 tests/qemu-iotests/158.out    |  2 +-
 tests/qemu-iotests/161        |  8 ++--
 tests/qemu-iotests/161.out    |  8 ++--
 tests/qemu-iotests/176        |  4 +-
 tests/qemu-iotests/176.out    | 32 ++++++++--------
 tests/qemu-iotests/177        |  2 +-
 tests/qemu-iotests/177.out    |  2 +-
 tests/qemu-iotests/179        |  2 +-
 tests/qemu-iotests/179.out    |  2 +-
 tests/qemu-iotests/189        |  2 +-
 tests/qemu-iotests/189.out    |  2 +-
 tests/qemu-iotests/191        | 12 +++---
 tests/qemu-iotests/191.out    | 12 +++---
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
 tests/qemu-iotests/228        |  5 ++-
 tests/qemu-iotests/245        |  3 +-
 tests/qemu-iotests/249        |  4 +-
 tests/qemu-iotests/249.out    |  4 +-
 tests/qemu-iotests/252        |  2 +-
 tests/qemu-iotests/257        |  3 +-
 tests/qemu-iotests/267        |  4 +-
 tests/qemu-iotests/267.out    |  6 +--
 tests/qemu-iotests/270        |  2 +-
 tests/qemu-iotests/270.out    |  2 +-
 tests/qemu-iotests/273        |  4 +-
 tests/qemu-iotests/273.out    |  4 +-
 tests/qemu-iotests/279        |  4 +-
 tests/qemu-iotests/279.out    |  4 +-
 tests/qemu-iotests/290        | 72 +++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/290.out    | 45 ++++++++++++++++++++++
 tests/qemu-iotests/group      |  1 +
 131 files changed, 671 insertions(+), 348 deletions(-)
 create mode 100755 tests/qemu-iotests/290
 create mode 100644 tests/qemu-iotests/290.out

--=20
2.25.1


