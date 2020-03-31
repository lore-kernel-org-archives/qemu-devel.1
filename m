Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B51C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 00:02:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DE0220771
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 00:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yo5sGg1d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DE0220771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJ4Me-0005Xf-AG
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 20:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35099)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1jJ4KT-0003fk-35
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 20:00:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1jJ4KP-0007aV-P1
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 20:00:27 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:56968)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1jJ4KP-0007XG-II
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 20:00:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585612824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=H0GJb1U2fGtmXLiD6C8AA5Jjix18YPn3wzzDa8O4KXA=;
 b=Yo5sGg1dHT+fAZ8d5ws+pwNd/K3WyOwd8hmTw0rcLzHkWUEJp51gheomC/nsuYBEG/CGIe
 gh7mwq4D4BOV/wgst8SbZDM/cEs79/LwM5ryPFYKOlEZKUfMmSqakf4yV5MrXP7rU2dEAV
 dmJaocL9V6WU1lIvftcu3/kRfzrvl4A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-th27StulMgWRGaBilKLsHw-1; Mon, 30 Mar 2020 20:00:22 -0400
X-MC-Unique: th27StulMgWRGaBilKLsHw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E99D7DB65;
 Tue, 31 Mar 2020 00:00:21 +0000 (UTC)
Received: from probe.redhat.com (ovpn-113-210.rdu2.redhat.com [10.10.113.210])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B2AA51001B2D;
 Tue, 31 Mar 2020 00:00:19 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 00/14] iotests: use python logging
Date: Mon, 30 Mar 2020 20:00:00 -0400
Message-Id: <20200331000014.11581-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
 armbru@redhat.com, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 philmd@redhat.com
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
Sorry about that. By version 9, it's now the overwhelming focus of
this series. No good deed, etc.

V10:

001/14:[0004] [FC] 'iotests: do a light delinting'
002/14:[----] [--] 'iotests: don't use 'format' for drive_add'
003/14:[----] [--] 'iotests: ignore import warnings from pylint'
004/14:[----] [--] 'iotests: replace mutable list default args'
005/14:[0006] [FC] 'iotests: add pylintrc file'
006/14:[----] [--] 'iotests: alphabetize standard imports'
007/14:[----] [--] 'iotests: drop pre-Python 3.4 compatibility code'
008/14:[----] [--] 'iotests: touch up log function signature'
009/14:[----] [-C] 'iotests: limit line length to 79 chars'
010/14:[0009] [FC] 'iotests: add hmp helper with logging'
011/14:[0019] [FC] 'iotests: add script_initialize'
012/14:[----] [--] 'iotest 258: use script_main'
013/14:[0013] [FC] 'iotests: Mark verify functions as private'
014/14:[0001] [FC] 'iotests: use python logging for iotests.log()'

001: replace "atom" name with "item". Kept RBs.
005: Alphabetized excluded warnings list. Kept RBs.
     Kevin's comments addressed by using pylint >=3D 2.2.0
009: Added Max's RB.
     Updated commit message based on Max's response
     Kevin's comments addressed by mypy >=3D 0.620
010: Fixed type hints (Kevin)
011: Replace 'Collection' with 'Sequence' to work around pylint/python 3.6
013: Update type signatures of _verify functions (Kevin)
014: Minor whitespace changes as the fault handler gets shuffled around.

V9:
006: New.
007: Split from old patch.
008: Split from old patch; enhanced a little to justify its own patch.
010: New, pulled in from bitmap-populate series. Helps line length.
011: Reflow columns for long `typing` import list. (Kept RB.)
014: New blank line. (Kept RB.)

V8:
- Split out the little drop of Python 3.4 code. (Phil)
- Change line continuation styles (QEMU Memorial Choir)
- Rebase changes; remove use_log from more places, adjust test output.

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

John Snow (14):
  iotests: do a light delinting
  iotests: don't use 'format' for drive_add
  iotests: ignore import warnings from pylint
  iotests: replace mutable list default args
  iotests: add pylintrc file
  iotests: alphabetize standard imports
  iotests: drop pre-Python 3.4 compatibility code
  iotests: touch up log function signature
  iotests: limit line length to 79 chars
  iotests: add hmp helper with logging
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
 tests/qemu-iotests/iotests.py | 366 ++++++++++++++++++++--------------
 tests/qemu-iotests/pylintrc   |  26 +++
 43 files changed, 343 insertions(+), 221 deletions(-)
 create mode 100644 tests/qemu-iotests/pylintrc

--=20
2.21.1


