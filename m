Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004D4C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 16:39:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C46D4206DF
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 16:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hxfCLUXT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C46D4206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSkoI-0004VD-Cz
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 11:39:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42311)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iSkmb-0002bX-D3
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:37:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iSkmZ-0005T9-Ej
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:37:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21098
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iSkmZ-0005SX-BN
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:37:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573144634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qQZqJb1b93WSJnnr0mxMVRJ4w4SD+QRCmeoIgeQdxK4=;
 b=hxfCLUXTX0Xl0iW3fxkGa/anyP+VqLYhMSa8SjM9cE928l1KNU4F2OcI14uo28KuU+9cqO
 UAmpQLXu+tIKdvvWMICQLGQA4B6eaAxOaVmoZeTuO933QXDMxMPUsaVvg1jWR/LjE4QPXF
 ukleASNXOXQkR62TbwoPpej5rr8Qgt0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-bAox8adiOc-qLN5w2Aownw-1; Thu, 07 Nov 2019 11:37:11 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 340831005500;
 Thu,  7 Nov 2019 16:37:10 +0000 (UTC)
Received: from localhost (ovpn-117-149.ams2.redhat.com [10.36.117.149])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F8B85DA76;
 Thu,  7 Nov 2019 16:37:09 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 00/22] iotests: Allow ./check -o data_file
Date: Thu,  7 Nov 2019 17:36:46 +0100
Message-Id: <20191107163708.833192-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: bAox8adiOc-qLN5w2Aownw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

The cover letter from v1 (explaining the motivation behind this series
and the general structure) is here:

https://lists.nongnu.org/archive/html/qemu-block/2019-09/msg01323.html


For v2, I=E2=80=99ve addressed more of Maxim=E2=80=99s comments:
- Patch 1: Added; Maxim noted this problem on patch 5, but that patch
           doesn=E2=80=99t touch all files that have this mistake, so I dec=
ided
           to make it an extra patch

- Patch 20 (now patch 21):
  - Added TODO comments where it would make sense to at some point split
    off some cases into an own test file (so they can run with an
    external data file, where the whole test now has to be skipped)
  - Fixed the reason why we have to skip 138 with external data files
  - Disable 261, too (which was added in the meantime)

- Some contextual differences in some patches due to the $SOCK_DIR
  series

git-backport-diff against v2:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respecti=
vely

001/22:[down] 'iotests: s/qocw2/qcow2/'
002/22:[----] [--] 'iotests/qcow2.py: Add dump-header-exts'
003/22:[----] [--] 'iotests/qcow2.py: Split feature fields into bits'
004/22:[----] [--] 'iotests: Add _filter_json_filename'
005/22:[----] [--] 'iotests: Filter refcount_order in 036'
006/22:[----] [-C] 'iotests: Replace IMGOPTS by _unsupported_imgopts'
007/22:[----] [--] 'iotests: Drop compat=3D1.1 in 050'
008/22:[----] [--] 'iotests: Let _make_test_img parse its parameters'
009/22:[----] [--] 'iotests: Add -o and --no-opts to _make_test_img'
010/22:[----] [--] 'iotests: Inject space into -ocompat=3D0.10 in 051'
011/22:[----] [--] 'iotests: Replace IMGOPTS=3D by -o'
012/22:[----] [--] 'iotests: Replace IMGOPTS=3D'' by --no-opts'
013/22:[----] [-C] 'iotests: Drop IMGOPTS use in 267'
014/22:[----] [--] 'iotests: Avoid qemu-img create'
015/22:[----] [-C] 'iotests: Use _rm_test_img for deleting test images'
016/22:[----] [--] 'iotests: Avoid cp/mv of test images'
017/22:[----] [--] 'iotests: Make 091 work with data_file'
018/22:[----] [--] 'iotests: Make 110 work with data_file'
019/22:[----] [--] 'iotests: Make 137 work with data_file'
020/22:[----] [--] 'iotests: Make 198 work with data_file'
021/22:[0010] [FC] 'iotests: Disable data_file where it cannot be used'
022/22:[----] [-C] 'iotests: Allow check -o data_file'


Max Reitz (22):
  iotests: s/qocw2/qcow2/
  iotests/qcow2.py: Add dump-header-exts
  iotests/qcow2.py: Split feature fields into bits
  iotests: Add _filter_json_filename
  iotests: Filter refcount_order in 036
  iotests: Replace IMGOPTS by _unsupported_imgopts
  iotests: Drop compat=3D1.1 in 050
  iotests: Let _make_test_img parse its parameters
  iotests: Add -o and --no-opts to _make_test_img
  iotests: Inject space into -ocompat=3D0.10 in 051
  iotests: Replace IMGOPTS=3D by -o
  iotests: Replace IMGOPTS=3D'' by --no-opts
  iotests: Drop IMGOPTS use in 267
  iotests: Avoid qemu-img create
  iotests: Use _rm_test_img for deleting test images
  iotests: Avoid cp/mv of test images
  iotests: Make 091 work with data_file
  iotests: Make 110 work with data_file
  iotests: Make 137 work with data_file
  iotests: Make 198 work with data_file
  iotests: Disable data_file where it cannot be used
  iotests: Allow check -o data_file

 tests/qemu-iotests/005           |  2 +-
 tests/qemu-iotests/007           |  5 ++-
 tests/qemu-iotests/014           |  2 +
 tests/qemu-iotests/015           |  5 ++-
 tests/qemu-iotests/019           |  6 +--
 tests/qemu-iotests/020           |  6 +--
 tests/qemu-iotests/024           | 10 ++---
 tests/qemu-iotests/026           |  5 ++-
 tests/qemu-iotests/028           |  2 +-
 tests/qemu-iotests/029           |  7 ++--
 tests/qemu-iotests/031           |  9 ++--
 tests/qemu-iotests/031.out       | 36 ++++++++--------
 tests/qemu-iotests/036           | 15 ++++---
 tests/qemu-iotests/036.out       | 66 ++++-------------------------
 tests/qemu-iotests/039           | 27 +++++-------
 tests/qemu-iotests/039.out       | 22 +++++-----
 tests/qemu-iotests/043           |  4 +-
 tests/qemu-iotests/046           |  2 +
 tests/qemu-iotests/048           |  4 +-
 tests/qemu-iotests/050           |  8 +---
 tests/qemu-iotests/051           |  7 ++--
 tests/qemu-iotests/053           |  4 +-
 tests/qemu-iotests/058           |  7 ++--
 tests/qemu-iotests/059           | 20 ++++-----
 tests/qemu-iotests/060           | 14 ++++---
 tests/qemu-iotests/060.out       | 20 ++++-----
 tests/qemu-iotests/061           | 63 +++++++++++++++-------------
 tests/qemu-iotests/061.out       | 72 ++++++++++++++++----------------
 tests/qemu-iotests/062           |  5 ++-
 tests/qemu-iotests/063           | 18 ++++----
 tests/qemu-iotests/063.out       |  3 +-
 tests/qemu-iotests/066           |  7 +++-
 tests/qemu-iotests/067           |  6 ++-
 tests/qemu-iotests/068           |  6 ++-
 tests/qemu-iotests/069           |  2 +-
 tests/qemu-iotests/071           |  7 +++-
 tests/qemu-iotests/073           |  4 ++
 tests/qemu-iotests/074           |  4 +-
 tests/qemu-iotests/079           |  3 +-
 tests/qemu-iotests/080           |  7 ++--
 tests/qemu-iotests/081           |  6 +--
 tests/qemu-iotests/085           | 18 ++++----
 tests/qemu-iotests/085.out       |  8 ++--
 tests/qemu-iotests/088           |  2 +-
 tests/qemu-iotests/090           |  2 +
 tests/qemu-iotests/091           |  2 +-
 tests/qemu-iotests/091.out       |  2 -
 tests/qemu-iotests/092           |  2 +-
 tests/qemu-iotests/094           |  4 +-
 tests/qemu-iotests/095           |  5 ++-
 tests/qemu-iotests/098           |  6 ++-
 tests/qemu-iotests/099           | 10 +++--
 tests/qemu-iotests/103           |  5 ++-
 tests/qemu-iotests/106           |  2 +-
 tests/qemu-iotests/108           | 10 +++--
 tests/qemu-iotests/109           |  4 +-
 tests/qemu-iotests/110           | 11 +++--
 tests/qemu-iotests/110.out       |  4 +-
 tests/qemu-iotests/111           |  3 +-
 tests/qemu-iotests/112           | 37 ++++++++--------
 tests/qemu-iotests/114           |  2 +
 tests/qemu-iotests/115           |  3 +-
 tests/qemu-iotests/121           |  9 ++--
 tests/qemu-iotests/122           |  6 ++-
 tests/qemu-iotests/123           |  4 +-
 tests/qemu-iotests/125           |  2 +-
 tests/qemu-iotests/137           | 17 +++++---
 tests/qemu-iotests/137.out       |  6 +--
 tests/qemu-iotests/138           |  8 ++--
 tests/qemu-iotests/141           |  4 +-
 tests/qemu-iotests/142           |  2 +-
 tests/qemu-iotests/144           |  4 +-
 tests/qemu-iotests/153           | 12 ++----
 tests/qemu-iotests/156           | 10 ++++-
 tests/qemu-iotests/159           |  2 +-
 tests/qemu-iotests/160           |  3 +-
 tests/qemu-iotests/161           |  4 +-
 tests/qemu-iotests/170           |  2 +-
 tests/qemu-iotests/172           |  6 +--
 tests/qemu-iotests/173           |  3 +-
 tests/qemu-iotests/174           |  2 +-
 tests/qemu-iotests/175           |  2 +-
 tests/qemu-iotests/176           |  7 +++-
 tests/qemu-iotests/178           |  6 +--
 tests/qemu-iotests/182           |  2 +-
 tests/qemu-iotests/183           |  2 +-
 tests/qemu-iotests/185           |  4 +-
 tests/qemu-iotests/187           |  6 +--
 tests/qemu-iotests/190           |  4 +-
 tests/qemu-iotests/191           | 11 ++---
 tests/qemu-iotests/195           |  2 +-
 tests/qemu-iotests/197           |  6 +--
 tests/qemu-iotests/198           |  6 ++-
 tests/qemu-iotests/198.out       |  4 +-
 tests/qemu-iotests/200           |  7 ++--
 tests/qemu-iotests/201           |  6 +--
 tests/qemu-iotests/214           |  3 +-
 tests/qemu-iotests/215           |  6 +--
 tests/qemu-iotests/217           |  3 +-
 tests/qemu-iotests/220           |  5 ++-
 tests/qemu-iotests/225           |  2 +-
 tests/qemu-iotests/229           |  3 +-
 tests/qemu-iotests/232           |  4 +-
 tests/qemu-iotests/243           | 10 +++--
 tests/qemu-iotests/244           | 15 ++++---
 tests/qemu-iotests/247           |  4 +-
 tests/qemu-iotests/249           |  4 +-
 tests/qemu-iotests/250           |  5 ++-
 tests/qemu-iotests/252           |  2 +-
 tests/qemu-iotests/261           |  5 ++-
 tests/qemu-iotests/265           |  2 +-
 tests/qemu-iotests/267           | 17 +++++---
 tests/qemu-iotests/common.filter | 47 ++++++++++++++++++++-
 tests/qemu-iotests/common.rc     | 63 ++++++++++++++++++++++++----
 tests/qemu-iotests/qcow2.py      | 23 ++++++++--
 115 files changed, 614 insertions(+), 460 deletions(-)

--=20
2.23.0


