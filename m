Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1448BC2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 22:00:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 827D2206B5
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 22:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H5W9K3sp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 827D2206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKqKt-0003wU-J3
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 18:00:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKpfz-000782-IH
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 17:18:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34873)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKpfw-0006cB-De
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 17:18:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600809490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pzCkhx3jAQnNykdLYbMXBnGYLgVnOwMbJk37YDS08R4=;
 b=H5W9K3spSh7VUMLzS421cv2IwhLMO1f4siHvkdG+U+2fiw/SZ0kfJHzMh0UC7Gh4p0pdKG
 8zk7177d/SXLkbHE+SQnOUYwzRmztxFEOTsGtV0sfahqWBOymo4cTyN0RJCTE/O2V1dz7L
 v7Xm7KlwI/uCdV8S6eHn1nd6QuZfCjw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-Ya5Pq2UdP_uOWmIDd0kW7w-1; Tue, 22 Sep 2020 17:18:08 -0400
X-MC-Unique: Ya5Pq2UdP_uOWmIDd0kW7w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 671211084C9A;
 Tue, 22 Sep 2020 21:18:07 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 293495DE51;
 Tue, 22 Sep 2020 21:18:03 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 00/14] qapi: static typing conversion, pt3
Date: Tue, 22 Sep 2020 17:17:48 -0400
Message-Id: <20200922211802.4083666-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 02:07:04
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
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

based-on: <20200922211313.4082880-1-jsnow@redhat.com>=0D
          [PATCH 00/16] qapi: static typing conversion, pt2=0D
=0D
Hi, this series adds static type hints to the QAPI module.=0D
This is part three!=0D
=0D
Part 3: https://gitlab.com/jsnow/qemu/-/tree/python-qapi-cleanup-pt3=0D
Everything: https://gitlab.com/jsnow/qemu/-/tree/python-qapi-cleanup-pt6=0D
=0D
- Requires Python 3.6+=0D
- Requires mypy 0.770 or newer (for type analysis only)=0D
- Requires pylint 2.6.0 or newer (for lint checking only)=0D
=0D
This part of the series focuses on just doc.py ... which, err, Peter=0D
Maydell is getting rid of soon. Oh well. This is posted for reference;=0D
and simply as context and pre-requisite for later patches.=0D
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
John Snow (14):=0D
  qapi/doc.py: stash long temporary locals in named locals=0D
  qapi/doc.py: avoid unnecessary keyword arguments=0D
  qapi/doc.py: Add assertion on section.member=0D
  qapi/doc.py: assert correct types in member_func callbacks=0D
  qapi/doc.py: Assert no suffix given for enum members=0D
  qapi/doc.py: Add type hint annotations=0D
  qapi/doc.py: enable mypy checks=0D
  qapi/doc.py: Add generic texi_member callback=0D
  qapi/doc.py: Remove one-letter variables=0D
  qapi/gen.py: Add __bool__ dunder method to QAPIGen=0D
  qapi/doc.py: Don't use private attributes of QAPIGen property=0D
  qapi/doc.py: Assert tag member is Enum type=0D
  qapi/doc.py: Assert type of object variant=0D
  qapi/doc.py: enable pylint checks=0D
=0D
 scripts/qapi/doc.py   | 189 ++++++++++++++++++++++++++++--------------=0D
 scripts/qapi/gen.py   |   3 +=0D
 scripts/qapi/mypy.ini |   5 --=0D
 scripts/qapi/pylintrc |   3 +-=0D
 4 files changed, 133 insertions(+), 67 deletions(-)=0D
=0D
--=20=0D
2.26.2=0D
=0D


