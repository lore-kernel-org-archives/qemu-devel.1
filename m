Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B94DC4BA33
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 00:07:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B48624650
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 00:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WRUxzE4z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B48624650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j76iV-0006aG-Jk
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 19:07:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43260)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1j76hZ-0004r7-MY
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 19:06:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1j76hY-0005xZ-JN
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 19:06:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46383
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1j76hY-0005vx-EO
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 19:06:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582762012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SGiQVnf46PSJrSTolJI4zT48hbs3f22awRHyKDmrIbo=;
 b=WRUxzE4z9O9LiMZZW0fzzGKgyil/2kZYbzsXs6WZgLTIsbg1xWTkNrqiIeBVxiLhZ3flEO
 Rl5AOE9o/u41BlsnZOaQpE0osFw5G7tF2ez2TNscE+YXjOXbxbrBHBP/bNFQbsOVf4NOeK
 gtmtqhCFAzDNh8uXPfV+kadxddzOot8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-gFb_z9xLP0qlp_h2F1umFg-1; Wed, 26 Feb 2020 19:06:50 -0500
X-MC-Unique: gFb_z9xLP0qlp_h2F1umFg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5304F107ACC5;
 Thu, 27 Feb 2020 00:06:49 +0000 (UTC)
Received: from probe.redhat.com (ovpn-123-58.rdu2.redhat.com [10.10.123.58])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C7639390;
 Thu, 27 Feb 2020 00:06:48 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 7/9] iotests: ignore import warnings from pylint
Date: Wed, 26 Feb 2020 19:06:37 -0500
Message-Id: <20200227000639.9644-8-jsnow@redhat.com>
In-Reply-To: <20200227000639.9644-1-jsnow@redhat.com>
References: <20200227000639.9644-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The right way to solve this is to come up with a virtual environment
infrastructure that sets all the paths correctly, and/or to create
installable python modules that can be imported normally.

That's hard, so just silence this error for now.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/iotests.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 60c4c7f736..214f59995e 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -30,6 +30,7 @@
 from collections import OrderedDict
 from typing import Collection
=20
+# pylint: disable=3Dimport-error, wrong-import-position
 sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'pytho=
n'))
 from qemu import qtest
=20
--=20
2.21.1


