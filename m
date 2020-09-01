Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75340C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 13:32:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40165206EB
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 13:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z2zNnmkB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40165206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD6Oz-0001Ic-BQ
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 09:32:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kD6NU-0008Na-3K
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 09:31:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32983
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kD6NL-00075E-9q
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 09:31:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598967062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DVzEytBvexLhPQwpZZpKzUgjXa+Zor8NCj8/FALjqLw=;
 b=Z2zNnmkB/mLvQSrImrYdQSPlgAd/sXOPmEll9/iMRoVeVOHKAujKUS3PdkDoRze2E0XxyX
 9REGZJa9XcBp2V5CydqC85el8PquhIqQRUUaE/XOR3IisxIp5oOs4LMRH4TyYi9w9qTZKf
 wm+WLuVqsrIo/HGIO7PBXjvIeTRSIag=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-B44C0XH0Nw-QPALfY3wuHw-1; Tue, 01 Sep 2020 09:30:59 -0400
X-MC-Unique: B44C0XH0Nw-QPALfY3wuHw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2989C801AE4;
 Tue,  1 Sep 2020 13:30:58 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-114-215.ams2.redhat.com
 [10.36.114.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D4D875D9CC;
 Tue,  1 Sep 2020 13:30:51 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/2] crypto: fix build with gcrypt
Date: Tue,  1 Sep 2020 14:30:48 +0100
Message-Id: <20200901133050.381844-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 00:57:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The build system failed to add gcrypt flags and also didn't link to=0D
gnutls in all scenarios.  This was missed because of the lack of CI=0D
coverage for various build scenarios=0D
=0D
Changed in v2:=0D
=0D
 - Change way we add library dependencies in meson rules=0D
   to fix linux-user build with gcrypt/gnutls too.=0D
 - Extend CI coverage to test 1 system and 1 linux-user=0D
   build with each crypto combination, not merely tools.=0D
=0D
Daniel P. Berrang=C3=A9 (2):=0D
  crypto: fix build with gcrypt enabled=0D
  gitlab: expand test coverage for crypto builds=0D
=0D
 .gitlab-ci.yml                          | 69 +++++++++++++++++++++++++=0D
 configure                               |  2 +=0D
 crypto/meson.build                      | 42 +++++++++++----=0D
 meson.build                             |  5 ++=0D
 tests/docker/dockerfiles/centos7.docker |  2 +=0D
 tests/docker/dockerfiles/centos8.docker |  1 +=0D
 6 files changed, 110 insertions(+), 11 deletions(-)=0D
=0D
--=20=0D
2.26.2=0D
=0D


