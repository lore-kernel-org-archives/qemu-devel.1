Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202C8C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 23:02:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A94C5221EB
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 23:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XbNg6dcu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A94C5221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKrJ2-00026G-Qe
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 19:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60170)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKr2A-0001uk-VL
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 18:45:15 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60418
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKr29-0000IV-6X
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 18:45:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600814712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pZiehwfnAcgF30FmnUiuqDd2+0YlkvJzC0Ecczvsrzc=;
 b=XbNg6dcu14ZRi0U4Bl2NOYd0yHxPuTuC9zFcbjW9i0KpFLUYebAOFoO2DrvgNWJqax7xBL
 zSHMi39FM59RhgGTGmZ30kIrjAtvP0S7PzfcOyiBg7wwGh3DgdOBfAUnBjINt318gYEBuX
 SV1qITHmgeJeCZWX8VOp27XkWVw7k5Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-akqZhBpuO0WxD6EVXcGikg-1; Tue, 22 Sep 2020 18:45:09 -0400
X-MC-Unique: akqZhBpuO0WxD6EVXcGikg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 511D31005E66;
 Tue, 22 Sep 2020 22:45:08 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 782B25C1A3;
 Tue, 22 Sep 2020 22:45:01 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 00/25] qapi: static typing conversion, pt6
Date: Tue, 22 Sep 2020 18:44:36 -0400
Message-Id: <20200922224501.4087749-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

based-on: <20200922223525.4085762-1-jsnow@redhat.com>=0D
          [PATCH 00/26] qapi: static typing conversion, pt5=0D
=0D
Hi, this series adds static type hints to the QAPI module.=0D
This is the final part, part six!=0D
=0D
Part 6 (Everything):=0D
    https://gitlab.com/jsnow/qemu/-/tree/python-qapi-cleanup-pt6=0D
=0D
- Requires Python 3.6+=0D
- Requires mypy 0.770 or newer (for type analysis only)=0D
- Requires pylint 2.6.0 or newer (for lint checking only)=0D
=0D
This part of the series focuses on schema.py.=0D
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
John Snow (25):=0D
  qapi/schema: add Visitable mixin=0D
  qapi/schema.py: Move meta-type into class instances=0D
  qapi/schema.py: add assert in stub methods=0D
  qapi/schema.py: constrain QAPISchemaObjectType base type=0D
  qapi/schema.py: constrain QAPISchemaObjectTypeMember arg_type type=0D
  qapi/schema.py: constrain QAPISchemaEvent arg_type type=0D
  qapi/schema.py: constrain tag_member type=0D
  qapi/schema.py: Allow alternate_type to assert=0D
  qapi/schema.py: remove superfluous assert=0D
  qapi/schema.py: Add assertion to ifcond property=0D
  qapi/schema.py: Constrain type of QAPISchemaObjectType members field=0D
  qapi/schema.py: remove 'and' from non-bool rvalue expressions=0D
  qapi/schema.py: Test type of self.ret_type instead of local temp=0D
  qapi/schema.py: Assert variants of an object are also objects=0D
  qapi/schema.py: add type hint annotations=0D
  qapi/schema.py: enable checking=0D
  qapi: Disable similarity checks in pylint entirely=0D
  qapi/schema.py: Add pylint warning suppressions=0D
  qapi/schema.py: Convert several methods to classmethods=0D
  qapi/schema.py: Replace one-letter variable names=0D
  qapi/schema.py: disable pylint line limit=0D
  qapi/schema.py: Ignore unused argument for check()=0D
  qapi/schema.py: enable pylint checks=0D
  qapi/schema.py: Add module docstring=0D
  qapi/schema.py: Use python3 style super()=0D
=0D
 scripts/qapi/mypy.ini  |   6 -=0D
 scripts/qapi/pylintrc  |   6 +-=0D
 scripts/qapi/schema.py | 848 +++++++++++++++++++++++++++--------------=0D
 3 files changed, 557 insertions(+), 303 deletions(-)=0D
=0D
--=20=0D
2.26.2=0D
=0D


