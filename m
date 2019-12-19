Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED54C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:40:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3851821D7D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BgWhaynM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3851821D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihwyQ-0006Oj-Kx
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 09:40:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55315)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1ihwwf-0004Nv-BG
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:38:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1ihwwc-000400-Ig
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:38:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55393
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1ihwwc-0003wP-Ci
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:38:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576766305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=TIh6+dCTQCtvcqlGAhurd0yD0IXfF5qR68urUCsxofQ=;
 b=BgWhaynMP9KRFEB6/KGdCJjk6dBk2P2sSYaslZYbJ/6KIKLFwxFBHpsHjm+G52HAKq7TYv
 a0j6KzCID26A30p2ODGbU3WrFtOp+HLfPQkDvm3QYyD//bgxX/Eioud96gcRLB50I8Ph/G
 /cXwxo5sDjwQMg7y8QIHYC1nfkrG/Gg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-X2RmopPsMrSJgKMu_HmDTQ-1; Thu, 19 Dec 2019 09:38:21 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BABD31137852;
 Thu, 19 Dec 2019 14:38:20 +0000 (UTC)
Received: from localhost (ovpn-205-138.brq.redhat.com [10.40.205.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BAD8760FC1;
 Thu, 19 Dec 2019 14:38:19 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 00/18] block: Allow exporting BDSs via FUSE
Date: Thu, 19 Dec 2019 15:38:00 +0100
Message-Id: <20191219143818.1646168-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: X2RmopPsMrSJgKMu_HmDTQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Preamble: This series is based on a combination of my (current) block
branch and =E2=80=9Ciotests: Minor fixes=E2=80=9D.  I=E2=80=99ve pushed it =
here:

  https://git.xanclic.moe/XanClic/qemu fuse-exports-v1

(The base is on fuse-exports-v1-base.)


Hi,

Ever since I found out that you can mount FUSE filesystems on regular
files (not just directories), I had the idea of adding FUSE block
exports to qemu where you can export block nodes as raw images.  The
best thing is that you=E2=80=99d be able to mount an image on itself, so
whatever format it may be in, qemu lets it appear as a raw image (and
you can then use regular tools like dd on it).

I started with some concept of a qemu-blkfuse daemon (similar to
qemu-nbd), but never sent patches, for two reasons: (1) Performance was
not good, (2) it didn=E2=80=99t seem right, for some reason.

Now Kevin is proposing a storage daemon for multiple export types like
NBD, and he also mentioned FUSE (while knowing of my previous attempts).
Now it does seem right to add FUSE exports to qemu, but only in the form
of some module with a proper QAPI/QMP binding.

Performance is still quite bad, but who cares.  We can always improve
it, if the need arises.


This series does the following:

First, add the FUSE export module (block/fuse.c) that implements the
basic file access functions.  (Note that you need libfuse 3.8.0 or later
for SEEK_HOLE/SEEK_DATA.)

Second, it allows using FUSE exports as a protocol in the iotests and
makes many iotests work with it.  (The file node is exported by a
background qemu instance to $SOCK_DIR.)
Note that I only ran raw and qcow2 on it; I=E2=80=99m sure other formats
currently have some failing tests.

This gives us a lot of coverage for, well, not free (it does take ten
patches), but for cheap; but there are still some more specialized
things we want to test, so third and last, this series adds an iotest
dedicated to FUSE exports.


Final rather important notice: I didn=E2=80=99t really run the iotests with=
 this
yet.  I wanted to, but they appear rather broken on current master,
actually.  I=E2=80=99m not yet sure whether that=E2=80=99s because somethin=
g in my setup
broke in the last two weeks, or because there=E2=80=99s quite something bro=
ken
in master (it does look like there are a couple things broken in master
currently).


Max Reitz (18):
  configure: Detect libfuse
  fuse: Allow exporting BDSs via FUSE
  fuse: Implement standard FUSE operations
  fuse: Add fuse-export-remove
  fuse: Allow growable exports
  fuse: (Partially) implement fallocate()
  fuse: Implement hole detection through lseek
  iotests: Do not needlessly filter _make_test_img
  iotests: Do not pipe _make_test_img
  iotests: Use convert -n in some cases
  iotests: Avoid renaming images
  iotests: Derive image names from $TEST_IMG
  iotests/091: Use _cleanup_qemu instad of "wait"
  iotests: Restrict some Python tests to file
  iotests: Let _make_test_img guess $TEST_IMG_FILE
  iotests: Allow testing FUSE exports
  iotests: Enable fuse for many tests
  iotests/281: Add test for FUSE exports

 block.c                          |   4 +
 block/Makefile.objs              |   3 +
 block/fuse.c                     | 668 +++++++++++++++++++++++++++++++
 configure                        |  68 ++++
 include/block/fuse.h             |  24 ++
 qapi/block.json                  |  42 ++
 tests/qemu-iotests/013           |   9 +-
 tests/qemu-iotests/013.out       |   3 +-
 tests/qemu-iotests/018           |   5 +-
 tests/qemu-iotests/018.out       |   1 +
 tests/qemu-iotests/020           |   2 +-
 tests/qemu-iotests/025           |   2 +-
 tests/qemu-iotests/026           |   2 +-
 tests/qemu-iotests/028           |  16 +-
 tests/qemu-iotests/028.out       |   3 +
 tests/qemu-iotests/031           |   2 +-
 tests/qemu-iotests/034           |   2 +-
 tests/qemu-iotests/036           |   2 +-
 tests/qemu-iotests/037           |   2 +-
 tests/qemu-iotests/038           |   2 +-
 tests/qemu-iotests/039           |   2 +-
 tests/qemu-iotests/046           |   7 +-
 tests/qemu-iotests/046.out       |   2 +-
 tests/qemu-iotests/050           |   2 +-
 tests/qemu-iotests/054           |   2 +-
 tests/qemu-iotests/060           |   2 +-
 tests/qemu-iotests/071           |  21 +-
 tests/qemu-iotests/072           |   5 +-
 tests/qemu-iotests/072.out       |   1 +
 tests/qemu-iotests/079           |   2 +-
 tests/qemu-iotests/080           |   2 +-
 tests/qemu-iotests/089           |   5 +-
 tests/qemu-iotests/089.out       |   1 +
 tests/qemu-iotests/090           |   2 +-
 tests/qemu-iotests/091           |   5 +-
 tests/qemu-iotests/095           |   2 +-
 tests/qemu-iotests/097           |   2 +-
 tests/qemu-iotests/098           |   2 +-
 tests/qemu-iotests/102           |   2 +-
 tests/qemu-iotests/103           |   2 +-
 tests/qemu-iotests/106           |   2 +-
 tests/qemu-iotests/107           |   2 +-
 tests/qemu-iotests/108           |   2 +-
 tests/qemu-iotests/111           |   2 +-
 tests/qemu-iotests/112           |   2 +-
 tests/qemu-iotests/115           |   2 +-
 tests/qemu-iotests/117           |   2 +-
 tests/qemu-iotests/120           |   2 +-
 tests/qemu-iotests/121           |   2 +-
 tests/qemu-iotests/127           |   2 +-
 tests/qemu-iotests/133           |   2 +-
 tests/qemu-iotests/137           |   2 +-
 tests/qemu-iotests/138           |   2 +-
 tests/qemu-iotests/140           |   2 +-
 tests/qemu-iotests/154           |   2 +-
 tests/qemu-iotests/161           |  14 +-
 tests/qemu-iotests/171           |   2 +-
 tests/qemu-iotests/174           |  10 +-
 tests/qemu-iotests/175           |   8 +-
 tests/qemu-iotests/176           |   2 +-
 tests/qemu-iotests/177           |   2 +-
 tests/qemu-iotests/179           |   2 +-
 tests/qemu-iotests/183           |   2 +-
 tests/qemu-iotests/186           |   2 +-
 tests/qemu-iotests/187           |   2 +-
 tests/qemu-iotests/191           |   2 +-
 tests/qemu-iotests/195           |   2 +-
 tests/qemu-iotests/200           |   5 +-
 tests/qemu-iotests/200.out       |   4 +-
 tests/qemu-iotests/204           |   2 +-
 tests/qemu-iotests/206           |   1 +
 tests/qemu-iotests/214           |   2 +-
 tests/qemu-iotests/217           |   2 +-
 tests/qemu-iotests/220           |   2 +-
 tests/qemu-iotests/221           |   2 +-
 tests/qemu-iotests/229           |   5 +-
 tests/qemu-iotests/229.out       |   6 +-
 tests/qemu-iotests/242           |   1 +
 tests/qemu-iotests/247           |   2 +-
 tests/qemu-iotests/249           |   8 +-
 tests/qemu-iotests/250           |   2 +-
 tests/qemu-iotests/252           |   2 +-
 tests/qemu-iotests/265           |   2 +-
 tests/qemu-iotests/268           |   2 +-
 tests/qemu-iotests/272           |   2 +-
 tests/qemu-iotests/273           |   2 +-
 tests/qemu-iotests/279           |   2 +-
 tests/qemu-iotests/281           | 328 +++++++++++++++
 tests/qemu-iotests/281.out       |  92 +++++
 tests/qemu-iotests/check         |   6 +
 tests/qemu-iotests/common.filter |   5 +-
 tests/qemu-iotests/common.rc     | 190 ++++++++-
 tests/qemu-iotests/group         |   1 +
 93 files changed, 1571 insertions(+), 120 deletions(-)
 create mode 100644 block/fuse.c
 create mode 100644 include/block/fuse.h
 create mode 100755 tests/qemu-iotests/281
 create mode 100644 tests/qemu-iotests/281.out

--=20
2.23.0


