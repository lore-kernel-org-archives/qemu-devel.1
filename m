Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4B4C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 21:57:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B03620758
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 21:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QmMnnrkd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B03620758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDalH-000562-9y
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 17:57:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kDahq-0007tN-0e
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 17:54:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40301)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kDahn-0002a2-U6
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 17:54:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599083646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=kWWDH7OdgAYf9se9YGWChk0FkwyvlqfueUIFnEfWhK4=;
 b=QmMnnrkd60BFtYE4LMhz2TwsWtyeuZiLLf/KENpprvujtxZB2GVBUnBgXd02MMnx82uPM5
 GLSWEwL90BWsbTopIHxy0Bi/zzr4OQixGk+c+xQ5GdKHFtmRmecpEr219+GwJBN0UuSWsd
 eBeKHkxq0KfY+gJsyjxmCupKRNa8IwQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-577-6YUD4EMZP_qv2W9F0Xi2UA-1; Wed, 02 Sep 2020 17:54:03 -0400
X-MC-Unique: 6YUD4EMZP_qv2W9F0Xi2UA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39B7E1009444
 for <qemu-devel@nongnu.org>; Wed,  2 Sep 2020 21:54:02 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-128.phx2.redhat.com [10.3.113.128])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0633E76E01
 for <qemu-devel@nongnu.org>; Wed,  2 Sep 2020 21:54:01 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/6] NBD patches for 2020-09-02
Date: Wed,  2 Sep 2020 16:53:54 -0500
Message-Id: <20200902215400.2673028-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 17:54:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit ed215cec0fcaeaece064b0fdf37fe3bceb06d76c:

  Merge remote-tracking branch 'remotes/ehabkost/tags/machine-next-pull-request' into staging (2020-09-02 15:26:38 +0100)

are available in the Git repository at:

  https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2020-09-02

for you to fetch changes up to eb705985f43d631438a318f1146eac61ae10d273:

  nbd: disable signals and forking on Windows builds (2020-09-02 16:48:21 -0500)

----------------------------------------------------------------
nbd patches for 2020-09-02

- fix a few iotests affected by earlier nbd changes
- avoid blocking qemu by nbd client in connect()
- build qemu-nbd for mingw

----------------------------------------------------------------
Daniel P. Berrangé (3):
      block: add missing socket_init() calls to tools
      nbd: skip SIGTERM handler if NBD device support is not built
      nbd: disable signals and forking on Windows builds

Max Reitz (2):
      iotests/059: Fix reference output
      iotests/259: Fix reference output

Vladimir Sementsov-Ogievskiy (1):
      block/nbd: use non-blocking connect: fix vm hang on connect()

 block/nbd.c                | 266 ++++++++++++++++++++++++++++++++++++++++++++-
 qemu-img.c                 |   2 +
 qemu-io.c                  |   2 +
 qemu-nbd.c                 |  11 +-
 meson.build                |   7 +-
 tests/qemu-iotests/059.out |   2 +-
 tests/qemu-iotests/259.out |   2 +-
 7 files changed, 283 insertions(+), 9 deletions(-)

-- 
2.28.0


