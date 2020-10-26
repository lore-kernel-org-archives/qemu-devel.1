Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B9EC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 20:07:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60E5321707
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 20:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="elSvWb5o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60E5321707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX8mJ-0007r8-CO
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 16:07:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kX8Om-0006a2-MK
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 15:43:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50536)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kX8Oh-00038K-K4
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 15:43:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603741394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NS7GuZOZomlBwMDkfqMsEGS70Im1nb/zmllpfmWqJaM=;
 b=elSvWb5ois9bXL/navVsIBcs0Ble/ZFNYYSCGStJw9jzJ9sqS/2X5WlhmAlcPFHd27bp2b
 pe1AD8da5Ex7WOZWwYGb2raf/AyX54FtdApb7+CpTsSub9kH7oja3YenSdD59pJCpoSGZX
 sRzLh+UcUUoaS5bN06YDDCEyHbTMRO4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-kH3TNXVcPaybA14AuKXQ2Q-1; Mon, 26 Oct 2020 15:43:11 -0400
X-MC-Unique: kH3TNXVcPaybA14AuKXQ2Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B41C88C7AA
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 19:43:07 +0000 (UTC)
Received: from scv.redhat.com (ovpn-118-238.rdu2.redhat.com [10.10.118.238])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A35605B4C9;
 Mon, 26 Oct 2020 19:42:52 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v2 00/11] qapi: static typing conversion, pt2
Date: Mon, 26 Oct 2020 15:42:40 -0400
Message-Id: <20201026194251.11075-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
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
Cc: John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, this series adds static type hints to the QAPI module.=0D
This is part two, and covers introspect.py.=0D
=0D
Part 2: https://gitlab.com/jsnow/qemu/-/tree/python-qapi-cleanup-pt2=0D
Everything: https://gitlab.com/jsnow/qemu/-/tree/python-qapi-cleanup-pt6=0D
=0D
- Requires Python 3.6+=0D
- Requires mypy 0.770 or newer (for type analysis only)=0D
- Requires pylint 2.6.0 or newer (for lint checking only)=0D
=0D
Type hints are added in patches that add *only* type hints and change no=0D
other behavior. Any necessary changes to behavior to accommodate typing=0D
are split out into their own tiny patches.=0D
=0D
Every commit should pass with:=0D
 - flake8 qapi/=0D
 - pylint --rcfile=3Dqapi/pylintrc qapi/=0D
 - mypy --config-file=3Dqapi/mypy.ini qapi/=0D
=0D
V2:=0D
 - Dropped all R-B from previous series; enough has changed.=0D
 - pt2 is now introspect.py, expr.py is pushed to pt3.=0D
 - Reworked again to have less confusing (?) type names=0D
 - Added an assertion to prevent future accidental breakage=0D
=0D
John Snow (11):=0D
  [DO-NOT-MERGE] docs: replace single backtick (`) with double-backtick=0D
    (``)=0D
  [DO-NOT-MERGE] docs/sphinx: change default role to "any"=0D
  [DO-NOT-MERGE] docs: enable sphinx-autodoc for scripts/qapi=0D
  qapi/introspect.py: add assertions and casts=0D
  qapi/introspect.py: add preliminary type hint annotations=0D
  qapi/introspect.py: add _gen_features helper=0D
  qapi/introspect.py: Unify return type of _make_tree()=0D
  qapi/introspect.py: replace 'extra' dict with 'comment' argument=0D
  qapi/introspect.py: create a typed 'Annotated' data strutcure=0D
  qapi/introspect.py: improve readability of _tree_to_qlit=0D
  qapi/introspect.py: Add docstring to _tree_to_qlit=0D
=0D
 docs/conf.py                           |   6 +-=0D
 docs/devel/build-system.rst            | 120 +++++------=0D
 docs/devel/index.rst                   |   1 +=0D
 docs/devel/migration.rst               |  59 +++---=0D
 docs/devel/python/index.rst            |   7 +=0D
 docs/devel/python/qapi.commands.rst    |   7 +=0D
 docs/devel/python/qapi.common.rst      |   7 +=0D
 docs/devel/python/qapi.error.rst       |   7 +=0D
 docs/devel/python/qapi.events.rst      |   7 +=0D
 docs/devel/python/qapi.expr.rst        |   7 +=0D
 docs/devel/python/qapi.gen.rst         |   7 +=0D
 docs/devel/python/qapi.introspect.rst  |   7 +=0D
 docs/devel/python/qapi.main.rst        |   7 +=0D
 docs/devel/python/qapi.parser.rst      |   8 +=0D
 docs/devel/python/qapi.rst             |  26 +++=0D
 docs/devel/python/qapi.schema.rst      |   7 +=0D
 docs/devel/python/qapi.source.rst      |   7 +=0D
 docs/devel/python/qapi.types.rst       |   7 +=0D
 docs/devel/python/qapi.visit.rst       |   7 +=0D
 docs/devel/tcg-plugins.rst             |  14 +-=0D
 docs/devel/testing.rst                 |   2 +-=0D
 docs/interop/live-block-operations.rst |   4 +-=0D
 docs/system/arm/cpu-features.rst       | 110 +++++-----=0D
 docs/system/arm/nuvoton.rst            |   2 +-=0D
 docs/system/s390x/protvirt.rst         |  10 +-=0D
 qapi/block-core.json                   |   4 +-=0D
 scripts/qapi/introspect.py             | 277 +++++++++++++++++--------=0D
 scripts/qapi/mypy.ini                  |   5 -=0D
 scripts/qapi/schema.py                 |   2 +-=0D
 29 files changed, 487 insertions(+), 254 deletions(-)=0D
 create mode 100644 docs/devel/python/index.rst=0D
 create mode 100644 docs/devel/python/qapi.commands.rst=0D
 create mode 100644 docs/devel/python/qapi.common.rst=0D
 create mode 100644 docs/devel/python/qapi.error.rst=0D
 create mode 100644 docs/devel/python/qapi.events.rst=0D
 create mode 100644 docs/devel/python/qapi.expr.rst=0D
 create mode 100644 docs/devel/python/qapi.gen.rst=0D
 create mode 100644 docs/devel/python/qapi.introspect.rst=0D
 create mode 100644 docs/devel/python/qapi.main.rst=0D
 create mode 100644 docs/devel/python/qapi.parser.rst=0D
 create mode 100644 docs/devel/python/qapi.rst=0D
 create mode 100644 docs/devel/python/qapi.schema.rst=0D
 create mode 100644 docs/devel/python/qapi.source.rst=0D
 create mode 100644 docs/devel/python/qapi.types.rst=0D
 create mode 100644 docs/devel/python/qapi.visit.rst=0D
=0D
--=20=0D
2.26.2=0D
=0D


