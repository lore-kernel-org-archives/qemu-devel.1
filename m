Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66FF6C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 16:11:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24B20207FB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 16:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QTa2lrsF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24B20207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqfKZ-00062S-DD
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 12:11:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38098)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jqfEc-000365-8W
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 12:05:18 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60078
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jqfEa-00054l-Aj
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 12:05:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593619515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gNnnLOL/f77zHhhxuWlvKXOmM8IGPq18pJK/yuUuYIk=;
 b=QTa2lrsFfvIMFKT5I8Z8DKe2O/COcRdPfTNmf4978Mt1cY1cklNOEQ/BSnL7h2RQU818n3
 5rOlxu/OzPLqwIS5zsm7YQ1z1S1PdZd+BAivBuqJfAlyKaK/yiV5+gTywx4kYp/tjKC9Gx
 vnKNz3UslaFoJ4j+OmXy0ATxaRCssWc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-PfNXpDx_MYG5P9WVjEuAeQ-1; Wed, 01 Jul 2020 12:05:13 -0400
X-MC-Unique: PfNXpDx_MYG5P9WVjEuAeQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83750805EEE;
 Wed,  1 Jul 2020 16:05:12 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B59382B4CE;
 Wed,  1 Jul 2020 16:05:10 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] block: improve error reporting for unsupported O_DIRECT
Date: Wed,  1 Jul 2020 17:05:06 +0100
Message-Id: <20200701160509.1523847-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 01:05:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, P J P <ppandit@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To repeat the commit message from patch 3...=0D
=0D
Currently at startup if using cache=3Dnone on a filesystem lacking=0D
O_DIRECT such as tmpfs, at startup QEMU prints=0D
=0D
qemu-system-x86_64: -drive file=3D/tmp/foo.img,cache=3Dnone: file system ma=
y not support O_DIRECT=0D
qemu-system-x86_64: -drive file=3D/tmp/foo.img,cache=3Dnone: Could not open=
 '/tmp/foo.img': Invalid argument=0D
=0D
while at QMP level the hint is missing, so QEMU reports just=0D
=0D
  "error": {=0D
      "class": "GenericError",=0D
      "desc": "Could not open '/tmp/foo.img': Invalid argument"=0D
  }=0D
=0D
which is close to useless for the end user trying to figure out what=0D
they did wrong=0D
=0D
With this change at startup QEMU prints=0D
=0D
qemu-system-x86_64: -drive file=3D/tmp/foo.img,cache=3Dnone: Unable to open=
 '/tmp/foo.img' flags 0x4000: filesystem does not support O_DIRECT=0D
=0D
while at the QMP level QEMU reports a massively more informative=0D
=0D
  "error": {=0D
     "class": "GenericError",=0D
     "desc": "Unable to open '/tmp/foo.img' flags 0x4002: filesystem does n=
ot support O_DIRECT"=0D
  }=0D
=0D
=0D
qemu_open is used in many more places besides block layer, but=0D
converting those to qemu_open_err is left as an exercise for=0D
other maintainers.=0D
=0D
Daniel P. Berrang=C3=A9 (3):=0D
  util: validate whether O_DIRECT is supported after failure=0D
  util: support detailed error reporting for qemu_open=0D
  block: switch to use qemu_open_err for improved errors=0D
=0D
 block/file-posix.c   | 10 +++----=0D
 include/qemu/osdep.h |  1 +=0D
 util/osdep.c         | 70 ++++++++++++++++++++++++++++++++++++++------=0D
 3 files changed, 66 insertions(+), 15 deletions(-)=0D
=0D
--=20=0D
2.26.2=0D
=0D


