Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357EDC4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 12:47:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FE5C20789
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 12:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HN+/e2yL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FE5C20789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNbWR-0007PE-Ak
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 08:47:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51062)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kNbUp-0005wf-UP
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 08:46:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28600)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kNbUo-0001AB-9y
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 08:46:11 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601469968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ew6AVuU1qrxq3Xvj3vDsOtrOvY1C9V98pjmXX2m0Bv8=;
 b=HN+/e2yLGOzLX5NfzzNCCp02iqrqyieqHCuCFbRYs9C3qFL4O1ewqlTDdggtz9ddQRfrd9
 rR/rTi0fn2bPo+MKM4I3NAeK9tbL7aj/Bde5E6VSIueZ9+g7v5fpHytymYt0RM5O9WxoNJ
 hoN9cJhp3U3fdBci8SX3SMUfByADXxE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-p3vKRBdPPROSoM2e0DdQzg-1; Wed, 30 Sep 2020 08:46:06 -0400
X-MC-Unique: p3vKRBdPPROSoM2e0DdQzg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E61741084D68;
 Wed, 30 Sep 2020 12:46:05 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-128.ams2.redhat.com
 [10.36.113.128])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A7D0A60C05;
 Wed, 30 Sep 2020 12:46:04 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 0/4] qemu-storage-daemon: Remove QemuOpts from --object
 parser
Date: Wed, 30 Sep 2020 14:45:53 +0200
Message-Id: <20200930124557.51835-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:31:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This replaces the QemuOpts-based help code for --object in the storage
daemon with code based on the keyval parser.

v2:
- Fixed double comma by reusing the existing key and value parsers [Eric]
- More tests to cover the additional cases

Kevin Wolf (4):
  keyval: Parse help options
  qom: Factor out helpers from user_creatable_print_help()
  qom: Add user_creatable_print_help_from_qdict()
  qemu-storage-daemon: Remove QemuOpts from --object parser

 include/qemu/option.h                |   2 +-
 include/qom/object_interfaces.h      |   9 ++
 qapi/qobject-input-visitor.c         |   2 +-
 qom/object_interfaces.c              |  99 ++++++++-----
 storage-daemon/qemu-storage-daemon.c |  15 +-
 tests/test-keyval.c                  | 205 +++++++++++++++++++--------
 util/keyval.c                        |  38 ++++-
 7 files changed, 252 insertions(+), 118 deletions(-)

-- 
2.25.4


