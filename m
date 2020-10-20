Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58353C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 19:38:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFB832225D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 19:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GaEy1rhQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFB832225D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUxT1-00085f-E4
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 15:38:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kUxQf-00064P-19
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 15:36:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23971)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kUxQW-0000xX-Hy
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 15:36:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603222566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=xtqcJAUYuLJAJpXRUfjnqDw1SsReRIH+lGN/DWz9fRw=;
 b=GaEy1rhQqZo42whOFmVWYRy4t4eGiXLbvdfWhHRoa4TcGwzrZlTuQSVj0ltYwFK4CHRUw5
 42e322PqJ2hpUyRDFMSmNaWlT1EBjfda9zphpnK+Xcan99KbbCmK8NNwze/zecYwhpSSvj
 uehZdR0uEU/Y7nFeRHPTGtzgvUFVCfM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-gj8lbIvbMO6K0hA7mUQgtQ-1; Tue, 20 Oct 2020 15:36:03 -0400
X-MC-Unique: gj8lbIvbMO6K0hA7mUQgtQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 909098049E1;
 Tue, 20 Oct 2020 19:36:01 +0000 (UTC)
Received: from scv.redhat.com (ovpn-115-172.rdu2.redhat.com [10.10.115.172])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9471D5C1C2;
 Tue, 20 Oct 2020 19:35:56 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 00/15] python: create installable package
Date: Tue, 20 Oct 2020 15:35:40 -0400
Message-Id: <20201020193555.1493936-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:16:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Ben Widawsky <ben@bwidawsk.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Rohit Shinde <rohit.shinde12194@gmail.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Based-on: https://gitlab.com/jsnow/qemu/-/tree/python=0D
=0D
This series factors the python/qemu directory as an installable=0D
package. It does not yet actually change the mechanics of how any other=0D
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
python script that uses "from qemu.[qmp|machine] import ..." should work=0D
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
V3:=0D
 - Changed "qemu.core" to "qemu.qmp" and "qemu.machine",=0D
   Partly to accommodate forthcoming work which would benefit from a separa=
te=0D
   qemu.qmp namespace.=0D
 - Changed the initial version from 5.2.0a1 to 0.5.2.0a1, to allow for=0D
   more rapid development while we smooth out the initial kinks.=0D
 - 001: Renamed patch title; differences implement the new names.=0D
 - 002: Readme changes for above.=0D
 - 003: Version change.=0D
 - 004: New readme for the new qmp directory.=0D
 - 006: A few more import exceptions for pylint, hopefully temporary.=0D
 - 009: Updated flake8 config comment to match qapi's=0D
 - 012: Added namespace_package configuration value=0D
=0D
001/15:[down] 'python: create qemu packages'=0D
002/15:[0009] [FC] 'python: add qemu package installer'=0D
003/15:[0002] [FC] 'python: add VERSION file'=0D
004/15:[0015] [FC] 'python: add directory structure README.rst files'=0D
005/15:[----] [--] 'python: Add pipenv support'=0D
006/15:[down] 'python: add pylint import exceptions'=0D
007/15:[----] [--] 'python: move pylintrc into setup.cfg'=0D
008/15:[----] [--] 'python: add pylint to pipenv'=0D
009/15:[0002] [FC] 'python: move flake8 config to setup.cfg'=0D
010/15:[----] [--] 'python: Add flake8 to pipenv'=0D
011/15:[----] [-C] 'python: move mypy.ini into setup.cfg'=0D
012/15:[0001] [FC] 'python: add mypy to pipenv'=0D
013/15:[----] [--] 'python: move .isort.cfg into setup.cfg'=0D
014/15:[----] [--] 'python/qemu: add isort to pipenv'=0D
015/15:[----] [--] 'python/qemu: add qemu package itself to pipenv'=0D
=0D
John Snow (15):=0D
  python: create qemu packages=0D
  python: add qemu package installer=0D
  python: add VERSION file=0D
  python: add directory structure README.rst files=0D
  python: Add pipenv support=0D
  python: add pylint import exceptions=0D
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
 python/PACKAGE.rst                          |  26 +++=0D
 python/README.rst                           |  27 +++=0D
 python/qemu/README.rst                      |   8 +=0D
 python/qemu/machine/README.rst              |   9 +=0D
 python/qemu/qmp/README.rst                  |   9 +=0D
 python/Pipfile                              |  16 ++=0D
 python/Pipfile.lock                         | 207 ++++++++++++++++++++=0D
 python/VERSION                              |   1 +=0D
 python/mypy.ini                             |   4 -=0D
 python/qemu/.flake8                         |   2 -=0D
 python/qemu/.isort.cfg                      |   7 -=0D
 python/qemu/__init__.py                     |  11 --=0D
 python/qemu/machine/__init__.py             |  44 +++++=0D
 python/qemu/{ =3D> machine}/accel.py          |   0=0D
 python/qemu/{ =3D> machine}/console_socket.py |   0=0D
 python/qemu/{ =3D> machine}/machine.py        |  16 +-=0D
 python/qemu/{ =3D> machine}/qtest.py          |   3 +-=0D
 python/qemu/{qmp.py =3D> qmp/__init__.py}     |  12 +-=0D
 python/{qemu/pylintrc =3D> setup.cfg}         |  67 ++++---=0D
 python/setup.py                             |  23 +++=0D
 tests/acceptance/boot_linux.py              |   3 +-=0D
 tests/qemu-iotests/297                      |   2 +-=0D
 tests/qemu-iotests/300                      |   4 +-=0D
 tests/qemu-iotests/iotests.py               |   2 +-=0D
 tests/vm/basevm.py                          |   3 +-=0D
 25 files changed, 437 insertions(+), 69 deletions(-)=0D
 create mode 100644 python/PACKAGE.rst=0D
 create mode 100644 python/README.rst=0D
 create mode 100644 python/qemu/README.rst=0D
 create mode 100644 python/qemu/machine/README.rst=0D
 create mode 100644 python/qemu/qmp/README.rst=0D
 create mode 100644 python/Pipfile=0D
 create mode 100644 python/Pipfile.lock=0D
 create mode 100644 python/VERSION=0D
 delete mode 100644 python/mypy.ini=0D
 delete mode 100644 python/qemu/.flake8=0D
 delete mode 100644 python/qemu/.isort.cfg=0D
 delete mode 100644 python/qemu/__init__.py=0D
 create mode 100644 python/qemu/machine/__init__.py=0D
 rename python/qemu/{ =3D> machine}/accel.py (100%)=0D
 rename python/qemu/{ =3D> machine}/console_socket.py (100%)=0D
 rename python/qemu/{ =3D> machine}/machine.py (98%)=0D
 rename python/qemu/{ =3D> machine}/qtest.py (98%)=0D
 rename python/qemu/{qmp.py =3D> qmp/__init__.py} (96%)=0D
 rename python/{qemu/pylintrc =3D> setup.cfg} (50%)=0D
 mode change 100644 =3D> 100755=0D
 create mode 100755 python/setup.py=0D
=0D
--=20=0D
2.26.2=0D
=0D


