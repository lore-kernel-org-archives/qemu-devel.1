Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCB7CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 07:23:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26EBD2064B
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 07:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FZNmDwQi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26EBD2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50977 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMoVf-00069c-1S
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 03:23:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39049)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iMoUH-000502-Qf
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 03:21:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iMoUG-0005B7-Ka
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 03:21:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25708
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iMoUG-0005Aj-HK
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 03:21:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571728907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3jwGoqu3/nXzNy6jQFWzPQQB4qY5jxDakNr6tPeKyNE=;
 b=FZNmDwQipy6ZlT4Mk31FqWbo2GqTkPF73XdWCOJKzvPeLNBLqlhDM1HmAwrZiuJwF3YOrP
 Fws+FKAcBoATErxn0ZnKe1CoJfEhbRVabG8EpF+vcgOVVYrb7YK+5V2GK2PkK+Kue/fn1q
 TpkAKeKQ7At7Z3HkxfIybjzLoirZmSQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-haIZN31DMCmtmESlISe55Q-1; Tue, 22 Oct 2019 03:21:44 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D0FBC1005509;
 Tue, 22 Oct 2019 07:21:43 +0000 (UTC)
Received: from thuth.com (dhcp-200-228.str.redhat.com [10.33.200.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 46F141B465;
 Tue, 22 Oct 2019 07:21:39 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Max Reitz <mreitz@redhat.com>,
	qemu-block@nongnu.org
Subject: [PATCH v3 0/6] Enable more iotests during "make check-block"
Date: Tue, 22 Oct 2019 09:21:29 +0200
Message-Id: <20191022072135.11188-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: haIZN31DMCmtmESlISe55Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As discussed here:

 https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg00697.html

and here:

 https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg01388.html

it would be good to have some more valuable iotests enabled in the
"auto" group to get better iotest coverage during "make check".

And once Max' "iotests: Add and use $SOCK_DIR" patch series has been
merged, we can indeed enable these Python-based tests, too.

There is just one small downside: Since these tests require a QEMU
that features a 'virtio-blk' device, we cannot run the iotests
with binaries like qemu-system-tricore anymore. But since the iotests
were not very useful with such binaries anyway, I think it's ok now
if we skip them there.

I've also added a patch that removes test 130 from the "auto" group
instead. Test 130 has been reported to fail intermittently, so we
should not use it in "make check" block until it is fixed.

Based-on: 20191010152457.17713-1-mreitz@redhat.com

v3:
 - Test 183 fails on Patchew, so I removed it from the "auto" group
   again

v2:
 - Checked the iotests with NetBSD, too (now that Eduardo has
   re-activated Gerd's patches for creating NetBSD VM images)
 - Use 'openbsd' instead of 'openbsd6'
 - Use 'grep -q' instead of 'grep' for grep'ing silently
 - Added the patch to disable 130 from the "auto" group

John Snow (1):
  iotests: remove 'linux' from default supported platforms

Thomas Huth (5):
  iotests: Test 041 only works on certain systems
  iotests: Test 183 does not work on macOS and OpenBSD
  iotests: Skip "make check-block" if QEMU does not support virtio-blk
  iotests: Enable more tests in the 'auto' group to improve test
    coverage
  iotests: Remove 130 from the "auto" group

 tests/check-block.sh          | 16 +++++++++++++++-
 tests/qemu-iotests/041        |  3 ++-
 tests/qemu-iotests/183        |  1 +
 tests/qemu-iotests/group      | 18 +++++++++---------
 tests/qemu-iotests/iotests.py | 16 +++++++++++-----
 5 files changed, 38 insertions(+), 16 deletions(-)

--=20
2.18.1


