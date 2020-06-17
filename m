Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B26C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 10:53:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53A5720DD4
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 10:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XaB+J7nu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53A5720DD4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlVhD-0005Me-IY
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 06:53:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59788)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jlVcN-0006GF-Dh
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 06:48:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29377
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jlVcL-0002rh-Ku
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 06:48:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592390908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=em2jn7SZRS6IW3/zeKNoyC1BJqjaUeC1MdlOqZQ9DSE=;
 b=XaB+J7nuqM8/h9A3UnCq12RtQjh4t2MC9JFMKlid9XxRSz+Ptk2ocCXP0VagtQ/7ev/0c8
 zytSmTyeWQPzlPgFVjZuZjeZi9L5hNwfRn2NGxTuOar8XUECXykxfBZnPHlo1kls81lY4P
 /YCXdfhifgzTy2gLSaCYM/nAf6IuRGY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-B21Ukk18M-q8lzVe2c6pHw-1; Wed, 17 Jun 2020 06:48:25 -0400
X-MC-Unique: B21Ukk18M-q8lzVe2c6pHw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2002B80F5DA;
 Wed, 17 Jun 2020 10:48:24 +0000 (UTC)
Received: from localhost (ovpn-113-111.ams2.redhat.com [10.36.113.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B64D278911;
 Wed, 17 Jun 2020 10:48:23 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 0/5] iotests: Some fixes for rarely run cases
Date: Wed, 17 Jun 2020 12:48:17 +0200
Message-Id: <20200617104822.27525-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 23:30:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

Thomas’s report
(https://lists.nongnu.org/archive/html/qemu-block/2020-06/msg00791.html)
has given me a nice excuse to write this series.

There are some iotests that have recently start to fail in rarely
exercised test environments (qed, qcow2 with data_file, qcow2 v2), and
this series fixes what I found.


Max Reitz (5):
  iotests.py: Add skip_for_formats() decorator
  iotests/041: Skip test_small_target for qed
  iotests/292: data_file is unsupported
  iotests/229: data_file is unsupported
  iotests/{190,291}: compat=0.10 is unsupported

 tests/qemu-iotests/041        |  2 ++
 tests/qemu-iotests/118        |  7 +++----
 tests/qemu-iotests/190        |  2 ++
 tests/qemu-iotests/229        |  3 +++
 tests/qemu-iotests/291        |  2 ++
 tests/qemu-iotests/292        |  5 +++++
 tests/qemu-iotests/iotests.py | 13 +++++++++++++
 7 files changed, 30 insertions(+), 4 deletions(-)

-- 
2.26.2


