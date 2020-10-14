Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11865C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 14:31:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C8D0212CC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 14:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GpULQPud"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C8D0212CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kShoo-0005r3-8N
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 10:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36370)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kShnI-0004Bm-QE
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 10:30:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40631)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kShnE-0005SW-0a
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 10:30:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602685814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=lV8gOC/4ZTH9hfr1s+24YNwoOwwWQqNonJV6a8e3tog=;
 b=GpULQPudqDQnd1g46wurNHAGCH96CkeeQX0RJtJJaCDDTwskSaX9HkdsrWUwiL2wdip0M3
 7x9Gyco2gYrnZ3AyFw5fFpgmgD43f0DmmGhFmDhmw/bbuBUHpXQTNCRLRf7lZ6KwnMsZ0W
 QD67qUEFRqxBNZOqszsdZX6PbycSH8I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-Ddy7zRlkM5m1Ekhrs8jvzA-1; Wed, 14 Oct 2020 10:30:10 -0400
X-MC-Unique: Ddy7zRlkM5m1Ekhrs8jvzA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87C5F10866A8;
 Wed, 14 Oct 2020 14:30:08 +0000 (UTC)
Received: from scv.redhat.com (ovpn-117-231.rdu2.redhat.com [10.10.117.231])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 857A476649;
 Wed, 14 Oct 2020 14:29:58 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/15] python: create installable package
Date: Wed, 14 Oct 2020 10:29:42 -0400
Message-Id: <20201014142957.763624-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 03:37:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Ben Widawsky <ben@bwidawsk.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Rohit Shinde <rohit.shinde12194@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Fam Zheng <fam@euphon.net>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Based-on: https://gitlab.com/jsnow/qemu/-/tree/python=0D
=0D
This series factors the python/qemu directory as an installable=0D
module. It does not yet actually change the mechanics of how any other=0D
python source in the tree actually consumes it (yet), beyond the import=0D
path.=0D
=0D
The point of this series is primarily to formalize our dependencies on=0D
mypy, flake8, isort, and pylint alongside versions that are known to=0D
work. It also adds explicitly pinned versions of these dependencies that=0D
should behave in a repeatable and known way for developers and CI=0D
environments both.=0D
=0D
With the python tooling as a proper package, you can install this=0D
package in editable or production mode to a virtual environment, your=0D
local user environment, or your system packages. The primary benefit of=0D
this is to gain access to QMP tooling regardless of CWD, without needing=0D
to battle sys.path.=0D
=0D
For example: when developing, you may go to qemu/python/ and invoke=0D
`pipenv shell` to activate a virtual environment that contains the qemu=0D
packages.  This package will always reflect the current version of the=0D
source files in the tree. When you are finished, you can simply exit the=0D
shell to remove these packages from your python environment.=0D
=0D
When not developing, you could install a version of this package to your=0D
environment outright to gain access to the QMP and QEMUMachine classes=0D
for lightweight scripting and testing by using pip: "pip install [--user] .=
"=0D
=0D
Finally, this package is formatted in such a way that it COULD be=0D
uploaded to https://pypi.org/project/qemu and installed independently of=0D
qemu.git with `pip install qemu`, but that button remains unpushed.=0D
=0D
TESTING THIS SERIES:=0D
=0D
CD to qemu/python first, and then:=0D
=0D
1. Try "pipenv shell" to get a venv with the package installed to it in=0D
editable mode. Ctrl+d exits this venv shell. While in this shell, any=0D
python script that uses "from qemu.core import ..." should work=0D
correctly regardless of your CWD.=0D
=0D
2. Try "pipenv sync --dev" to create/update the venv with the=0D
development packages without actually entering the venv. This should=0D
install isort, mypy, flake8 and pylint to the venv.=0D
=0D
3. After the above sync, try "pipenv shell" again, and from the python=0D
project root, try any of the following:=0D
=0D
  - pylint qemu=0D
  - flake8 qemu=0D
  - isort -c qemu=0D
  - mypy qemu=0D
=0D
4. Leave any venv you are in, and from the project root, try the=0D
following commands:=0D
=0D
  - pipenv run pylint qemu=0D
  - pipenv run flake8 qemu=0D
  - pipenv run isort -c qemu=0D
  - pipenv run mypy qemu=0D
=0D
John Snow (15):=0D
  python: create qemu.core package=0D
  python: add qemu package installer=0D
  python: add VERSION file=0D
  python: add directory structure README.rst files=0D
  python: Add pipenv support=0D
  python: add pylint exceptions to __init__.py=0D
  python: move pylintrc into setup.cfg=0D
  python: add pylint to pipenv=0D
  python: move flake8 config to setup.cfg=0D
  python: Add flake8 to pipenv=0D
  python: move mypy.ini into setup.cfg=0D
  python: add mypy to pipenv=0D
  python: move .isort.cfg into setup.cfg=0D
  python/qemu: add isort to pipenv=0D
  python/qemu: add qemu package itself to pipenv=0D
=0D
 python/PACKAGE.rst                        |  23 +++=0D
 python/README.rst                         |  27 +++=0D
 python/qemu/README.rst                    |   8 +=0D
 python/qemu/core/README.rst               |   9 +=0D
 python/Pipfile                            |  16 ++=0D
 python/Pipfile.lock                       | 207 ++++++++++++++++++++++=0D
 python/VERSION                            |   1 +=0D
 python/mypy.ini                           |   4 -=0D
 python/qemu/.flake8                       |   2 -=0D
 python/qemu/.isort.cfg                    |   7 -=0D
 python/qemu/__init__.py                   |  11 --=0D
 python/qemu/core/__init__.py              |  47 +++++=0D
 python/qemu/{ =3D> core}/accel.py           |   0=0D
 python/qemu/{ =3D> core}/console_socket.py  |   0=0D
 python/qemu/{ =3D> core}/machine.py         |   0=0D
 python/qemu/{ =3D> core}/qmp.py             |   0=0D
 python/qemu/{ =3D> core}/qtest.py           |   0=0D
 python/{qemu/pylintrc =3D> setup.cfg}       |  66 +++----=0D
 python/setup.py                           |  23 +++=0D
 scripts/device-crash-test                 |   2 +-=0D
 scripts/qmp/qemu-ga-client                |   2 +-=0D
 scripts/qmp/qmp                           |   2 +-=0D
 scripts/qmp/qmp-shell                     |   2 +-=0D
 scripts/qmp/qom-fuse                      |   2 +-=0D
 scripts/qmp/qom-get                       |   2 +-=0D
 scripts/qmp/qom-list                      |   2 +-=0D
 scripts/qmp/qom-set                       |   2 +-=0D
 scripts/qmp/qom-tree                      |   2 +-=0D
 scripts/render_block_graph.py             |   6 +-=0D
 scripts/simplebench/bench_block_job.py    |   4 +-=0D
 tests/acceptance/avocado_qemu/__init__.py |   2 +-=0D
 tests/acceptance/boot_linux.py            |   3 +-=0D
 tests/acceptance/virtio_check_params.py   |   2 +-=0D
 tests/acceptance/virtio_version.py        |   2 +-=0D
 tests/migration/guestperf/engine.py       |   2 +-=0D
 tests/qemu-iotests/235                    |   2 +-=0D
 tests/qemu-iotests/297                    |   2 +-=0D
 tests/qemu-iotests/300                    |   4 +-=0D
 tests/qemu-iotests/iotests.py             |   4 +-=0D
 tests/vm/basevm.py                        |   6 +-=0D
 40 files changed, 424 insertions(+), 84 deletions(-)=0D
 create mode 100644 python/PACKAGE.rst=0D
 create mode 100644 python/README.rst=0D
 create mode 100644 python/qemu/README.rst=0D
 create mode 100644 python/qemu/core/README.rst=0D
 create mode 100644 python/Pipfile=0D
 create mode 100644 python/Pipfile.lock=0D
 create mode 100644 python/VERSION=0D
 delete mode 100644 python/mypy.ini=0D
 delete mode 100644 python/qemu/.flake8=0D
 delete mode 100644 python/qemu/.isort.cfg=0D
 delete mode 100644 python/qemu/__init__.py=0D
 create mode 100644 python/qemu/core/__init__.py=0D
 rename python/qemu/{ =3D> core}/accel.py (100%)=0D
 rename python/qemu/{ =3D> core}/console_socket.py (100%)=0D
 rename python/qemu/{ =3D> core}/machine.py (100%)=0D
 rename python/qemu/{ =3D> core}/qmp.py (100%)=0D
 rename python/qemu/{ =3D> core}/qtest.py (100%)=0D
 rename python/{qemu/pylintrc =3D> setup.cfg} (51%)=0D
 mode change 100644 =3D> 100755=0D
 create mode 100755 python/setup.py=0D
=0D
--=20=0D
2.26.2=0D
=0D


