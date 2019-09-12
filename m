Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2730ECDE27
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 09:19:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 781BD20663
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 09:19:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 781BD20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8LGd-0003eB-P5
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 05:19:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42296)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i8LEA-0001mB-0N
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 05:17:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i8LE9-0005WR-1R
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 05:17:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41262)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i8LE6-0005Tc-8B; Thu, 12 Sep 2019 05:17:18 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4D2F5300BE7F;
 Thu, 12 Sep 2019 09:17:17 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BAACD194B9;
 Thu, 12 Sep 2019 09:17:12 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 12 Sep 2019 12:16:58 +0300
Message-Id: <20190912091710.21449-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Thu, 12 Sep 2019 09:17:17 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 00/12] crypto/luks: preparation for encryption
 key managment
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi!

This patch series is the refactoring/preparation part of the
former patch series I had sent which adds support for luks
key management.

This series includes all the feedback from the last review iteration
and one new patch that removes errno values from .open
callback of luks crypto driver since these values are not
used anyway.

Best regards,
	Maxim Levitsky

Maxim Levitsky (12):
  block-crypto: misc refactoring
  qcrypto-luks: rename some fields in QCryptoBlockLUKSHeader
  qcrypto-luks: don't overwrite cipher_mode in header
  qcrypto-luks: simplify masterkey and masterkey length
  qcrypto-luks: pass keyslot index rather that pointer to the keyslot
  qcrypto-luks: use the parsed encryption settings in QCryptoBlockLUKS
  qcrypto-luks: purge unused error codes from open callback
  qcrypto-luks: extract store and load header
  qcrypto-luks: extract check and parse header
  qcrypto-luks: extract store key function
  qcrypto-luks: simplify the math used for keyslot locations
  qcrypto-luks: more rigorous header checking

 block/crypto.c      |   12 +-
 crypto/block-luks.c | 1023 +++++++++++++++++++++++++------------------
 2 files changed, 602 insertions(+), 433 deletions(-)

--=20
2.17.2


