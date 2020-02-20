Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DD4C11D05
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 15:12:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D46B208CD
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 15:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZqiQ8DT4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D46B208CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4nUf-0003yr-8p
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 10:12:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46590)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ovoshcha@redhat.com>) id 1j4nTW-0002gS-Tt
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 10:10:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ovoshcha@redhat.com>) id 1j4nTV-0006Yk-3c
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 10:10:49 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60803
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ovoshcha@redhat.com>) id 1j4nTU-0006UZ-U0
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 10:10:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582211447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2zo+pPvqrzPmBS/SZ2NEd9yOSnmug68al9S/y0RHMP0=;
 b=ZqiQ8DT4WVtwuHnihNwu/nQ4VTSBR48Z/0if68Lw2VhbXscta/EStOXnBNP8hj83RCfCjp
 rfhM7eWH9de+GBu20OvVn41UlW97t+J34jK7eLjsMrhhHyuI/vzMlDMRR6SYbQX+EKHx0o
 aytJd1IAKDhzrBTLqLUOiAv5xZP7QvA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-tfvm9U5eN0SoMpriHi-mjA-1; Thu, 20 Feb 2020 10:10:45 -0500
X-MC-Unique: tfvm9U5eN0SoMpriHi-mjA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02067100550E
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 15:10:45 +0000 (UTC)
Received: from kh066.redhat.com (ovpn-204-205.brq.redhat.com [10.40.204.205])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C121C909E1;
 Thu, 20 Feb 2020 15:10:40 +0000 (UTC)
From: Oksana Vohchana <ovoshcha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/3] Migration mechanism with FD
Date: Thu, 20 Feb 2020 17:10:36 +0200
Message-Id: <20200220151039.20552-1-ovoshcha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
Cc: ovoshcha@redhat.com, philmd@redhat.com, ehabkost@redhat.com,
 wainersm@redhat.com, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To test migration through the file descriptor we should build and provide
a path to socket_scm_helper file. This way is inconvenient for acceptance
testing.
This series provides new functions to receive and send messages over a UNIX
socket. And adds a new migration test.

v2:=20
 -  Fix warning of line over 80 characters

Oksana Vohchana (3):
  Adding functions _send_fds and _recv_fds
  Updates send_fd_scm function
  Acceptance test: FD migration

 python/qemu/machine.py        | 88 +++++++++++++++++++++++++----------
 tests/acceptance/migration.py | 21 +++++++++
 2 files changed, 85 insertions(+), 24 deletions(-)

--=20
2.21.1


