Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ECDEC4724C
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 12:00:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECB8820CC7
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 11:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dz8RTZ+r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECB8820CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWfC3-0007WN-49
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 07:59:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37138)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jWfAK-0006Fp-WB
 for qemu-devel@nongnu.org; Thu, 07 May 2020 07:58:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44418
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jWfAJ-0008MD-SM
 for qemu-devel@nongnu.org; Thu, 07 May 2020 07:58:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588852690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=kC5NVKUbCnCpp5CJ73NiCoD9H3xMniCcjFeTpmuJh/s=;
 b=dz8RTZ+r0ri46PD9L70AZtS8Ml36Ji6ADyWJOjl5CMssXIZp2OmiJAKOB49g7KTvkKR0qT
 /n2YwvWKJG6EeYSQo/wKv9MLkzt9dGIygwN3Gh/WsLmWEoHD7Bg3oHRvJtjlFyD8ucSRo9
 aA2xBeY1ettH5gK+b6WeZD50gK+txh8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-268Jw3UdPeiEFlaYi6fttg-1; Thu, 07 May 2020 07:58:07 -0400
X-MC-Unique: 268Jw3UdPeiEFlaYi6fttg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B0DA107BF0D;
 Thu,  7 May 2020 11:58:06 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.63])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9EEB162A50;
 Thu,  7 May 2020 11:58:04 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/5] Misc crypto subsystem fixes
Date: Thu,  7 May 2020 12:57:58 +0100
Message-Id: <20200507115803.1122661-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 03:15:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 609dd53df540edd72faee705205aceca9c42fea5=
:=0D
=0D
  Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20200506' into st=
ag=3D=0D
ing (2020-05-07 09:45:54 +0100)=0D
=0D
are available in the Git repository at:=0D
=0D
  https://github.com/berrange/qemu tags/qcrypto-next-pull-request=0D
=0D
for you to fetch changes up to 6022e15d146d8bba9610a9d134afa4bc6e5d9275:=0D
=0D
  crypto: extend hash benchmark to cover more algorithms (2020-05-07 12:52:=
51=3D=0D
 +0100)=0D
=0D
----------------------------------------------------------------=0D
Misc crypto subsystem fixes=0D
=0D
* Improve error message for large files when creating LUKS volumes=0D
* Expand crypto hash benchmark coverage=0D
* Misc code refactoring with no functional change=0D
=0D
----------------------------------------------------------------=0D
=0D
Alexey Krasikov (1):=0D
  crypto/secret: fix inconsequential errors.=0D
=0D
Chen Qun (1):=0D
  crypto: Redundant type conversion for AES_KEY pointer=0D
=0D
Daniel P. Berrang=3DC3=3DA9 (1):=0D
  crypto: extend hash benchmark to cover more algorithms=0D
=0D
Maxim Levitsky (1):=0D
  block: luks: better error message when creating too large files=0D
=0D
Tong Ho (1):=0D
  crypto: fix getter of a QCryptoSecret's property=0D
=0D
 block/crypto.c                | 25 ++++++++++--=0D
 crypto/cipher-builtin.c       | 10 ++---=0D
 crypto/secret.c               |  5 ++-=0D
 tests/benchmark-crypto-hash.c | 73 ++++++++++++++++++++++++++++-------=0D
 4 files changed, 87 insertions(+), 26 deletions(-)=0D
=0D
--=3D20=0D
2.26.2=0D
=0D


