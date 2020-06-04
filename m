Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A69C2C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 20:23:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71322207D0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 20:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d+S2GXvD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71322207D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgwOt-0005ra-Fn
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 16:23:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49404)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jgwNw-0003us-Sx
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 16:22:44 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38146
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jgwNv-0005U8-GW
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 16:22:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591302161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=rlvr1akbpfej2zmC+f76o1Eb2ZezLElIKOU51/Rl4uM=;
 b=d+S2GXvDhZLW34tRYBSg8gc3cMKm6Orll5lPjJh1uhEQY1s16PF+hd0cIsdDvuZ9zZOr9y
 7ccfh7apHVn0Rb0c3oCHYpO2NqBuio4gOrM65SERDCnPObLuUA3gjIq8bUdzKRhiOlc+ho
 PpA3XIcVGMkslpGzNu/pjBs/YoykSUM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-AkUrbRqEM2S_SfYx8SPh9g-1; Thu, 04 Jun 2020 16:22:38 -0400
X-MC-Unique: AkUrbRqEM2S_SfYx8SPh9g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92BCA108BD1B;
 Thu,  4 Jun 2020 20:22:37 +0000 (UTC)
Received: from probe.redhat.com (ovpn-117-188.rdu2.redhat.com [10.10.117.188])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B73665D9D3;
 Thu,  4 Jun 2020 20:22:36 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 00/16] python: add mypy support to python/qemu
Date: Thu,  4 Jun 2020 16:22:20 -0400
Message-Id: <20200604202236.25039-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 01:08:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Based-on: 20200604195252.20739-1-jsnow@redhat.com

This series is extracted from my larger series that attempted to bundle
our python module as an installable module. These fixes don't require that,
so they are being sent first as I think there's less up for debate in here.

This requires my "refactor shutdown" patch as a pre-requisite.

v3:
001/16:[----] [--] 'python/qmp.py: Define common types'
002/16:[----] [--] 'iotests.py: use qemu.qmp type aliases'
003/16:[----] [--] 'python/qmp.py: re-absorb MonitorResponseError'
004/16:[----] [--] 'python/qmp.py: Do not return None from cmd_obj'
005/16:[0002] [FC] 'python/qmp.py: add casts to JSON deserialization'
006/16:[----] [--] 'python/qmp.py: add QMPProtocolError'
007/16:[----] [-C] 'python/machine.py: Fix monitor address typing'
008/16:[----] [--] 'python/machine.py: reorder __init__'
009/16:[----] [-C] 'python/machine.py: Don't modify state in _base_args()'
010/16:[down] 'python/machine.py: Handle None events in events_wait'
011/16:[----] [--] 'python/machine.py: use qmp.command'
012/16:[----] [--] 'python/machine.py: Add _qmp access shim'
013/16:[----] [--] 'python/machine.py: fix _popen access'
014/16:[----] [--] 'python/qemu: make 'args' style arguments immutable'
015/16:[----] [--] 'iotests.py: Adjust HMP kwargs typing'
016/16:[0007] [FC] 'python/qemu: Add mypy type annotations'

005: Removed a cast, per Kevin Wolf's tip
010: Renamed with correct function name;
     Rewrote docstring and added comments
016: Use SocketAddrT instead of Union[Tuple[str,str],str]

"v2":
- This version supports iotests 297
- Many patches merged by Phil are removed
- Replaces iotests.py type aliases with centralized ones
  (See patch 2)
- Imports etc are reworked to use the non-installable
  package layout instead. (Mostly important for patch 3)

Testing this out:
- You'll need Python3.6+
- I encourage you to use a virtual environment!
- You don't necessarily need these exact versions, but I didn't test the
  lower bounds, use older versions at your peril:
  - pylint==2.5.0
  - mypy=0.770
  - flake8=3.7.8

> cd ~/src/qemu/python/
> flake8 qemu
> mypy --strict qemu
> cd qemu
> pylint *.py

These should all 100% pass.

---

Open RFC: What's the right way to hook this into make check to prevent
regressions?

John Snow (16):
  python/qmp.py: Define common types
  iotests.py: use qemu.qmp type aliases
  python/qmp.py: re-absorb MonitorResponseError
  python/qmp.py: Do not return None from cmd_obj
  python/qmp.py: add casts to JSON deserialization
  python/qmp.py: add QMPProtocolError
  python/machine.py: Fix monitor address typing
  python/machine.py: reorder __init__
  python/machine.py: Don't modify state in _base_args()
  python/machine.py: Handle None events in events_wait
  python/machine.py: use qmp.command
  python/machine.py: Add _qmp access shim
  python/machine.py: fix _popen access
  python/qemu: make 'args' style arguments immutable
  iotests.py: Adjust HMP kwargs typing
  python/qemu: Add mypy type annotations

 python/qemu/accel.py          |   8 +-
 python/qemu/machine.py        | 286 ++++++++++++++++++++--------------
 python/qemu/qmp.py            | 111 +++++++++----
 python/qemu/qtest.py          |  53 ++++---
 scripts/render_block_graph.py |   7 +-
 tests/qemu-iotests/iotests.py |  11 +-
 6 files changed, 298 insertions(+), 178 deletions(-)

-- 
2.21.3


