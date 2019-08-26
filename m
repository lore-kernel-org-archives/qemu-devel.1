Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A5FFC3A59F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 13:53:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 723F6206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 13:53:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 723F6206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2FRN-0001Il-CK
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 09:53:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37975)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i2FP3-0007tu-QH
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 09:51:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i2FOu-0006Hu-Br
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 09:51:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44880)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i2FOs-0006GD-AZ; Mon, 26 Aug 2019 09:51:14 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8B8DB300BE7F;
 Mon, 26 Aug 2019 13:51:13 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C65F85D721;
 Mon, 26 Aug 2019 13:51:05 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 26 Aug 2019 16:50:50 +0300
Message-Id: <20190826135103.22410-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Mon, 26 Aug 2019 13:51:13 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 00/13] RFC crypto/luks: preparation for
 encryption key managment
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi!

This patch series is the refactoring/preparation part of the
former patch series I had sent which adds support for luks
key management.

I tried my best to address all the comments that were given
during the review, and I would like to use that opportunity
to thanks again for the review I was given.

Best regards,
	Maxim Levitsky

Maxim Levitsky (13):
  introduce g_autowipe
  block-crypto: misc refactoring
  qcrypto-luks: rename some fields in QCryptoBlockLUKSHeader
  qcrypto-luks: don't overwrite cipher_mode in header
  qcrypto-luks: simplify masterkey and masterkey length
  qcrypto-block: pass keyslot index rather that pointer to the keyslot
  qcrypto-luks: use the parsed encryption settings in QCryptoBlockLUKS
  qcrypto-luks: extract store and load header
  qcrypto-block: extract check and parse header
  qcrypto-luks: refactoring: extract store key function
  qcrypto-luks: refactoring: simplify the math used for keyslot
    locations
  qcrypto-luks: use g_autowipe
  qcrypto-luks: implement more rigorous header checking

 block/crypto.c      |   12 +-
 crypto/block-luks.c | 1046 +++++++++++++++++++++++++------------------
 include/autowipe.h  |   52 +++
 3 files changed, 666 insertions(+), 444 deletions(-)
 create mode 100644 include/autowipe.h

--=20
2.17.2


