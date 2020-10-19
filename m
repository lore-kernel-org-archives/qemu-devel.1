Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840EFC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 16:40:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2CB321D81
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 16:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fCNLLQ/x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2CB321D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUYCm-0004jB-MA
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 12:40:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34450)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1kUY9v-0001go-1P
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 12:37:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28067)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1kUY9s-0006E6-RA
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 12:37:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603125433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=X8E/KM0mtklf+p626VqlC8I3RPcRzt2S/nbwzM5B67k=;
 b=fCNLLQ/xg8bgyjJLQ1bRYgoG30eP98DlDojMp/yEGkDQWJYgCnHT1ZzFFD/QGEgnR3Lk8B
 3y89IRtfVjIiuVvu9IteFBeMT/cQXW7qmtPu/mWfk2ENMKNaJa9saY/s1zf+YLnJKmeAtB
 E4FPSTjmBkzf/XMiA2LhwseffrmfMig=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-Y62x-3RENw-kAy363_nKdQ-1; Mon, 19 Oct 2020 12:37:11 -0400
X-MC-Unique: Y62x-3RENw-kAy363_nKdQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE2298049C1;
 Mon, 19 Oct 2020 16:37:10 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.35.206.118])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B65355B4B4;
 Mon, 19 Oct 2020 16:37:03 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/4] Assorted fixes to tests that were broken by recent scsi
 changes
Date: Mon, 19 Oct 2020 19:36:58 +0300
Message-Id: <20201019163702.471239-1-mlevitsk@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlevitsk@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 02:32:01
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Just few fixes, for some stuff that slipped thorough.=0D
=0D
Tested with make check, and qcow2/raw/nbd iotests.=0D
=0D
Best regards,=0D
=09Maxim Levitsky=0D
=0D
Maxim Levitsky (4):=0D
  qdev: Fix two typos=0D
  libqtest: fix the order of buffered events=0D
  libqtest: fix memory leak in the qtest_qmp_event_ref=0D
  iotests: rewrite iotest 240 in python=0D
=0D
 include/hw/qdev-core.h     |   4 +-=0D
 tests/qemu-iotests/240     | 228 ++++++++++++++++---------------------=0D
 tests/qemu-iotests/240.out |  76 ++++++++-----=0D
 tests/qtest/libqtest.c     |  13 +--=0D
 4 files changed, 150 insertions(+), 171 deletions(-)=0D
=0D
--=20=0D
2.26.2=0D
=0D


