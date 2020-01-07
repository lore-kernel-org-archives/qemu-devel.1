Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9F5C282DD
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 19:10:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C7D62087F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 19:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ff6GHU5i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C7D62087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iouFH-0006dz-GJ
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 14:10:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48204)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iouDb-0005Am-7l
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 14:08:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iouDY-00081R-W3
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 14:08:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36558
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iouDY-00080F-Se
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 14:08:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578424120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jEMv4Nfv2Xy6fSy+Jyj0B8rAj1NrSrySV7Wqv71aQ1Q=;
 b=Ff6GHU5i6rui/AiobqICO7VNgV3y1KfqKTEVDhw6vhd3YIg3VZWRM7Tc7OBV8CYMe3EWEC
 tZuKiNQW54Eevr8PICQUAaIRdIboRsPbkJzMgQs3Ej+UB49mhsCzeyjpVZbtFYA/BoNztc
 z7n2/ICfSE+TChyuSdr/QT11V2nrtnc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-gvCj44pBOEuKalzT16DbDw-1; Tue, 07 Jan 2020 14:08:36 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B80D21900F31;
 Tue,  7 Jan 2020 19:08:35 +0000 (UTC)
Received: from thuth.com (ovpn-116-83.ams2.redhat.com [10.36.116.83])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 778CB6106D;
 Tue,  7 Jan 2020 19:08:34 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 1/8] tests/Makefile: test-char does not need libqtest
Date: Tue,  7 Jan 2020 20:07:55 +0100
Message-Id: <20200107190802.2257-2-thuth@redhat.com>
In-Reply-To: <20200107190802.2257-1-thuth@redhat.com>
References: <20200107190802.2257-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: gvCj44pBOEuKalzT16DbDw-1
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

No need to link the libqtest objects here.

Message-Id: <20191218103059.11729-2-thuth@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/Makefile.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 9146e1bdee..7679d0369a 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -538,7 +538,7 @@ tests/check-qlit$(EXESUF): tests/check-qlit.o $(test-ut=
il-obj-y)
 tests/check-qom-interface$(EXESUF): tests/check-qom-interface.o $(test-qom=
-obj-y)
 tests/check-qom-proplist$(EXESUF): tests/check-qom-proplist.o $(test-qom-o=
bj-y)
=20
-tests/test-char$(EXESUF): tests/test-char.o $(test-util-obj-y) $(qtest-obj=
-y) $(test-io-obj-y) $(chardev-obj-y) tests/socket-helpers.o
+tests/test-char$(EXESUF): tests/test-char.o $(test-util-obj-y) $(test-io-o=
bj-y) $(chardev-obj-y) tests/socket-helpers.o
 tests/test-coroutine$(EXESUF): tests/test-coroutine.o $(test-block-obj-y)
 tests/test-aio$(EXESUF): tests/test-aio.o $(test-block-obj-y)
 tests/test-aio-multithread$(EXESUF): tests/test-aio-multithread.o $(test-b=
lock-obj-y)
--=20
2.18.1


