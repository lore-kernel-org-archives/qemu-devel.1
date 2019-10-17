Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB8FFA3735
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 15:45:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A052E21835
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 15:45:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A052E21835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL7yC-0006Nz-6E
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 11:45:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52062)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iL7D3-00053e-0V
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:57:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iL7D1-000371-PF
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:57:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:12473)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iL7D1-00036Q-KE
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:56:59 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D5A014FCDB
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 14:56:57 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-112-36.ams2.redhat.com
 [10.36.112.36])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CDDD31001B11;
 Thu, 17 Oct 2019 14:56:56 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/4] crypto: improve performance of ciphers in XTS mode
Date: Thu, 17 Oct 2019 15:56:50 +0100
Message-Id: <20191017145654.11371-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Thu, 17 Oct 2019 14:56:57 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently QEMU uses its own XTS cipher mode, however, this has
relatively poor performance.

Gcrypt now includes its own XTS cipher which is at least x2 faster than
what we get with QEMU's on Fedora/RHEL hosts. With gcrypt git master, a
further x5-6 speed up is seen.

This is essential for QEMU's LUKS performance to be viable.

Daniel P. Berrang=C3=A9 (4):
  tests: allow filtering crypto cipher benchmark tests
  tests: benchmark crypto with fixed data size, not time period
  crypto: add support for gcrypt's native XTS impl
  crypto: add support for nettle's native XTS impl

 configure                       | 40 +++++++++++++++++++++++++++++++++
 crypto/Makefile.objs            |  2 +-
 crypto/cipher-gcrypt.c          | 36 ++++++++++++++++++++++++++++-
 crypto/cipher-nettle.c          | 18 +++++++++++++++
 tests/Makefile.include          |  2 +-
 tests/benchmark-crypto-cipher.c | 39 +++++++++++++++++++++-----------
 tests/benchmark-crypto-hash.c   | 17 +++++++-------
 7 files changed, 130 insertions(+), 24 deletions(-)

--=20
2.21.0


