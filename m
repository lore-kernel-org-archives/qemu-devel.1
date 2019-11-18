Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B6DC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 17:10:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D85062192B
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 17:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Af99O4jA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D85062192B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWkXW-0002QS-LO
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 12:10:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52745)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iWkQn-0003Tr-MV
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 12:03:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iWkQl-0002kA-Mb
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 12:03:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35821
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iWkQi-0002gE-6v
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 12:03:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574096591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UzVNhB0B8XOLmpCcaY1y+ngg7apmCBSl9Y+iNAHUwRg=;
 b=Af99O4jALt+U1EA9KV+X0bRC69T24sLxumXKb1Q0zXnHLvqlpjgPf9tS32HxI55IG9gCoJ
 WK8rqbrDKO/mjxbpRJK2QCX5CsejVdCE0IS+q8eYwMRehv6kXRGYakJ3DlXcb9ONLoJWV7
 Fap+jhlxY3j7NrU+yFrSfUiESyqk+JM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-r6xyGtwCPvez4yXdn37YuQ-1; Mon, 18 Nov 2019 12:03:08 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3960802D14;
 Mon, 18 Nov 2019 17:03:07 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-108.ams2.redhat.com
 [10.36.117.108])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B5BDC608B5;
 Mon, 18 Nov 2019 17:03:06 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 1/4] qemu-iotests/iotests.py: improve assert_qmp message
Date: Mon, 18 Nov 2019 18:02:53 +0100
Message-Id: <20191118170256.31477-2-kwolf@redhat.com>
In-Reply-To: <20191118170256.31477-1-kwolf@redhat.com>
References: <20191118170256.31477-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: r6xyGtwCPvez4yXdn37YuQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

From the two values compared, make it obvious which is found at path, and
which is expected.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/iotests.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 075f4739da..6a248472b9 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -731,8 +731,8 @@ class QMPTestCase(unittest.TestCase):
             self.fail('no match for "%s" in %s' % (str(result), str(value)=
))
         else:
             self.assertEqual(result, value,
-                             'values not equal "%s" and "%s"'
-                                 % (str(result), str(value)))
+                             '"%s" is "%s", expected "%s"'
+                                 % (path, str(result), str(value)))
=20
     def assert_no_active_block_jobs(self):
         result =3D self.vm.qmp('query-block-jobs')
--=20
2.20.1


