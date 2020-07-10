Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0129C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 05:23:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EAAC20720
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 05:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PYUWKyqG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EAAC20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtlVk-0000jA-Sb
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 01:23:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jtlUS-0007AV-EZ
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 01:22:28 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41915
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jtlUQ-0008Bj-QG
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 01:22:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594358546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/EmkCoYGzMJnaF1oavGoH/h0JxhA47mRbjq2Gx91VvY=;
 b=PYUWKyqG4dCYVFIuT3TGo4zEfm3dewqCFTZ3wjVNxebR/FHhieoxfcY9ulY6J8dfET+lsP
 hrWXZABGuqyJ4NcDYNzDP2fg9JxLwBFIKLwsKXqMhXUtL+Y33Ql2nRunXLM/IoU1khNbW9
 35VKLGk+N4gFsQLS1vYObhPz/IeImqg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-91-HTIfW7qGMZm6xWNZatW2uA-1; Fri, 10 Jul 2020 01:22:23 -0400
X-MC-Unique: HTIfW7qGMZm6xWNZatW2uA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B8BE1009441;
 Fri, 10 Jul 2020 05:22:22 +0000 (UTC)
Received: from probe.redhat.com (ovpn-118-196.rdu2.redhat.com [10.10.118.196])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 12031920CA;
 Fri, 10 Jul 2020 05:22:20 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 00/16] python: add mypy support to python/qemu
Date: Fri, 10 Jul 2020 01:22:04 -0400
Message-Id: <20200710052220.3306-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 23:35:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

Based-on: 20200710050649.32434-1-jsnow@redhat.com

This series modifies the python/qemu library to comply with mypy --strict,
pylint, and flake8.
This requires my "refactor shutdown" patch as a pre-requisite.

v5: (Things unchanged omitted)

003/16:[----] [-C] 'python/qmp.py: re-absorb MonitorResponseError'
009/16:[----] [-C] 'python/machine.py: Don't modify state in _base_args()'
012/16:[0004] [FC] 'python/machine.py: Add _qmp access shim'
013/16:[0002] [FC] 'python/machine.py: fix _popen access'
016/16:[0004] [FC] 'python/qemu: Add mypy type annotations'

--  Rebased on "refactor shutdown" v5
12: Dependent changes from more extensive shutdown() refactoring
13: Dependent changes; one less ._popen access.
16: Dependent changes; _post_shutdown return annotation fell down here.
                       wait annotation got bumped up to the previous series.

v4:
 - Rebased on "refactor shutdown" v4
 - Fixed _qmp access for scripts that disable QMP

v3:
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
 python/qemu/machine.py        | 296 ++++++++++++++++++++--------------
 python/qemu/qmp.py            | 111 +++++++++----
 python/qemu/qtest.py          |  53 +++---
 scripts/render_block_graph.py |   7 +-
 tests/qemu-iotests/iotests.py |  11 +-
 6 files changed, 301 insertions(+), 185 deletions(-)

-- 
2.21.3


