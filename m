Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D20C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 17:44:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F2AF2074D
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 17:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iQFEH52J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F2AF2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGnbf-0007HZ-C8
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 13:44:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58701)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jGnZY-0004ZJ-Ps
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 13:42:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jGnZX-0007TP-Ki
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 13:42:40 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:55895)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jGnZX-0007TE-I2
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 13:42:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585071759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=d4arHiKOK7h4d/hUL8nq45J5Bn13zC8DtiqcRUXvtX0=;
 b=iQFEH52JBehHOLfNE92mv+on8OTzjDagOco4eGt4EtnfZYcs/Y4MmYQYpM9I8m5petdIvq
 kVKt7p7j32XYu1R5g2mHrXdtlcV+CcvxV6LH6TWA3/vX0E3P6EjRxUskjsFDlxFX650GA6
 mg5hQaYvO39qxmMmIPeUPNUdyil6/tQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-DxkOMJhFPAS7enSHiUbZYg-1; Tue, 24 Mar 2020 13:42:36 -0400
X-MC-Unique: DxkOMJhFPAS7enSHiUbZYg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DBE61800D53;
 Tue, 24 Mar 2020 17:42:34 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-103.phx2.redhat.com [10.3.113.103])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7773D1001B0B;
 Tue, 24 Mar 2020 17:42:34 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.0 v2 0/4] bug fixes extracted from larger qcow2 zero bit
 work
Date: Tue, 24 Mar 2020 12:42:29 -0500
Message-Id: <20200324174233.1622067-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

My proposal [1] to add an autoclear all-zero-content bit to the qcow2
format has now stalled into 5.1 territory, but several patches in my
initial proposal are uncontroversial and obvious bug fixes worth
having in 5.0.

[1] https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg08075.html

Eric Blake (4):
  qcow2: Comment typo fixes
  qcow2: List autoclear bit names in header
  qcow2: Avoid feature name extension on small cluster size
  sheepdog: Consistently set bdrv_has_zero_init_truncate

 docs/interop/qcow2.txt     |  3 ++-
 block/qcow2.c              | 29 +++++++++++++++++++++++------
 block/sheepdog.c           |  2 ++
 tests/qemu-iotests/031.out |  8 ++++----
 tests/qemu-iotests/036     |  6 ++++--
 tests/qemu-iotests/036.out |  4 ++--
 tests/qemu-iotests/061     |  6 ++++--
 tests/qemu-iotests/061.out | 14 +++++++-------
 8 files changed, 48 insertions(+), 24 deletions(-)

--=20
2.26.0.rc2


