Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E79C4727D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 21:11:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FF1020715
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 21:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UKMBIL8d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FF1020715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKpZL-000605-F9
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 17:11:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36940)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKpPb-0001zk-96
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 17:01:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55655)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKpPY-0004Xn-Vc
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 17:01:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600808476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=P0vPMY365iP0scQ30oS8TUqlW7pNatr1SSOpqlNr8aY=;
 b=UKMBIL8dVkwEOpTYBT/LmbZDtOFjb9Zas/jFsY+2pZzGZbsR/1bIgFnfQUhmFv0TgHExgm
 kxNSMiGafPSp0E1mpqd+0Bdaxb7+VI7p2tsY3HBM2TgGbzpJ+ej8J7tIILsjLrVxOhkFio
 mmvZUZAJ8180SnmGsq4bVHXen3dyIFw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-gsrFPbeFOYmRwAv7FS9c-g-1; Tue, 22 Sep 2020 17:01:04 -0400
X-MC-Unique: gsrFPbeFOYmRwAv7FS9c-g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 66C50100746D;
 Tue, 22 Sep 2020 21:01:03 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 433C855765;
 Tue, 22 Sep 2020 21:01:02 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 00/38] qapi: static typing conversion, pt1
Date: Tue, 22 Sep 2020 17:00:23 -0400
Message-Id: <20200922210101.4081073-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 15:47:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, this series adds static type hints to the QAPI module.=0D
This is part one!=0D
=0D
Part 1: https://gitlab.com/jsnow/qemu/-/tree/python-qapi-cleanup-pt1=0D
Everything: https://gitlab.com/jsnow/qemu/-/tree/python-qapi-cleanup-pt6=0D
=0D
- Requires Python 3.6+=0D
- Requires mypy 0.770 or newer (for type analysis only)=0D
- Requires pylint 2.6.0 or newer (for lint checking only)=0D
=0D
In general, this series tackles the cleanup of one individual QAPI=0D
module at a time. Once it passes pylint or mypy checks, those checks are=0D
enabled for that file.=0D
=0D
Type hints are added in patches that add *only* type hints and change no=0D
other behavior. Any necessary changes to behavior to accommodate typing=0D
are split out into their own tiny patches.=0D
=0D
- Patches 1-7: generic, qapi-wide cleanups, flake8 and pylint support=0D
- Patches 8-16: common.py cleanup (with mypy support added at the end)=0D
- Patches 17-18: events.py cleanup=0D
- Patches 19-21: commands.py cleanup=0D
- Patches 22-23: source.py cleanup=0D
- Patches 24-29: gen.py cleanup=0D
- Patches 30-33: introspect.py cleanup=0D
- Patches 34-35: types.py cleanup=0D
- Patches 36-37: visit.py cleanup=0D
=0D
Notes:=0D
- After patch 6, `flake8 qapi/` should pass 100% on this and every=0D
  future commit.=0D
=0D
- After patch 7, `pylint --rcfile=3D3Dqapi/pylintrc qapi/` should pass 100%=
=0D
  on this and every future commit.=0D
=0D
- After patch 16, `mypy --config-file=3D3Dqapi/mypy.ini qapi/` should pass=
=0D
  100% on this and every future commit.=0D
=0D
V2:=0D
 - Removed Python3.6 patch in favor of Thomas Huth's=0D
 - Addressed (most) feedback from Markus=0D
 - Renamed type hint annotation commits=0D
=0D
Changelog:=0D
=0D
003/38:[0082] [FC] 'qapi: move generator entrypoint into module'=0D
004/38:[down] 'qapi: Prefer explicit relative imports'=0D
006/38:[0027] [FC] 'qapi: delint using flake8'=0D
007/38:[0006] [FC] 'qapi: add pylintrc'=0D
008/38:[0002] [FC] 'qapi/common.py: Remove python compatibility workaround'=
=0D
009/38:[0037] [FC] 'qapi/common.py: Add indent manager'=0D
010/38:[0008] [FC] 'qapi/common.py: delint with pylint'=0D
011/38:[0002] [FC] 'qapi/common.py: Replace one-letter 'c' variable'=0D
012/38:[----] [-C] 'qapi/common.py: check with pylint'=0D
013/38:[down] 'qapi/common.py: add type hint annotations'=0D
014/38:[down] 'qapi/common.py: Convert comments into docstrings, and elabor=
at=3D=0D
e'=0D
015/38:[down] 'qapi/common.py: move build_params into gen.py'=0D
017/38:[down] 'qapi/events.py: add type hint annotations'=0D
020/38:[0006] [FC] 'qapi/commands.py: add notational type hints'=0D
022/38:[down] 'qapi/source.py: add type hint annotations'=0D
025/38:[down] 'qapi/gen.py: add type hint annotations'=0D
033/38:[down] 'qapi/introspect.py: add type hint annotations'=0D
034/38:[down] 'qapi/types.py: add type hint annotations'=0D
036/38:[down] 'qapi/visit.py: assert tag_member contains a QAPISchemaEnumTy=
pe'=0D
037/38:[----] [-C] 'qapi/visit.py: remove unused parameters from gen_visit_=
ob=3D=0D
ject'=0D
038/38:[down] 'qapi/visit.py: add type hint annotations'=0D
=0D
John Snow (38):=0D
  [DO-NOT-MERGE] qapi: add debugging tools=0D
  qapi-gen: Separate arg-parsing from generation=0D
  qapi: move generator entrypoint into module=0D
  qapi: Prefer explicit relative imports=0D
  qapi: Remove wildcard includes=0D
  qapi: delint using flake8=0D
  qapi: add pylintrc=0D
  qapi/common.py: Remove python compatibility workaround=0D
  qapi/common.py: Add indent manager=0D
  qapi/common.py: delint with pylint=0D
  qapi/common.py: Replace one-letter 'c' variable=0D
  qapi/common.py: check with pylint=0D
  qapi/common.py: add type hint annotations=0D
  qapi/common.py: Convert comments into docstrings, and elaborate=0D
  qapi/common.py: move build_params into gen.py=0D
  qapi: establish mypy type-checking baseline=0D
  qapi/events.py: add type hint annotations=0D
  qapi/events.py: Move comments into docstrings=0D
  qapi/commands.py: Don't re-bind to variable of different type=0D
  qapi/commands.py: add notational type hints=0D
  qapi/commands.py: enable checking with mypy=0D
  qapi/source.py: add type hint annotations=0D
  qapi/source.py: delint with pylint=0D
  qapi/gen.py: Fix edge-case of _is_user_module=0D
  qapi/gen.py: add type hint annotations=0D
  qapi/gen.py: Enable checking with mypy=0D
  qapi/gen.py: Remove unused parameter=0D
  qapi/gen.py: update write() to be more idiomatic=0D
  qapi/gen.py: delint with pylint=0D
  qapi/introspect.py: Add a typed 'extra' structure=0D
  qapi/introspect.py: add _gen_features helper=0D
  qapi/introspect.py: create a typed 'Node' data structure=0D
  qapi/introspect.py: add type hint annotations=0D
  qapi/types.py: add type hint annotations=0D
  qapi/types.py: remove one-letter variables=0D
  qapi/visit.py: assert tag_member contains a QAPISchemaEnumType=0D
  qapi/visit.py: remove unused parameters from gen_visit_object=0D
  qapi/visit.py: add type hint annotations=0D
=0D
 scripts/qapi-gen.py        |  59 ++---------=0D
 scripts/qapi/.flake8       |   2 +=0D
 scripts/qapi/commands.py   |  85 +++++++++++----=0D
 scripts/qapi/common.py     | 163 +++++++++++++++-------------=0D
 scripts/qapi/debug.py      |  78 ++++++++++++++=0D
 scripts/qapi/doc.py        |   3 +-=0D
 scripts/qapi/events.py     |  64 ++++++++---=0D
 scripts/qapi/expr.py       |   4 +-=0D
 scripts/qapi/gen.py        | 176 ++++++++++++++++++------------=0D
 scripts/qapi/introspect.py | 212 +++++++++++++++++++++++++------------=0D
 scripts/qapi/main.py       |  91 ++++++++++++++++=0D
 scripts/qapi/mypy.ini      |  30 ++++++=0D
 scripts/qapi/parser.py     |   4 +-=0D
 scripts/qapi/pylintrc      |  71 +++++++++++++=0D
 scripts/qapi/schema.py     |  33 +++---=0D
 scripts/qapi/source.py     |  34 +++---=0D
 scripts/qapi/types.py      | 125 +++++++++++++++-------=0D
 scripts/qapi/visit.py      | 116 ++++++++++++++------=0D
 18 files changed, 952 insertions(+), 398 deletions(-)=0D
 create mode 100644 scripts/qapi/.flake8=0D
 create mode 100644 scripts/qapi/debug.py=0D
 create mode 100644 scripts/qapi/main.py=0D
 create mode 100644 scripts/qapi/mypy.ini=0D
 create mode 100644 scripts/qapi/pylintrc=0D
=0D
--=3D20=0D
2.26.2=0D
=0D


