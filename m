Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D3BC4363A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:31:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAC6A2227F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jNgAyoVr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAC6A2227F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQvJ9-0007lU-Vx
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 12:31:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34296)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kQv43-0003qB-L9
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:16:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52127)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kQv3w-0003Dk-EV
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:16:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602260163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NQr87SG5G6LVzSZPGWTeoLxbmrT9JtsGO30iKvpZMD4=;
 b=jNgAyoVrkkVmyDripCqDFZ+MOqCxj9kdj4sAPWk5YGCn9duLABV7WlY+juAubGgM5B/OXi
 9h4LmWcXj3vLNXPll8O5H5sxzHXS3pQJV61wk4jm8cHr2Q0RkWH4tE/zTC7MYLyLFBNx/v
 pwJuInpq/UsU2oPlIF/qB1L+cpeCHL0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-UIsrXdjtN5GiNbW3iAQFjg-1; Fri, 09 Oct 2020 12:16:00 -0400
X-MC-Unique: UIsrXdjtN5GiNbW3iAQFjg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9EA0318A8236;
 Fri,  9 Oct 2020 16:15:59 +0000 (UTC)
Received: from scv.redhat.com (ovpn-112-203.rdu2.redhat.com [10.10.112.203])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DA9C038A;
 Fri,  9 Oct 2020 16:15:58 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 00/36] qapi: static typing conversion, pt1
Date: Fri,  9 Oct 2020 12:15:22 -0400
Message-Id: <20201009161558.107041-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:37
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
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
- After patch 07, `isort -c` should pass 100% on this and every=0D
  future commit.=0D
=0D
- After patch 08, `flake8 qapi/` should pass 100% on this and every=0D
  future commit.=0D
=0D
- After patch 09, `pylint --rcfile=3Dqapi/pylintrc qapi/` should pass 100%=
=0D
  on this and every future commit.=0D
=0D
- After patch 18, `mypy --config-file=3Dqapi/mypy.ini qapi/` should pass=0D
  100% on this and every future commit.=0D
=0D
Review Status:=0D
=0D
[01] docs-repair-broken-references  #=0D
[02] qapi-modify-docstrings-to-be   #=0D
[03] qapi-gen-separate-arg-parsing  # [RB] CR,EH [TB] CR [SOB] JS=0D
[04] qapi-move-generator-entrypoint # [RB] CR,EH [TB] CR [SOB] JS=0D
[05] qapi-prefer-explicit-relative  # [RB] CR,EH,PM [SOB] JS=0D
[06] qapi-remove-wildcard-includes  # [RB] CR,EH,PM [SOB] JS=0D
[07] qapi-enforce-import-order      # [RB] CR,MA [TB] CR [SOB] JS=0D
[08] qapi-delint-using-flake8       # [RB] CR,EH [SOB] JS=0D
[09] qapi-add-pylintrc              # [RB] CR [TB] CR,EH [SOB] JS=0D
[10] qapi-common-py-remove-python   # [RB] CR,EH [SOB] JS=0D
[11] qapi-common-add-indent-manager # [RB] CR,EH [SOB] JS=0D
[12] qapi-common-py-delint-with     # [RB] CR,EH [SOB] JS=0D
[13] replace-c-by-char              # [RB] CR,EH,PM [SOB] JS=0D
[14] qapi-common-py-check-with      # [RB] CR [TB] CR,EH [SOB] JS=0D
[15] qapi-common-py-add-notational  # [RB] CR,EH [SOB] JS=0D
[16] qapi-common-move-comments-into # [RB] CR,EH [SOB] JS=0D
[17] qapi-split-build_params-into   # [RB] CR,EH [SOB] JS=0D
[18] qapi-establish-mypy-type       # [RB] CR [TB] CR,EH [SOB] JS=0D
[19] qapi-events-py-add-notational  # [RB] CR,EH [SOB] JS=0D
[20] qapi-events-move-comments-into # [RB] CR,EH [SOB] JS=0D
[21] qapi-commands-py-don-t-re-bind # [RB] CR,EH,MA [SOB] JS=0D
[22] qapi-commands-py-add           # [RB] CR,EH [SOB] JS=0D
[23] qapi-commands-py-enable        # [RB] CR,EH [SOB] JS=0D
[24] qapi-source-py-add-notational  # [RB] CR,EH [TB] CR [SOB] JS=0D
[25] qapi-source-py-delint-with     # [RB] CR,EH [TB] CR [SOB] JS=0D
[26] qapi-gen-py-fix-edge-case-of   # [RB] CR,EH,PM [SOB] JS=0D
[27] qapi-gen-py-add-notational     # [RB] CR,EH [SOB] JS=0D
[28] qapi-gen-py-enable-checking    # [RB] CR,EH [TB] CR [SOB] JS=0D
[29] qapi-gen-py-remove-unused      # [RB] CR,EH [SOB] JS=0D
[30] qapi-gen-py-update-write-to-be # [RB] CR,EH,MA [SOB] JS=0D
[31] qapi-gen-py-delint-with-pylint # [RB] CR,EH [SOB] JS=0D
[32] qapi-types-py-add-type-hint    # [RB] CR,EH [SOB] JS=0D
[33] qapi-types-py-remove-one       # [RB] CR,EH [SOB] JS=0D
[34] qapi-visit-py-assert           # [RB] CR,EH [SOB] JS=0D
[35] qapi-visit-py-remove-unused    # [RB] CR,EH,PM [TB] CR [SOB] JS=0D
[36] qapi-visit-py-add-notational   # [RB] CR,EH [TB] CR [SOB] JS=0D
=0D
Changelog:=0D
=0D
002/36:[0001] [FC] 'qapi: modify docstrings to be sphinx-compatible'=0D
003/36:[0030] [FC] 'qapi-gen: Separate arg-parsing from generation'=0D
004/36:[down] 'qapi: move generator entrypoint into package'=0D
008/36:[0008] [FC] 'qapi: delint using flake8'=0D
016/36:[0017] [FC] 'qapi/common.py: Convert comments into docstrings, and e=
laborate'=0D
017/36:[0004] [FC] 'qapi/common.py: move build_params into gen.py'=0D
022/36:[0011] [FC] 'qapi/commands.py: add type hint annotations'=0D
024/36:[0003] [FC] 'qapi/source.py: add type hint annotations'=0D
033/36:[0022] [FC] 'qapi/types.py: remove one-letter variables'=0D
=0D
V6:=0D
 - Rebase=0D
 - 02: Dropped changes not *strictly* required for sphinx building.=0D
 - 03: Split prefix check into helper function,=0D
       Removed default constants,=0D
       Moved error message back to main() function, changed wording=0D
 - 04: Changes from 003; fixed commit message ("package", not "module")=0D
 - 08: Line wrapping changes.=0D
 - 16: Sphinx formatting changes, docstring change.=0D
 - 17: Copyright string changes=0D
 - 22: Reflow and add type for new 'coroutine' parameter=0D
 - 24: Simpler QAPISourceInfo() typing=0D
 - 33: "memb" and "var" instead of "member" and "variant".=0D
=0D
V5:=0D
 - Remove DO-NOT-MERGE patches (Now in Part2)=0D
 - Remove introspect.py patches (Now in Part2)=0D
 - 02: Docstring formatting, more commit message (Markus)=0D
=0D
V4:=0D
 - Rebase on Peter Maydell's work;=0D
  - 05: Context differences from Peter Maydell's work=0D
  - 06: Remove qapi.doc=0D
  - 07: Remove qapi.doc, remove superfluous "if match"=0D
  - 09: Remove qapi.doc=0D
  - 13: remove qapi.doc=0D
  - 18: remove qapi.doc=0D
  - 22: remove qapi.doc=0D
  - 31: remove QAPIGenDoc changes=0D
=0D
 - Minor adjustments from list feedback;=0D
  - 01: More backticks for QAPI json files, now that they are in Sphinx-exe=
=0D
  - 02: Use :ref: role for the `docker-ref` cross-reference=0D
  - 04: Remove doc.py work changes; add references for start_if/end_if=0D
  - 10: Changes to accommodate isort=0D
  - 11: Added lines_after_imports=3D2=0D
  - 16: isort whitespace changes=0D
  - 24: Take Markus's docstring phrasing=0D
  - 34: add comment explaining os.open()=0D
  - 37: isort differences=0D
=0D
V3:=0D
 - Use isort to enforce import consistency=0D
 - Use sphinx apidoc to check docstring format=0D
=0D
V2:=0D
 - Removed Python3.6 patch in favor of Thomas Huth's=0D
 - Addressed (most) feedback from Markus=0D
 - Renamed type hint annotation commits=0D
=0D
John Snow (36):=0D
  docs: repair broken references=0D
  qapi: modify docstrings to be sphinx-compatible=0D
  qapi-gen: Separate arg-parsing from generation=0D
  qapi: move generator entrypoint into package=0D
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
  qapi/types.py: add type hint annotations=0D
  qapi/types.py: remove one-letter variables=0D
  qapi/visit.py: assert tag_member contains a QAPISchemaEnumType=0D
  qapi/visit.py: remove unused parameters from gen_visit_object=0D
  qapi/visit.py: add type hint annotations=0D
=0D
 docs/devel/multi-thread-tcg.rst |   2 +-=0D
 docs/devel/testing.rst          |   2 +-=0D
 scripts/qapi-gen.py             |  57 ++--------=0D
 scripts/qapi/.flake8            |   2 +=0D
 scripts/qapi/.isort.cfg         |   7 ++=0D
 scripts/qapi/commands.py        |  90 +++++++++++-----=0D
 scripts/qapi/common.py          | 164 ++++++++++++++++-------------=0D
 scripts/qapi/events.py          |  58 +++++++---=0D
 scripts/qapi/expr.py            |   7 +-=0D
 scripts/qapi/gen.py             | 180 ++++++++++++++++++++------------=0D
 scripts/qapi/introspect.py      |  16 ++-=0D
 scripts/qapi/main.py            |  95 +++++++++++++++++=0D
 scripts/qapi/mypy.ini           |  30 ++++++=0D
 scripts/qapi/parser.py          |   6 +-=0D
 scripts/qapi/pylintrc           |  70 +++++++++++++=0D
 scripts/qapi/schema.py          |  33 +++---=0D
 scripts/qapi/source.py          |  35 ++++---=0D
 scripts/qapi/types.py           | 125 +++++++++++++++-------=0D
 scripts/qapi/visit.py           | 116 ++++++++++++++------=0D
 19 files changed, 759 insertions(+), 336 deletions(-)=0D
 create mode 100644 scripts/qapi/.flake8=0D
 create mode 100644 scripts/qapi/.isort.cfg=0D
 create mode 100644 scripts/qapi/main.py=0D
 create mode 100644 scripts/qapi/mypy.ini=0D
 create mode 100644 scripts/qapi/pylintrc=0D
=0D
--=20=0D
2.26.2=0D
=0D


