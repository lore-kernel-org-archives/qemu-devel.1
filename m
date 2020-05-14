Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC69BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 05:56:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9614A205CB
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 05:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cFYZvWFM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9614A205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ6rZ-0002O0-MC
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 01:56:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jZ6ov-0004G0-Qp
 for qemu-devel@nongnu.org; Thu, 14 May 2020 01:54:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48181
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jZ6ou-0001ZX-Q9
 for qemu-devel@nongnu.org; Thu, 14 May 2020 01:54:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589435652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=dH4ZXqAFuug2EBmy1VfGMeC26e+iQIpv36Jr8GdOoe4=;
 b=cFYZvWFMX3TtOgekq9jongVIYogx9D4ZbpVs8PoeJKg8jn1je63H5TVHmXRMt0DRUWn2P4
 xp/1BQ06qZgz5qFJkk2pm9rSeqT9wUY8S9JlLyGiCFrc2G9tVIUqz0ySxwZUdDUN6opKjM
 gPrg6gdiZbqQE7SBqEyEkFyPkgrA2Uc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-OzmykLznNey4zqYZOisEEA-1; Thu, 14 May 2020 01:54:07 -0400
X-MC-Unique: OzmykLznNey4zqYZOisEEA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB96B83DA41;
 Thu, 14 May 2020 05:54:05 +0000 (UTC)
Received: from probe.redhat.com (ovpn-113-9.rdu2.redhat.com [10.10.113.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 64D077D959;
 Thu, 14 May 2020 05:54:04 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC 00/32] python/qemu: refactor as installable package
Date: Thu, 14 May 2020 01:53:31 -0400
Message-Id: <20200514055403.18902-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jsnow@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hey, I got lost on my way to the store and I accidentally got 32 patches
that convert our python library into something that passes pylint,
flake8, and mypy --strict.

...So, a few things:

1. This is just an RFC. The actual design of these libraries really
needs adjusted to be more pythonic. In general this means less
Optional[T] return types and raising more exceptions. This could be
handled later, but we ought to address it before publishing, if we do.

2. We still need to think carefully about how we package this, if we
even want to package it, what the license on the top-level package
should be, etc.

3. We should consider how to version it. For now, I'm using a lockstep
versioning.

4. You can install this package using pip3 or python3 setup.py to a
virtual environment or to your real one. From there, any python code in
the QEMU tree that imports these modules will work with no sys.path
hacking or custom PYTHONPATH exports.

5. You don't have to install it, though. I left all of the usual hacks
in place in the rest of the tree so that everything will just keep
working exactly as-is for right now. It's just that you COULD install it.

6. Here's a cool trick if you don't know about it yet:

> cd qemu/python/qemu
> pip3 install --user -e .

This will install the package in "develop" mode, which installs a
forwarder package. When you update your source tree, the installed
package stays "up to date" with the most recent edits.

Alright, have fun, stay safe!

John Snow (32):
  python/qemu: create qemu.lib module
  scripts/qmp: Fix shebang and imports
  python//machine.py: remove bare except
  python/qemu/lib: delint, add pylintrc
  python/qemu/lib: delint; add flake8 config
  python/qemu: formalize as package
  python/qemu: add README.rst
  python/qemu: Add Pipfile
  python/qemu: add pylint to Pipfile
  python/qemu: Add flake8 to Pipfile
  python/qemu/lib: remove Python2 style super() calls
  python/qemu/lib: fix socket.makefile() typing
  python/qemu/lib: Adjust traceback typing
  python//qmp.py: use True/False for non/blocking modes
  python//qmp.py: Define common types
  python//qmp.py: re-absorb MonitorResponseError
  python//qmp.py: Do not return None from cmd_obj
  python//qmp.py: add casts to JSON deserialization
  python//qmp.py: add QMPProtocolError
  python//qmp.py: assert sockfile is not None
  python//machine.py: remove logging configuration
  python//machine.py: Fix monitor address typing
  python//machine.py: reorder __init__
  python//machine.py: Don't modify state in _base_args()
  python//machine.py: Handle None events in event_wait
  python//machine.py: use qmp.command
  python//machine.py: Add _qmp access shim
  python//machine.py: fix _popen access
  python//qtest.py: Check before accessing _qtest
  python/qemu/lib: make 'args' style arguments immutable
  python/qemu: add mypy to Pipfile
  python/qemu/lib: Add mypy type annotations

 python/README.rst                         |   6 +
 python/qemu/README.rst                    |   8 +
 python/Pipfile                            |  14 +
 python/Pipfile.lock                       | 187 +++++++++++++
 python/qemu/__init__.py                   |  11 -
 python/qemu/lib/.flake8                   |   2 +
 python/qemu/lib/__init__.py               |  57 ++++
 python/qemu/{ => lib}/accel.py            |  17 +-
 python/qemu/{ => lib}/machine.py          | 320 +++++++++++++---------
 python/qemu/lib/pylintrc                  |  58 ++++
 python/qemu/{ => lib}/qmp.py              | 140 +++++++---
 python/qemu/lib/qtest.py                  | 160 +++++++++++
 python/qemu/qtest.py                      | 119 --------
 python/setup.py                           |  50 ++++
 scripts/device-crash-test                 |   2 +-
 scripts/qmp/qemu-ga-client                |   2 +-
 scripts/qmp/qmp                           |   4 +-
 scripts/qmp/qmp-shell                     |   2 +-
 scripts/qmp/qom-fuse                      |   4 +-
 scripts/qmp/qom-get                       |   6 +-
 scripts/qmp/qom-list                      |   4 +-
 scripts/qmp/qom-set                       |   6 +-
 scripts/qmp/qom-tree                      |   6 +-
 scripts/render_block_graph.py             |   5 +-
 scripts/simplebench/bench_block_job.py    |   4 +-
 tests/acceptance/avocado_qemu/__init__.py |   2 +-
 tests/acceptance/boot_linux.py            |   3 +-
 tests/acceptance/virtio_check_params.py   |   2 +-
 tests/acceptance/virtio_version.py        |   2 +-
 tests/migration/guestperf/engine.py       |   2 +-
 tests/qemu-iotests/235                    |   2 +-
 tests/qemu-iotests/iotests.py             |   2 +-
 tests/vm/basevm.py                        |   6 +-
 33 files changed, 881 insertions(+), 334 deletions(-)
 create mode 100644 python/README.rst
 create mode 100644 python/qemu/README.rst
 create mode 100644 python/Pipfile
 create mode 100644 python/Pipfile.lock
 delete mode 100644 python/qemu/__init__.py
 create mode 100644 python/qemu/lib/.flake8
 create mode 100644 python/qemu/lib/__init__.py
 rename python/qemu/{ => lib}/accel.py (86%)
 rename python/qemu/{ => lib}/machine.py (67%)
 create mode 100644 python/qemu/lib/pylintrc
 rename python/qemu/{ => lib}/qmp.py (70%)
 create mode 100644 python/qemu/lib/qtest.py
 delete mode 100644 python/qemu/qtest.py
 create mode 100755 python/setup.py

-- 
2.21.1


