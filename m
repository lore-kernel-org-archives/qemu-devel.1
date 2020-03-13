Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D231AC4CECE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 08:37:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EC9420749
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 08:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V9S45T+k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EC9420749
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCfoy-0003uo-S3
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 04:37:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45337)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jCfo4-0001x6-Pj
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 04:36:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jCfo1-00061F-Jn
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 04:36:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48287
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jCfo1-0005yp-Fu
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 04:36:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584088591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HU+OyKWeets5YCf9ac4z9kplh0aiqER6vBetzLT6Hcc=;
 b=V9S45T+k27V2gJJghin+Z0422ae8CbbUjHnifj+0CIP0/A6mzXQmLcw0BRv1LESQkiGar5
 OQxHNtnk0503Ow1fKeIIL6ntb9jHb1+gPtEq01DX5jOjh7cNEN1FWUQPjbvjwicGdKzDj0
 Rbc/MQa7rJdOWoLxfVa+s6ozYW64KgI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-ujBIyZ2QMeabkGBJ2afniw-1; Fri, 13 Mar 2020 04:36:30 -0400
X-MC-Unique: ujBIyZ2QMeabkGBJ2afniw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 257AF802568;
 Fri, 13 Mar 2020 08:36:29 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-85.ams2.redhat.com [10.36.117.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 254AB92D47;
 Fri, 13 Mar 2020 08:36:25 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 1/3] iotests.py: Enable faulthandler
Date: Fri, 13 Mar 2020 09:36:15 +0100
Message-Id: <20200313083617.8326-2-kwolf@redhat.com>
In-Reply-To: <20200313083617.8326-1-kwolf@redhat.com>
References: <20200313083617.8326-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: kwolf@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With this, you can send SIGABRT to a hanging test case and you'll get a
Python stack trace so you know where it was hanging.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/iotests.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 23043baa26..b859c303a2 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -30,12 +30,15 @@ import logging
 import atexit
 import io
 from collections import OrderedDict
+import faulthandler
=20
 sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'pytho=
n'))
 from qemu import qtest
=20
 assert sys.version_info >=3D (3,6)
=20
+faulthandler.enable()
+
 # This will not work if arguments contain spaces but is necessary if we
 # want to support the override options that ./check supports.
 qemu_img_args =3D [os.environ.get('QEMU_IMG_PROG', 'qemu-img')]
--=20
2.20.1


