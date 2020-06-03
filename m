Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7973AC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 00:16:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45F552067B
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 00:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gic03k1W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45F552067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgH5I-0008Ol-Ey
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 20:16:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35126)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jgH4C-00072m-3g
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 20:15:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44465
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jgH49-0005iQ-FX
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 20:15:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591143332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2mFG57JHDodXybBVi0e5PYoy/G8nd9k/VB4rDD34u60=;
 b=Gic03k1WSu9TRDWVvgcBZ6Wy+dmX2uqLxrIkUHTaHURU0pOixv4ZeDDo8hTMvOy8nPwNXw
 A7C42rXJPkUvCuGOSxuPHY7wm7Ozp8Vpgf/OWufqfE3EI4/KXT/Ez3sqPDiEOCgplhysYX
 WWJ6xF6VzXVxZJW1+K5Jdyv7epfyfW4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-VUoyrbQvPWK2HeCFpls0_A-1; Tue, 02 Jun 2020 20:15:29 -0400
X-MC-Unique: VUoyrbQvPWK2HeCFpls0_A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F03E8014D4;
 Wed,  3 Jun 2020 00:15:28 +0000 (UTC)
Received: from probe.redhat.com (ovpn-112-142.rdu2.redhat.com [10.10.112.142])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CA7EF78B56;
 Wed,  3 Jun 2020 00:15:23 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/7] python: create installable package
Date: Tue,  2 Jun 2020 20:15:16 -0400
Message-Id: <20200603001523.18085-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jsnow@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 17:45:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Based-on: 20200602214528.12107-1-jsnow@redhat.com

This series factors the python/qemu directory as an installable
module. As a developer, you can install this to your virtual environment
and then always have access to the classes contained within without
needing to wrangle python import path problems.

When developing, you could go to qemu/python/ and invoke `pipenv shell`
to activate a virtual environment within which you could type `pip
install -e .` to install a special development version of this package
to your virtual environment. This package will always reflect the most
recent version of the source files in the tree.

When not developing, you could install a version of this package to your
environment outright to gain access to the QMP and QEMUMachine classes
for lightweight scripting and testing.

This package is formatted in such a way that it COULD be uploaded to
https://pypi.org/project/qemu and installed independently of qemu.git
with `pip install qemu`, but of course that button remains unpushed.

There are a few major questions to answer first:

- What versioning scheme should we use? See patch 2.

- Should we use a namespace package or not?
  - Namespaced: 'qemu.machine', 'qemu.monitor' etc may be separately
    versioned, packaged and distributed packages. Third party authors
    may register 'qemu.xxx' to create plugins within the namespace as
    they see fit.

  - Non-namespaced: 'qemu' is one giant glob package, packaged and
    versioned in unison. We control this package exclusively.

- How do we eliminate sys.path hacks from the rest of the QEMU tree?
  (Background: sys.path hacks generally impede the function of static
  code quality analysis tools like mypy and pylint.)

  - Simplest: parent scripts (or developer) needs to set PYTHONPATH.

  - Harder: Python scripts should all be written to assume package form,
    all tests and CI that use Python should execute within a VENV.

  In either case, we lose the ability (for many scripts) to "just run" a
  script out of the source tree if it depends on other QEMU Python
  files. This is annoying, but as the complexity of the Python lib
  grows, it is unavoidable.

  In the VENV case, we at least establish a simple paradigm: the scripts
  should work in their "installed" forms; and the rest of the build and
  test infrastructure should use this VENV to automatically handle
  dependencies and path requirements. This should allow us to move many
  of our existing python scripts with "hidden" dependencies into a
  proper python module hierarchy and test for regressions with mypy,
  flake8, pylint, etc.

  (We could even establish e.g. Sphinx versions as a dependency for our
  build kit here and make sure it's installed to the VENV.)

  Pros: Almost all scripts can be moved under python/qemu/* and checked
  with CQA tools. imports are written the same no matter where you are
  (Use the fully qualified names, e.g. qemu.core.qmp.QMPMessage).
  Regressions in scripts are caught *much* faster.

  Downsides: Kind of annoying; most scripts now require you to install a
  devkit forwarder (pip3 install --user .) or be inside of an activated
  venv. Not too bad if you know python at all, but it's certainly less
  plug-n-play.

- What's our backwards compatibility policy if we start shipping this?

  Proposed: Attempt to maintain API compatibility (after stabilizing the
  library). Incompatible changes should probably cause a semver bump.

  Each published release makes no attempt to support any version of QEMU
  other than the one it was released against. We publish this on the tin
  in big red letters.

TESTING THIS PACKAGE OUT:

1. You can install to your local user's environment normally by
navigating to qemu/python/ and typing "pip3 install --user ."

2. If you are in a VENV, use "pip install ."

3. To install in development mode (Where the installed package always
reflects the most recent version of the files automatically), use "pip3
install -e ." or "pip install -e ." as appropriate (See above)

John Snow (7):
  python/qemu: create qemu.lib module
  python/qemu: formalize as package
  python/qemu: add README.rst
  python/qemu: Add pipenv support
  python/qemu: add pylint to pipenv
  python/qemu: Add flake8 to pipenv
  python/qemu: add mypy to pipenv

 python/README.rst                         |   6 +
 python/qemu/README.rst                    |   8 +
 python/Pipfile                            |  14 ++
 python/Pipfile.lock                       | 195 ++++++++++++++++++++++
 python/qemu/__init__.py                   |  11 --
 python/qemu/{ => core}/.flake8            |   0
 python/qemu/core/__init__.py              |  57 +++++++
 python/qemu/{ => core}/accel.py           |   0
 python/qemu/{ => core}/machine.py         |   0
 python/qemu/{ => core}/pylintrc           |   0
 python/qemu/{ => core}/qmp.py             |   0
 python/qemu/{ => core}/qtest.py           |   0
 python/setup.py                           |  50 ++++++
 scripts/device-crash-test                 |   2 +-
 scripts/qmp/qemu-ga-client                |   2 +-
 scripts/qmp/qmp                           |   2 +-
 scripts/qmp/qmp-shell                     |   2 +-
 scripts/qmp/qom-fuse                      |   2 +-
 scripts/qmp/qom-get                       |   2 +-
 scripts/qmp/qom-list                      |   2 +-
 scripts/qmp/qom-set                       |   2 +-
 scripts/qmp/qom-tree                      |   2 +-
 scripts/render_block_graph.py             |   6 +-
 scripts/simplebench/bench_block_job.py    |   4 +-
 tests/acceptance/avocado_qemu/__init__.py |   2 +-
 tests/acceptance/boot_linux.py            |   3 +-
 tests/acceptance/virtio_check_params.py   |   2 +-
 tests/acceptance/virtio_version.py        |   2 +-
 tests/migration/guestperf/engine.py       |   2 +-
 tests/qemu-iotests/235                    |   2 +-
 tests/qemu-iotests/297                    |   2 +-
 tests/qemu-iotests/iotests.py             |   4 +-
 tests/vm/basevm.py                        |   6 +-
 33 files changed, 355 insertions(+), 39 deletions(-)
 create mode 100644 python/README.rst
 create mode 100644 python/qemu/README.rst
 create mode 100644 python/Pipfile
 create mode 100644 python/Pipfile.lock
 delete mode 100644 python/qemu/__init__.py
 rename python/qemu/{ => core}/.flake8 (100%)
 create mode 100644 python/qemu/core/__init__.py
 rename python/qemu/{ => core}/accel.py (100%)
 rename python/qemu/{ => core}/machine.py (100%)
 rename python/qemu/{ => core}/pylintrc (100%)
 rename python/qemu/{ => core}/qmp.py (100%)
 rename python/qemu/{ => core}/qtest.py (100%)
 create mode 100755 python/setup.py

-- 
2.21.3


