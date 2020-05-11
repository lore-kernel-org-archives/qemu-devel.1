Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40FBCC47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 16:38:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CF0E20643
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 16:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cuO7Of0W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CF0E20643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYBS1-00022O-6g
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 12:38:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54686)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jYBPj-00073U-Rf
 for qemu-devel@nongnu.org; Mon, 11 May 2020 12:36:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58795
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jYBPj-0000i8-1v
 for qemu-devel@nongnu.org; Mon, 11 May 2020 12:36:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589214981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Wr1dJLH/HJ+IjgVPORoKsIFDuC53/7po0J0O62kdasg=;
 b=cuO7Of0WCSu/ABTqb3X60CGwm5FOqhwmkHNRuaaogJnqiYWhJIjAqQMJxXgX7iirwqYwaA
 Dy3S4FgTRvKW1sclquQb7WyZp9zi7zDkCYdqzn4hvGT/CAd33GrO9z6Ql2zOx0V1BB/sCq
 wDFCw6VBfrEPUUZFa0iqGtSWc6VB7oU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-1kG8jKLwOC6o6VFu-zlhkA-1; Mon, 11 May 2020 12:36:20 -0400
X-MC-Unique: 1kG8jKLwOC6o6VFu-zlhkA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B20BB190C420;
 Mon, 11 May 2020 16:35:39 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-142.ams2.redhat.com
 [10.36.114.142])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8C2CD5C1B5;
 Mon, 11 May 2020 16:35:38 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 0/2] iotests: Run pylint and mypy in a testcase
Date: Mon, 11 May 2020 18:35:27 +0200
Message-Id: <20200511163529.349329-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 00:05:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf (2):
  iotests: Fix incomplete type declarations
  iotests: Run pylint and mypy in a testcase

 tests/qemu-iotests/iotests.py |  8 +++----
 tests/qemu-iotests/297        | 44 +++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/297.out    |  3 +++
 tests/qemu-iotests/group      |  1 +
 4 files changed, 52 insertions(+), 4 deletions(-)
 create mode 100755 tests/qemu-iotests/297
 create mode 100644 tests/qemu-iotests/297.out

-- 
2.25.3


