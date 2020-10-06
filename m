Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB67C4363D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 00:04:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8D252054F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 00:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RnykhVC0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8D252054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPwwK-0004us-Ny
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 20:04:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kPwqk-0007mZ-Al
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 19:58:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28769)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kPwqd-0002HM-VW
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 19:58:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602028702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=cA8+U3QK4F6syvATPSR1HCFONmAbWe6xx5NQVWsk2ZI=;
 b=RnykhVC0yd1e/k0s0p8VPmvG7Zp+TR9oTcnVHDF18XSvq1jFQXn5XYWJF0wNeC+6CnGfYK
 Gs5fRMecZu6HRMdB9F+k5FNw3bwkrz9QluYZlYS7e4JQOyDi8d6nQsj61NA4PmrRhG0W23
 42hHkNATT3CBXfuAs0xgP2XZp8hrSY8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-KXFH3o3fMXmkq5e03jWFbw-1; Tue, 06 Oct 2020 19:58:20 -0400
X-MC-Unique: KXFH3o3fMXmkq5e03jWFbw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E12AD1084D60;
 Tue,  6 Oct 2020 23:58:18 +0000 (UTC)
Received: from scv.redhat.com (ovpn-120-38.rdu2.redhat.com [10.10.120.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B552C619B5;
 Tue,  6 Oct 2020 23:58:17 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/20] python/qemu: strictly typed mypy conversion, pt2
Date: Tue,  6 Oct 2020 19:57:57 -0400
Message-Id: <20201006235817.3280413-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 00:55:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Continuing where I left off prior to the 5.1 release, this series=0D
touches up a few odds and ends and introduces mypy hints.=0D
=0D
What's new:=0D
=0D
- Using isort to solidify import order=0D
- Patches adding small corrections and typing for console_socket=0D
- A few error class changes for qmp.py=0D
=0D
Like my QAPI series, this requires:=0D
=0D
- pylint >=3D 2.6.0=0D
- flake8 >=3D 3.8.0=0D
- mypy >=3D 0.770=0D
- isort >=3D 4.3.0 (Presumably...)=0D
=0D
What this series doesn't do:=0D
=0D
- Create a proper python package=0D
- Establish a CI test to prevent regressions=0D
- Fix the docstring conventions in the library=0D
=0D
Those are coming soon! (and in the order mentioned.)=0D
=0D
Changes against the last version of this series that was sent prior to=0D
5.1:=0D
=0D
001/20:[down] 'python/qemu: use isort to lay out imports'=0D
002/20:[0005] [FC] 'python/machine.py: Fix monitor address typing'=0D
003/20:[0015] [FC] 'python/machine.py: reorder __init__'=0D
004/20:[0009] [FC] 'python/machine.py: Don't modify state in _base_args()'=
=0D
005/20:[0002] [FC] 'python/machine.py: Handle None events in events_wait'=
=0D
006/20:[0006] [FC] 'python/machine.py: use qmp.command'=0D
007/20:[----] [-C] 'python/machine.py: Add _qmp access shim'=0D
008/20:[----] [-C] 'python/machine.py: fix _popen access'=0D
009/20:[0006] [FC] 'python/qemu: make 'args' style arguments immutable'=0D
010/20:[----] [--] 'iotests.py: Adjust HMP kwargs typing'=0D
011/20:[0010] [FC] 'python/qemu: Add mypy type annotations'=0D
012/20:[down] 'python/qemu/console_socket.py: Correct type of recv()'=0D
013/20:[down] 'python/qemu/console_socket.py: fix typing of settimeout'=0D
014/20:[down] 'python/qemu/console_socket.py: Clarify type of drain_thread'=
=0D
015/20:[down] 'python/qemu/console_socket.py: Add type hint annotations'=0D
016/20:[down] 'python/console_socket: avoid encoding to/from string'=0D
017/20:[down] 'python/qemu/qmp.py: Preserve error context on re-raise'=0D
018/20:[down] 'python/qemu/qmp.py: re-raise OSError when encountered'=0D
019/20:[down] 'python/qemu/qmp.py: Straighten out exception hierarchy'=0D
020/20:[down] 'python: add mypy config'=0D
=0D
02: import order differences, context changes from console_socket.py=0D
03: (minor) changes for console_socket, RB-s dropped just in case=0D
04: import order differences=0D
05: import order differences=0D
06: import order differences=0D
09: import order differences=0D
11: import order differences, small changes for console_socket=0D
=0D
John Snow (20):=0D
  python/qemu: use isort to lay out imports=0D
  python/machine.py: Fix monitor address typing=0D
  python/machine.py: reorder __init__=0D
  python/machine.py: Don't modify state in _base_args()=0D
  python/machine.py: Handle None events in events_wait=0D
  python/machine.py: use qmp.command=0D
  python/machine.py: Add _qmp access shim=0D
  python/machine.py: fix _popen access=0D
  python/qemu: make 'args' style arguments immutable=0D
  iotests.py: Adjust HMP kwargs typing=0D
  python/qemu: Add mypy type annotations=0D
  python/qemu/console_socket.py: Correct type of recv()=0D
  python/qemu/console_socket.py: fix typing of settimeout=0D
  python/qemu/console_socket.py: Clarify type of drain_thread=0D
  python/qemu/console_socket.py: Add type hint annotations=0D
  python/console_socket: avoid encoding to/from string=0D
  python/qemu/qmp.py: Preserve error context on re-raise=0D
  python/qemu/qmp.py: re-raise OSError when encountered=0D
  python/qemu/qmp.py: Straighten out exception hierarchy=0D
  python: add mypy config=0D
=0D
 python/mypy.ini               |   4 +=0D
 python/qemu/.isort.cfg        |   7 +=0D
 python/qemu/accel.py          |   9 +-=0D
 python/qemu/console_socket.py |  54 +++---=0D
 python/qemu/machine.py        | 306 +++++++++++++++++++++-------------=0D
 python/qemu/qmp.py            | 114 ++++++++-----=0D
 python/qemu/qtest.py          |  55 +++---=0D
 tests/qemu-iotests/iotests.py |   2 +-=0D
 8 files changed, 331 insertions(+), 220 deletions(-)=0D
 create mode 100644 python/mypy.ini=0D
 create mode 100644 python/qemu/.isort.cfg=0D
=0D
--=20=0D
2.26.2=0D
=0D


