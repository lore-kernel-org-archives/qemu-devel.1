Return-Path: <SRS0=5Zkg=SY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB11C282CE
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 21:14:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BEC920896
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 21:14:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BEC920896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44316 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIgHC-0004XS-L3
	for qemu-devel@archiver.kernel.org; Mon, 22 Apr 2019 17:14:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hIgED-0002UV-VA
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 17:11:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hIg7P-0000F5-Ao
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 17:04:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55758)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hIg7P-0000Ej-5d
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 17:04:51 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 75D3030917AF
	for <qemu-devel@nongnu.org>; Mon, 22 Apr 2019 21:04:50 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 079471001E71;
	Mon, 22 Apr 2019 21:04:49 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 22 Apr 2019 18:04:45 -0300
Message-Id: <20190422210448.2488-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Mon, 22 Apr 2019 21:04:50 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 0/3] Remove AccelClass::available field
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190422210445.dXIa7RfALfkZVT7Okwj3Y6kOM9rLU9Jnaq6Q7-aRsUU@z>

The only user of AccelClass::available was the qtest accelerator,
to make it unavailable on non-POSIX systems.  We can drop the
field if we simply not compile the accelerator code on those
systems.

Eduardo Habkost (3):
  qtest: Move accel code to accel/qtest.c
  qtest: Don't compile qtest accel on non-POSIX systems
  accel: Remove unused AccelClass::available field

 include/sysemu/accel.h |  1 -
 include/sysemu/qtest.h |  9 -------
 accel/accel.c          |  5 ----
 accel/qtest.c          | 54 ++++++++++++++++++++++++++++++++++++++++++
 qtest.c                | 34 --------------------------
 accel/Makefile.objs    |  1 +
 6 files changed, 55 insertions(+), 49 deletions(-)
 create mode 100644 accel/qtest.c

-- 
2.18.0.rc1.1.g3f1ff2140


