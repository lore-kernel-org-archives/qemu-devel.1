Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4ECC4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 10:31:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84CEF2072E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 10:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MMECCYQ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84CEF2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGKN4-0005wO-Jx
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 06:31:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33871)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ovoshcha@redhat.com>) id 1jGKLt-00051M-Ta
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 06:30:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ovoshcha@redhat.com>) id 1jGKLs-0004oX-SA
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 06:30:37 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:48777)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ovoshcha@redhat.com>) id 1jGKLs-0004oR-Ok
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 06:30:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584959436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+RNSUjcFFKuWQEOtA83hIY6VVubmayotqtO3Z8WUOvQ=;
 b=MMECCYQ9V8QL387hVdaSIhd8t7vSykEf238h3imC+xixZE6vhTJr2TrpTMBj/X6/MGGC1n
 8Sg5pEnLvI+KzprjFgv74NwceBGRSkgACpzZwbCG7h4vQKqnBJMFnX3XST8L8WjNt4cFpd
 Wf1NfCQqh/uAYYvYQakomeK+6s+isCE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-3As8mgv0NHm0SE31lqzTsQ-1; Mon, 23 Mar 2020 06:30:34 -0400
X-MC-Unique: 3As8mgv0NHm0SE31lqzTsQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E448F8018C0
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 10:30:33 +0000 (UTC)
Received: from kh066.redhat.com (ovpn-112-254.ams2.redhat.com [10.36.112.254])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B09665DDAB;
 Mon, 23 Mar 2020 10:30:17 +0000 (UTC)
From: Oksana Vohchana <ovoshcha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 0/3] Acceptance test: Extension of migration tests
Date: Mon, 23 Mar 2020 12:30:13 +0200
Message-Id: <20200323103016.17368-1-ovoshcha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
Cc: ehabkost@redhat.com, crosa@redhat.com, wainersm@redhat.com,
 wrampazz@redhat.com, ovoshcha@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series adds a new migration test through RDMA.
To correct uses of migration need to add a new function to work
with RDMA service.
And as a part of migration tests, the series makes small updates to EXEC
migration and to _get_free_port function

V2:
 - improves commit message in Acceptance test: adds param 'address'
   in _get_free_port
 - provides import check for netifaces library
 - makes fix to _get_ip_rdma function
 - adds skip to test if not upload python module

V3:
 - removes unrelated changes
 - updates functions with new avocado features

V4:
 - moves RDMA's functions outside the Migration class

Oksana Vohchana (3):
  Acceptance test: adds param 'address' in _get_free_port
  Acceptance test: provides new functions
  Acceptance test: provides to use RDMA transport for migration test

 tests/acceptance/migration.py | 48 +++++++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)

--=20
2.21.1


