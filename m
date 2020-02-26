Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6708C4BA0E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 11:58:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1EE624684
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 11:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hr+jOmFw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1EE624684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6vKs-0000NN-4N
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 06:58:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39178)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ovoshcha@redhat.com>) id 1j6vJz-0007j5-2F
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:57:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ovoshcha@redhat.com>) id 1j6vJw-0008Ne-SW
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:57:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26677
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ovoshcha@redhat.com>) id 1j6vJw-0008IL-KB
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:57:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582718263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3GkzJZGdzg5C4zBIpvuMQuQeWcHMv87RVsQVWhyUyaI=;
 b=hr+jOmFwOG8+KuM08y5XJThH/YezSJE1Aw6vsVqAQS8NRADHwQMNADMuGnGlIR66Pk/3Hn
 05KrJndEUbjh4wxsCkm3iUeYmi31GZTuIJHt3kJWDQaJOw3dWi1CPLeozUSgsMnMcmVAad
 k2pjeQmt0DHjn/XHvp8kznUlCYkJWUk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-VNUKCHQ3OfaG3w2xE7dEaw-1; Wed, 26 Feb 2020 06:57:41 -0500
X-MC-Unique: VNUKCHQ3OfaG3w2xE7dEaw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8F2EF107ACCA
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 11:57:40 +0000 (UTC)
Received: from kh066.redhat.com (ovpn-117-106.ams2.redhat.com [10.36.117.106])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3E7775C102;
 Wed, 26 Feb 2020 11:57:35 +0000 (UTC)
From: Oksana Vohchana <ovoshcha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/3] Acceptance test: Migration mechanism with FD
Date: Wed, 26 Feb 2020 13:57:32 +0200
Message-Id: <20200226115735.857-1-ovoshcha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
socket. And adds a new migration test that depends on it

v2:
 -  Fix warning of line over 80 characters

v3:
 - Improve commit messages

Oksana Vohchana (3):
  python/qemu/machine: Adding functions _send_fds and _recv_fds
  python/qemu/machine: Updates send_fd_scm function
  Acceptance test: add FD migration

 python/qemu/machine.py        | 88 +++++++++++++++++++++++++----------
 tests/acceptance/migration.py | 21 +++++++++
 2 files changed, 85 insertions(+), 24 deletions(-)

--=20
2.21.1


