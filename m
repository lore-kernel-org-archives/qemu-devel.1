Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D340C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 07:51:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2617620768
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 07:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QyhOczNP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2617620768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOcpU-0001Y3-7B
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 03:51:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51128)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jOcnd-0006KH-7E
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 03:49:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jOcnc-0007In-6r
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 03:49:33 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25915
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jOcnc-0007IO-2q
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 03:49:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586936971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=dVBj41bOIhOU/Yc7loPiWx+jM6iDoQ0fhcAkWaoR8Uk=;
 b=QyhOczNPu9tasVOw8Qgr+8zQIiN6cAdWbUHcVT39GLERcjMzZDmvdWfiieQk5kbaUNfpnk
 kC/sppZpVgpZRf3ekwE1II0wN3ZkefhFp+BnMZGbuBOB2JVtodJXRuzPNCqVKfaqA5Ocl3
 LyRf2YCOZtPasuQrbTb94oeGy9Iapqc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-117-MvsJeOyxPV6EIYdHIm7xhA-1; Wed, 15 Apr 2020 03:49:30 -0400
X-MC-Unique: MvsJeOyxPV6EIYdHIm7xhA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2846BDB66;
 Wed, 15 Apr 2020 07:49:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-20.ams2.redhat.com
 [10.36.113.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E89745C1A2;
 Wed, 15 Apr 2020 07:49:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AD9A811385C8; Wed, 15 Apr 2020 09:49:27 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 for-5.1 0/9] qemu-option: Fix corner cases and clean up
Date: Wed, 15 Apr 2020 09:49:18 +0200
Message-Id: <20200415074927.19897-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v2:
* PATCH 1,4,5: Cover "?" in addition to "help" [Kevin]
* PATCH 4-6: Old PATCH 4 moved after old PATCH 5+6, commit message
  adjusted
* PATCH 4: Unbreak "?" [Eric]
* PATCH 8: Commit message tweaked
* PATCH 9: New

Markus Armbruster (9):
  tests-qemu-opts: Cover has_help_option(), qemu_opt_has_help_opt()
  qemu-options: Factor out get_opt_name_value() helper
  qemu-option: Fix sloppy recognition of "id=3D..." after ",,"
  qemu-option: Fix has_help_option()'s sloppy parsing
  test-qemu-opts: Simplify test_has_help_option() after bug fix
  qemu-option: Avoid has_help_option() in qemu_opts_parse_noisily()
  qemu-img: Factor out accumulate_options() helper
  qemu-img: Move is_valid_option_list() to qemu-img.c and rewrite
  qemu-img: Reject broken -o ""

 include/qemu/option.h  |   1 -
 qemu-img.c             |  87 ++++++++++-------
 tests/test-qemu-opts.c |  46 ++++++++-
 util/qemu-option.c     | 210 ++++++++++++++++++++---------------------
 4 files changed, 199 insertions(+), 145 deletions(-)

--=20
2.21.1


