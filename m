Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFA4C0044D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 00:42:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9BE820674
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 00:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iosT37hC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9BE820674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE0JO-0005cK-Uq
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 20:42:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41292)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1jE0IC-0003wa-Nq
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 20:41:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1jE0IA-0004fY-NA
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 20:41:12 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:26522)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1jE0IA-0004bb-HC
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 20:41:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584405669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=q/YZa5lEct+/eXe9bTizlWeKQGM8/j+row8jyVixLZc=;
 b=iosT37hC4uH3Ci0wKn+H8gBkLPc3gB2wubkGlZl4lafU0tnZM9g9V/hPbYNP3+zVnqrN0p
 ++CAq/u/5QNhptNymaaIR9vXuHEVrRo731REI3v0UtdnJrRsFCWSqe3/ljrdX9AmQ///ld
 VS/lCEIoYCQQfVlTpix37IWr9ksdhA8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-30Dc5Kc5ML-fp7n-VVHr1w-1; Mon, 16 Mar 2020 20:41:07 -0400
X-MC-Unique: 30Dc5Kc5ML-fp7n-VVHr1w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF4B38017CC;
 Tue, 17 Mar 2020 00:41:06 +0000 (UTC)
Received: from probe.redhat.com (ovpn-112-191.rdu2.redhat.com [10.10.112.191])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E50D593531;
 Tue, 17 Mar 2020 00:41:05 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 00/11] iotests: use python logging
Date: Mon, 16 Mar 2020 20:40:54 -0400
Message-Id: <20200317004105.27059-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Kevin Wolf <kwolf@redhat.com>, ehabkost@redhat.com, qemu-block@nongnu.org,
 philmd@redhat.com, armbru@redhat.com, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series uses python logging to enable output conditionally on
iotests.log(). We unify an initialization call (which also enables
debugging output for those tests with -d) and then make the switch
inside of iotests.

It will help alleviate the need to create logged/unlogged versions
of all the various helpers we have made.

Also, I got lost and accidentally delinted iotests while I was here.
Sorry about that.

V8:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respecti=
vely

001/11:[----] [--] 'iotests: do a light delinting'
002/11:[----] [--] 'iotests: don't use 'format' for drive_add'
003/11:[----] [--] 'iotests: ignore import warnings from pylint'
004/11:[----] [--] 'iotests: replace mutable list default args'
005/11:[----] [--] 'iotests: add pylintrc file'
006/11:[down] 'iotests: drop Python 3.4 compatibility code'
007/11:[0033] [FC] 'iotests: limit line length to 79 chars'
008/11:[----] [--] 'iotests: add script_initialize'
009/11:[----] [--] 'iotest 258: use script_main'
010/11:[----] [--] 'iotests: Mark verify functions as private'
011/11:[0007] [FC] 'iotests: use python logging for iotests.log()'

6: Split out the little drop of Python 3.4 code. (Phil)
7: Change line continuation styles (QEMU Memorial Choir)
11: Rebase changes; remove use_log from more places, adjust test output.

V7:

- All delinting patches are now entirely front-loaded.
- Redid delinting to avoid "correcting" no-else-return statements.
- Moved more mutable list corrections into patch 4, to make it standalone.
- Moved pylintrc up to patch 5. Disabled no-else-return.
- Added patch 6 to require line length checks.
  (Some python 3.4 compatibility code is removed as a consequence.)
- Patch 7 changes slightly as a result of patch 4 changes.
- Added some logging explainer into patch 10.
  (Patch changes slightly because of patch 6.)

V6:
 - It's been so long since V5, let's just look at it anew.
 - Dropped patch 1, rebased, added more delinting.
 - I'm not touching the supported_platforms thing.
   Not interested in rehashing that debate.

V5:
 - Rebased again
 - Allow Python tests to run on any platform

V4:
 - Rebased on top of kwolf/block at the behest of mreitz

V3:
 - Rebased for 4.1+; now based on main branch.

V2:
 - Added all of the other python tests I missed to use script_initialize
 - Refactored the common setup as per Ehabkost's suggestion
 - Added protocol arguments to common initialization,
   but this isn't strictly required.

John Snow (11):
  iotests: do a light delinting
  iotests: don't use 'format' for drive_add
  iotests: ignore import warnings from pylint
  iotests: replace mutable list default args
  iotests: add pylintrc file
  iotests: drop Python 3.4 compatibility code
  iotests: limit line length to 79 chars
  iotests: add script_initialize
  iotest 258: use script_main
  iotests: Mark verify functions as private
  iotests: use python logging for iotests.log()

 tests/qemu-iotests/030        |   4 +-
 tests/qemu-iotests/055        |   3 +-
 tests/qemu-iotests/149        |   3 +-
 tests/qemu-iotests/155        |   2 +-
 tests/qemu-iotests/194        |   4 +-
 tests/qemu-iotests/202        |   4 +-
 tests/qemu-iotests/203        |   4 +-
 tests/qemu-iotests/206        |   2 +-
 tests/qemu-iotests/207        |   6 +-
 tests/qemu-iotests/208        |   2 +-
 tests/qemu-iotests/209        |   2 +-
 tests/qemu-iotests/210        |   6 +-
 tests/qemu-iotests/211        |   6 +-
 tests/qemu-iotests/212        |   6 +-
 tests/qemu-iotests/213        |   6 +-
 tests/qemu-iotests/216        |   4 +-
 tests/qemu-iotests/218        |   2 +-
 tests/qemu-iotests/219        |   2 +-
 tests/qemu-iotests/222        |   7 +-
 tests/qemu-iotests/224        |   4 +-
 tests/qemu-iotests/228        |   6 +-
 tests/qemu-iotests/234        |   4 +-
 tests/qemu-iotests/235        |   4 +-
 tests/qemu-iotests/236        |   2 +-
 tests/qemu-iotests/237        |   2 +-
 tests/qemu-iotests/238        |   2 +
 tests/qemu-iotests/242        |   2 +-
 tests/qemu-iotests/245        |   1 +
 tests/qemu-iotests/245.out    |  24 +--
 tests/qemu-iotests/246        |   2 +-
 tests/qemu-iotests/248        |   2 +-
 tests/qemu-iotests/254        |   2 +-
 tests/qemu-iotests/255        |   2 +-
 tests/qemu-iotests/256        |   2 +-
 tests/qemu-iotests/258        |  10 +-
 tests/qemu-iotests/260        |   4 +-
 tests/qemu-iotests/262        |   4 +-
 tests/qemu-iotests/264        |   4 +-
 tests/qemu-iotests/277        |   2 +
 tests/qemu-iotests/280        |   8 +-
 tests/qemu-iotests/283        |   4 +-
 tests/qemu-iotests/iotests.py | 312 ++++++++++++++++++++--------------
 tests/qemu-iotests/pylintrc   |  26 +++
 43 files changed, 307 insertions(+), 203 deletions(-)
 create mode 100644 tests/qemu-iotests/pylintrc

--=20
2.21.1


