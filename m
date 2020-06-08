Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ABD8C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 09:41:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39F7F206D5
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 09:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y7DuDISP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39F7F206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiEHx-0007Me-D9
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 05:41:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50030)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jiEGl-0005qn-RL
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 05:40:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42409
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jiEGl-00023A-32
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 05:40:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591609238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=eG+1IFdoUmBOxXTFEjG0dpYT/2EDKd1PDwsYAF/7eU4=;
 b=Y7DuDISPmlCavQBw7tj4zwK/6IzIG/GAwBWOuP4iZ66XBYU46uZKnVEMs9ox+UoLlKFpjF
 Vyvjc2EmnX2Uwu0tYy0FYrXl/+aEUANYMU4pOiikOd+6Dnf2t9ii9ODodoJ4LpOuiSZBD+
 5U3i5N8kWLV2BMdl8yFYnp1l6ET+nds=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-116-3GGvXGnHN6mISgOtbYjeGw-1; Mon, 08 Jun 2020 05:40:36 -0400
X-MC-Unique: 3GGvXGnHN6mISgOtbYjeGw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9070D1940920;
 Mon,  8 Jun 2020 09:40:35 +0000 (UTC)
Received: from starship.redhat.com (unknown [10.35.206.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6A0B5891E0;
 Mon,  8 Jun 2020 09:40:31 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 00/14] LUKS: encryption slot management using amend
 interface
Date: Mon,  8 Jun 2020 12:40:16 +0300
Message-Id: <20200608094030.670121-1-mlevitsk@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 01:05:50
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

clone of "luks-keymgmnt-v2"=0D
=0D
Maxim Levitsky (14):=0D
  qcrypto/core: add generic infrastructure for crypto options amendment=0D
  qcrypto/luks: implement encryption key management=0D
  block/amend: add 'force' option=0D
  block/amend: separate amend and create options for qemu-img=0D
  block/amend: refactor qcow2 amend options=0D
  block/crypto: rename two functions=0D
  block/crypto: implement the encryption key management=0D
  block/qcow2: extend qemu-img amend interface with crypto options=0D
  iotests: filter few more luks specific create options=0D
  iotests: qemu-img tests for luks key management=0D
  block/core: add generic infrastructure for x-blockdev-amend qmp=0D
    command=0D
  block/crypto: implement blockdev-amend=0D
  block/qcow2: implement blockdev-amend=0D
  iotests: add tests for blockdev-amend=0D
=0D
 block.c                          |   4 +-=0D
 block/Makefile.objs              |   2 +-=0D
 block/amend.c                    | 113 +++++++++=0D
 block/crypto.c                   | 206 +++++++++++++--=0D
 block/crypto.h                   |  37 +++=0D
 block/qcow2.c                    | 332 +++++++++++++-----------=0D
 crypto/block-luks.c              | 416 ++++++++++++++++++++++++++++++-=0D
 crypto/block.c                   |  29 +++=0D
 crypto/blockpriv.h               |   8 +=0D
 docs/tools/qemu-img.rst          |   5 +-=0D
 include/block/block.h            |   1 +=0D
 include/block/block_int.h        |  24 +-=0D
 include/crypto/block.h           |  22 ++=0D
 qapi/block-core.json             |  68 +++++=0D
 qapi/crypto.json                 |  73 +++++-=0D
 qapi/job.json                    |   4 +-=0D
 qemu-img-cmds.hx                 |   4 +-=0D
 qemu-img.c                       |  44 +++-=0D
 tests/qemu-iotests/049.out       | 102 ++++----=0D
 tests/qemu-iotests/061.out       |  12 +-=0D
 tests/qemu-iotests/079.out       |  18 +-=0D
 tests/qemu-iotests/082.out       | 185 ++++----------=0D
 tests/qemu-iotests/085.out       |  38 +--=0D
 tests/qemu-iotests/087.out       |   6 +-=0D
 tests/qemu-iotests/115.out       |   2 +-=0D
 tests/qemu-iotests/121.out       |   4 +-=0D
 tests/qemu-iotests/125.out       | 192 +++++++-------=0D
 tests/qemu-iotests/134.out       |   2 +-=0D
 tests/qemu-iotests/144.out       |   4 +-=0D
 tests/qemu-iotests/158.out       |   4 +-=0D
 tests/qemu-iotests/182.out       |   2 +-=0D
 tests/qemu-iotests/185.out       |   8 +-=0D
 tests/qemu-iotests/188.out       |   2 +-=0D
 tests/qemu-iotests/189.out       |   4 +-=0D
 tests/qemu-iotests/198.out       |   4 +-=0D
 tests/qemu-iotests/243.out       |  16 +-=0D
 tests/qemu-iotests/250.out       |   2 +-=0D
 tests/qemu-iotests/255.out       |   8 +-=0D
 tests/qemu-iotests/259.out       |   2 +-=0D
 tests/qemu-iotests/263.out       |   4 +-=0D
 tests/qemu-iotests/274.out       |  46 ++--=0D
 tests/qemu-iotests/280.out       |   2 +-=0D
 tests/qemu-iotests/284.out       |   6 +-=0D
 tests/qemu-iotests/293           | 207 +++++++++++++++=0D
 tests/qemu-iotests/293.out       |  99 ++++++++=0D
 tests/qemu-iotests/294           |  90 +++++++=0D
 tests/qemu-iotests/294.out       |  30 +++=0D
 tests/qemu-iotests/295           | 279 +++++++++++++++++++++=0D
 tests/qemu-iotests/295.out       |  40 +++=0D
 tests/qemu-iotests/296           | 234 +++++++++++++++++=0D
 tests/qemu-iotests/296.out       |  33 +++=0D
 tests/qemu-iotests/common.filter |   6 +-=0D
 tests/qemu-iotests/group         |   4 +=0D
 53 files changed, 2524 insertions(+), 565 deletions(-)=0D
 create mode 100644 block/amend.c=0D
 create mode 100755 tests/qemu-iotests/293=0D
 create mode 100644 tests/qemu-iotests/293.out=0D
 create mode 100755 tests/qemu-iotests/294=0D
 create mode 100644 tests/qemu-iotests/294.out=0D
 create mode 100755 tests/qemu-iotests/295=0D
 create mode 100644 tests/qemu-iotests/295.out=0D
 create mode 100755 tests/qemu-iotests/296=0D
 create mode 100644 tests/qemu-iotests/296.out=0D
=0D
--=20=0D
2.25.4=0D
=0D


