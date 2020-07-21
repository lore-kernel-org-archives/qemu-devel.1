Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F202CC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 15:49:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBFA020771
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 15:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UZxJ5QUc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBFA020771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxuVv-0006EL-On
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 11:49:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58174)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jxuTt-0004Xs-G5
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 11:47:03 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48337
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jxuTq-0001Km-Sn
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 11:47:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595346414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9JCpwFOYTvLOTTxAg8ixmO0b9zbd0DENRDj1HwK+XVY=;
 b=UZxJ5QUcMOMCWd3cRGHvyzFnSXEe+3ZIdo2acJeeCpVB8DjzGX6b+sE01Y3ckHPNPn8Ysf
 XsJl7nRfxEVvlK9lXXHPSYZ1K3nprEZm3n0lxQrXN0X10WNQ9sutaICh99I866O90HFWcL
 U3BrefJPkN5prxLd27a1rxw0OZnHKoA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-QW1lw428Nz-XZ1RJpCNVvg-1; Tue, 21 Jul 2020 11:46:48 -0400
X-MC-Unique: QW1lw428Nz-XZ1RJpCNVvg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 786F5100AA23;
 Tue, 21 Jul 2020 15:46:47 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-97.ams2.redhat.com [10.36.113.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 85FBD76216;
 Tue, 21 Jul 2020 15:46:46 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 0/3] Block layer patches for 5.1.0-rc1
Date: Tue, 21 Jul 2020 17:46:34 +0200
Message-Id: <20200721154637.220022-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 10:17:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 90218a9a393c7925f330e7dcc08658e2a01d3bd4:

  Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2020-07-21' into staging (2020-07-21 10:24:38 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 4a01e27ddcb5921efd68820d05d85ba71293fea6:

  iotests: Test sparseness for qemu-img convert -n (2020-07-21 17:44:35 +0200)

----------------------------------------------------------------
Block layer patches:

- file-posix: Handle `EINVAL` fallocate return value
- qemu-img convert -n: Keep qcow2 v2 target sparse

----------------------------------------------------------------
Antoine Damhet (1):
      file-posix: Handle `EINVAL` fallocate return value

Kevin Wolf (2):
      qcow2: Implement v2 zero writes with discard if possible
      iotests: Test sparseness for qemu-img convert -n

 block/file-posix.c         |  6 +++++-
 block/qcow2-cluster.c      |  9 ++++++++-
 tests/qemu-iotests/122     | 30 ++++++++++++++++++++++++++++++
 tests/qemu-iotests/122.out | 17 +++++++++++++++++
 4 files changed, 60 insertions(+), 2 deletions(-)


