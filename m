Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD01C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 02:49:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBFE2206F0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 02:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="epYo+DGB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBFE2206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iV5Bs-0006cY-DR
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 21:49:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60297)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iV59f-0005A1-Dz
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 21:46:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iV59c-0002py-Ch
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 21:46:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39050
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iV59b-0002oj-Tf
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 21:46:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573699599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bpTgZxaxACHxNFPURZAXwSbyM0VOXrAz9DIYXcFoA0E=;
 b=epYo+DGBQjyl4hw2N2hzS8+eg8L5XCTU/q+NJb/UmfhPijREo2AFG+gRaUUY5v6yFHwnU+
 yBU8m0HrXrzSjgOok1VNDmNcTTJQjNVMQKzx1MxIm7hT+g15HBPHosot6wiRt26cMP943Q
 BbgJSsc74rPRDBLpnvodlKE31/H2Lmk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-tkqVGSTkM0qU941Rnn69wQ-1; Wed, 13 Nov 2019 21:46:37 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D6AFDB61;
 Thu, 14 Nov 2019 02:46:36 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-242.phx2.redhat.com [10.3.116.242])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D51F981759;
 Thu, 14 Nov 2019 02:46:35 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 for-4.2 0/4] Better NBD string length handling
Date: Wed, 13 Nov 2019 20:46:31 -0600
Message-Id: <20191114024635.11363-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: tkqVGSTkM0qU941Rnn69wQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: vsementsov@virtuozzo.com, qemu-block@nongnu.org, mlevitsk@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series was originally posted before soft freeze, but then KVM
Forum interfered. I think that patches 1-3 are bug fixes still
appropriate for -rc2 if they get good reviews, but patch 4 is a new
feature and now only appropriate for 5.0.

Since v2:
- Patch 1, 2: new [Vladimir]
- Patch 3: improve error messages and fix a memleak [Vladimir]
- Patch 3: bump name length from 256 to 4k (R-b dropped)
- Patch 4: add R-b, but tweak to defer to 5.0

Eric Blake (4):
  nbd/server: Prefer heap over stack for parsing client names
  bitmap: Enforce maximum bitmap name length
  nbd: Don't send oversize strings
  nbd: Allow description when creating NBD blockdev

 qapi/block-core.json         |  2 +-
 qapi/block.json              |  9 +++++---
 include/block/dirty-bitmap.h |  2 ++
 include/block/nbd.h          | 12 +++++-----
 block/dirty-bitmap.c         | 12 +++++++---
 block/nbd.c                  | 10 +++++++++
 block/qcow2-bitmap.c         |  2 ++
 blockdev-nbd.c               | 14 +++++++++++-
 monitor/hmp-cmds.c           |  4 ++--
 nbd/client.c                 | 18 ++++++++++++---
 nbd/server.c                 | 43 ++++++++++++++++++++++++------------
 qemu-nbd.c                   |  9 ++++++++
 tests/qemu-iotests/223       |  2 +-
 tests/qemu-iotests/223.out   |  1 +
 14 files changed, 106 insertions(+), 34 deletions(-)

--=20
2.21.0


