Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C17C3F2CE
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 21:39:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BA9D20838
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 21:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WjK9NjtL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BA9D20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9bk3-0007rU-Pm
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 16:39:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52053)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1j9bij-00068I-Gt
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 16:38:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1j9bih-0007Uu-PX
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 16:38:25 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41067
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1j9bih-0007U7-Mf
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 16:38:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583357902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=l6tX2+w2ST65MKyouGiIh7RQzHBOFgPo3I2iwl8Mxmk=;
 b=WjK9NjtL3y2dvsA6lvxMGgLhr3qmmeZahYBD6x2pALsRMmLAiROtA/2Qgztnak2pV9LV1B
 V1d5wZWBZW+S2+huWv9jSth9DxqkgDmrnFHPMSgbFEUEyeEoB2+f7Ow//dRa1buDp2rMJO
 3yhgdEOPlr0n/V67WehmuWJ/Fim9PIA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-83-kqrZ6ACCNJWC1W3LH_GiAA-1; Wed, 04 Mar 2020 16:38:21 -0500
X-MC-Unique: kqrZ6ACCNJWC1W3LH_GiAA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0AD508010E3;
 Wed,  4 Mar 2020 21:38:20 +0000 (UTC)
Received: from probe.redhat.com (ovpn-120-212.rdu2.redhat.com [10.10.120.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0E0385C1D4;
 Wed,  4 Mar 2020 21:38:18 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 00/10] iotests: use python logging
Date: Wed,  4 Mar 2020 16:38:08 -0500
Message-Id: <20200304213818.15341-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, armbru@redhat.com,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>, philmd@redhat.com
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

V7:

[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respecti=
vely

001/10:[0025] [FC] 'iotests: do a light delinting'
002/10:[----] [--] 'iotests: don't use 'format' for drive_add'
003/10:[----] [-C] 'iotests: ignore import warnings from pylint'
004/10:[0008] [FC] 'iotests: replace mutable list default args'
005/10:[0006] [FC] 'iotests: add pylintrc file'
006/10:[down] 'iotests: limit line length to 79 chars'
007/10:[0008] [FC] 'iotests: add script_initialize'
008/10:[----] [--] 'iotest 258: use script_main'
009/10:[----] [--] 'iotests: Mark verify functions as private'
010/10:[0006] [FC] 'iotests: use python logging for iotests.log()'

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

John Snow (10):
  iotests: do a light delinting
  iotests: don't use 'format' for drive_add
  iotests: ignore import warnings from pylint
  iotests: replace mutable list default args
  iotests: add pylintrc file
  iotests: limit line length to 79 chars
  iotests: add script_initialize
  iotest 258: use script_main
  iotests: Mark verify functions as private
  iotests: use python logging for iotests.log()

 tests/qemu-iotests/030        |   4 +-
 tests/qemu-iotests/055        |   3 +-
 tests/qemu-iotests/149        |   3 +-
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
 tests/qemu-iotests/iotests.py | 300 ++++++++++++++++++++--------------
 tests/qemu-iotests/pylintrc   |  26 +++
 42 files changed, 300 insertions(+), 196 deletions(-)
 create mode 100644 tests/qemu-iotests/pylintrc

--=20
2.21.1


