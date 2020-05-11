Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187C7C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 13:59:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3F8120708
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 13:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a6ujwtn5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3F8120708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY8yG-0002GX-2D
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 09:59:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jY8xJ-0000xo-Qc
 for qemu-devel@nongnu.org; Mon, 11 May 2020 09:58:53 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58087
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jY8xI-0000Jy-Ez
 for qemu-devel@nongnu.org; Mon, 11 May 2020 09:58:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589205531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XdHiia3KxGAMqcXQAV7JebsiSz6RnEHY8s3hOsCOGUI=;
 b=a6ujwtn5xWRfRiTsgIwOLxqDZBCIp3nBlFT8qqZ/OPUWR5l4Ik2s6Pc6TsF4hVdvPAJq+3
 iksLdBH+O6gpsU4oUnVG3OdhM3d9eOj2rKDKM+rJePa+rpYPPGwVVXAqdzSSzUUmOIrzkR
 RQZXMs0+cADiMs1auCgxu//R4WX8s6I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-uQZW9RP-MpeWGB9oLIPqrw-1; Mon, 11 May 2020 09:58:46 -0400
X-MC-Unique: uQZW9RP-MpeWGB9oLIPqrw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D6207BBA;
 Mon, 11 May 2020 13:58:45 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-142.ams2.redhat.com
 [10.36.114.142])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BDE2B1002382;
 Mon, 11 May 2020 13:58:43 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 0/4] mirror: Make sure that source and target size match
Date: Mon, 11 May 2020 15:58:21 +0200
Message-Id: <20200511135825.219437-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 03:10:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, jsnow@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Same thing as the recent fix for backup, except that mirror already
forbids resizing during the job. So what remains is checking that the
sizes match at the start of the job.

v2:
- Added patch 1 to fix a test that used different source/target size

Kevin Wolf (4):
  iotests/109: Don't mirror with mismatched size
  iotests/229: Use blkdebug to inject an error
  mirror: Make sure that source and target size match
  iotests: Mirror with different source/target size

 block/mirror.c                   | 21 +++++----
 tests/qemu-iotests/041           | 45 +++++++++++++++++++
 tests/qemu-iotests/041.out       |  4 +-
 tests/qemu-iotests/109           | 10 ++---
 tests/qemu-iotests/109.out       | 74 +++++++++++++-------------------
 tests/qemu-iotests/229           | 15 +++++--
 tests/qemu-iotests/229.out       |  6 +--
 tests/qemu-iotests/common.filter |  5 +++
 8 files changed, 114 insertions(+), 66 deletions(-)

-- 
2.25.3


