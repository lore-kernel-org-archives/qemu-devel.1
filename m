Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22FCC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 01:56:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE7252176D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 01:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DQDsXjts"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE7252176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihOa9-0005Uo-SW
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 20:56:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37564)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1ihOYk-0004Gg-Pg
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 20:55:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1ihOYh-0004HQ-EF
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 20:55:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39706
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ihOYg-0004Ea-SV
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 20:55:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576634125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=KOTR2InTacFoLiulMlepJs86JjtHjVFCFg2+mF4MnZ4=;
 b=DQDsXjtsSPoU3k9lKTrSFiTlNeliAV3plz6G5XxjvXr1GBHNhIP1/d52B4bKLFZULTAUYR
 GkVjGCHWPEqWWF7DcmiLm6h3pW6Sjf993qri/izPX+zLU/zH69YWJ4DLBsBBN8RcsCgFf9
 K9sSI2T+E2BGmaPjYzlEY6Y1a2eULT0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-rhrJBEqnMJOg38ynpsbbbw-1; Tue, 17 Dec 2019 20:55:24 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F5B8800D48
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 01:55:23 +0000 (UTC)
Received: from secure.mitica (ovpn-116-32.ams2.redhat.com [10.36.116.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E7FCA51;
 Wed, 18 Dec 2019 01:55:21 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/10] Migration Arguments cleanup
Date: Wed, 18 Dec 2019 02:55:10 +0100
Message-Id: <20191218015520.2881-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: rhrJBEqnMJOg38ynpsbbbw-1
X-Mimecast-Spam-Score: 0
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[v2]
- fix use-after-free (thanks peter)

[v1]
This series simplify test_migrate_start() in two ways:
- simplify the command line creation, so everything that is common between
  architectures don't have to be repeated (DRY).
  Note that this bit remove lines of code.
- test_migrate_start() has two bools and two strings as arguments, it is ve=
ry
  difficult to remmeber which is which and meaning.  And it is even worse t=
o
  add new parameters.  Just pass them through one struct.

Please, review.

Juan Quintela (10):
  migration-test: Create cmd_soure and cmd_target
  migration-test: Move hide_stderr to common commandline
  migration-test: Move -machine to common commandline
  migration-test: Move memory size to common commandline
  migration-test: Move shmem handling to common commandline
  migration-test: Move -name handling to common commandline
  migration-test: Move -serial handling to common commandline
  migration-test: Move -incomming handling to common commandline
  migration-test: Rename cmd_src/dst to arch_source/arch_target
  migration-test: Use a struct for test_migrate_start parameters

 tests/migration-test.c | 269 +++++++++++++++++++++++------------------
 1 file changed, 149 insertions(+), 120 deletions(-)

--=20
2.23.0


