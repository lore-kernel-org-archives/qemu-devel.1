Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83CEDC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 22:52:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CF69206CC
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 22:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B5atkZ0g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CF69206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jALpV-0004vE-DR
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 17:52:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32838)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jALoZ-0003wL-5S
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 17:51:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jALoX-0003jW-5Q
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 17:51:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23573
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jALoW-0003fe-UB
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 17:51:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583535088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=D8YNaEl/TX8OFyP3t3AMd5iygI9eSalWW/fN4QUTs58=;
 b=B5atkZ0gexOYUhKxVejPROJVJ3n1nRmPrXqWfFa/aMcSK95a/L9jrn5M5uPkM3iWdclDKB
 VIpJhOpLb79hPXAss72IxAPmH51cDQsWXKCTdjDowqtdsiPpUydkY9TcB/CwQdg22lbjkC
 EOs0Z8GJAJ/Hp3VZUw0+qs7l6H4r/Gg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-gL-BG9cNMr-Li7LGvmTgOQ-1; Fri, 06 Mar 2020 17:51:26 -0500
X-MC-Unique: gL-BG9cNMr-Li7LGvmTgOQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 58874107ACC7;
 Fri,  6 Mar 2020 22:51:25 +0000 (UTC)
Received: from blue.redhat.com (ovpn-117-177.phx2.redhat.com [10.3.117.177])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 392EE60BE0;
 Fri,  6 Mar 2020 22:51:22 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/4] Tighten qemu-img rules on missing backing format
Date: Fri,  6 Mar 2020 16:51:17 -0600
Message-Id: <20200306225121.3199279-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
Cc: libvir-list@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In v3:
- patch 1 is new [Jan]
- patch 2:
  - add test 225 for vmdk [Jan]
  - add a few more tests where raw backing files are used [Peter]
- patch 3 add R-b
- patch 4:
  - more tweaks on which messages are emitted [Peter]
  - more test coverage in 114 of new messages
  - rebase to .rst conversion

Eric Blake (4):
  block: Add trivial backing_fmt support to qcow, sheepdog, vmdk
  iotests: Specify explicit backing format where sensible
  block: Add support to warn on backing file change without format
  qemu-img: Deprecate use of -b without -F

 docs/system/deprecated.rst    | 19 ++++++++++++++
 include/block/block.h         |  4 +--
 block.c                       | 34 ++++++++++++++++++++++---
 block/qcow.c                  |  6 +++++
 block/qcow2.c                 |  2 +-
 block/sheepdog.c              |  6 +++++
 block/stream.c                |  2 +-
 block/vmdk.c                  |  5 ++++
 blockdev.c                    |  3 ++-
 qemu-img.c                    |  4 +--
 tests/qemu-iotests/017        |  2 +-
 tests/qemu-iotests/017.out    |  2 +-
 tests/qemu-iotests/018        |  2 +-
 tests/qemu-iotests/018.out    |  2 +-
 tests/qemu-iotests/019        |  5 ++--
 tests/qemu-iotests/019.out    |  2 +-
 tests/qemu-iotests/020        |  4 +--
 tests/qemu-iotests/020.out    |  4 +--
 tests/qemu-iotests/024        |  8 +++---
 tests/qemu-iotests/024.out    |  5 ++--
 tests/qemu-iotests/028        |  4 +--
 tests/qemu-iotests/028.out    |  2 +-
 tests/qemu-iotests/030        | 26 +++++++++++++------
 tests/qemu-iotests/034        |  2 +-
 tests/qemu-iotests/034.out    |  2 +-
 tests/qemu-iotests/037        |  2 +-
 tests/qemu-iotests/037.out    |  2 +-
 tests/qemu-iotests/038        |  2 +-
 tests/qemu-iotests/038.out    |  2 +-
 tests/qemu-iotests/039        |  3 ++-
 tests/qemu-iotests/039.out    |  2 +-
 tests/qemu-iotests/040        | 47 +++++++++++++++++++++++++----------
 tests/qemu-iotests/041        | 37 ++++++++++++++++++---------
 tests/qemu-iotests/042        |  4 +--
 tests/qemu-iotests/043        | 18 +++++++-------
 tests/qemu-iotests/043.out    | 16 +++++++-----
 tests/qemu-iotests/046        |  2 +-
 tests/qemu-iotests/046.out    |  2 +-
 tests/qemu-iotests/050        |  4 +--
 tests/qemu-iotests/050.out    |  2 +-
 tests/qemu-iotests/051        |  2 +-
 tests/qemu-iotests/051.out    |  2 +-
 tests/qemu-iotests/051.pc.out |  2 +-
 tests/qemu-iotests/056        |  3 ++-
 tests/qemu-iotests/060        |  2 +-
 tests/qemu-iotests/060.out    |  2 +-
 tests/qemu-iotests/061        | 10 ++++----
 tests/qemu-iotests/061.out    | 10 ++++----
 tests/qemu-iotests/069        |  2 +-
 tests/qemu-iotests/069.out    |  2 +-
 tests/qemu-iotests/073        |  2 +-
 tests/qemu-iotests/073.out    |  2 +-
 tests/qemu-iotests/082        | 16 +++++++-----
 tests/qemu-iotests/082.out    | 16 ++++++------
 tests/qemu-iotests/085        |  4 +--
 tests/qemu-iotests/085.out    |  6 ++---
 tests/qemu-iotests/089        |  2 +-
 tests/qemu-iotests/089.out    |  2 +-
 tests/qemu-iotests/095        |  4 +--
 tests/qemu-iotests/095.out    |  4 +--
 tests/qemu-iotests/097        |  4 +--
 tests/qemu-iotests/097.out    | 16 ++++++------
 tests/qemu-iotests/098        |  2 +-
 tests/qemu-iotests/098.out    |  8 +++---
 tests/qemu-iotests/110        |  4 +--
 tests/qemu-iotests/110.out    |  4 +--
 tests/qemu-iotests/114        | 11 ++++++++
 tests/qemu-iotests/114.out    |  8 ++++++
 tests/qemu-iotests/122        | 27 ++++++++++++--------
 tests/qemu-iotests/122.out    |  8 +++---
 tests/qemu-iotests/126        |  4 +--
 tests/qemu-iotests/126.out    |  4 +--
 tests/qemu-iotests/127        |  4 +--
 tests/qemu-iotests/127.out    |  4 +--
 tests/qemu-iotests/129        |  3 ++-
 tests/qemu-iotests/133        |  2 +-
 tests/qemu-iotests/133.out    |  2 +-
 tests/qemu-iotests/139        |  2 +-
 tests/qemu-iotests/141        |  4 +--
 tests/qemu-iotests/141.out    |  4 +--
 tests/qemu-iotests/142        |  2 +-
 tests/qemu-iotests/142.out    |  2 +-
 tests/qemu-iotests/153        | 14 +++++------
 tests/qemu-iotests/153.out    | 35 ++++++++++++++------------
 tests/qemu-iotests/154        | 42 +++++++++++++++----------------
 tests/qemu-iotests/154.out    | 42 +++++++++++++++----------------
 tests/qemu-iotests/155        | 12 ++++++---
 tests/qemu-iotests/156        |  9 ++++---
 tests/qemu-iotests/156.out    |  6 ++---
 tests/qemu-iotests/158        |  2 +-
 tests/qemu-iotests/158.out    |  2 +-
 tests/qemu-iotests/161        |  8 +++---
 tests/qemu-iotests/161.out    |  8 +++---
 tests/qemu-iotests/176        |  4 +--
 tests/qemu-iotests/176.out    | 32 ++++++++++++------------
 tests/qemu-iotests/177        |  2 +-
 tests/qemu-iotests/177.out    |  2 +-
 tests/qemu-iotests/179        |  2 +-
 tests/qemu-iotests/179.out    |  2 +-
 tests/qemu-iotests/189        |  2 +-
 tests/qemu-iotests/189.out    |  2 +-
 tests/qemu-iotests/191        | 12 ++++-----
 tests/qemu-iotests/191.out    | 12 ++++-----
 tests/qemu-iotests/195        |  6 ++---
 tests/qemu-iotests/195.out    |  6 ++---
 tests/qemu-iotests/198        |  2 +-
 tests/qemu-iotests/198.out    |  3 ++-
 tests/qemu-iotests/204        |  2 +-
 tests/qemu-iotests/204.out    |  2 +-
 tests/qemu-iotests/216        |  2 +-
 tests/qemu-iotests/224        |  4 +--
 tests/qemu-iotests/225        |  2 +-
 tests/qemu-iotests/225.out    |  2 +-
 tests/qemu-iotests/228        |  5 ++--
 tests/qemu-iotests/245        |  3 ++-
 tests/qemu-iotests/249        |  4 +--
 tests/qemu-iotests/249.out    |  4 +--
 tests/qemu-iotests/252        |  2 +-
 tests/qemu-iotests/257        |  3 ++-
 tests/qemu-iotests/267        |  4 +--
 tests/qemu-iotests/267.out    |  6 ++---
 tests/qemu-iotests/270        |  2 +-
 tests/qemu-iotests/270.out    |  2 +-
 tests/qemu-iotests/273        |  4 +--
 tests/qemu-iotests/273.out    |  4 +--
 tests/qemu-iotests/279        |  4 +--
 tests/qemu-iotests/279.out    |  4 +--
 127 files changed, 509 insertions(+), 351 deletions(-)

--=20
2.25.1


