Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41077C33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 11:19:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D39620721
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 11:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LGIZ+WMS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D39620721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyZl8-0006fs-84
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 06:19:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58639)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ovoshcha@redhat.com>) id 1iyZid-0003AJ-Rb
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:16:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ovoshcha@redhat.com>) id 1iyZib-0007mj-JL
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:16:42 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38716
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ovoshcha@redhat.com>) id 1iyZib-0007ev-AH
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:16:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580728600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=KtO6qgb2V7cjvOhMhAy77Qcv7ZyluZl94Ob4VWklibc=;
 b=LGIZ+WMSRjdERZTIgCU/wTeymTjKqZmvafFRzjNb9DnrpLRubu1klledzjmREZITPFam2r
 ZOPg/VYuQk9fu7K1bPKtfto0SEL9jQLDJQ5c710ZoF8rgcffj9AEqkVj6+QzX7onpGwlhF
 ie6OWmLYDdh/3hEKpEcaBfq9HXWXrCM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-ellGq3t6PZWiJ8tgvfcwMw-1; Mon, 03 Feb 2020 06:16:38 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8AA91851FC2
 for <qemu-devel@nongnu.org>; Mon,  3 Feb 2020 11:16:37 +0000 (UTC)
Received: from kh066.redhat.com (ovpn-116-185.ams2.redhat.com [10.36.116.185])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F0CCB60BE0;
 Mon,  3 Feb 2020 11:16:31 +0000 (UTC)
From: Oksana Vohchana <ovoshcha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/2] Acceptance test: provides to use different transport
 for migration
Date: Mon,  3 Feb 2020 13:16:29 +0200
Message-Id: <20200203111631.18796-1-ovoshcha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: ellGq3t6PZWiJ8tgvfcwMw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: philmd@redhat.com, wainersm@redhat.com, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series makes refactoring to migration test and adds new tests with
EXEC and UNIX protocols

---
v2:
  - Removes unnecessary symbols and unused method

v3:
 - Makes refactoring and split into 2 patches
 - Provides TCP and EXEC migration

Oksana Vohchana (2):
  Acceptance test: provides to use different transport for migration
  Acceptance test: provides to use different transport for  migration

 tests/acceptance/migration.py | 52 +++++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 15 deletions(-)

--=20
2.21.1


