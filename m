Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FBBC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 12:57:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D423F20772
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 12:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dBYzoL5d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D423F20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqymJ-0007OM-1R
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 08:57:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53490)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jqylN-00065m-09
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 08:56:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49520
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jqylK-0004UL-JX
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 08:56:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593694581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7cTot/lNWJbPrHjepuHzE71xHyFZX8/p+XJLdwE61yQ=;
 b=dBYzoL5dIt2AKsQ4EevIJnDLUnBhXXTwsEIuzmRAq782hYV/vep6147g830QwQEk7kxzYy
 YKxLodPT1/RtbyD+ekpCI9qwvOUeV6DWAgKJfiCx27OzNSQ4jBP6GglemqE/8BXx3mrphl
 yxNRX8mNRteW3NgY6nMut2c6AoWb3jQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-4FRsJaV5NAalDYap3NbkGw-1; Thu, 02 Jul 2020 08:56:16 -0400
X-MC-Unique: 4FRsJaV5NAalDYap3NbkGw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4B3219057A6;
 Thu,  2 Jul 2020 12:56:15 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.52])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 61AF12B4CA;
 Thu,  2 Jul 2020 12:56:13 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/3] block: improve error reporting for unsupported O_DIRECT
Date: Thu,  2 Jul 2020 13:56:09 +0100
Message-Id: <20200702125612.2176194-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 04:00:43
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 P J P <ppandit@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v1: https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg00269.html=0D
=0D
See patch commit messages for rationale=0D
=0D
Ideally we would convert other callers of qemu_open to use=0D
qemu_open_err, and eventually remove qemu_open, renaming=0D
qemu_open_err back to qemu_open.  Given soft freeze is just=0D
days away though, I'm hoping this series is simple enough=0D
to get into this release, leaving bigger cleanup for later.=0D
=0D
Improved in v2:=0D
=0D
 - Mention that qemu_open_err is preferred over qemu_open=0D
 - Get rid of obsolete error_report call=0D
 - Simplify O_DIRECT handling=0D
 - Fixup iotests for changed error message text=0D
=0D
Daniel P. Berrang=C3=A9 (3):=0D
  util: validate whether O_DIRECT is supported after failure=0D
  util: support detailed error reporting for qemu_open=0D
  block: switch to use qemu_open_err for improved errors=0D
=0D
 block/file-posix.c            | 10 ++---=0D
 include/qemu/osdep.h          |  2 +=0D
 tests/qemu-iotests/051.out    |  4 +-=0D
 tests/qemu-iotests/051.pc.out |  4 +-=0D
 tests/qemu-iotests/061.out    |  2 +-=0D
 tests/qemu-iotests/069.out    |  2 +-=0D
 tests/qemu-iotests/082.out    |  4 +-=0D
 tests/qemu-iotests/111.out    |  2 +-=0D
 tests/qemu-iotests/226.out    |  6 +--=0D
 tests/qemu-iotests/232.out    | 12 +++---=0D
 tests/qemu-iotests/244.out    |  6 +--=0D
 util/osdep.c                  | 69 +++++++++++++++++++++++++++++------=0D
 12 files changed, 85 insertions(+), 38 deletions(-)=0D
=0D
--=20=0D
2.26.2=0D
=0D


