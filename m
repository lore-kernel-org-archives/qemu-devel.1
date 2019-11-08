Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A441FC5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 12:37:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 734D1222CE
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 12:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FDEHAcKT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 734D1222CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT3Vl-0004HH-BE
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 07:37:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44662)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iT3Tp-0002XP-8W
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 07:35:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iT3Tj-0003GE-Mz
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 07:35:08 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20967
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iT3Tj-0003Et-4g
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 07:35:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573216501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ThzsEykWB6T2kqaiaIDFaAGqFSjfCTqfxfJ6nnF6CKE=;
 b=FDEHAcKTnYzqGHSr0XAn9MvRiaKweKzmy35NOwprE6/rTDTqgtQkMM2wJReGiu7JIBCU+j
 cIVaYOokilQnTnRTX1NyATKw8woSZuxp4aKxk7PUl4Le5JuZAvdeq1sj+t1ICXjZWhHaYq
 Y2MSxNe2Eyovxt5PAfAnAqTSgpbpowU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-_dhKYBR0NTi4c5p-Bbaveg-1; Fri, 08 Nov 2019 07:34:58 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 248C31800D7B;
 Fri,  8 Nov 2019 12:34:57 +0000 (UTC)
Received: from localhost (ovpn-117-78.ams2.redhat.com [10.36.117.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BF5331001B39;
 Fri,  8 Nov 2019 12:34:56 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-5.0 v4 0/5] iotests: Test failing mirror complete
Date: Fri,  8 Nov 2019 13:34:50 +0100
Message-Id: <20191108123455.39445-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: _dhKYBR0NTi4c5p-Bbaveg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

v3 of this series was this:

https://lists.nongnu.org/archive/html/qemu-block/2019-10/msg00868.html

In the meantime, I=E2=80=99ve merged the first patch, so the subject of the
series has changed.

In v4, I=E2=80=99ve tried to address Vladimir=E2=80=99s concern of how to m=
ap QAPI
BlockPermission values to BLK_PERM_* flags with the new patches 1 and 2,
and a minor change to patch 3:
- Patch 1: Added, this new function will translate QAPI BlockPermission
           values to BLK_PERM_* flags
- Patch 2: Added; we can make use of the new function in
           xdbg_graph_add_edge() to save some LoC
- Patch 3:
  - %s/4.2/5.0/
  - Let blkdebug_parse_perm_list() initialize *dest
  - Use bdrv_qapi_perm_to_blk_perm() to translate QAPI BlockPermission
    values instead of blindly assuming an x -> 2^x mapping


git-backport-diff against v3:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respecti=
vely

001/5:[down] 'block: Add bdrv_qapi_perm_to_blk_perm()'
002/5:[down] 'block: Use bdrv_qapi_perm_to_blk_perm()'
003/5:[0008] [FC] 'blkdebug: Allow taking/unsharing permissions'
004/5:[----] [--] 'iotests: Add @error to wait_until_completed'
005/5:[----] [--] 'iotests: Add test for failing mirror complete'


Max Reitz (5):
  block: Add bdrv_qapi_perm_to_blk_perm()
  block: Use bdrv_qapi_perm_to_blk_perm()
  blkdebug: Allow taking/unsharing permissions
  iotests: Add @error to wait_until_completed
  iotests: Add test for failing mirror complete

 block.c                       | 47 ++++++++++--------
 block/blkdebug.c              | 93 ++++++++++++++++++++++++++++++++++-
 include/block/block.h         |  1 +
 qapi/block-core.json          | 14 +++++-
 tests/qemu-iotests/041        | 44 +++++++++++++++++
 tests/qemu-iotests/041.out    |  4 +-
 tests/qemu-iotests/iotests.py | 18 ++++---
 7 files changed, 190 insertions(+), 31 deletions(-)

--=20
2.23.0


