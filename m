Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 408FAC2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 22:36:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA07F239CF
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 22:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KpuGjE1d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA07F239CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKqtj-0005pl-RM
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 18:36:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKqsp-000462-F1
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 18:35:35 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59342
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKqsn-0007bB-5L
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 18:35:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600814131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5eVpkdcjCkO0x/bhaaCI/lR3dymJdH6x4Nudt5tVF4Q=;
 b=KpuGjE1do0LkHSWMbA3lqtZc8Sx8GhJ2N1TjL46AzQmuDvMzE/fz8QoY9OHtDm1lfoCIgv
 rcEI31pLZkt7hLdZTv3ULg8CZTPtR0pYEr4uNyxDybIaBB3CJUdcPlyK4Q1vMariJ+Eoyj
 +Pv+JkHdIxDWsGDWAFMh86pSWE1D6Kw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-WJrrfG7EODmP_a-ta9x_ag-1; Tue, 22 Sep 2020 18:35:28 -0400
X-MC-Unique: WJrrfG7EODmP_a-ta9x_ag-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 389D21005E64;
 Tue, 22 Sep 2020 22:35:27 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 68B4460C05;
 Tue, 22 Sep 2020 22:35:26 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 00/26] qapi: static typing conversion, pt5
Date: Tue, 22 Sep 2020 18:34:59 -0400
Message-Id: <20200922223525.4085762-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 17:01:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

based-on: <20200922210101.4081073-1-jsnow@redhat.com>=0D
          [PATCH 0/6] qapi: static typing conversion, pt4=0D
=0D
Hi, this series adds static type hints to the QAPI module.=0D
This is part five!=0D
=0D
Part 5: https://gitlab.com/jsnow/qemu/-/tree/python-qapi-cleanup-pt5=0D
Everything: https://gitlab.com/jsnow/qemu/-/tree/python-qapi-cleanup-pt6=0D
=0D
- Requires Python 3.6+=0D
- Requires mypy 0.770 or newer (for type analysis only)=0D
- Requires pylint 2.6.0 or newer (for lint checking only)=0D
=0D
This part of the series focuses on just parser.py.=0D
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
John Snow (26):=0D
  qapi/parser.py: refactor parsing routine into method=0D
  qapi/parser.py: group variable declarations in __init__=0D
  qapi/parser.py: use 'with' statement for opening files=0D
  qapi/source.py: Add default arguments to QAPISourceInfo=0D
  qapi/parser.py: start source info at line 0=0D
  qapi/parser.py: raise QAPIParseError during file opening=0D
  qapi/parser.py: fully remove 'null' constant=0D
  qapi/parser.py: Assert lexer value is a string=0D
  qapi/parser.py: assert get_expr returns object in outer loop=0D
  qapi/parser.py: assert object keys are strings=0D
  qapi/parser.py: Convert several methods to @classmethod=0D
  qapi/parser.py: add casts to pragma checks=0D
  qapi/parser.py: add type hint annotations=0D
  qapi/parser.py: add docstrings=0D
  qapi/parser.py: add ParsedExpression type=0D
  qapi/pragma.py: Move QAPISchemaPragma into its own module=0D
  qapi/pragma.py: Move pragma parsing out of parser.py=0D
  qapi/parser.py: Modify _include() to use parser state=0D
  qapi/parser.py: add parent argument=0D
  qapi/parser.py: remove unused check_args_section arguments=0D
  qapi/parser.py: QAPIDoc: convert @staticmethod to @classmethod=0D
  qapi/parser.py: add type hint annotations (QAPIDoc)=0D
  qapi/parser.py: enable mypy checks=0D
  qapi/parser.py: remove one and two-letter variables=0D
  qapi/parser.py: Silence too-few-public-methods warning=0D
  qapi/parser.py: enable pylint checks=0D
=0D
 scripts/qapi/error.py                     |   8 +-=0D
 scripts/qapi/expr.py                      |  56 ++--=0D
 scripts/qapi/mypy.ini                     |   5 -=0D
 scripts/qapi/parser.py                    | 322 +++++++++++++---------=0D
 scripts/qapi/pragma.py                    |  68 +++++=0D
 scripts/qapi/pylintrc                     |   3 +-=0D
 scripts/qapi/schema.py                    |   6 +-=0D
 scripts/qapi/source.py                    |  22 +-=0D
 tests/qapi-schema/leading-comma-list.err  |   2 +-=0D
 tests/qapi-schema/trailing-comma-list.err |   2 +-=0D
 10 files changed, 301 insertions(+), 193 deletions(-)=0D
 create mode 100644 scripts/qapi/pragma.py=0D
=0D
--=20=0D
2.26.2=0D
=0D


