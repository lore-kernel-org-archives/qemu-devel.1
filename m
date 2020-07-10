Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB18C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 14:23:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3461320674
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 14:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BGRWeUyp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3461320674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jttvY-0003fh-Df
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 10:23:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41052)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jttuf-0002oe-Hp
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 10:22:05 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25993
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jttuc-0004LC-Vr
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 10:22:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594390922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=99QFaw1l6HqyUAdmvjoy+gwEG2Pi01A2xPelU2cgk9w=;
 b=BGRWeUypUNlYE5OOLX8cX6GJo99cHluqAwuaDSRAb8pOv7HO83Z+yhND/K5huWhD2Jn+tz
 Fj8RGXdmZw1ls4ic2QojIHArxkBtQ20UX+96sv1BjM6+HrNDRGm5iB3UuOCGu0TTtgY2+H
 8Uvu943mE+Nc6jFXaTzmaY8N1kI6QhE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-ds-KGuqJM-Wr8xxcCTPGjw-1; Fri, 10 Jul 2020 10:21:59 -0400
X-MC-Unique: ds-KGuqJM-Wr8xxcCTPGjw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2EFBD802815;
 Fri, 10 Jul 2020 14:21:58 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-57.ams2.redhat.com [10.36.114.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B658560C05;
 Fri, 10 Jul 2020 14:21:55 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-5.1 0/2] qemu-img convert: Fix abort with unaligned image
 size
Date: Fri, 10 Jul 2020 16:21:47 +0200
Message-Id: <20200710142149.40962-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 23:35:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: kwolf@redhat.com, nsoffer@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1834646

Patch 1 fixes the assertion failure by failing gracefully when opening
an image whose size isn't aligned to the required request alignment.

Patch 2 relaxes the restrictions for NFS, which actually supports byte
alignment, but incorrectly gets a 4k request alignment in the file-posix
block driver.

Kevin Wolf (2):
  block: Require aligned image size to avoid assertion failure
  file-posix: Allow byte-aligned O_DIRECT with NFS

 block.c            | 10 ++++++++++
 block/file-posix.c | 26 +++++++++++++++++++++++++-
 2 files changed, 35 insertions(+), 1 deletion(-)

-- 
2.25.4


