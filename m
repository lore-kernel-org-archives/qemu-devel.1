Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA79EC4332D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 22:28:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3D3F2076C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 22:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KAB4XpMs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3D3F2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEhAb-00056J-Oj
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 18:28:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37170)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jEh9p-000454-4W
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 18:27:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jEh9o-0002Ne-3m
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 18:27:25 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:60417)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jEh9o-0002MW-0Y
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 18:27:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584570443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2WFbwPTCZwKcrJPJefMZXSwfuOUfE/G/3ce0GYBaZe4=;
 b=KAB4XpMsA/079C1rxI+EeCk99tREwGCTehH95Tt98Bj9kw3gGyeKOFhcBwN8Ks2JwCV5S5
 ECXI5EKTMsvlVuXYveGF2/IRPfe3dRPN9Pw9MwugdDVRuAWtwbLmy8o9MGbEtID5ihoL+R
 SN6UGp1R09nk1UG17X02Np4+Ur06WOs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-dKdBXNNvOFWv8lsKNhMBNw-1; Wed, 18 Mar 2020 18:27:21 -0400
X-MC-Unique: dKdBXNNvOFWv8lsKNhMBNw-1
Received: by mail-wm1-f72.google.com with SMTP id m4so259381wme.0
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 15:27:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7OXLwSpGiekWzMft0XJONWDDHi7E7bFIrtpeLbbH5Wc=;
 b=eUMHBDAHTe8tnm7PMRJDdqe93wyOeYr8dJ7qTD98E+Op+u8pVAety7v2ncOu3wrKg4
 A3QZEdPRoYSz+YJ3mnyAq4F78YusazsmgIPDx+gm5w+WDIEJ/YjP8xGomTY8d4jH/hA5
 Cv37mZx+yzzj6EsOK372d0fc4G5uY6vH9l/B8gHPrDiNaVugkDFAy/+13/hPHana66el
 n/WsbtumVGMcSmxY9bIDiURwex9TUe0fxmEUSZ+qIRon6FNRrCXsYfET0tQXhGr7cDoG
 bvYkfKODI1btrxc5OWnNzh9actLLVuwwo1oDnK9r7XBVp86M+h859XBnuYtMKC3OuX+g
 ajLw==
X-Gm-Message-State: ANhLgQ0zjTHythN7eKZRP5Yo0AmSFvFOx2VmJGdg8XDj8KHGNusWM+o3
 GPlkFov+2zJNZt+yoNe2BOGsWeV9VwQrg7x55iHIDeksh+lGQOFYI3B4IhJQDHbJjB9gb4Iltos
 CsfcdVx/aCsXNxBY=
X-Received: by 2002:adf:fe4c:: with SMTP id m12mr143887wrs.96.1584570440743;
 Wed, 18 Mar 2020 15:27:20 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuJ58SJVQHCgT0NLIy+pgzx5xBV4Jmab4RzyziaofYytvEjOYxpb5VDA25K4r2nEyrfcRGfiQ==
X-Received: by 2002:adf:fe4c:: with SMTP id m12mr143863wrs.96.1584570440537;
 Wed, 18 Mar 2020 15:27:20 -0700 (PDT)
Received: from localhost.localdomain (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id y189sm270706wmb.26.2020.03.18.15.27.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2020 15:27:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/4] travis-ci: Add a KVM-only s390x job
Date: Wed, 18 Mar 2020 23:27:13 +0100
Message-Id: <20200318222717.24676-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
 Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a Travis job to build a KVM-only QEMU on s390x.

This series also contains few fixes for Travis/s390x.

Since v1:
- Do not disable autoconverge on s390x, but reduce the test
  initial bandwidth (dgilbert)
- Added danpb R-b tags

Philippe Mathieu-Daud=C3=A9 (4):
  tests/test-util-filemonitor: Fix Travis-CI $ARCH env variable name
  tests/test-util-sockets: Skip test on non-x86 Travis containers
  tests/migration: Reduce autoconverge initial bandwidth
  .travis.yml: Add a KVM-only s390x job

 tests/qtest/migration-test.c  |  2 +-
 tests/test-util-filemonitor.c |  2 +-
 tests/test-util-sockets.c     |  7 ++++++
 .travis.yml                   | 42 +++++++++++++++++++++++++++++++++++
 4 files changed, 51 insertions(+), 2 deletions(-)

--=20
2.21.1


