Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E388C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 21:44:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67B8B20879
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 21:44:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67B8B20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55053 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQfDU-0000j3-J3
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 17:44:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hQfC4-0008Hw-Ul
	for qemu-devel@nongnu.org; Tue, 14 May 2019 17:42:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hQfC2-0006lA-ML
	for qemu-devel@nongnu.org; Tue, 14 May 2019 17:42:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50296)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hQfBy-0006cU-0b; Tue, 14 May 2019 17:42:34 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7700D3082E72;
	Tue, 14 May 2019 21:42:32 +0000 (UTC)
Received: from localhost (unknown [10.40.205.236])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 06BD95D70A;
	Tue, 14 May 2019 21:42:31 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 14 May 2019 23:42:28 +0200
Message-Id: <20190514214230.22601-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Tue, 14 May 2019 21:42:32 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 0/2] block/file-posix: Fix unaligned O_DIRECT
 block status
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org,
	qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The user-visible problem:
$ echo > foo
$ qemu-img map --image-opts driver=3Dfile,filename=3Dfoo,cache.direct=3Do=
n
Offset          Length          Mapped to       File
qemu-img: block/io.c:2093: bdrv_co_block_status: Assertion `*pnum &&
QEMU_IS_ALIGNED(*pnum, align) && align > offset - aligned_offset'
failed.

The internal problem: file-posix truncates status requests to the EOF.
If the EOF is not aligned at the request_alignment,
bdrv_co_block_status() won't like that.

See patch 1 for a deeper discussion (including two possible alternatives
how we could address the problem).
(As I note there, I=E2=80=99ve looked through all block drivers, and I di=
dn=E2=80=99t
find any other which could have the same problem.  gluster uses the same
block-status code, but it doesn=E2=80=99t set a request_alignment.  NBD
force-aligns the server response in nbd_parse_blockstatus_payload().
qcow2... Should be fine as long as no crypto driver has a block limit
exceeding the qcow2 cluster size.  And so on.)

Patch 2 adds a test.  After writing that test, I noticed that we already
had one: 109 fails with -c none before patch 1.  Er, well, at least the
new test is more succinct and has the correct default cache mode, so it
will actually do the test if you run ./check without enforcing any cache
on a filesystem that supports O_DIRECT.


Max Reitz (2):
  block/file-posix: Unaligned O_DIRECT block-status
  iotests: Test unaligned raw images with O_DIRECT

 block/file-posix.c         | 17 ++++++++
 tests/qemu-iotests/221     |  4 ++
 tests/qemu-iotests/253     | 84 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/253.out | 14 +++++++
 tests/qemu-iotests/group   |  1 +
 5 files changed, 120 insertions(+)
 create mode 100755 tests/qemu-iotests/253
 create mode 100644 tests/qemu-iotests/253.out

--=20
2.21.0


