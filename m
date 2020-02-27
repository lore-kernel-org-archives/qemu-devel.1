Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31271C4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 02:41:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB3B424679
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 02:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dvk7xlut"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB3B424679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j797P-0006lG-5U
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 21:41:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33609)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j795P-0005JQ-19
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 21:39:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j795N-0000ng-IJ
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 21:39:38 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60380
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j795N-0000lY-Ez
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 21:39:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582771176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=z27B1om9iK3esyaCh151DiSl6AVviQZwOhVZWWA2G2c=;
 b=Dvk7xlutca2YSSPktRlWOxZzJhC0LnB7OQxg5oDulQP+fRmtKGbop4/74Pt4eFqty/sVDl
 BELBRAEcBBT+n1CaNJ/RQBqZZ5rrC6rMm9wQBcU8TUmDslAYxu6tYfcEJDv+wqvyvlxgQe
 0GcoMAH+SSvs44hg7YVGv1BxsGg3sFU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-r05mf17zPm23QrmMXCJPuQ-1; Wed, 26 Feb 2020 21:39:33 -0500
X-MC-Unique: r05mf17zPm23QrmMXCJPuQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 006EF1005512;
 Thu, 27 Feb 2020 02:39:32 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-57.phx2.redhat.com [10.3.116.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0F6018D540;
 Thu, 27 Feb 2020 02:39:28 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/3] Tighten qemu-img rules on missing backing format
Date: Wed, 26 Feb 2020 20:39:25 -0600
Message-Id: <20200227023928.1021959-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

In v2:
- patch 3 changes to ALWAYS warn if -b provided without -F (rather
than being silent on raw or json:) [Peter]
- patch 3 changes to ONLY write implied format if probe read raw (all
other probes are still mentioned, but not implicitly written) [Peter]
- couple more tests converted in patch 1 [fallout from the above]

Eric Blake (3):
  iotests: Specify explicit backing format where sensible
  block: Add support to warn on backing file change without format
  qemu-img: Deprecate use of -b without -F

 qemu-deprecated.texi          | 15 +++++++++++
 include/block/block.h         |  4 +--
 block.c                       | 34 ++++++++++++++++++++++---
 block/qcow2.c                 |  2 +-
 block/stream.c                |  2 +-
 blockdev.c                    |  3 ++-
 qemu-img.c                    | 10 ++++++--
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
 tests/qemu-iotests/114        |  4 +--
 tests/qemu-iotests/114.out    |  1 +
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
 122 files changed, 476 insertions(+), 351 deletions(-)

--=20
2.25.1


