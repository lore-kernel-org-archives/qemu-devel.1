Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64549C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 21:39:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED805207F7
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 21:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FUeSOABh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED805207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXACo-0005k0-VU
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 17:39:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60408)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kXAAZ-000402-Em
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 17:36:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47350)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kXAAW-0001Uj-I8
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 17:36:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603748202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=f0cY1sd7Ic4psifF1PKBn23U6pmsYOFNN4v6KHJnlPs=;
 b=FUeSOABh0SDwGZG1X2nP3vP2aMpWnGw67WuUpzxVGNFbtN9qJdsRi2d8BbGOgftrHd31Fw
 IYEZHrxpy1fy8nazqzuZMWhln5bQc82BWFoQDDwnJFik24oE9838BeB9bHZtUJDyEPkIQX
 uSegSTooEUnkwjEau0ENarp4geJRXpw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-oFfmqxYHPTmhPFWIHExejg-1; Mon, 26 Oct 2020 17:36:40 -0400
X-MC-Unique: oFfmqxYHPTmhPFWIHExejg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2193B8064BE
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 21:36:39 +0000 (UTC)
Received: from scv.redhat.com (ovpn-118-238.rdu2.redhat.com [10.10.118.238])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7E9221992F;
 Mon, 26 Oct 2020 21:36:38 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v2 00/16] qapi: static typing conversion, pt3
Date: Mon, 26 Oct 2020 17:36:21 -0400
Message-Id: <20201026213637.47087-1-jsnow@redhat.com>
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

based-on: <20201026194251.11075-1-jsnow@redhat.com>=0D
          [PATCH v2 00/11] qapi: static typing conversion, pt2=0D
=0D
Hi, this series adds static type hints to the QAPI module.=0D
This is part three, and it focuses on expr.py.=0D
=0D
Part 3: https://gitlab.com/jsnow/qemu/-/tree/python-qapi-cleanup-pt3=0D
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
 - Rebased on the latest V2=0D
002/16:[0001] [FC] 'qapi/expr.py: Check for dict instead of OrderedDict'=0D
 - Import order differences=0D
007/16:[0006] [FC] 'qapi/expr.py: Add casts in a few select cases'=0D
 - Import order differences=0D
008/16:[0006] [FC] 'qapi/expr.py: add type hint annotations'=0D
 - Import order differents=0D
012/16:[0066] [FC] 'qapi/expr.py: Add docstrings'=0D
 - Various docstring changes for Sphinx=0D
014/16:[0004] [FC] 'qapi/expr.py: Use tuples instead of lists for static da=
ta'=0D
 - Change to accommodate new 'coroutine' key=0D
015/16:[0006] [FC] 'qapi/expr.py: move related checks inside check_xxx func=
tions'=0D
 - Fix check order (ehabkost)=0D
=0D
John Snow (16):=0D
  qapi/expr.py: Remove 'info' argument from nested check_if_str=0D
  qapi/expr.py: Check for dict instead of OrderedDict=0D
  qapi/expr.py: constrain incoming expression types=0D
  qapi/expr.py: Add assertion for union type 'check_dict'=0D
  qapi/expr.py: move string check upwards in check_type=0D
  qapi/expr.py: Check type of 'data' member=0D
  qapi/expr.py: Add casts in a few select cases=0D
  qapi/expr.py: add type hint annotations=0D
  qapi/expr.py: rewrite check_if=0D
  qapi/expr.py: Remove single-letter variable=0D
  qapi/expr.py: enable pylint checks=0D
  qapi/expr.py: Add docstrings=0D
  qapi/expr.py: Modify check_keys to accept any Iterable=0D
  qapi/expr.py: Use tuples instead of lists for static data=0D
  qapi/expr.py: move related checks inside check_xxx functions=0D
  qapi/expr.py: Use an expression checker dispatch table=0D
=0D
 scripts/qapi/expr.py  | 447 +++++++++++++++++++++++++++++++-----------=0D
 scripts/qapi/mypy.ini |   5 -=0D
 scripts/qapi/pylintrc |   1 -=0D
 3 files changed, 334 insertions(+), 119 deletions(-)=0D
=0D
--=20=0D
2.26.2=0D
=0D


