Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F65BC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 02:11:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA8D122255
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 02:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JTE8ENCv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA8D122255
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQhsN-0001uF-QR
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 22:11:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kQhon-00064j-Of
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 22:07:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22969)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kQhof-0006sH-PW
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 22:07:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602209248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=s9m3+R8yE7Y80bW6r260IfS4ye1Ft7F4+DbPcRAR138=;
 b=JTE8ENCvpfFvXeuh6yUVz7cn4Udc2b6MBZysoFuVYyZEpTSbkquAWqhZsFdgR7rOh8qnWI
 mETt/MSW5ojH+sRn5GaayCEH4lErsh7ffJsEIph41rfOvXrsCwT3mYE4k5VNWQLvyrB/nk
 8mOu0njq4mTV3hQ/2IDScpB7W7+T0+k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-F6cZ4JNzM420kb1esaUhgg-1; Thu, 08 Oct 2020 22:07:20 -0400
X-MC-Unique: F6cZ4JNzM420kb1esaUhgg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE06B18C5201;
 Fri,  9 Oct 2020 02:07:18 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-14.phx2.redhat.com [10.3.113.14])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5756876651;
 Fri,  9 Oct 2020 02:07:15 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/6] Exposing backing-chain allocation over NBD
Date: Thu,  8 Oct 2020 21:07:08 -0500
Message-Id: <20201009020714.1074061-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 22:07:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, vsementsov@virtuozzo.com,
 rjones@redhat.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v2 was here:
https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg10926.html

Since then:
rebase to master
patches 1-3/5 of v2 are in pull request
patch 4/5 in v2 (1/6 here) includes improvements from Vladimir
patches 3-6/6 here are new (and I hope to have public patches to
libnbd's 'nbdinfo --map' to take advantage of it posted soon...)

Based-on: <20201008185951.1026052-1-eblake@redhat.com>
([PULL 0/8] NBD patches through 2020-10-08)

Also available at:
https://repo.or.cz/qemu/ericb.git/shortlog/refs/tags/nbd-alloc-depth-v3

001/6:[0056] [FC] 'nbd: Add new qemu:allocation-depth metacontext'
002/6:[0002] [FC] 'nbd: Add 'qemu-nbd -A' to expose allocation depth'
003/6:[down] 'nbd: Update qapi to support multiple bitmaps'
004/6:[down] 'nbd: Simplify qemu bitmap context name'
005/6:[down] 'nbd: Refactor counting of meta contexts'
006/6:[down] 'nbd: Allow export of multiple bitmaps for one device'

Eric Blake (6):
  nbd: Add new qemu:allocation-depth metacontext
  nbd: Add 'qemu-nbd -A' to expose allocation depth
  nbd: Update qapi to support multiple bitmaps
  nbd: Simplify qemu bitmap context name
  nbd: Refactor counting of meta contexts
  nbd: Allow export of multiple bitmaps for one device

 docs/interop/nbd.txt       |  23 +++-
 docs/tools/qemu-nbd.rst    |   6 ++
 qapi/block-core.json       |   7 +-
 qapi/block-export.json     |  20 +++-
 include/block/nbd.h        |   8 +-
 blockdev-nbd.c             |  20 +++-
 nbd/server.c               | 210 +++++++++++++++++++++++++++++--------
 qemu-nbd.c                 |  25 +++--
 tests/qemu-iotests/291     |   6 +-
 tests/qemu-iotests/309     |  73 +++++++++++++
 tests/qemu-iotests/309.out |  22 ++++
 tests/qemu-iotests/group   |   1 +
 12 files changed, 350 insertions(+), 71 deletions(-)
 create mode 100755 tests/qemu-iotests/309
 create mode 100644 tests/qemu-iotests/309.out

-- 
2.28.0


