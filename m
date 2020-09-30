Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD51EC4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 12:13:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AA55206B7
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 12:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BX06dFKB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AA55206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNaz1-0005J5-21
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 08:13:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kNax9-0003go-UC
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 08:11:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21705)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kNax7-000794-KB
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 08:11:23 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601467880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4vUYn/hOJUbDOrjDYcsv5gNe9C0e31VTBO1mpJqtXD4=;
 b=BX06dFKBpL8ZERrSOSG8UQht6Zn5GelMPqz1Uaf40mIO8bhd+f1lbhNDg8a6lIyeyetuy6
 EbR7EE6R/+oAXsDHcwLV2xURz/sbrmuWy1c/SuUyNEReCRbOw88WyMuj7WuE2XiM4yYwn9
 Pb+SP3wtv94GEIZ8zFzxcC6mvS0CYLI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-jGYXNZ5OPz2zKZGlSAy6QQ-1; Wed, 30 Sep 2020 08:11:13 -0400
X-MC-Unique: jGYXNZ5OPz2zKZGlSAy6QQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83D7B8015B0;
 Wed, 30 Sep 2020 12:11:12 +0000 (UTC)
Received: from blue.redhat.com (ovpn-112-208.phx2.redhat.com [10.3.112.208])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2613260C05;
 Wed, 30 Sep 2020 12:11:06 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/5] Exposing backing-chain allocation over NBD
Date: Wed, 30 Sep 2020 07:11:00 -0500
Message-Id: <20200930121105.667049-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eblake@redhat.com;
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org,
 rjones@redhat.com, vsementsov@virtuozzo.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v1 was here: https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg09623.htm
l

Based-on: <20200924152717.287415-1-kwolf@redhat.com>
(block/export: Add infrastructure and QAPI for block exports)

Also available at:
https://repo.or.cz/qemu/ericb.git/shortlog/refs/tags/nbd-alloc-depth-v2

Since then:
- rebase on Kevin's work
- add new patch to fix qemu-nbd SIGINT (conflicts with Stefan's work,
we can either rebase his on mine or drop mine if his goes in first)
- split out fix for handling NUL bytes from client [Vladimir]
- further cleanups of query parsing [Vladimir]
- more documentation of how we could also expose actual depth in
remaining bits of the context reply [Rich]

001/5:[down] 'qemu-nbd: Honor SIGINT and SIGHUP'
002/5:[down] 'nbd/server: Reject embedded NUL in NBD strings'
003/5:[0139] [FC] 'nbd: Simplify meta-context parsing'
004/5:[0035] [FC] 'nbd: Add new qemu:allocation-depth metacontext'
005/5:[0038] [FC] 'nbd: Add 'qemu-nbd -A' to expose allocation depth'

Eric Blake (5):
  qemu-nbd: Honor SIGINT and SIGHUP
  nbd/server: Reject embedded NUL in NBD strings
  nbd: Simplify meta-context parsing
  nbd: Add new qemu:allocation-depth metacontext
  nbd: Add 'qemu-nbd -A' to expose allocation depth

 docs/interop/nbd.txt       |  22 ++-
 docs/tools/qemu-nbd.rst    |   6 +
 qapi/block-core.json       |   7 +-
 qapi/block-export.json     |   6 +-
 include/block/nbd.h        |   8 +-
 blockdev-nbd.c             |   2 +
 nbd/server.c               | 324 +++++++++++++++++++++----------------
 qemu-nbd.c                 |  20 ++-
 tests/qemu-iotests/309     |  73 +++++++++
 tests/qemu-iotests/309.out |  22 +++
 tests/qemu-iotests/group   |   1 +
 11 files changed, 342 insertions(+), 149 deletions(-)
 create mode 100755 tests/qemu-iotests/309
 create mode 100644 tests/qemu-iotests/309.out

-- 
2.28.0


