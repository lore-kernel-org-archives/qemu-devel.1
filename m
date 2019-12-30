Return-Path: <SRS0=s40H=2U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDC3C2D0C2
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 18:46:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 770B820722
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 18:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CObkYBet"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 770B820722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1im045-0003Rc-Iy
	for qemu-devel@archiver.kernel.org; Mon, 30 Dec 2019 13:46:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35372)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1im015-00007W-Df
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 13:43:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1im014-0007nM-Co
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 13:43:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28514
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1im014-0007mg-8w
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 13:43:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577731425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A4Ukb4Equc/uewpDniW4tH6PQF+WOUjSCrgNORyFrQw=;
 b=CObkYBetN/ui4dZsTljtDP1+byofT4qm40BkiE3QbyGdVX+rrPhv2mfm0RPdUqSV3UP8i9
 Bnn6SB2V/1ADkQYeWsunqr20w5hmndiCJEat6vOY5gdL38Y5IjRhn7wrlsdN5zOI08y/Ay
 eMtfeLJce3dzeE3ueHzcAybW9XRPZY0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-UOPtr1xiO16BripF44kMDw-1; Mon, 30 Dec 2019 13:43:42 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A33518031C3;
 Mon, 30 Dec 2019 18:43:41 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-92.gru2.redhat.com
 [10.97.116.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 58C7760579;
 Mon, 30 Dec 2019 18:43:38 +0000 (UTC)
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] travis.yml: Detach build and test steps
Date: Mon, 30 Dec 2019 15:43:27 -0300
Message-Id: <20191230184327.2800-3-wainersm@redhat.com>
In-Reply-To: <20191230184327.2800-1-wainersm@redhat.com>
References: <20191230184327.2800-1-wainersm@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: UOPtr1xiO16BripF44kMDw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
Cc: fam@euphon.net, philmd@redhat.com, alex.bennee@linaro.org, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently build and test commands are a single step in a
Travis's `script` block. In order to see the output
of the tests one needs to scroll down the log to find where
the build messages ended and the limit is not clear. If
they were in different steps then Travis would print the
result build command, which can be easily grep'ed.

So this change is made to detach those commands
to ease the visualization of the output.

Note that all steps on the `script` block is executed regardless
if one previous has failed. To overcome it, let's save the
return code of the build then check whether succeed or failed on
the test step.

Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
---
 .travis.yml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index e7fdcb238c..fcc9de368b 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -94,7 +94,8 @@ before_script:
   - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
   - ${SRC_DIR}/configure ${BASE_CONFIG} ${CONFIG} || { cat config.log && e=
xit 1; }
 script:
-  - make -j3 && travis_retry ${TEST_CMD}
+  - BUILD_RC=3D0 && make -j3 || BUILD_RC=3D$?
+  - if [ "$BUILD_RC" -eq 0 ] ; then travis_retry ${TEST_CMD} ; else $(exit=
 $BUILD_RC); fi
 after_script:
   - if command -v ccache ; then ccache --show-stats ; fi
=20
--=20
2.23.0


