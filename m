Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4685CC4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 16:19:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61D142086A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 16:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lhep2vt5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61D142086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKl0f-000292-38
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 12:19:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kKkyE-00007f-6Z
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 12:16:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48315)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kKky8-0007yt-1K
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 12:16:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600791395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=806M/jjEM46kANdA6MteTpW8vJ4CyAjesuhqnvJIMlk=;
 b=Lhep2vt52Hwy82KsbsUYRTMBZ2XJDGZTH3wKWmywN/xvDMvU2cngL8055iqlCFDP72GjRI
 aiviiFJKMJLv9CYZ5Uq4bBlygDAPPgSfiw7tCgepCdNUQQ3Uouy1l60FMNbbNIFMgDaEeS
 CjlrcyUOCSi9HlxWpOXmpVXZ+cOf4v8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-565-yMhjd3zROEC3tNOLrh5LyA-1; Tue, 22 Sep 2020 12:16:19 -0400
X-MC-Unique: yMhjd3zROEC3tNOLrh5LyA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AAE0118B9EC1;
 Tue, 22 Sep 2020 16:16:17 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-114-64.ams2.redhat.com
 [10.36.114.64])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4ACB7614F5;
 Tue, 22 Sep 2020 16:16:12 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/2] block: deprecate the sheepdog driver
Date: Tue, 22 Sep 2020 17:16:09 +0100
Message-Id: <20200922161611.2049616-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 00:31:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 sheepdog@lists.wpkg.org, qemu-block@nongnu.org, libvir-list@redhat.com,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Liu Yuan <namei.unix@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

2 years back I proposed dropping the sheepdog mailing list from the=0D
MAINTAINERS file, but somehow the patch never got picked up:=0D
=0D
  https://lists.gnu.org/archive/html/qemu-block/2018-03/msg01048.html=0D
=0D
So here I am with the same patch again.=0D
=0D
This time I go further and deprecate the sheepdog driver entirely.=0D
See the rationale in the second patch commit message.=0D
=0D
Daniel P. Berrang=C3=A9 (2):=0D
  block: drop moderated sheepdog mailing list from MAINTAINERS file=0D
  block: deprecate the sheepdog block driver=0D
=0D
 MAINTAINERS                |  1 -=0D
 block/sheepdog.c           | 15 +++++++++++++++=0D
 configure                  |  5 +++--=0D
 docs/system/deprecated.rst |  9 +++++++++=0D
 4 files changed, 27 insertions(+), 3 deletions(-)=0D
=0D
--=20=0D
2.26.2=0D
=0D


