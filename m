Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8ADCC433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 21:57:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58AB72087D
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 21:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HJBrolgn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58AB72087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kR0OJ-0004Pz-0D
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 17:57:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kR0Md-0002jD-FH
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 17:55:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58041)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kR0MZ-0003Nu-Va
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 17:55:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602280542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=RyXmoZ+3zKntTK+dxAjU0XNIj+FmzBzD7B9cgMF9cnM=;
 b=HJBrolgnJYEEcdOUWMeMd1s+aHecAyiDCqyk1H5iBggkms90y+Q+XIzpyZOLmeUy7PZ4tk
 yCzpmSVIpB8G2mtiKRZ+4FdIMvCOhYXCTTq3qqXUJSUzR8cnyg9Q+YcILzrNgPhB2miAYa
 2OqlRfvw/DaqlcGQ9JmZ/Xn6XsS2AxQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-jLwE9jWeOVSK7OPn_XZkeQ-1; Fri, 09 Oct 2020 17:55:38 -0400
X-MC-Unique: jLwE9jWeOVSK7OPn_XZkeQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5DF00805EFB;
 Fri,  9 Oct 2020 21:55:37 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-14.phx2.redhat.com [10.3.113.14])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EF6B910013C4;
 Fri,  9 Oct 2020 21:55:33 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 0/7] Exposing backing-chain allocation over NBD
Date: Fri,  9 Oct 2020 16:55:26 -0500
Message-Id: <20201009215533.1194742-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, vsementsov@virtuozzo.com,
 rjones@redhat.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v3 was here:
https://lists.gnu.org/archive/html/qemu-devel/2020-10/msg02305.html

Since then:
rebase to master
- patch 1 is new, fixing a theoretical bug in QAPI interaction and
 simplifying later patches
- patch 2, 4, and 6 are renamed to favor the term 'metadata context'
 [Markus], sadly 'git backport-diff' can't see through renames

Based-on: <20201009200720.1169904-1-eblake@redhat.com>
([PULL v3 0/8] NBD patches through 2020-10-08)

Also available at:
https://repo.or.cz/qemu/ericb.git/shortlog/refs/tags/nbd-alloc-depth-v4

001/7:[down] 'nbd: Utilize QAPI_CLONE for type conversion'
002/7:[down] 'nbd: Add new qemu:allocation-depth metadata context'
003/7:[0042] [FC] 'nbd: Add 'qemu-nbd -A' to expose allocation depth'
004/7:[down] 'nbd: Update qapi to support exporting multiple bitmaps'
005/7:[----] [-C] 'nbd: Simplify qemu bitmap context name'
006/7:[down] 'nbd: Refactor counting of metadata contexts'
007/7:[----] [-C] 'nbd: Allow export of multiple bitmaps for one device'

Eric Blake (7):
  nbd: Utilize QAPI_CLONE for type conversion
  nbd: Add new qemu:allocation-depth metadata context
  nbd: Add 'qemu-nbd -A' to expose allocation depth
  nbd: Update qapi to support exporting multiple bitmaps
  nbd: Simplify qemu bitmap context name
  nbd: Refactor counting of metadata contexts
  nbd: Allow export of multiple bitmaps for one device

 docs/interop/nbd.txt       |  27 ++++-
 docs/tools/qemu-nbd.rst    |   8 +-
 qapi/block-core.json       |   7 +-
 qapi/block-export.json     |  22 +++-
 include/block/nbd.h        |  12 ++-
 blockdev-nbd.c             |  29 +++--
 nbd/server.c               | 210 +++++++++++++++++++++++++++++--------
 qemu-nbd.c                 |  33 ++++--
 tests/qemu-iotests/291     |   6 +-
 tests/qemu-iotests/309     |  73 +++++++++++++
 tests/qemu-iotests/309.out |  22 ++++
 tests/qemu-iotests/group   |   1 +
 12 files changed, 364 insertions(+), 86 deletions(-)
 create mode 100755 tests/qemu-iotests/309
 create mode 100644 tests/qemu-iotests/309.out

-- 
2.28.0


