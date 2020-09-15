Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D06C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 22:42:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4FA920795
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 22:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y9c5WNXq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4FA920795
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIJek-0008DV-Tk
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 18:42:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59090)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kIJd2-0006JT-I1
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 18:40:50 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55891
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kIJcy-0002W6-Jp
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 18:40:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600209643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hjSM66OxZQy1GKVaXpLaMGY0+ng/l+SVrtnkfVCPXNc=;
 b=Y9c5WNXqbYgvbO7i5VA4MHERg+VXr20F97rcn+31aC8neuZdfLJX8jGuGbcY16PnLqMIWf
 N+dcHRD1ZdOFHGPSsQ1Bxu1oXFp1TGozWnumAz68E1nK2Ue6g7k2ib218lc5Rf4ZBBTb8K
 3973/5uBHqxpqqv81zVfYOjr2yEEzuk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-519--d2wCUbMPgyB8t5IKJUs7w-1; Tue, 15 Sep 2020 18:40:36 -0400
X-MC-Unique: -d2wCUbMPgyB8t5IKJUs7w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BCB761891E81;
 Tue, 15 Sep 2020 22:40:29 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8AD3F81C43;
 Tue, 15 Sep 2020 22:40:28 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 00/37] qapi: static typing conversion, pt1
Date: Tue, 15 Sep 2020 18:39:50 -0400
Message-Id: <20200915224027.2529813-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 18:40:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, this series starts adding static type hints to the QAPI module. As=0D
you can see, the series started getting quite a bit long, so this is=0D
only a partial conversion that focuses on a handful of the easier files.=0D
=0D
The tougher files -- schema.py, expr.py, parser.py -- will each receive=0D
their own series as a follow-up to this one.=0D
=0D
Notes:=0D
=0D
- This requires Python 3.6+. Python 3.5 is EOL, so let's do that.=0D
=0D
- Any patch named "add notational type hints" changes ONLY signatures,=0D
  which have no runtime impact whatsoever. These are big patches,=0D
  but fairly straightforward.=0D
=0D
- Most other patches are as bite-sized as possible, generally fixing one=0D
  single warning.=0D
=0D
- After patch 6, `flake8 qapi/` should pass 100% on this and every=0D
  future commit.=0D
=0D
- After patch 7, `pylint --rcfile=3Dqapi/pylintrc qapi/` should pass 100%=
=0D
  on this and every future commit.=0D
=0D
- After patch 16, `mypy --config-file=3Dqapi/mypy.ini qapi/` should pass=0D
  100% on this and every future commit.=0D
=0D
Preliminary refactoring and prerequisites:=0D
=0D
001/37: 'python: Require 3.6+'=0D
002/37: '[DO-NOT-MERGE] qapi: add debugging tools'=0D
003/37: 'qapi-gen: Separate arg-parsing from generation'=0D
004/37: 'qapi: move generator entrypoint into module'=0D
005/37: 'qapi: Remove wildcard includes'=0D
006/37: 'qapi: delint using flake8'=0D
007/37: 'qapi: add pylintrc'=0D
=0D
common.py (and params.py):=0D
=0D
008/37: 'qapi/common.py: Remove python compatibility workaround'=0D
009/37: 'qapi/common.py: Add indent manager'=0D
010/37: 'qapi/common.py: delint with pylint'=0D
011/37: 'qapi/common.py: Replace one-letter 'c' variable'=0D
012/37: 'qapi/common.py: check with pylint'=0D
013/37: 'qapi/common.py: add notational type hints'=0D
014/37: 'qapi/common.py: Move comments into docstrings'=0D
015/37: 'qapi/common.py: split build_params into new file'=0D
016/37: 'qapi: establish mypy type-checking baseline'=0D
=0D
events.py:=0D
=0D
017/37: 'qapi/events.py: add notational type hints'=0D
018/37: 'qapi/events.py: Move comments into docstrings'=0D
=0D
commands.py:=0D
=0D
019/37: 'qapi/commands.py: Don't re-bind to variable of different type'=0D
020/37: 'qapi/commands.py: add notational type hints'=0D
021/37: 'qapi/commands.py: enable checking with mypy'=0D
=0D
source.py:=0D
=0D
022/37: 'qapi/source.py: add notational type hints'=0D
023/37: 'qapi/source.py: delint with pylint'=0D
=0D
gen.py:=0D
=0D
024/37: 'qapi/gen.py: Fix edge-case of _is_user_module'=0D
025/37: 'qapi/gen.py: add notational type hints'=0D
026/37: 'qapi/gen.py: Enable checking with mypy'=0D
027/37: 'qapi/gen.py: Remove unused parameter'=0D
028/37: 'qapi/gen.py: update write() to be more idiomatic'=0D
029/37: 'qapi/gen.py: delint with pylint'=0D
=0D
introspect.py:=0D
=0D
030/37: 'qapi/introspect.py: Add a typed 'extra' structure'=0D
031/37: 'qapi/introspect.py: add _gen_features helper'=0D
032/37: 'qapi/introspect.py: create a typed 'Node' data structure'=0D
033/37: 'qapi/introspect.py: add notational type hints'=0D
=0D
types.py:=0D
=0D
034/37: 'qapi/types.py: add notational type hints'=0D
035/37: 'qapi/types.py: remove one-letter variables'=0D
=0D
visit.py:=0D
=0D
036/37: 'qapi/visit.py: remove unused parameters from gen_visit_object'=0D
037/37: 'qapi/visit.py: add notational type hints'=0D
=0D
John Snow (37):=0D
  python: Require 3.6+=0D
  [DO-NOT-MERGE] qapi: add debugging tools=0D
  qapi-gen: Separate arg-parsing from generation=0D
  qapi: move generator entrypoint into module=0D
  qapi: Remove wildcard includes=0D
  qapi: delint using flake8=0D
  qapi: add pylintrc=0D
  qapi/common.py: Remove python compatibility workaround=0D
  qapi/common.py: Add indent manager=0D
  qapi/common.py: delint with pylint=0D
  qapi/common.py: Replace one-letter 'c' variable=0D
  qapi/common.py: check with pylint=0D
  qapi/common.py: add notational type hints=0D
  qapi/common.py: Move comments into docstrings=0D
  qapi/common.py: split build_params into new file=0D
  qapi: establish mypy type-checking baseline=0D
  qapi/events.py: add notational type hints=0D
  qapi/events.py: Move comments into docstrings=0D
  qapi/commands.py: Don't re-bind to variable of different type=0D
  qapi/commands.py: add notational type hints=0D
  qapi/commands.py: enable checking with mypy=0D
  qapi/source.py: add notational type hints=0D
  qapi/source.py: delint with pylint=0D
  qapi/gen.py: Fix edge-case of _is_user_module=0D
  qapi/gen.py: add notational type hints=0D
  qapi/gen.py: Enable checking with mypy=0D
  qapi/gen.py: Remove unused parameter=0D
  qapi/gen.py: update write() to be more idiomatic=0D
  qapi/gen.py: delint with pylint=0D
  qapi/introspect.py: Add a typed 'extra' structure=0D
  qapi/introspect.py: add _gen_features helper=0D
  qapi/introspect.py: create a typed 'Node' data structure=0D
  qapi/introspect.py: add notational type hints=0D
  qapi/types.py: add notational type hints=0D
  qapi/types.py: remove one-letter variables=0D
  qapi/visit.py: remove unused parameters from gen_visit_object=0D
  qapi/visit.py: add notational type hints=0D
=0D
 docs/conf.py                  |   4 +-=0D
 configure                     |   6 +-=0D
 .readthedocs.yml              |   2 +-=0D
 .travis.yml                   |   8 --=0D
 scripts/qapi-gen.py           |  59 ++--------=0D
 scripts/qapi/.flake8          |   2 +=0D
 scripts/qapi/commands.py      |  85 +++++++++++----=0D
 scripts/qapi/common.py        | 161 +++++++++++++++------------=0D
 scripts/qapi/debug.py         |  78 +++++++++++++=0D
 scripts/qapi/doc.py           |   3 +-=0D
 scripts/qapi/events.py        |  61 ++++++++---=0D
 scripts/qapi/expr.py          |   4 +-=0D
 scripts/qapi/gen.py           | 147 +++++++++++++------------=0D
 scripts/qapi/introspect.py    | 200 +++++++++++++++++++++++-----------=0D
 scripts/qapi/mypy.ini         |  30 +++++=0D
 scripts/qapi/params.py        |  40 +++++++=0D
 scripts/qapi/parser.py        |   4 +-=0D
 scripts/qapi/pylintrc         |  71 ++++++++++++=0D
 scripts/qapi/schema.py        |  33 +++---=0D
 scripts/qapi/script.py        |  91 ++++++++++++++++=0D
 scripts/qapi/source.py        |  34 +++---=0D
 scripts/qapi/types.py         | 125 ++++++++++++++-------=0D
 scripts/qapi/visit.py         | 104 +++++++++++++-----=0D
 tests/qemu-iotests/iotests.py |   2 -=0D
 24 files changed, 947 insertions(+), 407 deletions(-)=0D
 create mode 100644 scripts/qapi/.flake8=0D
 create mode 100644 scripts/qapi/debug.py=0D
 create mode 100644 scripts/qapi/mypy.ini=0D
 create mode 100644 scripts/qapi/params.py=0D
 create mode 100644 scripts/qapi/pylintrc=0D
 create mode 100644 scripts/qapi/script.py=0D
=0D
--=20=0D
2.26.2=0D
=0D


