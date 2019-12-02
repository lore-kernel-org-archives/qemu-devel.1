Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FAAC432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 10:22:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0C9D20718
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 10:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dp3Hcvdy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0C9D20718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibiqZ-0005nG-VM
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 05:22:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60892)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ibil2-0008I1-3Y
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 05:16:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ibiky-00081k-05
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 05:16:41 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39951)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ibikv-0007zF-V3
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 05:16:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575281797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DiRzthbf6PxSqKbTlbRKclc+v/87Gj5EeYvBAQ4PYog=;
 b=dp3Hcvdy+ICDbVfZ/MEycBaFgevsSbQQc3bwVB4lixBrr8mvHS8UgaKZOpfT7kELRa1avt
 /6nQsTZlHBVyC7r839BM/OxHZy5s8/NPKKIp3PnaCDeUDZen2wPTBhEO/ck39D8HHZcozL
 naXamTLNcZ6+YqKvo2S8YuM8WEHfjro=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-mfGMiKA1NfGGVN5a3ym-nA-1; Mon, 02 Dec 2019 05:16:36 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4036F800D53;
 Mon,  2 Dec 2019 10:16:35 +0000 (UTC)
Received: from thuth.com (ovpn-117-196.ams2.redhat.com [10.36.117.196])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C393767648;
 Mon,  2 Dec 2019 10:16:33 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Subject: [PATCH 0/3] iotests: Check for the possibility to create large files
Date: Mon,  2 Dec 2019 11:16:28 +0100
Message-Id: <20191202101631.10003-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: mfGMiKA1NfGGVN5a3ym-nA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Travis recently added the possibility to test on ppc64le, arm64 and s390x
hosts, too. However, the containers are very restricted there and do not
allow the creation of large files, so that the tests 060 and 079 are
currently failing there. So let's add some proper checks to these tests
first.

Thomas Huth (3):
  iotests: Provide a function for checking the creation of huge files
  iotests: Skip test 060 if it is not possible to create large files
  iotests: Skip test 079 if it is not possible to create large files

 tests/qemu-iotests/005       |  5 +----
 tests/qemu-iotests/060       |  3 +++
 tests/qemu-iotests/079       |  3 +++
 tests/qemu-iotests/220       |  6 ++----
 tests/qemu-iotests/common.rc | 10 ++++++++++
 5 files changed, 19 insertions(+), 8 deletions(-)

--=20
2.18.1


