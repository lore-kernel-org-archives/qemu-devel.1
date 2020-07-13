Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA294C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:34:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5AFC2065F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CuHZfhAv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5AFC2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juzX9-00025m-U3
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 10:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1juzKm-00079D-Oe
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:21:32 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26129
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1juzKl-00086b-1g
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:21:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594650090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=TMe58Q1Gt6tVW7PMBF/pfLOWo2f+zU7CJQAW/uywFPM=;
 b=CuHZfhAvgf3j1mO3QvFoD1Ifw5kxYgpdL7usJYDjmDx0w6HNA9f9foEnndR6o7AqouzK56
 4X1JEKPT1BX0XFM72C7buXAAwcNWGCah1wyyh4QIgbTmQQS6/DPDG8hPaTr5P7SMSFHpBO
 a9h6ASQXSlAjBDyEuzDPMG4Gq3p2OPQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-L0G3KfE3NXyfU-7FVGIBaw-1; Mon, 13 Jul 2020 10:21:09 -0400
X-MC-Unique: L0G3KfE3NXyfU-7FVGIBaw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A81921086
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 14:21:08 +0000 (UTC)
Received: from blue.redhat.com (ovpn-112-134.phx2.redhat.com [10.3.112.134])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 813A07621E
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 14:21:08 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/5] NBD patches for 2020-07-13
Date: Mon, 13 Jul 2020 09:21:01 -0500
Message-Id: <20200713142106.261809-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 01:36:29
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 00ce6c36b35e0eb8cc5d68a28f288a6335848813:

  Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2020-07-13' into staging (2020-07-13 13:01:30 +0100)

are available in the Git repository at:

  https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2020-07-13

for you to fetch changes up to df0e032b6196934b2b12180a6a05aa8b7e6553fc:

  iotests.py: filter_testfiles(): filter SOCK_DIR too (2020-07-13 09:01:01 -0500)

Patch 2 is a trivial patch that isn't really NBD-related, but which
has been overlooked for too long now, so I just included it.

----------------------------------------------------------------
NBD patches for 2020-07-13

- fix off-by-one truncation in corner-case name display
- use fcntl correctly
- iotest cleanups that enable testing an upcoming fix for NBD close

----------------------------------------------------------------
Eric Blake (2):
      nbd: Avoid off-by-one in long export name truncation
      hax: Fix setting of FD_CLOEXEC

Vladimir Sementsov-Ogievskiy (3):
      iotests: QemuIoInteractive: use qemu_io_args_no_fmt
      iotests.py: QemuIoInteractive: print output on failure
      iotests.py: filter_testfiles(): filter SOCK_DIR too

 block/nbd.c                   |  2 +-
 target/i386/hax-posix.c       |  6 +++---
 tests/qemu-iotests/iotests.py | 15 +++++++++++----
 3 files changed, 15 insertions(+), 8 deletions(-)

-- 
2.27.0


