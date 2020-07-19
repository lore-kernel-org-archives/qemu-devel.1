Return-Path: <SRS0=x6dg=A6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC919C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2020 12:22:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1B5922B4D
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2020 12:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nv0VLMc2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1B5922B4D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jx8Kc-0006Nw-PL
	for qemu-devel@archiver.kernel.org; Sun, 19 Jul 2020 08:22:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41010)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jx8Je-0005Nx-UG
 for qemu-devel@nongnu.org; Sun, 19 Jul 2020 08:21:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53193
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jx8Ja-0006YR-Gh
 for qemu-devel@nongnu.org; Sun, 19 Jul 2020 08:21:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595161266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8lwNYnUQPTalzoGTj1+5WQ+13m/BHPVqpPqSHb3Lo1Y=;
 b=Nv0VLMc2HCe4K5spzsuiG4ttqNX1TO03n92ajiiioIuLiXVhbUChcVxY8RLI/CcMfBUZIN
 Tb8h2wpzY+MgHhyV6jS/zbTozZ8rhcGm8LNIQfRbjOzbCGMQnMlB5aCKh9CkDWhqiNlFhz
 AUDPupnZsyeCob5LiHkFwsC0qmdMq1s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-C-odP1sMNSWpe2YDI6cKLw-1; Sun, 19 Jul 2020 08:21:03 -0400
X-MC-Unique: C-odP1sMNSWpe2YDI6cKLw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E12F9100AA21;
 Sun, 19 Jul 2020 12:21:02 +0000 (UTC)
Received: from starship.redhat.com (unknown [10.35.206.208])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 676A25D9CC;
 Sun, 19 Jul 2020 12:21:00 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] Fix for write sharing on luks raw images
Date: Sun, 19 Jul 2020 15:20:57 +0300
Message-Id: <20200719122059.59843-1-mlevitsk@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlevitsk@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/19 08:21:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A rebase gone wrong, and I ended up allowing a luks image=0D
to be opened at the same time by two VMs without any warnings/overrides.=0D
=0D
Fix that and also add an iotest to prevent this from happening.=0D
=0D
Best regards,=0D
=09Maxim Levisky=0D
=0D
Maxim Levitsky (2):=0D
  block/crypto: disallow write sharing by default=0D
  qemu-iotests: add testcase for bz #1857490=0D
=0D
 block/crypto.c             |  2 +-=0D
 tests/qemu-iotests/296     | 44 +++++++++++++++++++++++++++++++++++++-=0D
 tests/qemu-iotests/296.out | 12 +++++++++--=0D
 3 files changed, 54 insertions(+), 4 deletions(-)=0D
=0D
--=20=0D
2.26.2=0D
=0D


