Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CCDC4346E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 00:36:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68E1A238D6
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 00:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R8AWZ1AP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68E1A238D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLbjD-0006SQ-8t
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 20:36:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50954)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kLbbq-0000kF-4H
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 20:29:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32041)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kLbbm-000086-US
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 20:29:09 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600993745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fHnML+diva64zn2Jyk4aDOXvUteNO7Q+UVK4EOOTzE8=;
 b=R8AWZ1APRR0b9RgIilTxOEZl3u/5yjdNDUatDbISWEuADsz466VjGUbj/oVOh5XM9eJhKu
 nTfBO6ByQ35LsURKz4kxs6KR1NJMk/ZShpx4b/e3SZfE1Y1IyH1tq5/pJyo3VPdWPOILBb
 5UwwQWBH0eCE/iyaoYqTF/MaKYSyTqk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-DZiaHOXzNcSm3uerg2ed1A-1; Thu, 24 Sep 2020 20:29:02 -0400
X-MC-Unique: DZiaHOXzNcSm3uerg2ed1A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72D771008552
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 00:29:01 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B83FD5D9F1;
 Fri, 25 Sep 2020 00:29:00 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 00/47] qapi: static typing conversion, pt1
Date: Thu, 24 Sep 2020 20:28:13 -0400
Message-Id: <20200925002900.465855-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
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
Cc: John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
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
Notes:=0D
=0D
- `make sphinxdocs` should work on every commit. It begins to include=0D
  docstring content after the DO-NOT-MERGE patch 6.=0D
=0D
- After patch 12, `isort -c` should pass 100% on this and every=0D
  future commit.=0D
=0D
- After patch 13, `flake8 qapi/` should pass 100% on this and every=0D
  future commit.=0D
=0D
- After patch 14, `pylint --rcfile=3D3Dqapi/pylintrc qapi/` should pass 100=
%=0D
  on this and every future commit.=0D
=0D
- After patch 23, `mypy --config-file=3D3Dqapi/mypy.ini qapi/` should pass=
=0D
  100% on this and every future commit.=0D
=0D
V3:=0D
 - Use isort to enforce import consistency=0D
 - Use sphinx apidoc to check docstring format=0D
 - 16: Changed docstring formatting, changed import ordering.=0D
 - 17: Changed import ordering.=0D
 - 21: Changed formatting and added some comments for Sphinx.=0D
 - 22: Changed import ordering.=0D
 - 31: Fixed, thanks Eduardo.=0D
 - 32: Shortened type annotation, thanks Cleber.=0D
 - 39: Spiritually the same, but contextually extremely different.=0D
 - 42: Very different, it now inlines the 'Extra' fields directly.=0D
 - 43: Import ordering changes.=0D
 - 45: Import ordering changes.=0D
 - 47: Import ordering changes.=0D
=0D
Status:=0D
=0D
(This is my stgit summary with reviewer tags visible.)=0D
=0D
+ [01] docs-replace-single-backtick   #=0D
+ [02] docs-repair-broken-references  #=0D
+ [03] docs-sphinx-change-default     #=0D
+ [04] qapi-modify-docstrings-to-be   #=0D
+ [05] qapi-doc-py-change-code        #=0D
+ [06] docs-enable-sphinx-autodoc-for #=0D
+ [07] qapi-gen-separate-arg-parsing  # [SOB] JS [RB] EH=0D
+ [08] qapi-move-generator-entrypoint # [SOB] JS [RB] CR,EH [TB] CR=0D
+ [09] do-not-merge-more-apidoc       #=0D
+ [10] qapi-prefer-explicit-relative  # [SOB] JS [RB] CR,EH=0D
+ [11] qapi-remove-wildcard-includes  # [SOB] JS [RB] CR,EH=0D
+ [12] qapi-enforce-import-order      # [SOB] JS=0D
+ [13] qapi-delint-using-flake8       # [SOB] JS [RB] CR,EH=0D
+ [14] qapi-add-pylintrc              # [SOB] JS [TB] CR,EH [RB] CR=0D
+ [15] qapi-common-py-remove-python   # [SOB] JS [RB] CR,EH=0D
+ [16] qapi-common-add-indent-manager # [SOB] JS [RB] CR,EH=0D
+ [17] qapi-common-py-delint-with     # [SOB] JS [RB] CR,EH=0D
+ [18] replace-c-by-char              # [SOB] JS [RB] CR,EH=0D
+ [19] qapi-common-py-check-with      # [SOB] JS [RB] CR [TB] CR,EH=0D
+ [20] qapi-common-py-add-notational  # [SOB] JS [RB] CR,EH=0D
+ [21] qapi-common-move-comments-into # [SOB] JS [RB] CR,EH=0D
+ [22] qapi-split-build_params-into   # [SOB] JS [RB] CR,EH=0D
+ [23] qapi-establish-mypy-type       # [SOB] JS [TB] EH=0D
+ [24] qapi-events-py-add-notational  # [SOB] JS [RB] CR,EH=0D
+ [25] qapi-events-move-comments-into # [SOB] JS [RB] CR,EH=0D
+ [26] qapi-commands-py-don-t-re-bind # [SOB] JS [RB] CR,EH=0D
+ [27] qapi-commands-py-add           # [SOB] JS [RB] CR,EH=0D
+ [28] qapi-commands-py-enable        # [SOB] JS [RB] CR,EH=0D
+ [29] qapi-source-py-add-notational  # [SOB] JS [RB] EH=0D
+ [30] qapi-source-py-delint-with     # [SOB] JS [RB] CR,EH [TB] CR=0D
+ [31] qapi-gen-py-fix-edge-case-of   #=0D
+ [32] qapi-gen-py-add-notational     # [SOB] JS [RB] CR,EH=0D
+ [33] qapi-gen-py-enable-checking    # [SOB] JS [RB] CR,EH [TB] CR=0D
+ [34] qapi-gen-py-remove-unused      # [SOB] JS [RB] CR,EH=0D
+ [35] qapi-gen-py-update-write-to-be # [SOB] JS [RB] CR,EH=0D
+ [36] qapi-gen-py-delint-with-pylint # [SOB] JS [RB] CR,EH=0D
+ [37] qapi-introspect-py-assert-obj  #=0D
+ [38] qapi-introspect-py-create-a    # [SOB] EH,JS=0D
+ [39] qapi-introspect-py-add         #=0D
+ [40] qapi-introspect-py-unify       #=0D
+ [41] qapi-introspect-py-replace     #=0D
+ [42] qapi-introspect-py-create-a-0  #=0D
+ [43] qapi-types-py-add-type-hint    # [SOB] JS [RB] CR,EH=0D
+ [44] qapi-types-py-remove-one       # [SOB] JS [RB] CR,EH=0D
+ [45] qapi-visit-py-assert           # [SOB] JS [RB] CR,EH=0D
+ [46] qapi-visit-py-remove-unused    # [SOB] JS [RB] CR,EH [TB] CR=0D
> [47] qapi-visit-py-add-notational   # [SOB] JS [RB] CR,EH [TB] CR=0D
=0D
Changelog:=0D
=0D
001/47:[down] '[DO-NOT-MERGE] docs: replace single backtick (`) with double=
-b=3D=0D
acktick (``)'=0D
002/47:[down] '[DO-NOT-MERGE] docs: repair broken references'=0D
003/47:[down] '[DO-NOT-MERGE] docs/sphinx: change default role to "any"'=0D
004/47:[down] 'qapi: modify docstrings to be sphinx-compatible'=0D
005/47:[down] 'qapi/doc.py: Change code templates from function to string'=
=0D
006/47:[down] '[DO-NOT-MERGE] docs: enable sphinx-autodoc for scripts/qapi'=
=0D
009/47:[down] '[DO-NOT-MERGE] docs: add scripts/qapi/main to python manual'=
=0D
012/47:[down] 'qapi: enforce import order/styling with isort'=0D
016/47:[0012] [FC] 'qapi/common.py: Add indent manager'=0D
017/47:[0003] [FC] 'qapi/common.py: delint with pylint'=0D
021/47:[0006] [FC] 'qapi/common.py: Convert comments into docstrings, and e=
la=3D=0D
borate'=0D
022/47:[0020] [FC] 'qapi/common.py: move build_params into gen.py'=0D
027/47:[down] 'qapi/commands.py: add type hint annotations'=0D
031/47:[0002] [FC] 'qapi/gen.py: Fix edge-case of _is_user_module'=0D
032/47:[0011] [FC] 'qapi/gen.py: add type hint annotations'=0D
037/47:[down] 'qapi/introspect.py: assert obj is a dict when features are g=
iv=3D=0D
en'=0D
038/47:[down] 'qapi/instrospect.py: add preliminary type hint annotations'=
=0D
039/47:[0013] [FC] 'qapi/introspect.py: add _gen_features helper'=0D
040/47:[down] 'qapi/introspect.py: Unify return type of _make_tree()'=0D
041/47:[down] 'qapi/introspect.py: replace 'extra' dict with 'comment' argu=
me=3D=0D
nt'=0D
042/47:[0062] [FC] 'qapi/introspect.py: create a typed 'Node' data structur=
e'=0D
043/47:[0004] [FC] 'qapi/types.py: add type hint annotations'=0D
045/47:[0005] [FC] 'qapi/visit.py: assert tag_member contains a QAPISchemaE=
nu=3D=0D
mType'=0D
047/47:[0005] [FC] 'qapi/visit.py: add type hint annotations'=0D
=0D
V2:=0D
 - Removed Python3.6 patch in favor of Thomas Huth's=0D
 - Addressed (most) feedback from Markus=0D
 - Renamed type hint annotation commits=0D
=0D
Eduardo Habkost (1):=0D
  qapi/instrospect.py: add preliminary type hint annotations=0D
=0D
John Snow (46):=0D
  [DO-NOT-MERGE] docs: replace single backtick (`) with double-backtick=0D
    (``)=0D
  [DO-NOT-MERGE] docs: repair broken references=0D
  [DO-NOT-MERGE] docs/sphinx: change default role to "any"=0D
  qapi: modify docstrings to be sphinx-compatible=0D
  qapi/doc.py: Change code templates from function to string=0D
  [DO-NOT-MERGE] docs: enable sphinx-autodoc for scripts/qapi=0D
  qapi-gen: Separate arg-parsing from generation=0D
  qapi: move generator entrypoint into module=0D
  [DO-NOT-MERGE] docs: add scripts/qapi/main to python manual=0D
  qapi: Prefer explicit relative imports=0D
  qapi: Remove wildcard includes=0D
  qapi: enforce import order/styling with isort=0D
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
  qapi/commands.py: add type hint annotations=0D
  qapi/commands.py: enable checking with mypy=0D
  qapi/source.py: add type hint annotations=0D
  qapi/source.py: delint with pylint=0D
  qapi/gen.py: Fix edge-case of _is_user_module=0D
  qapi/gen.py: add type hint annotations=0D
  qapi/gen.py: Enable checking with mypy=0D
  qapi/gen.py: Remove unused parameter=0D
  qapi/gen.py: update write() to be more idiomatic=0D
  qapi/gen.py: delint with pylint=0D
  qapi/introspect.py: assert obj is a dict when features are given=0D
  qapi/introspect.py: add _gen_features helper=0D
  qapi/introspect.py: Unify return type of _make_tree()=0D
  qapi/introspect.py: replace 'extra' dict with 'comment' argument=0D
  qapi/introspect.py: create a typed 'Node' data structure=0D
  qapi/types.py: add type hint annotations=0D
  qapi/types.py: remove one-letter variables=0D
  qapi/visit.py: assert tag_member contains a QAPISchemaEnumType=0D
  qapi/visit.py: remove unused parameters from gen_visit_object=0D
  qapi/visit.py: add type hint annotations=0D
=0D
 docs/conf.py                           |   9 +-=0D
 docs/devel/build-system.rst            | 118 +++++++-------=0D
 docs/devel/index.rst                   |   1 +=0D
 docs/devel/migration.rst               |  59 +++----=0D
 docs/devel/multi-thread-tcg.rst        |   2 +-=0D
 docs/devel/python/index.rst            |   7 +=0D
 docs/devel/python/qapi.commands.rst    |   7 +=0D
 docs/devel/python/qapi.common.rst      |   7 +=0D
 docs/devel/python/qapi.doc.rst         |   7 +=0D
 docs/devel/python/qapi.error.rst       |   7 +=0D
 docs/devel/python/qapi.events.rst      |   7 +=0D
 docs/devel/python/qapi.expr.rst        |   7 +=0D
 docs/devel/python/qapi.gen.rst         |   7 +=0D
 docs/devel/python/qapi.introspect.rst  |   7 +=0D
 docs/devel/python/qapi.main.rst        |   7 +=0D
 docs/devel/python/qapi.parser.rst      |   8 +=0D
 docs/devel/python/qapi.rst             |  27 ++++=0D
 docs/devel/python/qapi.schema.rst      |   7 +=0D
 docs/devel/python/qapi.source.rst      |   7 +=0D
 docs/devel/python/qapi.types.rst       |   7 +=0D
 docs/devel/python/qapi.visit.rst       |   7 +=0D
 docs/devel/tcg-plugins.rst             |  14 +-=0D
 docs/devel/testing.rst                 |   4 +-=0D
 docs/interop/live-block-operations.rst |   4 +-=0D
 docs/system/arm/cpu-features.rst       | 110 ++++++-------=0D
 docs/system/arm/nuvoton.rst            |   2 +-=0D
 docs/system/s390x/protvirt.rst         |  10 +-=0D
 scripts/qapi-gen.py                    |  59 ++-----=0D
 scripts/qapi/.flake8                   |   2 +=0D
 scripts/qapi/.isort.cfg                |   5 +=0D
 scripts/qapi/commands.py               |  87 +++++++---=0D
 scripts/qapi/common.py                 | 162 ++++++++++---------=0D
 scripts/qapi/doc.py                    |  53 ++++---=0D
 scripts/qapi/events.py                 |  56 +++++--=0D
 scripts/qapi/expr.py                   |   6 +-=0D
 scripts/qapi/gen.py                    | 184 +++++++++++++---------=0D
 scripts/qapi/introspect.py             | 209 +++++++++++++++++--------=0D
 scripts/qapi/main.py                   |  90 +++++++++++=0D
 scripts/qapi/mypy.ini                  |  30 ++++=0D
 scripts/qapi/parser.py                 |  15 +-=0D
 scripts/qapi/pylintrc                  |  71 +++++++++=0D
 scripts/qapi/schema.py                 |  35 +++--=0D
 scripts/qapi/source.py                 |  34 ++--=0D
 scripts/qapi/types.py                  | 124 ++++++++++-----=0D
 scripts/qapi/visit.py                  | 116 ++++++++++----=0D
 45 files changed, 1210 insertions(+), 594 deletions(-)=0D
 create mode 100644 docs/devel/python/index.rst=0D
 create mode 100644 docs/devel/python/qapi.commands.rst=0D
 create mode 100644 docs/devel/python/qapi.common.rst=0D
 create mode 100644 docs/devel/python/qapi.doc.rst=0D
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
 create mode 100644 scripts/qapi/.flake8=0D
 create mode 100644 scripts/qapi/.isort.cfg=0D
 create mode 100644 scripts/qapi/main.py=0D
 create mode 100644 scripts/qapi/mypy.ini=0D
 create mode 100644 scripts/qapi/pylintrc=0D
=0D
--=3D20=0D
2.26.2=0D
=0D


